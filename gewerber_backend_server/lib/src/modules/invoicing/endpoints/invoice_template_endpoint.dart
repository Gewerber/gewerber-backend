import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/endpoints/business_scoped_endpoint.dart';
import '../../../generated/protocol.dart';
import '../application/create_invoice_template_use_case.dart';
import '../application/get_invoice_template_use_case.dart';
import '../application/list_invoice_templates_use_case.dart';
import '../application/update_invoice_template_use_case.dart';

class InvoiceTemplateEndpoint extends BusinessScopedEndpoint {
  Future<InvoiceTemplate> create(
    Session session,
    CreateInvoiceTemplateRequest request, {
    int? businessId,
  }) {
    return getIt<CreateInvoiceTemplateUseCase>().call(
      session,
      request,
      businessId: businessId,
    );
  }

  Future<InvoiceTemplate> get(
    Session session,
    int templateId, {
    int? businessId,
  }) {
    return getIt<GetInvoiceTemplateUseCase>().call(
      session,
      templateId,
      businessId: businessId,
    );
  }

  Future<InvoiceTemplate> update(
    Session session,
    UpdateInvoiceTemplateRequest request, {
    int? businessId,
  }) {
    return getIt<UpdateInvoiceTemplateUseCase>().call(
      session,
      request,
      businessId: businessId,
    );
  }

  Future<List<InvoiceTemplate>> list(
    Session session, {
    int? businessId,
    int? limit,
    int? offset,
  }) {
    return getIt<ListInvoiceTemplatesUseCase>().call(
      session,
      businessId: businessId,
      limit: limit,
      offset: offset,
    );
  }
}
