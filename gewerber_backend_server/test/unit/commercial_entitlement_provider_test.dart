// Mirrors the adapter's own import: the source contract lives under `src/`
// in the commercial module (real and stub) and is not part of its public API.
// ignore: implementation_imports
import 'package:gewerber_backend_commercial_server/src/modules/subscription/services/commercial_entitlement_source.dart';
import 'package:gewerber_backend_server/src/core/entitlement/commercial_entitlement_provider.dart';
import 'package:gewerber_backend_server/src/core/tenant/tenant_context.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

/// Minimal fake: every unimplemented [Session] member (including `log`) is
/// routed through `noSuchMethod`, which keeps the adapter's logging calls
/// harmless in a pure unit test.
class _FakeSession implements Session {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeEntitlementSource implements CommercialEntitlementSource {
  _FakeEntitlementSource(this.keys);

  final Set<String> keys;

  UuidValue? lastUserId;
  int? lastBusinessId;

  @override
  Future<Set<String>> featuresFor({
    required UuidValue userId,
    int? businessId,
  }) async {
    lastUserId = userId;
    lastBusinessId = businessId;
    return keys;
  }
}

class _ThrowingEntitlementSource implements CommercialEntitlementSource {
  @override
  Future<Set<String>> featuresFor({
    required UuidValue userId,
    int? businessId,
  }) async {
    throw StateError('commercial DB unreachable');
  }
}

void main() {
  const userId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';

  late TenantContext tenant;

  setUp(() {
    tenant = TenantContext(
      userId: UuidValue.fromString(userId),
      businessId: 42,
      role: MembershipRole.owner,
    );
    CommercialEntitlementProvider.loggedUnknownKeys.clear();
  });

  group('CommercialEntitlementProvider.mapFeatureKeys', () {
    test('maps every known commercial feature key to its OSS Feature', () {
      final features = CommercialEntitlementProvider.mapFeatureKeys(
        CommercialEntitlementProvider.featureByKey.keys,
      );

      expect(
        features,
        equals(CommercialEntitlementProvider.featureByKey.values.toSet()),
      );
      expect(
        features,
        containsAll(<Feature>[
          Feature.invoicing,
          Feature.time_tracking,
          Feature.accounting,
          Feature.guidance,
          Feature.multi_currency,
          Feature.banking,
          Feature.employees,
        ]),
      );
    });

    test('maps basic_accounting to Feature.accounting', () {
      expect(
        CommercialEntitlementProvider.mapFeatureKeys({'basic_accounting'}),
        equals({Feature.accounting}),
      );
    });

    test('skips unknown keys without throwing', () {
      final unknown = <String>[
        'unlimited_invoices',
        'no_branding',
        'exports',
        'payments',
        'payroll',
        'multi_user',
      ];
      final reported = <String>[];

      final features = CommercialEntitlementProvider.mapFeatureKeys(
        {...unknown, 'invoicing'},
        onUnknownKey: reported.add,
      );

      expect(features, equals({Feature.invoicing}));
      expect(reported, unorderedEquals(unknown));
    });

    test('reports each unknown key only once', () {
      final reported = <String>[];

      CommercialEntitlementProvider.mapFeatureKeys(
        const ['mystery_feature', 'mystery_feature', 'mystery_feature'],
        onUnknownKey: reported.add,
      );

      expect(reported, equals(['mystery_feature']));
    });

    test('returns an empty set for an empty key set', () {
      expect(
        CommercialEntitlementProvider.mapFeatureKeys(const <String>{}),
        isEmpty,
      );
    });
  });

  group('CommercialEntitlementProvider.featuresFor', () {
    test('passes the tenant scope to the source and maps its keys', () async {
      final source = _FakeEntitlementSource({
        'invoicing',
        'time_tracking',
        'basic_accounting',
        'guidance',
      });
      final provider = CommercialEntitlementProvider(
        sourceFactory: (_) => source,
      );

      final features = await provider.featuresFor(
        _FakeSession(),
        tenant,
      );

      expect(source.lastUserId, equals(UuidValue.fromString(userId)));
      expect(source.lastBusinessId, 42);
      expect(
        features,
        equals({
          Feature.invoicing,
          Feature.time_tracking,
          Feature.accounting,
          Feature.guidance,
        }),
      );
    });

    test(
      'never throws on unmapped keys and returns only mapped features',
      () async {
        final source = _FakeEntitlementSource({
          'payments',
          'banking',
          'payroll',
        });
        final provider = CommercialEntitlementProvider(
          sourceFactory: (_) => source,
        );

        final features = await provider.featuresFor(_FakeSession(), tenant);

        expect(features, equals({Feature.banking}));
      },
    );

    test(
      'fails open to all features when the source throws',
      () async {
        final provider = CommercialEntitlementProvider(
          sourceFactory: (_) => _ThrowingEntitlementSource(),
        );

        final features = await provider.featuresFor(_FakeSession(), tenant);

        expect(features, equals(Feature.values.toSet()));
      },
    );
  });
}
