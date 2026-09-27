import 'messages.dart';

/// English (en) message catalog.
///
/// Two different provenance rules apply to this map, and the difference is
/// deliberate:
///
///  - `error.*` values are **verbatim copies of the English literals that were
///    hardcoded at the throw sites** before issue #57. Routing them through the
///    catalog must therefore be a no-op for English-locale requests: the same
///    bytes reach the client, so no already-deployed app changes behaviour and
///    no client-side string matching can regress. Do not reword these casually
///    — do it as a deliberate copy change, not as catalog plumbing.
///
///  - `pdf.*` values are **new**. The PDF generator hardcoded German and
///    rendered it for every user regardless of locale, so English output is
///    genuinely new text rather than a preservation of existing strings.
///
/// Note on the `pdf.*` legal wording: see the GoBD note in `messages_de.dart`.
/// If prescribed German labels turn out to be non-translatable on documents
/// that stay in the German tax jurisdiction, the affected keys must be pinned
/// to the German string here instead of an English one.
const Map<String, String> messageMapEn = <String, String>{
  // Tenancy / authentication errors. Verbatim pre-catalog English.
  Messages.errorNotAuthenticated: 'Not authenticated.',
  Messages.errorNotBusinessMember: 'Not a member of this business.',
  Messages.errorAdminPermissionsRequired: 'Admin permissions required.',
  Messages.errorAdminRoleRequired: 'Administrator role required.',
  Messages.errorInsufficientAdminRole:
      'Insufficient administrator role: {minimum} required, {granted} granted.',

  // Invoice PDF: document identity.
  Messages.pdfDocumentInvoice: 'Invoice',
  Messages.pdfDocumentCreditNote: 'Credit note',
  Messages.pdfDocumentCancellationNotice: 'Cancellation / credit note',
  Messages.pdfDocumentCorrectionNote: 'Correction invoice for invoice {number}',

  // Invoice PDF: party and header fields.
  Messages.pdfFieldVatId: 'VAT ID',
  Messages.pdfFieldTaxNumber: 'Tax number',
  Messages.pdfFieldEmail: 'Email',
  Messages.pdfFieldPhone: 'Phone',
  Messages.pdfFieldInvoiceRecipient: 'Bill to',
  Messages.pdfFieldCreditNoteRecipient: 'Credit note recipient',
  Messages.pdfFieldCustomerVatId: 'VAT ID',
  Messages.pdfFieldInvoiceNumber: 'Invoice number',
  Messages.pdfFieldCreditNoteNumber: 'Credit note number',
  Messages.pdfFieldInvoiceDate: 'Invoice date',
  Messages.pdfFieldCreditNoteDate: 'Credit note date',
  Messages.pdfFieldCancelledInvoice: 'Cancelled invoice',
  Messages.pdfFieldDueDate: 'Due date',
  Messages.pdfFieldServicePeriod: 'Service period',

  // Invoice PDF: line item table.
  Messages.pdfTablePosition: 'Pos.',
  Messages.pdfTableDescription: 'Description',
  Messages.pdfTableQuantity: 'Qty',
  Messages.pdfTableUnit: 'Unit',
  Messages.pdfTableUnitPrice: 'Unit price',
  Messages.pdfTableVatRate: 'VAT',
  Messages.pdfTableLineTotal: 'Total',

  // Invoice PDF: totals.
  Messages.pdfTotalNetSubtotal: 'Net subtotal',
  Messages.pdfTotalVat: 'VAT',
  Messages.pdfTotalGrandTotal: 'Total amount',

  // Invoice PDF: tax notes and sections.
  Messages.pdfNoteKleinunternehmer:
      'No VAT is charged pursuant to Section 19 of the German VAT Act '
      '(Kleinunternehmerregelung).',
  Messages.pdfNoteReverseCharge:
      'Reverse charge: the recipient of the service is liable for the VAT, '
      'which is accounted for on their side.',
  Messages.pdfSectionNotes: 'Notes',
  Messages.pdfSectionOffset: 'Offset',
  Messages.pdfTextOffsetExplanation:
      'The cancelled invoice amount is offset against outstanding receivables. '
      'No payment is required.',
  Messages.pdfSectionPaymentTerms: 'Payment terms',
  Messages.pdfTextPaymentTerms:
      'Payable within {days} days of the invoice date without deduction.',
  Messages.pdfFooterPage: 'Page {page} of {pages}',

  // Invoice PDF: line item units.
  Messages.pdfUnitPiece: 'Unit',
  Messages.pdfUnitHour: 'Hour',
  Messages.pdfUnitDay: 'Day',
  Messages.pdfUnitMonth: 'Month',
  Messages.pdfUnitProject: 'Project',
  Messages.pdfUnitOther: 'Other',
};
