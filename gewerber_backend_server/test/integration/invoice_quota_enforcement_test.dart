@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/audit/audit_service.dart';
import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/core/di/service_locator.dart';
import 'package:gewerber_backend_server/src/core/entitlement/entitlement_provider.dart';
import 'package:gewerber_backend_server/src/core/entitlement/invoice_quota_policy.dart';
import 'package:gewerber_backend_server/src/core/tenant/tenant_context.dart';
import 'package:gewerber_backend_server/src/core/tenant/tenant_resolver.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/business/domain/business_gateway.dart';
import 'package:gewerber_backend_server/src/modules/business/domain/business_settings_gateway.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/application/create_invoice_use_case.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/domain/customer_gateway.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/domain/invoice_gateway.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/domain/invoice_item_gateway.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/domain/invoice_number_service.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/domain/invoice_template_gateway.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/domain/tax_rule_engine.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Fake provider whose granted capability set is mutable, so a single
/// registration can serve both the "unlimited" and "limited" scenarios.
class _FakeProvider implements EntitlementProvider {
  final Set<String> granted = <String>{};

  int capabilityCalls = 0;

  @override
  Future<Set<Feature>> featuresFor(
    Session session,
    TenantContext tenant,
  ) async {
    return Feature.values.toSet();
  }

  @override
  Future<bool> hasCapability(
    Session session, {
    required String capability,
    required UuidValue userId,
    int? businessId,
  }) async {
    capabilityCalls++;
    return granted.contains(capability);
  }
}

void main() {
  const testUserId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';

  // Backing map for the single test policy: the flag is read live by
  // `enforcementEnabled`, so flipping it here toggles enforcement without the
  // cached `CreateInvoiceUseCase` singleton holding a stale policy instance.
  final env = <String, String>{};
  late _FakeProvider provider;

  setUpAll(() async {
    await configureDependencies();
    getIt.allowReassignment = true;

    provider = _FakeProvider();
    getIt.registerSingleton<EntitlementProvider>(provider);
    final policy = InvoiceQuotaPolicy.test(environment: env);
    getIt.registerSingleton<InvoiceQuotaPolicy>(policy);

    // `@singleton` bindings are eager, so `CreateInvoiceUseCase` already
    // captured the real (flag-off) policy during `configureDependencies()`.
    // Rebuild it against the test policy so the endpoint exercises the
    // enforcement path.
    getIt.registerSingleton<CreateInvoiceUseCase>(
      CreateInvoiceUseCase(
        getIt<TenantResolver>(),
        getIt<InvoiceGateway>(),
        getIt<InvoiceItemGateway>(),
        getIt<BusinessGateway>(),
        getIt<BusinessSettingsGateway>(),
        getIt<CustomerGateway>(),
        getIt<InvoiceTemplateGateway>(),
        getIt<InvoiceNumberService>(),
        getIt<TaxRuleEngine>(),
        getIt<AuditService>(),
        policy,
      ),
    );
  });

  withServerpod('Given invoice quota enforcement', (sessionBuilder, endpoints) {
    late TestSessionBuilder auth;
    late int businessId;

    setUp(() async {
      env.clear();
      provider.granted.clear();
      provider.capabilityCalls = 0;
      auth = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          testUserId,
          {},
        ),
      );
      final business = await endpoints.business.create(
        auth,
        CreateBusinessRequest(name: 'Mein Gewerbe'),
      );
      businessId = business.id!;
    });

    InvoiceItemRequest item() => InvoiceItemRequest(
      description: 'Beratung',
      quantity: 1,
      unitPriceCents: 10000,
      vatRate: VatRate.standard,
    );

    Future<Invoice> createInvoice() => endpoints.invoice.create(
      auth,
      CreateInvoiceRequest(items: [item()]),
      businessId: businessId,
    );

    test(
      'when flag is off then many invoices create without any quota check',
      () async {
        // Flag unset: OSS behaviour. The provider would deny the capability,
        // but it must never even be consulted (no capability lookup, no
        // count query — zero added work).
        for (var i = 0; i < 10; i++) {
          final invoice = await createInvoice();
          expect(invoice.id, isNotNull);
        }
        expect(provider.capabilityCalls, 0);
      },
    );

    test(
      'when flag is on and unlimited then the limit does not apply',
      () async {
        env[commercialEntitlementsFlagEnvVar] = 'true';
        provider.granted.add(InvoiceQuotaPolicy.unlimitedInvoicesCapability);

        for (var i = 0; i < 5; i++) {
          final invoice = await createInvoice();
          expect(invoice.id, isNotNull);
        }
        // Flag on: the capability lookup runs (and short-circuits the count).
        expect(provider.capabilityCalls, greaterThan(0));
      },
    );

    test(
      'when flag is on and limited then the 4th invoice throws',
      () async {
        env[commercialEntitlementsFlagEnvVar] = 'true';
        // Default free limit is 3; provider denies `unlimited_invoices`.

        for (var i = 0; i < 3; i++) {
          final invoice = await createInvoice();
          expect(invoice.id, isNotNull);
        }

        await expectLater(
          createInvoice,
          throwsA(
            isA<InvoiceLimitReachedException>().having(
              (e) => e.limit,
              'limit',
              3,
            ),
          ),
        );
      },
    );

    test(
      'when flag is on then the quota is scoped per business',
      () async {
        env[commercialEntitlementsFlagEnvVar] = 'true';

        final other = await endpoints.business.create(
          auth,
          CreateBusinessRequest(name: 'Zweites Gewerbe'),
        );
        final otherId = other.id!;

        // Exhaust business A's quota.
        for (var i = 0; i < 3; i++) {
          await createInvoice();
        }
        await expectLater(
          createInvoice,
          throwsA(isA<InvoiceLimitReachedException>()),
        );

        // Business B has its own untouched quota.
        final bInvoice = await endpoints.invoice.create(
          auth,
          CreateInvoiceRequest(items: [item()]),
          businessId: otherId,
        );
        expect(bInvoice.id, isNotNull);
      },
    );
  });
}
