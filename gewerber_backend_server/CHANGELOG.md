# Changelog

## Unreleased

- XRechnung export now emits a document that passes the official KoSIT
  validator on the XRechnung 3.0.2 scenario: XRechnung 3.0.2 guideline id,
  mandatory delivery/settlement elements, BT-9 due date, BT-10 buyer
  reference, BT-23 business process, BG-6 seller contact, BT-34/BT-49
  electronic addresses, BG-16 payment instructions.
- Credit notes state amounts as on the original invoice (the document type
  conveys the credit) instead of negating them, per Peppol BIS 3.0 §5.6.1
  and EN 16931 BR-27/BR-28.
- New persisted fields: BusinessSettings.iban/bic/accountHolder and
  Customer.buyerReference (migration included).
- invoice.exportXrechnung now fails with a ValidationException listing
  every missing mandatory field instead of emitting invalid XML.
- New CI job validates the committed fixtures with the official KoSIT
  validator (1.6.3, XRechnung 3.0.2 configuration v2026-08-31); the
  fixtures are pinned byte-for-byte by a golden test.

## 0.0.1 - 2026-08-25

Initial release of the Gewerber open-source backend (Serverpod).

- Core platform: multi-tenancy (business scoping), DI, audit trail,
  serializable exceptions, events, mail service.
- Business module: businesses, memberships and business settings.
- Invoicing module: customers, invoices, templates, payments, recurring
  schedules, reminders, PDF generation and CSV/JSON export.
- Time tracking module: projects, tasks, time entries with timer, rounding,
  reports and invoice creation.
- Accounting module: income/expense transactions, receipts, P&L, CSV export.
- Guidance module: tooltips, checklists and per-user progress.
- Dashboard module: aggregated summary endpoint.
- Admin API: global admin roles, user/business/invoice administration and
  audit query surface for the AI MCP admin server.
- Auth via serverpod_auth (JWT + email IdP).
