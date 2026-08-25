# Changelog

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
