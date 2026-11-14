import 'package:gewerber_backend_server/src/auth/social_provider_config.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

const _googleClientSecret = '''
{
  "web": {
    "client_id": "123.apps.googleusercontent.com",
    "client_secret": "google-secret",
    "redirect_uris": ["https://api.gewerber.de/auth/google/callback"]
  }
}
''';

const _allKeys = {
  'googleClientSecret': _googleClientSecret,
  'appleServiceIdentifier': 'de.gewerber.app.service',
  'appleBundleIdentifier': 'de.gewerber.app',
  'appleRedirectUri': 'https://api.gewerber.de/auth/apple/callback',
  'appleTeamId': 'TEAM123456',
  'appleKeyId': 'KEY1234567',
  'appleKey': '-----BEGIN PRIVATE KEY-----\nkey\n-----END PRIVATE KEY-----',
  'facebookAppId': 'facebook-app-id',
  'facebookAppSecret': 'facebook-app-secret',
  'microsoftClientId': 'microsoft-client-id',
  'microsoftClientSecret': 'microsoft-client-secret',
};

Set<AuthProvider> _configured(Map<String, String> passwords) =>
    configuredProviders((key) => passwords[key]);

List<String> _missing(AuthProvider provider, Map<String, String> passwords) =>
    missingKeys(provider, (key) => passwords[key]);

void main() {
  group('configuredProviders', () {
    test('enables all four providers when every key is present', () {
      expect(_configured(_allKeys), equals(AuthProvider.values.toSet()));
    });

    test('returns an empty set when no key is present', () {
      expect(_configured(const {}), isEmpty);
    });

    test('excludes a partially configured provider', () {
      final passwords = Map<String, String>.from(_allKeys)
        ..remove('appleKeyId')
        ..remove('appleKey');

      expect(
        _configured(passwords),
        equals({
          AuthProvider.google,
          AuthProvider.facebook,
          AuthProvider.microsoft,
        }),
      );
    });

    test('treats empty and whitespace-only values as missing', () {
      final passwords = Map<String, String>.from(_allKeys)
        ..['facebookAppId'] = ''
        ..['facebookAppSecret'] = '   '
        ..['microsoftClientId'] = '\t';

      expect(
        _configured(passwords),
        equals({AuthProvider.google, AuthProvider.apple}),
      );
      expect(
        _missing(AuthProvider.facebook, passwords),
        equals(['facebookAppId', 'facebookAppSecret']),
      );
      expect(
        _missing(AuthProvider.microsoft, passwords),
        equals(['microsoftClientId']),
      );
    });

    test('keeps microsoft enabled when microsoftTenant is absent', () {
      final passwords = Map<String, String>.from(_allKeys)
        ..remove('microsoftTenant');

      expect(_configured(passwords), contains(AuthProvider.microsoft));
      expect(_missing(AuthProvider.microsoft, passwords), isEmpty);
    });

    test('ignores blank optional microsoftTenant', () {
      final passwords = Map<String, String>.from(_allKeys)
        ..['microsoftTenant'] = '  ';

      expect(_configured(passwords), contains(AuthProvider.microsoft));
    });

    test('excludes google on malformed JSON without throwing', () {
      final passwords = Map<String, String>.from(_allKeys)
        ..['googleClientSecret'] = '{"web": ';

      expect(
        () => _configured(passwords),
        returnsNormally,
      );
      expect(
        _configured(passwords),
        equals({
          AuthProvider.apple,
          AuthProvider.facebook,
          AuthProvider.microsoft,
        }),
      );
      expect(
        _missing(AuthProvider.google, passwords),
        equals(['googleClientSecret']),
      );
    });

    test('excludes google when the web credentials are incomplete', () {
      final passwords = Map<String, String>.from(_allKeys)
        ..['googleClientSecret'] = '{"web": {"client_id": "id"}}';

      expect(_configured(passwords), isNot(contains(AuthProvider.google)));
    });

    test('excludes google when redirect_uris contains non-string values', () {
      for (final json in [
        '{"web": {"client_id": "id", "client_secret": "secret", "redirect_uris": [1, 2]}}',
        '{"web": {"client_id": "id", "client_secret": "secret", "redirect_uris": ["ok", 3]}}',
        '{"web": {"client_id": "id", "client_secret": "secret", "redirect_uris": [null]}}',
      ]) {
        final passwords = Map<String, String>.from(_allKeys)
          ..['googleClientSecret'] = json;

        expect(() => _configured(passwords), returnsNormally);
        expect(_configured(passwords), isNot(contains(AuthProvider.google)));
        expect(
          _missing(AuthProvider.google, passwords),
          equals(['googleClientSecret']),
        );
      }
    });

    test('excludes google when the secret is not a JSON object', () {
      final passwords = Map<String, String>.from(_allKeys)
        ..['googleClientSecret'] = '"just a string"';

      expect(_configured(passwords), isNot(contains(AuthProvider.google)));
    });
  });

  group('missingKeys', () {
    test('lists every required key when nothing is configured', () {
      expect(
        _missing(AuthProvider.apple, const {}),
        equals([
          'appleServiceIdentifier',
          'appleBundleIdentifier',
          'appleRedirectUri',
          'appleTeamId',
          'appleKeyId',
          'appleKey',
        ]),
      );
    });

    test('lists exactly the absent keys for a partial provider', () {
      final passwords = Map<String, String>.from(_allKeys)
        ..remove('appleTeamId')
        ..remove('appleKey');

      expect(
        _missing(AuthProvider.apple, passwords),
        equals(['appleTeamId', 'appleKey']),
      );
    });

    test('is empty for every provider when fully configured', () {
      for (final provider in AuthProvider.values) {
        expect(_missing(provider, _allKeys), isEmpty, reason: provider.name);
      }
    });

    test('never reports key values, only names', () {
      final passwords = {'appleKey': 'super-secret-value'};
      final missing = _missing(AuthProvider.apple, passwords);

      expect(missing, isNot(contains('super-secret-value')));
      expect(missing, contains('appleServiceIdentifier'));
    });
  });
}
