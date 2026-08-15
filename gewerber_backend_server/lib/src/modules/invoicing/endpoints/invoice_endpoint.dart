import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/endpoints/business_scoped_endpoint.dart';
import '../../../generated/protocol.dart';
import '../application/cancel_invoice_use_case.dart';
import '../application/create_invoice_use_case.dart';
import '../application/delete_invoice_use_case.dart';
import '../application/get_invoice_use_case.dart';
import '../application/list_invoices_use_case.dart';
import '../application/mark_invoice_sent_use_case.dart';
import '../application/update_invoice_use_case.dart';

class InvoiceEndpoint extends BusinessScopedEndpoint {
  Future<Invoice> create(
    Session session,
    CreateInvoiceRequest request, {
    int? businessId,
  }) {
    return getIt<CreateInvoiceUseCase>().call(
      session,
      request,
      businessId: businessId,
    );
  }

  Future<Invoice> get(Session session, int invoiceId, {int? businessId}) {
    return getIt<GetInvoiceUseCase>().call(
      session,
      invoiceId,
      businessId: businessId,
    );
  }

  Future<List<InvoiceItem>> getItems(
    Session session,
    int invoiceId, {
    int? businessId,
  }) {
    return getIt<GetInvoiceUseCase>().items(
      session,
      invoiceId,
      businessId: businessId,
    );
  }

  Future<Invoice> update(
    Session session,
    UpdateInvoiceRequest request, {
    int? businessId,
  }) {
    return getIt<UpdateInvoiceUseCase>().call(
      session,
      request,
      businessId: businessId,
    );
  }

  Future<List<Invoice>> list(
    Session session, {
    InvoiceStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) {
    return getIt<ListInvoicesUseCase>().call(
      session,
      status: status,
      limit: limit,
      offset: offset,
      businessId: businessId,
    );
  }

  Future<void> delete(Session session, int invoiceId, {int? businessId}) {
    return getIt<DeleteInvoiceUseCase>().call(
      session,
      invoiceId,
      businessId: businessId,
    );
  }
}
