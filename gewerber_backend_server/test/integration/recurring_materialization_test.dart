@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/core/di/service_locator.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/application/process_recurring_invoices_use_case.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/domain/invoice_gateway.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  const testUserId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod(
    'Given recurring invoice materialization',
    (sessionBuilder, endpoints) {
      late TestSessionBuilder authenticatedSession;
      late int businessId;
      late ProcessRecurringInvoicesUseCase useCase;

      setUp(() async {
        authenticatedSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            testUserId,
            {},
          ),
        );
        final business = await endpoints.business.create(
          authenticatedSession,
          CreateBusinessRequest(name: 'Mein Gewerbe'),
        );
        businessId = business.id!;
        useCase = getIt<ProcessRecurringInvoicesUseCase>();
      });

      Future<Invoice> createSource({
        int paymentTermsDays = 14,
        VatRate vatRate = VatRate.standard,
        int unitPriceCents = 50000,
      }) {
        return endpoints.invoice.create(
          authenticatedSession,
          CreateInvoiceRequest(
            issueDate: DateTime(2026, 7, 1),
            nextRecurrenceDate: DateTime(2026, 8, 1),
            recurrenceInterval: RecurrenceInterval.monthly,
            paymentTermsDays: paymentTermsDays,
            items: [
              InvoiceItemRequest(
                description: 'Miete',
                quantity: 1,
                unitPriceCents: unitPriceCents,
                vatRate: vatRate,
              ),
            ],
          ),
          businessId: businessId,
        );
      }

      Future<Invoice> materializedClone(int sourceId) async {
        final invoices = await endpoints.invoice.list(
          authenticatedSession,
          businessId: businessId,
        );
        return invoices.firstWhere((i) => i.id != sourceId);
      }

      test(
        'when materializing then the clone gets a fresh sequence number',
        () async {
          final source = await createSource();
          expect(source.number, '2026-0001');

          final createdCount = await useCase.call(
            authenticatedSession.build(),
            now: DateTime(2026, 8, 2),
          );
          expect(createdCount, 1);

          final clone = await materializedClone(source.id!);
          // The old scheme produced '${source.number}-R'; clones now consume
          // the next value of the GoBD-safe business sequence.
          expect(clone.number, isNot('${source.number}-R'));
          expect(clone.number, '2026-0002');
        },
      );

      test(
        'when materializing then dueDate is issueDate plus paymentTermsDays',
        () async {
          final source = await createSource(paymentTermsDays: 30);

          await useCase.call(
            authenticatedSession.build(),
            now: DateTime(2026, 8, 2),
          );

          final clone = await materializedClone(source.id!);
          expect(clone.issueDate.toUtc(), DateTime(2026, 8, 1).toUtc());
          expect(clone.dueDate!.toUtc(), DateTime(2026, 8, 31).toUtc());
        },
      );

      test(
        'when a clone for the recurrence date already exists then it is not duplicated',
        () async {
          final source = await createSource();
          final createdCount = await useCase.call(
            authenticatedSession.build(),
            now: DateTime(2026, 8, 2),
          );
          expect(createdCount, 1);

          // Simulate a repeated job run that still sees the old recurrence
          // date (e.g. crash after cloning but before advancing the source).
          final gateway = getIt<InvoiceGateway>();
          final stored = await gateway.findById(
            authenticatedSession.build(),
            source.id!,
          );
          await gateway.update(
            authenticatedSession.build(),
            stored!.copyWith(
              nextRecurrenceDate: DateTime(2026, 8, 1),
              recurrenceOccurrencesCreated: 0,
            ),
          );

          final createdAgain = await useCase.call(
            authenticatedSession.build(),
            now: DateTime(2026, 8, 2),
          );
          expect(createdAgain, 0);

          final invoices = await endpoints.invoice.list(
            authenticatedSession,
            businessId: businessId,
          );
          expect(invoices, hasLength(2));
        },
      );

      test(
        'when the business becomes Kleinunternehmer then VAT is re-evaluated on materialization',
        () async {
          final source = await createSource(vatRate: VatRate.standard);
          expect(source.vatTotalCents, 9500);

          // After the source was issued, the owner switches to §19 UStG.
          await endpoints.business.update(
            authenticatedSession,
            UpdateBusinessRequest(
              businessId: businessId,
              name: 'Mein Gewerbe',
              legalForm: LegalForm.einzelunternehmen,
              isKleinunternehmer: true,
              locale: Locale.de,
              currency: Currency.eur,
            ),
          );

          await useCase.call(
            authenticatedSession.build(),
            now: DateTime(2026, 8, 2),
          );

          final clone = await materializedClone(source.id!);
          expect(clone.subtotalCents, 50000);
          expect(clone.vatTotalCents, 0);
          expect(clone.totalCents, 50000);

          final items = await endpoints.invoice.getItems(
            authenticatedSession,
            clone.id!,
            businessId: businessId,
          );
          expect(items.single.vatRate, VatRate.none);

          // ... while the already-issued source stays untouched.
          final fetchedSource = await endpoints.invoice.get(
            authenticatedSession,
            source.id!,
            businessId: businessId,
          );
          expect(fetchedSource.vatTotalCents, 9500);
        },
      );
    },
  );
}
