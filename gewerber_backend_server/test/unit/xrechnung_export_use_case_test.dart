// Fail-fast precondition tests for `XrechnungExportUseCase`.
//
// House pattern (see `tenant_resolver_locale_test.dart`): the gateways and
// `Session` are faked with `implements` + `noSuchMethod`, overriding only the
// methods the use case actually calls — no database, no network, no KoSIT
// validator. The behaviour under test is the aggregated precondition check:
// every missing required field must be named in a single ValidationException
// so the user can fix all gaps in one pass.
import 'package:gewerber_backend_server/src/core/tenant/tenant_context.dart';
import 'package:gewerber_backend_server/src/core/tenant/tenant_resolver.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/business/domain/business_gateway.dart';
import 'package:gewerber_backend_server/src/modules/business/domain/business_settings_gateway.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/application/xrechnung_export_use_case.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/domain/customer_gateway.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/domain/invoice_gateway.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/domain/invoice_item_gateway.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

/// Minimal fake: unimplemented [Session] members route through
/// `noSuchMethod`. The use case only forwards the session to the gateways.
class _FakeSession implements Session {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

/// Always resolves the (owner) tenant of [_businessId]; the use case's
/// business lookups go through the gateway fakes, not this resolver.
class _FakeTenantResolver implements TenantResolver {
  @override
  Future<TenantContext> resolve(Session session, {int? businessId}) async =>
      TenantContext(
        userId: _userId,
        businessId: _businessId,
        role: MembershipRole.owner,
        locale: Locale.de,
      );

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeInvoices implements InvoiceGateway {
  _FakeInvoices(this._byId);

  final Map<int, Invoice> _byId;

  @override
  Future<Invoice?> findById(Session session, int id) async => _byId[id];

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeInvoiceItems implements InvoiceItemGateway {
  _FakeInvoiceItems(this._items);

  final List<InvoiceItem> _items;

  @override
  Future<List<InvoiceItem>> findByInvoiceId(
    Session session,
    int invoiceId, {
    Transaction? transaction,
  }) async => _items;

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeCustomers implements CustomerGateway {
  _FakeCustomers(this._byId);

  final Map<int, Customer> _byId;

  @override
  Future<Customer?> findById(Session session, int id) async => _byId[id];

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeBusinesses implements BusinessGateway {
  _FakeBusinesses(this._byId);

  final Map<int, Business> _byId;

  @override
  Future<Business?> findById(Session session, int id) async => _byId[id];

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeSettings implements BusinessSettingsGateway {
  _FakeSettings(this._settings);

  final BusinessSettings? _settings;

  @override
  Future<BusinessSettings?> findByBusinessId(
    Session session,
    int businessId,
  ) async => _settings;

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

const _businessId = 7;

final _userId = UuidValue.fromString(
  'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d',
);

/// Matches a [ValidationException] by its `Missing:` list only — the fixed
/// preamble of the message ("XRechnung export requires: seller e-mail, ...")
/// enumerates every required field regardless of what is actually missing,
/// so matching the whole message would be vacuous.
Matcher throwsMissing(Matcher missingList) => throwsA(
  isA<ValidationException>().having(
    (e) => e.message.split('Missing: ').last,
    'missing list',
    missingList,
  ),
);

Invoice _invoice({
  InvoiceType type = InvoiceType.invoice,
  int? customerId = 1,
  int? originalInvoiceId,
}) => Invoice(
  id: 1,
  businessId: _businessId,
  number: 'RE-2026-0001',
  type: type,
  status: InvoiceStatus.sent,
  customerId: customerId,
  originalInvoiceId: originalInvoiceId,
  issueDate: DateTime(2026, 9, 15),
  dueDate: DateTime(2026, 9, 29),
  currency: Currency.eur,
  subtotalCents: 15000,
  vatTotalCents: 2850,
  totalCents: 17850,
);

InvoiceItem _item() => InvoiceItem(
  invoiceId: 1,
  position: 1,
  description: 'Webdesign',
  quantity: 1,
  unit: InvoiceItemUnit.piece,
  unitPriceCents: 15000,
  vatRate: VatRate.standard,
  lineTotalCents: 15000,
);

/// Seller with XRechnung-mandatory contact data (BT-34 / BG-6). The defaults
/// are deliberately overridable so a test can break exactly one field.
Business _business({
  String? email = 'kontakt@acme-gewerbe.de',
  String? phone = '+49 30 1234567',
}) => Business(
  id: _businessId,
  name: 'Acme Gewerbe GmbH',
  vatId: 'DE123456789',
  email: email,
  phone: phone,
  address: Address(
    street: 'Hauptstr. 1',
    zip: '10115',
    city: 'Berlin',
    country: Country.deu,
  ),
);

/// Buyer with BT-49 e-mail and BT-10 buyer reference.
Customer _customer({
  String? email = 'max@mustermann-werkstatt.de',
  String? buyerReference = '04011000-12345-34',
}) => Customer(
  id: 1,
  businessId: _businessId,
  name: 'Max Mustermann',
  companyName: 'Mustermann Werkstatt',
  email: email,
  buyerReference: buyerReference,
  address: Address(
    street: 'Musterweg 2',
    zip: '50667',
    city: 'Köln',
    country: Country.deu,
  ),
);

/// BG-16 payment account; [iban] null simulates "settings row exists but
/// carries no IBAN".
BusinessSettings _settings({String? iban = 'DE02120300000000202051'}) =>
    BusinessSettings(
      businessId: _businessId,
      iban: iban,
      bic: 'BYLADEM1001',
      accountHolder: 'Acme Gewerbe GmbH',
    );

/// Wires the use case around the fakes with a fully-populated tenant unless
/// a part is overridden. [noSettings] simulates a missing settings row (the
/// default `settings: null` argument means "use the populated one").
XrechnungExportUseCase _useCase({
  Map<int, Invoice>? invoices,
  Map<int, Customer>? customers,
  Map<int, Business>? businesses,
  BusinessSettings? settings,
  bool noSettings = false,
  List<InvoiceItem>? items,
}) => XrechnungExportUseCase(
  _FakeTenantResolver(),
  _FakeInvoices(invoices ?? {1: _invoice()}),
  _FakeInvoiceItems(items ?? [_item()]),
  _FakeCustomers(customers ?? {1: _customer()}),
  _FakeBusinesses(businesses ?? {_businessId: _business()}),
  _FakeSettings(noSettings ? null : settings ?? _settings()),
);

void main() {
  final session = _FakeSession();

  group('export preconditions', () {
    test('a fully populated business exports the XRechnung document', () async {
      final xml = await _useCase().exportXrechnung(session, 1);

      expect(
        xml,
        contains(
          'urn:cen.eu:en16931:2017#compliant#urn:xeinkauf.de:kosit:xrechnung_3.0',
        ),
      );
      expect(
        xml,
        contains('<ram:IBANID>DE02120300000000202051</ram:IBANID>'),
      );
      expect(
        xml,
        contains('<ram:BuyerReference>04011000-12345-34</ram:BuyerReference>'),
      );
    });

    test('a missing settings row names the seller IBAN', () async {
      await expectLater(
        () => _useCase(noSettings: true).exportXrechnung(session, 1),
        throwsMissing(contains('seller IBAN')),
      );
    });

    test('settings without an IBAN names the seller IBAN', () async {
      await expectLater(
        () => _useCase(settings: _settings(iban: null)).exportXrechnung(
          session,
          1,
        ),
        throwsMissing(contains('seller IBAN')),
      );
    });

    test(
      'a customer without a buyer reference names the buyer reference',
      () async {
        await expectLater(
          () => _useCase(
            customers: {1: _customer(buyerReference: null)},
          ).exportXrechnung(session, 1),
          throwsMissing(contains('buyer reference')),
        );
      },
    );

    test('an invoice without a customer names both buyer fields', () async {
      // A dangling/absent customer is folded into the same check, so the
      // message must list every field the missing buyer would violate.
      await expectLater(
        () => _useCase(
          invoices: {1: _invoice(customerId: null)},
        ).exportXrechnung(session, 1),
        throwsMissing(
          allOf(contains('buyer e-mail'), contains('buyer reference')),
        ),
      );
    });

    test('several gaps at once are aggregated into one message', () async {
      // The point of the fail-fast: the user sees every gap in a single
      // error instead of one per export attempt. Phone is present, so BG-6
      // is satisfied and `seller phone` must NOT appear in the missing list.
      await expectLater(
        () => _useCase(
          customers: {1: _customer(buyerReference: null)},
          businesses: {_businessId: _business(email: null)},
          noSettings: true,
        ).exportXrechnung(session, 1),
        throwsMissing(
          allOf(
            contains('seller e-mail'),
            contains('seller IBAN'),
            contains('buyer reference'),
            isNot(contains('seller phone')),
          ),
        ),
      );
    });

    test(
      'a seller without a phone but with an e-mail exports (BG-6)',
      () async {
        // BR-DE-2 accepts either contact channel, so a missing phone alone
        // must not block the export.
        final xml = await _useCase(
          businesses: {_businessId: _business(phone: null)},
        ).exportXrechnung(session, 1);

        expect(
          xml,
          contains('<ram:IBANID>DE02120300000000202051</ram:IBANID>'),
        );
      },
    );

    test('a missing business raises NotFoundException', () async {
      await expectLater(
        () => _useCase(businesses: {}).exportXrechnung(session, 1),
        throwsA(
          isA<NotFoundException>().having(
            (e) => e.entityType,
            'entityType',
            'Business',
          ),
        ),
      );
    });

    test(
      'a credit note with a dangling original raises ConflictException',
      () async {
        // The conflict check runs before the precondition aggregation.
        await expectLater(
          () => _useCase(
            invoices: {
              1: _invoice(
                type: InvoiceType.creditNote,
                originalInvoiceId: 99,
              ),
            },
          ).exportXrechnung(session, 1),
          throwsA(
            isA<ConflictException>().having(
              (e) => e.message,
              'message',
              contains('no longer exists'),
            ),
          ),
        );
      },
    );
  });
}
