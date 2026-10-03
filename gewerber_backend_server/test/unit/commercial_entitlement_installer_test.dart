import 'package:gewerber_backend_commercial_server/gewerber_backend_commercial_server.dart'
    show CommercialEntitlementInstaller, CommercialEntitlementProvider;
import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/core/di/service_locator.dart';
import 'package:gewerber_backend_server/src/core/entitlement/all_features_entitlement_provider.dart';
import 'package:gewerber_backend_server/src/core/entitlement/commercial_entitlement_installer.dart';
import 'package:gewerber_backend_server/src/core/entitlement/entitlement_provider.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  group('featuresFromOssNames', () {
    test('null names grant every feature (module fail-open contract)', () {
      expect(featuresFromOssNames(null), Feature.values.toSet());
    });

    test('maps known OSS feature names onto the enum', () {
      expect(
        featuresFromOssNames({'invoicing', 'accounting'}),
        equals({Feature.invoicing, Feature.accounting}),
      );
    });

    test('skips unknown names and reports them without throwing', () {
      final reported = <String>[];
      final features = featuresFromOssNames(
        {'invoicing', 'no_such_feature'},
        onUnknownKey: reported.add,
      );
      expect(features, equals({Feature.invoicing}));
      expect(reported, equals(['no_such_feature']));
    });

    test('maps an empty set to an empty set', () {
      expect(featuresFromOssNames(<String>{}), isEmpty);
    });
  });

  group('HostCommercialEntitlementInstaller', () {
    setUpAll(() async {
      await configureDependencies();
    });

    test('configureDependencies keeps the OSS default and registers the '
        'installer hook', () {
      expect(
        getIt<EntitlementProvider>(),
        isA<AllFeaturesEntitlementProvider>(),
      );
      expect(getIt.isRegistered<CommercialEntitlementInstaller>(), isTrue);
    });

    test(
      'installCommercialEntitlements swaps out the OSS default provider',
      () {
        // Defensive: restore the OSS default binding afterwards so the global
        // getIt state is not left swapped for other test files.
        addTearDown(() {
          getIt.unregister<EntitlementProvider>();
          getIt.registerSingleton<EntitlementProvider>(
            AllFeaturesEntitlementProvider(),
          );
        });
        // Only the swap mechanics are exercised here; calling into the module
        // provider would hit its DB-backed internals, which are owned and
        // tested by the commercial module.
        getIt<CommercialEntitlementInstaller>().installCommercialEntitlements(
          CommercialEntitlementProvider(),
        );
        expect(
          getIt<EntitlementProvider>(),
          isNot(isA<AllFeaturesEntitlementProvider>()),
        );
      },
    );
  });
}
