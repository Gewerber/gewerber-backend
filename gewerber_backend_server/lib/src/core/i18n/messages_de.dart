import 'messages.dart';

/// German (de) message catalog.
///
/// `de` is the [fallbackLocale], so **this map must define every key in
/// [Messages]** — a key missing here is missing for every locale. The
/// completeness test in `test/unit/message_catalog_test.dart` enforces that.
///
/// Values for `error.*` are new German translations of messages that were
/// previously English-only. Values for `pdf.*` are the literal strings the PDF
/// generator hardcoded before issue #57, kept byte-identical so that rendering
/// a German invoice is unchanged by the move to the catalog.
///
/// **Open legal question (GoBD / UStG):** a number of these labels — notably
/// `pdfFieldInvoiceNumber`, `pdfFieldInvoiceDate`, `pdfFieldDueDate` and the
/// §19 UStG exemption note — are prescribed wording for a German domestic
/// invoice. If legal review concludes they may not be translated on documents
/// that stay in the German tax jurisdiction, those keys must pin to the German
/// string in the `en` catalog too rather than be dropped. See issue #57.
const Map<String, String> messageMapDe = <String, String>{
  // Tenancy / authentication errors.
  Messages.errorNotAuthenticated: 'Nicht angemeldet.',
  Messages.errorNotBusinessMember: 'Kein Mitglied dieses Betriebs.',
  Messages.errorAdminPermissionsRequired: 'Administratorrechte erforderlich.',
  Messages.errorAdminRoleRequired: 'Administratorrolle erforderlich.',
  Messages.errorInsufficientAdminRole:
      'Unzureichende Administratorrolle: {minimum} erforderlich, '
      '{granted} vorhanden.',

  // Invoice PDF: document identity.
  Messages.pdfDocumentInvoice: 'Rechnung',
  Messages.pdfDocumentCreditNote: 'Gutschrift',
  Messages.pdfDocumentCancellationNotice: 'Stornorechnung / Gutschrift',
  Messages.pdfDocumentCorrectionNote: 'Korrekturrechnung zu Rechnung {number}',

  // Invoice PDF: party and header fields.
  Messages.pdfFieldVatId: 'USt-IdNr.',
  Messages.pdfFieldTaxNumber: 'Steuernummer',
  Messages.pdfFieldEmail: 'E-Mail',
  Messages.pdfFieldPhone: 'Telefon',
  Messages.pdfFieldInvoiceRecipient: 'Rechnungsempfänger',
  Messages.pdfFieldCreditNoteRecipient: 'Gutschriftsempfänger',
  Messages.pdfFieldCustomerVatId: 'USt-IdNr.',
  Messages.pdfFieldInvoiceNumber: 'Rechnungsnummer',
  Messages.pdfFieldCreditNoteNumber: 'Gutschriftsnummer',
  Messages.pdfFieldInvoiceDate: 'Rechnungsdatum',
  Messages.pdfFieldCreditNoteDate: 'Gutschriftsdatum',
  Messages.pdfFieldCancelledInvoice: 'Stornierte Rechnung',
  Messages.pdfFieldDueDate: 'Fällig am',
  Messages.pdfFieldServicePeriod: 'Leistungszeitraum',

  // Invoice PDF: line item table.
  Messages.pdfTablePosition: 'Pos.',
  Messages.pdfTableDescription: 'Leistung',
  Messages.pdfTableQuantity: 'Menge',
  Messages.pdfTableUnit: 'Einheit',
  Messages.pdfTableUnitPrice: 'Einzelpreis',
  Messages.pdfTableVatRate: 'USt.',
  Messages.pdfTableLineTotal: 'Gesamt',

  // Invoice PDF: totals.
  Messages.pdfTotalNetSubtotal: 'Zwischensumme (netto)',
  Messages.pdfTotalVat: 'Umsatzsteuer',
  Messages.pdfTotalGrandTotal: 'Gesamtbetrag',

  // Invoice PDF: tax notes and sections.
  Messages.pdfNoteKleinunternehmer:
      'Gemäß § 19 UStG wird keine Umsatzsteuer berechnet.',
  Messages.pdfNoteReverseCharge:
      'Steuerschuldnerschaft des Leistungsempfängers (Reverse Charge). '
      'Die Umsatzsteuer geht auf den Leistungsempfänger über.',
  Messages.pdfSectionNotes: 'Anmerkungen',
  Messages.pdfSectionOffset: 'Verrechnung',
  Messages.pdfTextOffsetExplanation:
      'Der stornierte Rechnungsbetrag wird mit offenen Forderungen '
      'verrechnet. Eine Zahlung ist nicht erforderlich.',
  Messages.pdfSectionPaymentTerms: 'Zahlungsbedingungen',
  Messages.pdfTextPaymentTerms:
      'Zahlbar innerhalb von {days} Tagen nach Rechnungsdatum ohne Abzug.',
  Messages.pdfFooterPage: 'Seite {page} von {pages}',

  // Invoice PDF: line item units.
  Messages.pdfUnitPiece: 'Stk.',
  Messages.pdfUnitHour: 'Std.',
  Messages.pdfUnitDay: 'Tag',
  Messages.pdfUnitMonth: 'Monat',
  Messages.pdfUnitProject: 'Projekt',
  Messages.pdfUnitOther: 'Sonst.',
};
