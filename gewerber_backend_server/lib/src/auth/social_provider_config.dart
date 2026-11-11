import 'dart:convert';

import '../generated/protocol.dart';

/// Reads a `config/passwords.yaml` value by key, returning `null` when the key
/// is absent. Matches `Serverpod.getPassword`.
typedef PasswordReader = String? Function(String key);

/// The `config/passwords.yaml` keys a social identity provider cannot start
/// without. Optional keys (e.g. `microsoftTenant`,
/// `appleAndroidPackageIdentifier`, `appleWebRedirectUri`) are deliberately
/// absent so that they never mark a provider as unconfigured.
const Map<AuthProvider, List<String>> _requiredKeys = {
  AuthProvider.google: ['googleClientSecret'],
  AuthProvider.apple: [
    'appleServiceIdentifier',
    'appleBundleIdentifier',
    'appleRedirectUri',
    'appleTeamId',
    'appleKeyId',
    'appleKey',
  ],
  AuthProvider.facebook: ['facebookAppId', 'facebookAppSecret'],
  AuthProvider.microsoft: ['microsoftClientId', 'microsoftClientSecret'],
};

/// Returns the social identity providers that are fully configured in the
/// passwords passed through [read].
///
/// A provider counts as configured when every key in [_requiredKeys] has a
/// non-blank value. Google's single value is the downloaded
/// `google_client_secret.json`; it additionally has to parse as JSON and carry
/// the `web` credentials the provider constructor reads. Malformed JSON is
/// reported as "not configured" instead of throwing, so the server can still
/// boot and the operator gets a readable startup log line — any decision to
/// fail hard belongs to the caller.
Set<AuthProvider> configuredProviders(PasswordReader read) {
  final configured = <AuthProvider>{};
  for (final provider in AuthProvider.values) {
    if (missingKeys(provider, read).isEmpty) {
      configured.add(provider);
    }
  }
  return configured;
}

/// Returns the names of the keys [provider] is missing (or that hold a blank
/// value), in declaration order. An empty list means the provider is
/// configured.
///
/// Only key names are returned, never values, so the result is safe for
/// operator-facing log output.
List<String> missingKeys(AuthProvider provider, PasswordReader read) {
  final missing = <String>[];
  for (final key in _requiredKeys[provider]!) {
    final value = read(key);
    if (value == null || value.trim().isEmpty) {
      missing.add(key);
    }
  }

  if (provider == AuthProvider.google && missing.isEmpty) {
    if (!_isUsableGoogleClientSecret(read('googleClientSecret')!)) {
      missing.add('googleClientSecret');
    }
  }

  return missing;
}

/// Whether [raw] is the JSON document `GoogleIdpConfigFromPasswords` expects.
///
/// Mirrors `GoogleClientSecret.fromJson` from `serverpod_auth_idp_server`:
/// it reads `web.client_id`, `web.client_secret` and `web.redirect_uris`, and
/// throws when any of them is absent. Values that would make the provider
/// constructor throw at startup are treated as not configured here.
bool _isUsableGoogleClientSecret(String raw) {
  final Object? decoded;
  try {
    decoded = jsonDecode(raw);
  } on FormatException {
    return false;
  }

  if (decoded is! Map<String, dynamic>) return false;

  final web = decoded['web'];
  if (web is! Map<String, dynamic>) return false;

  final clientId = web['client_id'];
  if (clientId is! String || clientId.trim().isEmpty) return false;

  final clientSecret = web['client_secret'];
  if (clientSecret is! String || clientSecret.trim().isEmpty) return false;

  // Not a credential, but `GoogleClientSecret.fromJson` requires it, so a
  // document without a `redirect_uris` list cannot be used to build the IdP.
  return web['redirect_uris'] is List;
}
