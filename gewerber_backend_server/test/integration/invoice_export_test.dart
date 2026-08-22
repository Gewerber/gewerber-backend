@Tags(['integration'])
library;

import 'dart:convert';

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Splits a single CSV row on semicolons while respecting double-quoted
/// fields (which may contain the separator).
List<String> splitCsvRow(String row) {
  final fields = <String>[];
  final current = StringBuffer();
  var inQuotes = false;
  for (var i = 0; i < row.length; i++) {
    final char = row[i];
    if (char == '"') {
      if (inQuotes && i + 1 < row.length && row[i + 1] == '"') {
        current.write('"');
        i++;
      } else {
        inQuotes = !inQuotes;
      }
    } else if (char == ';' && !inQuotes) {
      fields.add(current.toString());
      current.clear();
    } else {
      current.write(char);
    }
  }
  fields.add(current.toString());
  return fields;
}

void main() {
  const testUserId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const otherUserId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given invoice export', (sessionBuilder, endpoints) {
    late TestSessionBuilder authenticatedSession;
    late int businessId;
    late Customer customer;

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
      customer = await endpoints.customer.create(
        authenticatedSession,
        CreateCustomerRequest(name: 'ACME; GmbH', email: 'a@acme.de'),
        businessId: businessId,
      );
    });

    Future<Invoice> createInvoice({int unitPriceCents = 10000}) async {
      return endpoints.invoice.create(
        authenticatedSession,
        CreateInvoiceRequest(
          customerId: customer.id,
          issueDate: DateTime(2026, 8, 14),
          dueDate: DateTime(2026, 8, 28),
          items: [
            InvoiceItemRequest(
              description: 'Beratung',
              quantity: 2,
              unit: InvoiceItemUnit.hour,
              unitPriceCents: unitPriceCents,
              vatRate: VatRate.standard,
            ),
          ],
        ),
        businessId: businessId,
      );
    }

    test('when exporting CSV then rows contain totals and customer', () async {
      final invoice = await createInvoice();

      final csv = await endpoints.invoice.exportCsv(
        authenticatedSession,
        businessId: businessId,
      );

      final lines = csv.trim().split('\n');
      expect(lines.length, 2);
      expect(
        lines.first,
        'Nummer;Typ;Status;Kunde;Ausstellungsdatum;Fälligkeitsdatum;'
        'Netto;USt;Gesamt;Währung',
      );

      final fields = splitCsvRow(lines.last);
      expect(fields[0], invoice.number);
      expect(fields[1], 'invoice');
      expect(fields[2], 'draft');
      // Customer name with a semicolon must be CSV-quoted (quotes stripped).
      expect(fields[3], 'ACME; GmbH');
      expect(fields[4], '14.08.2026');
      expect(fields[5], '28.08.2026');
      expect(fields[6], '200,00');
      expect(fields[7], '38,00');
      expect(fields[8], '238,00');
      expect(fields[9], 'eur');
    });

    test(
      'when exporting CSV with status filter then only matching rows',
      () async {
        await createInvoice();
        final sent = await createInvoice();
        await endpoints.invoice.markSent(
          authenticatedSession,
          sent.id!,
          businessId: businessId,
        );

        final csv = await endpoints.invoice.exportCsv(
          authenticatedSession,
          status: InvoiceStatus.sent,
          businessId: businessId,
        );

        final lines = csv.trim().split('\n');
        expect(lines.length, 2);
        expect(splitCsvRow(lines.last)[0], sent.number);
      },
    );

    test('when exporting JSON then invoices and items are included', () async {
      final invoice = await createInvoice(unitPriceCents: 12345);

      final raw = await endpoints.invoice.exportJson(
        authenticatedSession,
        businessId: businessId,
      );

      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      expect(decoded['exportedAt'], isNotNull);
      final invoices = decoded['invoices'] as List<dynamic>;
      expect(invoices.length, 1);

      final entry = invoices.first as Map<String, dynamic>;
      final invoiceJson = entry['invoice'] as Map<String, dynamic>;
      expect(invoiceJson['number'], invoice.number);
      expect(invoiceJson['totalCents'], 2 * 12345 + 4691);

      final items = entry['items'] as List<dynamic>;
      expect(items.length, 1);
      expect((items.first as Map<String, dynamic>)['description'], 'Beratung');
    });

    test('when exporting then other tenant data is not included', () async {
      await createInvoice();

      final otherSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          otherUserId,
          {},
        ),
      );
      final otherBusiness = await endpoints.business.create(
        otherSession,
        CreateBusinessRequest(name: 'Anderes Gewerbe'),
      );

      final csv = await endpoints.invoice.exportCsv(
        otherSession,
        businessId: otherBusiness.id,
      );
      expect(csv.trim().split('\n').length, 1);
    });
  });
}
