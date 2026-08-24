# TODO — gewerber-backend

План по итогам аудита (2026-08). Порядок: этапы 0 → 1 → 2 → 3(масштабирование).
Каждый фикс сопровождать интеграционным тестом (`withServerpod`, postgres_test).

---

## Этап 0 — Критические исправления (P0)

### Корректность финансовых операций
- [x] **IDOR**: ownership-check для `customerId` при создании/редактировании счёта ✅ 2026-08-22
- [x] **IDOR**: проверка владения `receiptDocumentId` / `relatedInvoiceId` в transaction use cases ✅ 2026-08-22 (валидатор уже был, добавлены тесты)
- [x] **IDOR**: проверка владения `logoDocumentId` в шаблонах счетов ✅ 2026-08-22
- [x] **Status-guard**: редактирование счёта только в `draft`;
      применять Kleinunternehmer §19 переопределение также в `update` ✅ 2026-08-22
- [x] **Delete**: разрешить только для `draft`/`cancelled`;
      запретить для `partiallyPaid` и `overdue` ✅ 2026-08-22 (allow-list вместо deny-list)
- [x] **RecordPayment**: перенести расчёт paidTotal внутрь транзакции
      (LockMode.forUpdate по invoice); отклонять переплату явно ✅ 2026-08-22
- [x] **Recurring**: номеровать клоны через `SequenceGateway`;
      `_hasMaterialized` без `limit:1`; `dueDate` клона = `issueDate + paymentTermsDays`;
      KU/VAT переоцениваются на момент materialization ✅ 2026-08-22
- [x] **Таймер**: unique index `(businessId, stoppedAt) NULLS NOT DISTINCT`
      (миграция `20260822105809409`); гонка в start → `ConflictException` ✅ 2026-08-22

### CI (org-wide gap)
- [x] `.github/workflows/ci.yml`: `dart analyze` + `dart test` (service postgres_test) на PR и push в main/develop ✅ 2026-08-22
- [ ] Настроить branch protection: обязательный зелёный CI перед merge *(ручной шаг владельца: Settings → Branches → required check «Analyze & test»)*

**DoD этапа 0:** все пункты покрыты тестами, CI зелёный в основном PR.

---

## Этап 1 — Надёжность, производительность, GDPR (P1)

### Производительность
- [x] Cap лимитов во всех list use cases: `min(limit ?? 100, 200)` ✅ 2026-08-22
      (`core/pagination/list_limits.dart` → 8 list use cases; негативный limit =
      «не задан», чтобы не пробить cap через SQL LIMIT < 0)
- [x] Батчинг в биллинге времени: один `UPDATE ... WHERE id IN (...)` внутри tx ✅ 2026-08-22
      (`TimeEntryGateway.markInvoiced` через ORM `updateWhere`, noReturn)
- [x] JSON-export инвойсов: убрать N+1 (batched `WHERE invoiceId IN (...)` или related fetch) ✅ 2026-08-22
      (items одним запросом + customer names батчем — CSV тоже; тест на байт-в-байт
      идентичность с прежним N+1 пайплайном, кроме volatile `exportedAt`)
- [x] Метаданные пагинации (total count): offset-пилот `invoice.listPage` /
      `customer.listPage` → `InvoiceListPage` / `CustomerListPage`
      {items, totalCount, limit, offset} ✅ 2026-08-23 (старые `list` не тронуты;
      кап лимита как в `list`)
- [x] Cursor-based пагинация для больших списков (продолжение пилота) ✅ 2026-08-23
      (`invoice.listCursorPage` / `customer.listCursorPage`: opaque base64url-курсор
      {v, businessId, lastId, sortValue}, стабильный порядок issueDate/createdAt DESC +
      id DESC tiebreak, `nextCursor: null` = конец; без total count — O(page size).
      Курсор чужого tenant'а → ValidationException(field: 'cursor') ✅ 2026-08-23,
      решение владельца — security best practice вместо молчаливой пустой страницы;
      тамперенный/мусорный курсор тоже ValidationException; старые `list`/`listPage`
      не тронуты)
- [x] Ревизия индексов в миграциях: `businessId` везде (аудит 2026-08-23 —
      покрыты все business-scoped таблицы; recurring прикрыт существующим
      `invoice_recurrence_idx`), составной `(businessId, status, dueDate)`
      для overdue-job добавлен (миграция `20260823054539439`)
- [x] markOverdue per-business обход ✅ 2026-08-23 (hourly job обновляет
      per-business с предикатом `businessId = ?` — композитный индекс
      `(businessId, status, dueDate)` теперь используется; поведение идентичное,
      тест на несколько бизнесов + нетронутые статусы)

### Надёжность данных / деплой
- [x] Бэкапы Postgres: pg_dump (custom format) cron + restore runbook (`deploy/`)
      ✅ 2026-08-23 (`deploy/backup.sh` — daily naming, retention, integrity-check;
      `deploy/restore.sh` — верификация, подтверждение, stop server → restore → start;
      runbook с RTO/RPO в `deploy/README.md`; WAL/PITR для RPO < 6 ч — за скобками)
- [x] Log retention — `sessionLogs.persistentEnabled: true` растёт бесконтрольно
      ✅ 2026-08-23 (документировано в `deploy/README.md`: переключатель persistence
      в `config/<runmode>.yaml`, SQL-пример DELETE старше N дней для
      `serverpod_session_log` (+ query/message child tables), cron-пример)
- [x] Resource limits (mem/cpu) в `deploy/docker-compose.yml` ✅ 2026-08-23
      (`deploy.resources.limits`: server 1g/1.0, postgres 512m/0.50,
      redis 256m/0.25; override через `.env`, переменные задокументированы)
- [x] Задокументировать роль Redis (кэш vs messaging) + решить persistence
      ✅ 2026-08-23 (`deploy/README.md` раздел «Redis»: инвентаризация — код
      Redis-backed фичи не использует, Redis = headroom для >1 реплики;
      persistence OFF (--save "" --appendonly no в docker-compose) — всё
      durable живёт в Postgres; критерии «когда нужен / когда можно убрать»)

### Безопасность / комплаенс
- [x] **IDOR**: владение `templateId` в Create/UpdateInvoiceRequest ✅ 2026-08-22 (батч C1: NotFoundException при чужом/несуществующем шаблоне)
- [x] Upload: коллизия одинакового `stoppedAt` при ручном вводе time entry → `ValidationException` вместо 500 ✅ 2026-08-22 (батч C1; отклонение легитимных same-second остановок таймера принято владельцем)
- [x] **GDPR Art. 17**: endpoint удаления аккаунта (soft-delete + анонимизация
      `membership.userId`, `document.uploadedById`, `audit_entry.userId`, `user_guidance_progress.userId`)
      ✅ 2026-08-22 — `userProfile.deleteMyAccount`: маркер `user_profile.deletedAt`
      (тумбстоун создаётся, даже если профиля не было), все персональные ссылки
      обнуляются bulk-`updateWhere` в ОДНОЙ транзакции, бизнес-данные сохраняются
      (GoBD). Повторный вызов и использование удалённого аккаунта
      (`getMyProfile`/`update`/`business.create`) → `NotFoundException`.
      Принято владельцем 2026-08-22: serverpod_auth хранит email идентичность
      (нет задокументированного API удаления) — политика ретеншена.
- [x] Guidance write-эндпоинты (markCompleted/dismissTip) — guard от удалённого юзера ✅ 2026-08-22
      (проверка в `GuidanceSessionService.requireUser` — покрывает и будущие mutations;
      read `myProgress` без guard'а, для удалённых возвращает пусто)
- [x] **GDPR Art. 20**: полный экспорт данных пользователя ✅ 2026-08-23 —
      `userProfile.exportMyData` (ZIP, `archive`-пакет): manifest.json (версия
      формата), профиль, memberships, guidance progress + по каждому СВОЕМУ
      бизнесу: customers / invoices+items / projects+tasks+time entries /
      transactions / documents (метаданные + содержимое из DatabaseStorage,
      defensive-cap 512 KB на файл). Чужие tenant'ы не читаются (тест).
- [x] **GDPR Art. 20** — payments/reminders включены в экспорт ✅ 2026-08-23
      (`payments.json` / `reminders.json` внутри `businesses/<id>/`; batched
      `findByInvoiceIds` у PaymentRecordGateway и ReminderGateway по образцу items;
      версия формата экспорта 1 → 2, manifest layout дополнен; тесты: секции обоих
      бизнесов, чужие платежи/напоминания отсутствуют)
- [x] Upload: MIME/расширение whitelist ✅ 2026-08-23
      (`documents/domain/upload_policy.dart` — консервативный список:
      pdf/png/jpeg/webp/txt/csv/zip; расширение решает, переданный content-type
      должен быть из глобального whitelist'а; рассинхрон расширение↔MIME —
      доверяем расширению, warning в лог. Размер ограничен `maxRequestSize`
      на HTTP-слое, отдельный лимит в use case не нужен)
- [x] Audit: писать запись в той же транзакции (или outbox); аудировать guidance progress
      и recurring-materialization; заполнить `AuditEntry.businessId` для системных событий
      ✅ 2026-08-23 (`AuditService.log(transaction:)`; аудит перенесён внутрь tx:
      invoice.create/update, payment.record, template create/update, business.create;
      account.delete остался после commit намеренно — без персональных ссылок;
      новые события: guidance.markCompleted/dismissTip (user-scoped),
      invoice.recurringMaterialized (в tx материализации, businessId заполнен),
      invoice.markOverdue (per-business, businessId + count); тест: rollback мутации
      не оставляет audit-запись)
- [x] Длина верификационных кодов 8 знаков ✅ 2026-08-23
      (`server.dart`: `_verificationCodeLength = 8`, генератор переименован в
      `_generateVerificationCode`; длина задаётся функцией-генератором IdP,
      отдельного конфиг-параметра нет. ⚠️ Проверить input-маску кода в
      gewerber-app — клиент может ожидать 6 цифр)

---

## Этап 2 — Новые возможности (P2)

- [x] **Поштучный биллинг time entries**: `timeEntry.createInvoice` принимает
      опциональный `timeEntryIds: List<int>?` ✅ 2026-08-23 (запрос владельца;
      null/пустой → прежний режим «проект+период»; с ID — валидации: tenant,
      тот же проект, stoppedAt != null, billable, не invoiced; нарушения одним
      ValidationException(field: 'timeEntryIds') с перечислением проблемных ID;
      ⚠️ тип `List<int>` — TimeEntry.id серийный int, а не UuidValue)
- [x] **Recurring management API**: эндпоинт `recurringSchedule` (create/get/list/update/cancel) ✅ 2026-08-22
      (батч D1 — разблокировка UI приложения; расписание = поля исходного инвойса,
      без дублирования сущности; IDOR ×5 тестов; attach разрешён для любого статуса инвойса,
      прошедшая nextRecurrenceDate = backfill на следующем tick — семантика утверждена владельцем)
- [x] Recurring: clear-флаги `clearRecurrenceEndDate` / `clearMaxOccurrences` в update ✅ 2026-08-23
      (батч D2 — точечное снятие ограничений, flag=true перекрывает поле запроса)
- [x] `recurringSchedule.update`: флаги `clearRecurrenceEndDate` /
      `clearMaxOccurrences` для снятия ограничений ✅ 2026-08-23
      (flag=true → очистить независимо от значения поля в запросе; тесты ×4)
- [ ] **Membership management**: invite / remove / change role эндпоинты
      (роль создаётся только как owner при создании бизнеса)
- [ ] **Автоматический dunning**: отправка Mahnung по расписанию в hourly job
      (MailService и mark-overdue уже есть — соединить)
- [ ] **Korrekturrechnung / credit notes**: сторнирующий flow поверх статуса `cancelled`
- [ ] **E-Rechnung MVP ⭐**: экспорт XRechnung (XML) — обязанность приёма B2B уже действует,
      выставления — с 2027–2028; killer-feature в границах open-core
- [ ] S3 storage adapter за существующим интерфейсом (спека обещает S3, факт — DatabaseStorage)
- [ ] Multi-language писем/PDF/guidance (enum `Locale(de,en,ru,tr)` есть, контент захардкожен на de)
- [ ] Rate limiting публичных эндпоинтов
- [ ] Entitlement enforcement-точки в бизнес-логике (сейчас scaffold вызывается только из endpoint)

### Лидогенерация (связка с gewerber-website)
- [ ] **Waitlist: атрибуция первого касания** — изменение в закрытом модуле
      `gewerber-backend-commercial`: расширить
      `gewerber_commercial_server/lib/src/modules/waitlist/models/join_waitlist_request.spy.yaml`
      и таблицу `waitlist_entry.spy.yaml` опциональными полями
      `utmTerm`, `utmContent`, `gclid`, `fbclid`, `landingPage` (все `String?`),
      пробросить в use case создания записи → `serverpod generate` +
      `serverpod create-migration` + тест.
      Контекст: сайт уже собирает first-touch (localStorage → скрытые поля,
      `attribution.dart`) и парсит его (`waitlist_handler.dart`), но в запрос к
      бэкенду новые ключи не отправляет, пока контракт не расширен. После
      релиза модуля включить отправку в
      `gewerber-website/lib/server/waitlist_client.dart` (заготовка есть,
      ~5 строк). Результат: каждый лид приходит в БД с полным источником.

---

## Этап 3 — Масштабирование (квартал 2)

- [ ] Zero-downtime деплой (blue-green через Traefik, отказ от фиксированного `container_name`)
- [ ] Готовность к >1 реплике: sticky WebSocket в Traefik, распределённые локи FutureCall
- [ ] Streams/WebSocket для синхронизации таймера между устройствами (EventBus оживить)
- [ ] Офлайн-sync эндпоинты (курсоры по `updatedAt`) — совместно с приложением

---

## Техдолг / заметки
- EventBus (`core/events/`) зарегистрирован в DI, но никем не используется — либо применить, либо удалить
- `memberships.first` без сортировки в TenantResolver — произвольный дефолтный бизнес при мультитенантности
- Ролевая модель: зафиксировать матрицу прав owner/admin/member документацией
- [x] §19-маппинг дублировался в create/update/recurring use cases — извлечён в `TaxRuleEngine.applyKleinunternehmerOverride` ✅ 2026-08-22 (батч C1)
