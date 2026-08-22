import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/customer_gateway.dart';
import '../domain/invoice_gateway.dart';
import '../domain/invoice_item_gateway.dart';
import '../domain/money_formatter.dart';

/// Exports invoices of the current tenant as CSV (German accounting style:
/// semicolon-separated, comma decimals) or JSON (invoices with items).
@singleton
class ExportInvoicesUseCase {
  ExportInvoicesUseCase(
    this._tenantResolver,
    this._invoices,
    this._items,
    this._customers,
  );

  static const int _maxRows = 1000;

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;
  final InvoiceItemGateway _items;
  final CustomerGateway _customers;

  Future<String> csv(
    Session session, {
    InvoiceStatus? status,
    int? businessId,
  }) async {
    final invoices = await _load(
      session,
      status: status,
      businessId: businessId,
    );
    final customers = await _customerNames(session, invoices);

    final buffer = StringBuffer()
      ..writeln(
        'Nummer;Typ;Status;Kunde;Ausstellungsdatum;Fälligkeitsdatum;'
        'Netto;USt;Gesamt;Währung',
      );

    for (final invoice in invoices) {
      buffer.writeln(
        [
          _escapeCsv(invoice.number),
          invoice.type.name,
          invoice.status.name,
          _escapeCsv(customers[invoice.customerId] ?? ''),
          _formatDate(invoice.issueDate),
          invoice.dueDate == null ? '' : _formatDate(invoice.dueDate!),
          MoneyFormatter.formatCentsDecimal(invoice.subtotalCents),
          MoneyFormatter.formatCentsDecimal(invoice.vatTotalCents),
          MoneyFormatter.formatCentsDecimal(invoice.totalCents),
          invoice.currency.name,
        ].join(';'),
      );
    }
    return buffer.toString();
  }

  Future<String> json(
    Session session, {
    InvoiceStatus? status,
    int? businessId,
  }) async {
    final invoices = await _load(
      session,
      status: status,
      businessId: businessId,
    );

    final payload = <Map<String, dynamic>>[];
    for (final invoice in invoices) {
      final items = await _items.findByInvoiceId(session, invoice.id!);
      payload.add({
        'invoice': invoice.toJson(),
        'items': items.map((item) => item.toJson()).toList(),
      });
    }
    return jsonEncode({
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'invoices': payload,
    });
  }

  Future<List<Invoice>> _load(
    Session session, {
    InvoiceStatus? status,
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    return _invoices.find(
      session,
      businessId: tenant.businessId,
      status: status,
      limit: _maxRows,
      offset: 0,
    );
  }

  Future<Map<int, String>> _customerNames(
    Session session,
    List<Invoice> invoices,
  ) async {
    final ids = invoices.map((i) => i.customerId).whereType<int>().toSet();
    final result = <int, String>{};
    for (final id in ids) {
      final customer = await _customers.findById(session, id);
      if (customer != null) {
        result[id] = customer.companyName ?? customer.name;
      }
    }
    return result;
  }

  String _formatDate(DateTime dateTime) {
    final d = dateTime.toLocal();
    final day = d.day.toString().padLeft(2, '0');
    final month = d.month.toString().padLeft(2, '0');
    return '$day.$month.${d.year}';
  }

  String _escapeCsv(String value) {
    if (value.contains(';') || value.contains('"') || value.contains('\n')) {
      return '"${value.replaceAll('"', '""')}"';
    }
    return value;
  }
}
