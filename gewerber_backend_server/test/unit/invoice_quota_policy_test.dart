import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/core/di/service_locator.dart';
import 'package:gewerber_backend_server/src/core/entitlement/entitlement_provider.dart';
import 'package:gewerber_backend_server/src/core/entitlement/invoice_quota_policy.dart';
import 'package:gewerber_backend_server/src/core/tenant/tenant_context.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

/// Minimal fake: unimplemented [Session] members route through
/// `noSuchMethod`, so the capability lookup's logging is harmless.
class _FakeSession implements Session {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

/// Entitlement provider stub whose single knob is whether it grants the
/// capability under test.
class _FakeProvider implements EntitlementProvider {
  _FakeProvider({required this.granted});

  /// Capability keys this fake grants.
  final Set<String> granted;

  String? lastCapability;
  UuidValue? lastUserId;
  int? lastBusinessId;

  @override
  Future<Set<Feature>> featuresFor(
    Session session,
    TenantContext tenant,
  ) async {
    return const {};
  }

  @override
  Future<bool> hasCapability(
    Session session, {
    required String capability,
    required UuidValue userId,
    int? businessId,
  }) async {
    lastCapability = capability;
    lastUserId = userId;
    lastBusinessId = businessId;
    return granted.contains(capability);
  }
}

void main() {
  const userId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';

  late _FakeProvider provider;

  setUpAll(() async {
    await configureDependencies();
    getIt.allowReassignment = true;
  });

  setUp(() {
    provider = _FakeProvider(granted: const {});
    getIt.registerSingleton<EntitlementProvider>(provider);
  });

  InvoiceQuotaPolicy policyWith(Map<String, String> env) =>
      InvoiceQuotaPolicy.test(environment: env);

  group('enforcementEnabled', () {
    test('is false when the flag is unset (OSS default)', () {
      expect(policyWith(const {}).enforcementEnabled, isFalse);
    });

    test('is false unless the flag is exactly "true"', () {
      expect(
        policyWith({commercialEntitlementsFlagEnvVar: '1'}).enforcementEnabled,
        isFalse,
      );
      expect(
        policyWith({
          commercialEntitlementsFlagEnvVar: 'TRUE',
        }).enforcementEnabled,
        isFalse,
      );
    });

    test('is true only when the flag is exactly "true"', () {
      expect(
        policyWith({
          commercialEntitlementsFlagEnvVar: 'true',
        }).enforcementEnabled,
        isTrue,
      );
    });
  });

  group('configuredFreeMonthlyLimit', () {
    test('defaults to 3 when no env override is present', () {
      expect(policyWith(const {}).configuredFreeMonthlyLimit, 3);
    });

    test('honours a valid GEWERBER_FREE_INVOICE_LIMIT override', () {
      expect(
        policyWith({
          InvoiceQuotaPolicy.freeInvoiceLimitEnvVar: '5',
        }).configuredFreeMonthlyLimit,
        5,
      );
    });

    test(
      'falls back to the default on a non-integer or non-positive value',
      () {
        expect(
          policyWith({
            InvoiceQuotaPolicy.freeInvoiceLimitEnvVar: 'many',
          }).configuredFreeMonthlyLimit,
          3,
        );
        expect(
          policyWith({
            InvoiceQuotaPolicy.freeInvoiceLimitEnvVar: '0',
          }).configuredFreeMonthlyLimit,
          3,
        );
        expect(
          policyWith({
            InvoiceQuotaPolicy.freeInvoiceLimitEnvVar: '-2',
          }).configuredFreeMonthlyLimit,
          3,
        );
      },
    );
  });

  group('monthlyInvoiceLimit', () {
    test(
      'returns null (unlimited) when the provider grants the capability',
      () async {
        getIt.registerSingleton<EntitlementProvider>(
          _FakeProvider(
            granted: {InvoiceQuotaPolicy.unlimitedInvoicesCapability},
          ),
        );

        final limit = await policyWith(const {}).monthlyInvoiceLimit(
          _FakeSession(),
          userId: UuidValue.fromString(userId),
          businessId: 42,
        );

        expect(limit, isNull);
      },
    );

    test(
      'returns the configured limit and forwards scope when denied',
      () async {
        final limit =
            await policyWith({
              InvoiceQuotaPolicy.freeInvoiceLimitEnvVar: '7',
            }).monthlyInvoiceLimit(
              _FakeSession(),
              userId: UuidValue.fromString(userId),
              businessId: 42,
            );

        expect(limit, 7);
        expect(
          provider.lastCapability,
          InvoiceQuotaPolicy.unlimitedInvoicesCapability,
        );
        expect(provider.lastUserId, UuidValue.fromString(userId));
        expect(provider.lastBusinessId, 42);
      },
    );
  });
}
