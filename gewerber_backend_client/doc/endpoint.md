# Callable endpoints

Each class contains callable methods that call a method on the server side
(the classes are defined in the server project's `endpoints` directories).
This client sends requests to these endpoints and returns the result.

Example usage:

```dart
// Generic format.
await client.<endpoint>.<method>(...);

// List my businesses.
final businesses = await client.business.listMine();
```

Please see the full official documentation [here](https://docs.serverpod.dev)

## Endpoints

All business-scoped endpoints require an authenticated user (JWT) and scope
access to the caller's business. Admin endpoints are restricted by global
role (`moderator` = read-only, `admin` = mutations with `confirm: true`).

| Endpoint | Methods | Auth |
|---|---|---|
| `business` | create, get, update, listMine | login |
| `businessSettings` | get, update | login |
| `userProfile` | getMyProfile, update, deleteMyAccount, exportMyData | login |
| `entitlement` | list | login |
| `customer` | create, get, update, list, listPage, listCursorPage | login |
| `invoice` | create, get, getItems, update, list, listPage, listCursorPage, delete, markSent, cancel, exportCsv, exportJson, generatePdf | login |
| `invoiceTemplate` | create, get, update, list | login |
| `payment` | record, status | login |
| `recurringSchedule` | create, get, list, update, cancel | login |
| `reminder` | list, send | login |
| `document` | upload, list, get, download, delete | login |
| `project` | create, get, getTasks, update, list, delete | login |
| `task` | create, update, list | login |
| `timeEntry` | startTimer, stopTimer, create, get, update, list, delete, report, createInvoice | login |
| `accounting` | create, get, update, list, delete, profitLoss, exportCsv | login |
| `guidance` | tips, checklists, myProgress, markCompleted, dismissTip | login |
| `dashboard` | getSummary | login |
| `adminStats` | statsOverview | moderator+ |
| `adminUsers` | usersSearch, usersGet / usersVerifyEmail / usersBan, usersUnban | moderator read / admin check / admin write |
| `adminBusinesses` | businessesSearch, businessesGet / membershipsSetRole | moderator read / admin write |
| `adminInvoices` | invoicesList, invoicesGet / invoiceCancelAdmin | moderator read / admin write |
| `adminAudit` | auditQuery | moderator+ |
| `adminGuidance` | guidanceTipsList / guidanceTipUpsert | moderator read / admin write |

## Module endpoints

Provided by the wired Serverpod modules (`serverpod_auth_idp`,
`serverpod_auth_core`, `gewerber_backend_commercial`):

| Endpoint | Methods |
|---|---|
| `emailIdp` | login, startRegistration, verifyRegistrationCode, finishRegistration, startPasswordReset, verifyPasswordResetCode, finishPasswordReset, hasAccount |
| `jwtRefresh` | refreshAccessToken |

The commercial module's endpoints (e.g. public waitlist `join`) are appended
by the module at runtime and documented in its own package.
