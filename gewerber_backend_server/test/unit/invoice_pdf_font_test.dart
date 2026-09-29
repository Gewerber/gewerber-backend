import 'package:gewerber_backend_server/src/modules/invoicing/data/invoice_pdf_font.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:test/test.dart';

/// Every codepoint an invoice PDF emits, or that a locale the app persists
/// will need as soon as its catalog lands, with the reason it is required —
/// the fallback font must cover all of them. Most are beyond the built-in
/// fonts' WinAnsi range (U+0000–U+00FF), but not all: the coverage assertion
/// is on the fallback, so in-range glyphs like the footer separator belong
/// here too.
const _emittedGlyphs = <int, String>{
  0x20AC: 'U+20AC euro sign, emitted by the currency formatters (issue #70)',
  0x2013:
      'U+2013 en dash, emitted by the VAT "none" column and the service'
      ' period range (issue #70)',
  0x00B7: 'U+00B7 middle dot, emitted as the page-footer separator',
  0x041F: 'U+041F Cyrillic capital letter Pe, readiness for the ru locale',
  0x015F:
      'U+015F Latin small letter s with cedilla, readiness for the tr '
      'locale',
  0x0130:
      'U+0130 Latin capital letter I with dot above, readiness for the '
      'tr locale',
  0x0131: 'U+0131 Latin small letter dotless i, readiness for the tr locale',
};

/// The concrete font object the text layout asks for glyphs, built from the
/// very bytes [InvoicePdfFont.load] registers as the theme `fontFallback`.
///
/// `pw.Font.buildFont` is protected, but [PdfTtfFont.new] is exactly what the
/// widgets layer calls for a `TtfFont` when the document lays out its first
/// text, so this exercises the same `isRuneSupported` the renderer does.
PdfFont _renderableFont(pw.Font? loaded) {
  expect(
    loaded,
    isA<pw.TtfFont>(),
    reason:
        'the vendored font must load from ${InvoicePdfFont.resolvePath()} — '
        'the default path is relative to the server working directory',
  );
  final ttf = loaded! as pw.TtfFont;
  return PdfTtfFont(PdfDocument(), ttf.data);
}

void main() {
  // Regression guard for issue #70: the built-in Helvetica covers only
  // U+0000–U+00FF, so the invoice used to drop € and – on the floor. These
  // tests fail if the font the loader hands to the theme cannot draw a glyph
  // the PDF actually emits.
  group('glyph coverage', () {
    test('the fallback font draws every glyph the invoice emits', () {
      final pdfFont = _renderableFont(InvoicePdfFont.load());
      for (final glyph in _emittedGlyphs.entries) {
        expect(
          pdfFont.isRuneSupported(glyph.key),
          isTrue,
          reason: glyph.value,
        );
      }
    });

    test('the built-in Helvetica cannot draw € or –', () {
      // Negative control: this is why the theme keeps a fontFallback at all.
      // If WinAnsi ever gains these codepoints, the fallback needs revisiting
      // — not silent deletion — so pinning the limitation is the point.
      final helvetica = PdfFont.helvetica(PdfDocument());
      expect(
        helvetica.isRuneSupported(0x20AC),
        isFalse,
        reason: 'U+20AC euro sign must stay unsupported by Helvetica',
      );
      expect(
        helvetica.isRuneSupported(0x2013),
        isFalse,
        reason: 'U+2013 en dash must stay unsupported by Helvetica',
      );
    });
  });

  group('resolvePath', () {
    test('the environment variable wins when set', () {
      expect(
        InvoicePdfFont.resolvePath(
          environment: {invoiceFontPathEnvVar: '/opt/fonts/custom.ttf'},
        ),
        '/opt/fonts/custom.ttf',
      );
    });

    test('an empty value falls back to the vendored default', () {
      expect(
        InvoicePdfFont.resolvePath(environment: {invoiceFontPathEnvVar: ''}),
        defaultInvoiceFontPath,
      );
    });

    test('an absent variable falls back to the vendored default', () {
      expect(
        InvoicePdfFont.resolvePath(environment: const {}),
        defaultInvoiceFontPath,
      );
    });
  });

  group('load', () {
    test('a missing font file degrades to null without throwing', () {
      // The deployment contract: a misconfigured path warns on stderr and the
      // generator keeps using Helvetica; it must never fail invoice creation.
      // A throw here would surface as this test failing, not as a 500.
      expect(
        InvoicePdfFont.load(
          environment: {
            invoiceFontPathEnvVar: 'test/assets/this-font-does-not-exist.ttf',
          },
        ),
        isNull,
      );
    });
  });
}
