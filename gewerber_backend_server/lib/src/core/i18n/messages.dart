/// Stable message keys for every user-facing, backend-rendered string.
///
/// Keys are part of the backend's internal contract with its own catalogs and
/// are namespaced by surface (`error.*`, `pdf.*`, `email.*`, `guidance.*`).
/// They are **not** part of the wire protocol: exceptions keep carrying a
/// human-readable `message` string, resolved server-side through
/// `MessageCatalog`, so already-deployed clients need no change and no
/// client-side catalog exists yet.
///
/// Rules for keys:
///  - Namespaced by the surface that renders the text, dot-separated.
///  - Never renamed or reused for a different meaning. Add a new key instead;
///    a rename silently changes what existing callers display.
///  - Templates may only use `{camelCase}` placeholders, substituted by
///    `interpolate` from the `args` map at the call site.
///
/// Keep this class and the maps in `message_maps_*.dart` in sync — the
/// `message_catalog_test.dart` completeness test enforces that every key here
/// exists in the fallback catalog.
abstract final class Messages {
  // --- Tenancy / authentication errors -------------------------------------
  // Thrown by `core/tenant` resolvers, `core/admin` and the user module. These
  // were the most duplicated literals in the codebase (8 copies of
  // "Not authenticated.") and are the seed catalog for issue #57.

  /// `ForbiddenException` — no authenticated user on the session.
  static const String errorNotAuthenticated = 'error.notAuthenticated';

  /// `ForbiddenException` — authenticated, but not a member of the business.
  static const String errorNotBusinessMember = 'error.notBusinessMember';

  /// `ForbiddenException` — business member without an admin membership role.
  static const String errorAdminPermissionsRequired =
      'error.adminPermissionsRequired';

  /// `ForbiddenException` — global admin surface without an admin role.
  static const String errorAdminRoleRequired = 'error.adminRoleRequired';

  /// `ForbiddenException` — global admin role below the required level.
  /// Placeholders: `{minimum}`, `{granted}`.
  static const String errorInsufficientAdminRole =
      'error.insufficientAdminRole';

  // --- Invoice PDF: document identity --------------------------------------

  /// PDF title and metadata for an ordinary invoice.
  static const String pdfDocumentInvoice = 'pdf.document.invoice';

  /// PDF title and metadata for a credit note (Storno / Gutschrift).
  static const String pdfDocumentCreditNote = 'pdf.document.creditNote';

  /// Label for a credit note's correction notice.
  /// Placeholder: `{number}`.
  static const String pdfDocumentCancellationNotice =
      'pdf.document.cancellationNotice';

  /// Label for a correction invoice's reference line.
  /// Placeholders: `{number}`.
  static const String pdfDocumentCorrectionNote = 'pdf.document.correctionNote';

  // --- Invoice PDF: party and header fields ---------------------------------

  /// Sender/business VAT identification number label.
  static const String pdfFieldVatId = 'pdf.field.vatId';

  /// Sender/business tax number label.
  static const String pdfFieldTaxNumber = 'pdf.field.taxNumber';

  /// Email address field label.
  static const String pdfFieldEmail = 'pdf.field.email';

  /// Phone number field label.
  static const String pdfFieldPhone = 'pdf.field.phone';

  /// Recipient block heading on an ordinary invoice.
  static const String pdfFieldInvoiceRecipient = 'pdf.field.invoiceRecipient';

  /// Recipient block heading on a credit note.
  static const String pdfFieldCreditNoteRecipient =
      'pdf.field.creditNoteRecipient';

  /// Customer VAT identification number label.
  static const String pdfFieldCustomerVatId = 'pdf.field.customerVatId';

  /// Document number label on an ordinary invoice.
  static const String pdfFieldInvoiceNumber = 'pdf.field.invoiceNumber';

  /// Document number label on a credit note.
  static const String pdfFieldCreditNoteNumber = 'pdf.field.creditNoteNumber';

  /// Issue date label on an ordinary invoice.
  static const String pdfFieldInvoiceDate = 'pdf.field.invoiceDate';

  /// Issue date label on a credit note.
  static const String pdfFieldCreditNoteDate = 'pdf.field.creditNoteDate';

  /// Banner shown on a cancelled invoice.
  static const String pdfFieldCancelledInvoice = 'pdf.field.cancelledInvoice';

  /// Payment due date label.
  static const String pdfFieldDueDate = 'pdf.field.dueDate';

  /// Service period label.
  static const String pdfFieldServicePeriod = 'pdf.field.servicePeriod';

  // --- Invoice PDF: line item table -----------------------------------------

  /// Line item table header — position column.
  static const String pdfTablePosition = 'pdf.table.position';

  /// Line item table header — description column.
  static const String pdfTableDescription = 'pdf.table.description';

  /// Line item table header — quantity column.
  static const String pdfTableQuantity = 'pdf.table.quantity';

  /// Line item table header — unit column.
  static const String pdfTableUnit = 'pdf.table.unit';

  /// Line item table header — net unit price column.
  static const String pdfTableUnitPrice = 'pdf.table.unitPrice';

  /// Line item table header — VAT rate column.
  static const String pdfTableVatRate = 'pdf.table.vatRate';

  /// Line item table header — line total column.
  static const String pdfTableLineTotal = 'pdf.table.lineTotal';

  // --- Invoice PDF: totals --------------------------------------------------

  /// Net subtotal row label.
  static const String pdfTotalNetSubtotal = 'pdf.total.netSubtotal';

  /// VAT amount row label.
  static const String pdfTotalVat = 'pdf.total.vat';

  /// Grand total row label.
  static const String pdfTotalGrandTotal = 'pdf.total.grandTotal';

  // --- Invoice PDF: tax notes and sections ----------------------------------

  /// §19 UStG (Kleinunternehmer) exemption note.
  static const String pdfNoteKleinunternehmer = 'pdf.note.kleinunternehmer';

  /// Reverse charge note.
  static const String pdfNoteReverseCharge = 'pdf.note.reverseCharge';

  /// Free-text notes section heading.
  static const String pdfSectionNotes = 'pdf.section.notes';

  /// Offset ("Verrechnung") section heading.
  static const String pdfSectionOffset = 'pdf.section.offset';

  /// Body text of the offset section on a cancelled invoice.
  static const String pdfTextOffsetExplanation = 'pdf.text.offsetExplanation';

  /// Payment terms section heading.
  static const String pdfSectionPaymentTerms = 'pdf.section.paymentTerms';

  /// Body text of the payment terms section.
  /// Placeholders: `{days}`.
  static const String pdfTextPaymentTerms = 'pdf.text.paymentTerms';

  /// Page footer pagination.
  /// Placeholders: `{page}`, `{pages}`.
  static const String pdfFooterPage = 'pdf.footer.page';

  // --- Invoice PDF: line item units ----------------------------------------
  // Rendered next to a quantity in the line item table.

  /// Unit "Stk." — piece.
  static const String pdfUnitPiece = 'pdf.unit.piece';

  /// Unit "Std." — hour.
  static const String pdfUnitHour = 'pdf.unit.hour';

  /// Unit "Tag" — day.
  static const String pdfUnitDay = 'pdf.unit.day';

  /// Unit "Monat" — month.
  static const String pdfUnitMonth = 'pdf.unit.month';

  /// Unit "Projekt" — project.
  static const String pdfUnitProject = 'pdf.unit.project';

  /// Unit "Sonst." — anything else.
  static const String pdfUnitOther = 'pdf.unit.other';
}
