import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

/// Environment variable pointing at the invoice PDF fallback font (a TTF).
///
/// Same shape as `commercialEntitlementsFlagEnvVar` (see
/// `core/di/injection.dart`): an env var, not a `config/*.yaml` key, because
/// Serverpod 4's typed runtime config is code-generated from a fixed schema.
const String invoiceFontPathEnvVar = 'GEWERBER_INVOICE_FONT_PATH';

/// Vendored fallback font, relative to the server's working directory
/// (`gewerber_backend_server/assets/fonts/Roboto-Regular.ttf`, Apache-2.0;
/// the Docker image ships it at `/app/assets/fonts/...`).
const String defaultInvoiceFontPath = 'assets/fonts/Roboto-Regular.ttf';

/// Loads the embedded TrueType font used to render invoice PDFs.
///
/// The `pdf` package's built-in Helvetica is WinAnsi-encoded and covers only
/// U+0000–U+00FF, so it cannot draw `€` or `–` — the glyphs the German invoice
/// needs (issue #70). Roboto is vendored under `assets/fonts/` as the
/// fallback; [load] reads it once per call and never throws: a misconfigured
/// deployment must still be able to generate invoices, just with the old
/// glyph-limited font. Failures are loud in the logs (`stderr`) and graceful
/// in behaviour.
class InvoicePdfFont {
  InvoicePdfFont._();

  /// Resolves the font file path [load] will try to read.
  ///
  /// [invoiceFontPathEnvVar] wins when set to a non-empty value; otherwise
  /// [defaultInvoiceFontPath] applies. Exposed so tests and the deployment
  /// wiring reference one source for the path instead of duplicating the
  /// string. [environment] is injectable so callers never reach for
  /// `Platform.environment` deeper in the call stack.
  static String resolvePath({Map<String, String>? environment}) {
    final configured =
        (environment ?? Platform.environment)[invoiceFontPathEnvVar];
    if (configured == null || configured.isEmpty) {
      return defaultInvoiceFontPath;
    }
    return configured;
  }

  /// Loads the fallback font, or returns `null` when it is unavailable.
  ///
  /// `null` is a supported outcome, not an error: the caller keeps using the
  /// built-in Helvetica. This method never throws — a missing, unreadable or
  /// unparseable font file only produces a warning on `stderr`.
  static pw.Font? load({Map<String, String>? environment}) {
    final path = resolvePath(environment: environment);
    try {
      final file = File(path);
      if (!file.existsSync()) {
        stderr.writeln(
          'WARNING: invoice PDF font not found at "$path" (resolved from '
          '$invoiceFontPathEnvVar or the default); invoices will render with '
          'the built-in Helvetica, which cannot draw € or –. '
          'See https://github.com/Gewerber/gewerber-backend/issues/70',
        );
        return null;
      }
      return pw.Font.ttf(file.readAsBytesSync().buffer.asByteData());
    } catch (error) {
      stderr.writeln(
        'WARNING: could not load invoice PDF font "$path" ($error); invoices '
        'will render with the built-in Helvetica, which cannot draw € or –. '
        'Check that $invoiceFontPathEnvVar points to a readable TrueType '
        'file. See '
        'https://github.com/Gewerber/gewerber-backend/issues/70',
      );
      return null;
    }
  }
}
