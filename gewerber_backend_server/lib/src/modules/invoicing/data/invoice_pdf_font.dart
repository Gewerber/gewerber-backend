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
/// glyph-limited font. Failures are loud in the logs and graceful in behaviour.
///
/// Both outcomes are logged through [load]'s injectable `logSink` (issue #88):
/// a successful load writes an `INFO` line naming the resolved path — the
/// default is CWD-relative, so an unexpected working directory or a volume
/// mounted over the app directory silently degrades rendering — and a failure
/// writes the `WARNING` that explains the Helvetica fallback.
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
  /// unparseable font file only produces a warning on [logSink].
  ///
  /// [logSink] defaults to [stderr] and mirrors the injectable `environment`
  /// of [resolvePath]: the caller (or a test) decides where the observability
  /// lines go. A successful load writes an `INFO` line with the resolved path,
  /// because the default is CWD-relative (`assets/fonts/Roboto-Regular.ttf`)
  /// and a wrong working directory or a volume mounted over the app directory
  /// otherwise degrades PDFs without any visible error (issue #88).
  static pw.Font? load({
    Map<String, String>? environment,
    StringSink? logSink,
  }) {
    final sink = logSink ?? stderr;
    final path = resolvePath(environment: environment);
    try {
      final file = File(path);
      if (!file.existsSync()) {
        sink.writeln(
          'WARNING: invoice PDF font not found at "$path" (resolved from '
          '$invoiceFontPathEnvVar or the default); invoices will render with '
          'the built-in Helvetica, which cannot draw € or –. '
          'See https://github.com/Gewerber/gewerber-backend/issues/70',
        );
        return null;
      }
      final font = pw.Font.ttf(file.readAsBytesSync().buffer.asByteData());
      sink.writeln(
        'INFO: invoice PDF font loaded from "$path" (set '
        '$invoiceFontPathEnvVar to override the CWD-relative default; see '
        'https://github.com/Gewerber/gewerber-backend/issues/88)',
      );
      return font;
    } catch (error) {
      sink.writeln(
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
