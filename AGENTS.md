# Flutter & Serverpod project

Gewerber open-core backend — multi-tenant SaaS for solo Gewerbe owners in Germany.

## Stack

- Serverpod 4.0-beta backend (server + generated client)
- Auth: serverpod_auth (JWT + email IdP)
- DI: get_it + injectable
- Architecture: Clean Architecture per module

## Project Structure

```
gewerber_backend_server/lib/src/
  core/                          # shared kernel
    di/                          # get_it locator + injectable config
    tenant/                      # TenantContext, TenantResolver, Session.authUserId
    audit/                       # AuditEntry model + AuditService
    events/                      # EventBus (MessageCentral wrapper)
    errors/                      # Serializable exceptions (NotFound, Validation, Forbidden, Conflict)
    endpoints/                   # BusinessScopedEndpoint base class
  modules/
    business/                    # M1: Business + Membership + onboarding
    # invoicing/ time_tracking/ accounting/ documents/ guidance/ — next phases
  auth/                          # serverpod_auth_idp email/JWT endpoints
  generated/                     # Serverpod-generated code (do not edit)
```

## Key Conventions

- **Multi-tenancy**: every business-scoped table has `businessId`; `TenantResolver` resolves the current tenant from JWT `userIdentifier` + `Membership`.
- **DI**: endpoints are constructed by Serverpod codegen without arguments — they resolve services via `getIt<T>()`.
- **Naming**: domain interfaces use `*Gateway` suffix (e.g. `BusinessGateway`) to avoid collision with Serverpod's generated `*Repository` classes.
- **Enums**: always use `serialized: byName` in `.spy.yaml`.
- **String defaults**: must be quoted (`default='de'`).
- **Exceptions**: use generated `.spy.yaml` exceptions — they're thrown on the server and caught on the client by type.
- **Tests**: integration tests via `withServerpod` with test postgres (docker compose `postgres_test`). Call `configureDependencies()` in `setUpAll`.

## Endpoints

| Endpoint | Methods | Auth |
|---|---|---|
| `business` | create, get, update, listMine | requireLogin |
| auth (module) | email login/register, JWT refresh | per serverpod_auth |

## Phases

| Phase | Content | Status |
|---|---|---|
| M0 | DI, tenant, audit, errors, events, base endpoint | ✅ Done |
| M1 | Business + Membership + onboarding | ✅ Done |
| M2 | Invoicing (Client, Invoice, TaxRuleEngine, PDF, recurring) | Planned |
| M3 | Time tracking (Project, Task, TimeEntry, rounding, reports) | Planned |
| M4 | Accounting (Expense, Income, P&L, receipts) | Planned |
| M5 | Guidance (tooltips, checklists) | Planned |

## Commands

```bash
serverpod generate          # regenerate models/endpoints after changing .spy.yaml
serverpod create-migration  # create DB migration (after table changes)
dart run build_runner build # regenerate injectable DI config
dart analyze                # required before PR
dart format .               # required before PR
dart test                   # integration tests (needs postgres_test)
```

## Checklist after doing changes

1. `dart analyze` (CLI)
2. `dart format` (CLI)
3. `serverpod create-migration` (CLI — only if models changed)
4. Do `serverpod` MCP `hot_restart` if required
5. Run tests (`dart test` — needs `docker compose up -d postgres_test`)
6. Check `serverpod` MCP `tail_server_logs` and `tail_flutter_logs` for any issues.

The user starts the server and Flutter app with `serverpod start`. NEVER start the server yourself.

If the user asks you to test the app:

1. Use `get_flutter_app_dtd` (`serverpod` MCP) to get the Flutter app's DTD
2. Pass the DTD to `connect_dart_tooling_daemon` (`dart` MCP) to connect to the app
3. Use `flutter_driver` (`dart` MCP) to navigate through the app
