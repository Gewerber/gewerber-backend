/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'core/entitlement/feature.dart' as _i2;
import 'core/errors/conflict_exception.dart' as _i3;
import 'core/errors/forbidden_exception.dart' as _i4;
import 'core/errors/not_found_exception.dart' as _i5;
import 'core/errors/validation_exception.dart' as _i6;
import 'modules/accounting/models/accounting_transaction.dart' as _i7;
import 'modules/accounting/models/create_transaction_request.dart' as _i8;
import 'modules/accounting/models/profit_loss_line.dart' as _i9;
import 'modules/accounting/models/profit_loss_report.dart' as _i10;
import 'modules/accounting/models/transaction_category.dart' as _i11;
import 'modules/accounting/models/transaction_type.dart' as _i12;
import 'modules/accounting/models/update_transaction_request.dart' as _i13;
import 'modules/business/models/address.dart' as _i14;
import 'modules/business/models/business.dart' as _i15;
import 'modules/business/models/business_settings.dart' as _i16;
import 'modules/business/models/country.dart' as _i17;
import 'modules/business/models/create_business_request.dart' as _i18;
import 'modules/business/models/currency.dart' as _i19;
import 'modules/business/models/legal_form.dart' as _i20;
import 'modules/business/models/locale.dart' as _i21;
import 'modules/business/models/membership.dart' as _i22;
import 'modules/business/models/membership_role.dart' as _i23;
import 'modules/business/models/rounding_mode.dart' as _i24;
import 'modules/business/models/update_business_request.dart' as _i25;
import 'modules/business/models/update_business_settings_request.dart' as _i26;
import 'modules/documents/models/document.dart' as _i27;
import 'modules/documents/models/document_kind.dart' as _i28;
import 'modules/documents/models/storage_location.dart' as _i29;
import 'modules/documents/models/upload_document_request.dart' as _i30;
import 'modules/guidance/models/checklist_definition.dart' as _i31;
import 'modules/guidance/models/checklist_item_definition.dart' as _i32;
import 'modules/guidance/models/guidance_tip.dart' as _i33;
import 'modules/guidance/models/user_guidance_progress.dart' as _i34;
import 'modules/invoicing/models/create_customer_request.dart' as _i35;
import 'modules/invoicing/models/create_invoice_request.dart' as _i36;
import 'modules/invoicing/models/create_invoice_template_request.dart' as _i37;
import 'modules/invoicing/models/create_recurring_schedule_request.dart'
    as _i38;
import 'modules/invoicing/models/customer.dart' as _i39;
import 'modules/invoicing/models/customer_cursor_page.dart' as _i40;
import 'modules/invoicing/models/customer_list_page.dart' as _i41;
import 'modules/invoicing/models/customer_status.dart' as _i42;
import 'modules/invoicing/models/invoice.dart' as _i43;
import 'modules/invoicing/models/invoice_cursor_page.dart' as _i44;
import 'modules/invoicing/models/invoice_item.dart' as _i45;
import 'modules/invoicing/models/invoice_item_request.dart' as _i46;
import 'modules/invoicing/models/invoice_item_unit.dart' as _i47;
import 'modules/invoicing/models/invoice_list_page.dart' as _i48;
import 'modules/invoicing/models/invoice_payment_status.dart' as _i49;
import 'modules/invoicing/models/invoice_status.dart' as _i50;
import 'modules/invoicing/models/invoice_template.dart' as _i51;
import 'modules/invoicing/models/invoice_type.dart' as _i52;
import 'modules/invoicing/models/payment_method.dart' as _i53;
import 'modules/invoicing/models/payment_record.dart' as _i54;
import 'modules/invoicing/models/record_payment_request.dart' as _i55;
import 'modules/invoicing/models/recurrence_interval.dart' as _i56;
import 'modules/invoicing/models/reminder.dart' as _i57;
import 'modules/invoicing/models/update_customer_request.dart' as _i58;
import 'modules/invoicing/models/update_invoice_request.dart' as _i59;
import 'modules/invoicing/models/update_invoice_template_request.dart' as _i60;
import 'modules/invoicing/models/update_recurring_schedule_request.dart'
    as _i61;
import 'modules/invoicing/models/vat_rate.dart' as _i62;
import 'modules/time_tracking/models/create_project_request.dart' as _i63;
import 'modules/time_tracking/models/create_task_request.dart' as _i64;
import 'modules/time_tracking/models/create_time_entries_invoice_request.dart'
    as _i65;
import 'modules/time_tracking/models/create_time_entry_request.dart' as _i66;
import 'modules/time_tracking/models/project.dart' as _i67;
import 'modules/time_tracking/models/project_status.dart' as _i68;
import 'modules/time_tracking/models/start_timer_request.dart' as _i69;
import 'modules/time_tracking/models/task.dart' as _i70;
import 'modules/time_tracking/models/task_status.dart' as _i71;
import 'modules/time_tracking/models/time_entry.dart' as _i72;
import 'modules/time_tracking/models/time_report.dart' as _i73;
import 'modules/time_tracking/models/time_report_line.dart' as _i74;
import 'modules/time_tracking/models/update_project_request.dart' as _i75;
import 'modules/time_tracking/models/update_task_request.dart' as _i76;
import 'modules/time_tracking/models/update_time_entry_request.dart' as _i77;
import 'modules/user/models/app_theme.dart' as _i78;
import 'modules/user/models/update_user_profile_request.dart' as _i79;
import 'modules/user/models/user_profile.dart' as _i80;
import 'package:gewerber_backend_client/src/protocol/core/entitlement/feature.dart'
    as _i81;
import 'package:gewerber_backend_client/src/protocol/modules/accounting/models/accounting_transaction.dart'
    as _i82;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/business.dart'
    as _i83;
import 'package:gewerber_backend_client/src/protocol/modules/documents/models/document.dart'
    as _i84;
import 'package:gewerber_backend_client/src/protocol/modules/guidance/models/guidance_tip.dart'
    as _i85;
import 'package:gewerber_backend_client/src/protocol/modules/guidance/models/checklist_definition.dart'
    as _i86;
import 'package:gewerber_backend_client/src/protocol/modules/guidance/models/user_guidance_progress.dart'
    as _i87;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/customer.dart'
    as _i88;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice_item.dart'
    as _i89;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice.dart'
    as _i90;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice_template.dart'
    as _i91;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/reminder.dart'
    as _i92;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/task.dart'
    as _i93;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/project.dart'
    as _i94;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/time_entry.dart'
    as _i95;
import 'package:gewerber_commercial_client/gewerber_commercial_client.dart'
    as _i96;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i97;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i98;
export 'core/entitlement/feature.dart';
export 'core/errors/conflict_exception.dart';
export 'core/errors/forbidden_exception.dart';
export 'core/errors/not_found_exception.dart';
export 'core/errors/validation_exception.dart';
export 'modules/accounting/models/accounting_transaction.dart';
export 'modules/accounting/models/create_transaction_request.dart';
export 'modules/accounting/models/profit_loss_line.dart';
export 'modules/accounting/models/profit_loss_report.dart';
export 'modules/accounting/models/transaction_category.dart';
export 'modules/accounting/models/transaction_type.dart';
export 'modules/accounting/models/update_transaction_request.dart';
export 'modules/business/models/address.dart';
export 'modules/business/models/business.dart';
export 'modules/business/models/business_settings.dart';
export 'modules/business/models/country.dart';
export 'modules/business/models/create_business_request.dart';
export 'modules/business/models/currency.dart';
export 'modules/business/models/legal_form.dart';
export 'modules/business/models/locale.dart';
export 'modules/business/models/membership.dart';
export 'modules/business/models/membership_role.dart';
export 'modules/business/models/rounding_mode.dart';
export 'modules/business/models/update_business_request.dart';
export 'modules/business/models/update_business_settings_request.dart';
export 'modules/documents/models/document.dart';
export 'modules/documents/models/document_kind.dart';
export 'modules/documents/models/storage_location.dart';
export 'modules/documents/models/upload_document_request.dart';
export 'modules/guidance/models/checklist_definition.dart';
export 'modules/guidance/models/checklist_item_definition.dart';
export 'modules/guidance/models/guidance_tip.dart';
export 'modules/guidance/models/user_guidance_progress.dart';
export 'modules/invoicing/models/create_customer_request.dart';
export 'modules/invoicing/models/create_invoice_request.dart';
export 'modules/invoicing/models/create_invoice_template_request.dart';
export 'modules/invoicing/models/create_recurring_schedule_request.dart';
export 'modules/invoicing/models/customer.dart';
export 'modules/invoicing/models/customer_cursor_page.dart';
export 'modules/invoicing/models/customer_list_page.dart';
export 'modules/invoicing/models/customer_status.dart';
export 'modules/invoicing/models/invoice.dart';
export 'modules/invoicing/models/invoice_cursor_page.dart';
export 'modules/invoicing/models/invoice_item.dart';
export 'modules/invoicing/models/invoice_item_request.dart';
export 'modules/invoicing/models/invoice_item_unit.dart';
export 'modules/invoicing/models/invoice_list_page.dart';
export 'modules/invoicing/models/invoice_payment_status.dart';
export 'modules/invoicing/models/invoice_status.dart';
export 'modules/invoicing/models/invoice_template.dart';
export 'modules/invoicing/models/invoice_type.dart';
export 'modules/invoicing/models/payment_method.dart';
export 'modules/invoicing/models/payment_record.dart';
export 'modules/invoicing/models/record_payment_request.dart';
export 'modules/invoicing/models/recurrence_interval.dart';
export 'modules/invoicing/models/reminder.dart';
export 'modules/invoicing/models/update_customer_request.dart';
export 'modules/invoicing/models/update_invoice_request.dart';
export 'modules/invoicing/models/update_invoice_template_request.dart';
export 'modules/invoicing/models/update_recurring_schedule_request.dart';
export 'modules/invoicing/models/vat_rate.dart';
export 'modules/time_tracking/models/create_project_request.dart';
export 'modules/time_tracking/models/create_task_request.dart';
export 'modules/time_tracking/models/create_time_entries_invoice_request.dart';
export 'modules/time_tracking/models/create_time_entry_request.dart';
export 'modules/time_tracking/models/project.dart';
export 'modules/time_tracking/models/project_status.dart';
export 'modules/time_tracking/models/start_timer_request.dart';
export 'modules/time_tracking/models/task.dart';
export 'modules/time_tracking/models/task_status.dart';
export 'modules/time_tracking/models/time_entry.dart';
export 'modules/time_tracking/models/time_report.dart';
export 'modules/time_tracking/models/time_report_line.dart';
export 'modules/time_tracking/models/update_project_request.dart';
export 'modules/time_tracking/models/update_task_request.dart';
export 'modules/time_tracking/models/update_time_entry_request.dart';
export 'modules/user/models/app_theme.dart';
export 'modules/user/models/update_user_profile_request.dart';
export 'modules/user/models/user_profile.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.Feature) {
      return _i2.Feature.fromJson(data) as T;
    }
    if (t == _i3.ConflictException) {
      return _i3.ConflictException.fromJson(data) as T;
    }
    if (t == _i4.ForbiddenException) {
      return _i4.ForbiddenException.fromJson(data) as T;
    }
    if (t == _i5.NotFoundException) {
      return _i5.NotFoundException.fromJson(data) as T;
    }
    if (t == _i6.ValidationException) {
      return _i6.ValidationException.fromJson(data) as T;
    }
    if (t == _i7.AccountingTransaction) {
      return _i7.AccountingTransaction.fromJson(data) as T;
    }
    if (t == _i8.CreateTransactionRequest) {
      return _i8.CreateTransactionRequest.fromJson(data) as T;
    }
    if (t == _i9.ProfitLossLine) {
      return _i9.ProfitLossLine.fromJson(data) as T;
    }
    if (t == _i10.ProfitLossReport) {
      return _i10.ProfitLossReport.fromJson(data) as T;
    }
    if (t == _i11.TransactionCategory) {
      return _i11.TransactionCategory.fromJson(data) as T;
    }
    if (t == _i12.TransactionType) {
      return _i12.TransactionType.fromJson(data) as T;
    }
    if (t == _i13.UpdateTransactionRequest) {
      return _i13.UpdateTransactionRequest.fromJson(data) as T;
    }
    if (t == _i14.Address) {
      return _i14.Address.fromJson(data) as T;
    }
    if (t == _i15.Business) {
      return _i15.Business.fromJson(data) as T;
    }
    if (t == _i16.BusinessSettings) {
      return _i16.BusinessSettings.fromJson(data) as T;
    }
    if (t == _i17.Country) {
      return _i17.Country.fromJson(data) as T;
    }
    if (t == _i18.CreateBusinessRequest) {
      return _i18.CreateBusinessRequest.fromJson(data) as T;
    }
    if (t == _i19.Currency) {
      return _i19.Currency.fromJson(data) as T;
    }
    if (t == _i20.LegalForm) {
      return _i20.LegalForm.fromJson(data) as T;
    }
    if (t == _i21.Locale) {
      return _i21.Locale.fromJson(data) as T;
    }
    if (t == _i22.Membership) {
      return _i22.Membership.fromJson(data) as T;
    }
    if (t == _i23.MembershipRole) {
      return _i23.MembershipRole.fromJson(data) as T;
    }
    if (t == _i24.RoundingMode) {
      return _i24.RoundingMode.fromJson(data) as T;
    }
    if (t == _i25.UpdateBusinessRequest) {
      return _i25.UpdateBusinessRequest.fromJson(data) as T;
    }
    if (t == _i26.UpdateBusinessSettingsRequest) {
      return _i26.UpdateBusinessSettingsRequest.fromJson(data) as T;
    }
    if (t == _i27.Document) {
      return _i27.Document.fromJson(data) as T;
    }
    if (t == _i28.DocumentKind) {
      return _i28.DocumentKind.fromJson(data) as T;
    }
    if (t == _i29.StorageLocation) {
      return _i29.StorageLocation.fromJson(data) as T;
    }
    if (t == _i30.UploadDocumentRequest) {
      return _i30.UploadDocumentRequest.fromJson(data) as T;
    }
    if (t == _i31.ChecklistDefinition) {
      return _i31.ChecklistDefinition.fromJson(data) as T;
    }
    if (t == _i32.ChecklistItemDefinition) {
      return _i32.ChecklistItemDefinition.fromJson(data) as T;
    }
    if (t == _i33.GuidanceTip) {
      return _i33.GuidanceTip.fromJson(data) as T;
    }
    if (t == _i34.UserGuidanceProgress) {
      return _i34.UserGuidanceProgress.fromJson(data) as T;
    }
    if (t == _i35.CreateCustomerRequest) {
      return _i35.CreateCustomerRequest.fromJson(data) as T;
    }
    if (t == _i36.CreateInvoiceRequest) {
      return _i36.CreateInvoiceRequest.fromJson(data) as T;
    }
    if (t == _i37.CreateInvoiceTemplateRequest) {
      return _i37.CreateInvoiceTemplateRequest.fromJson(data) as T;
    }
    if (t == _i38.CreateRecurringScheduleRequest) {
      return _i38.CreateRecurringScheduleRequest.fromJson(data) as T;
    }
    if (t == _i39.Customer) {
      return _i39.Customer.fromJson(data) as T;
    }
    if (t == _i40.CustomerCursorPage) {
      return _i40.CustomerCursorPage.fromJson(data) as T;
    }
    if (t == _i41.CustomerListPage) {
      return _i41.CustomerListPage.fromJson(data) as T;
    }
    if (t == _i42.CustomerStatus) {
      return _i42.CustomerStatus.fromJson(data) as T;
    }
    if (t == _i43.Invoice) {
      return _i43.Invoice.fromJson(data) as T;
    }
    if (t == _i44.InvoiceCursorPage) {
      return _i44.InvoiceCursorPage.fromJson(data) as T;
    }
    if (t == _i45.InvoiceItem) {
      return _i45.InvoiceItem.fromJson(data) as T;
    }
    if (t == _i46.InvoiceItemRequest) {
      return _i46.InvoiceItemRequest.fromJson(data) as T;
    }
    if (t == _i47.InvoiceItemUnit) {
      return _i47.InvoiceItemUnit.fromJson(data) as T;
    }
    if (t == _i48.InvoiceListPage) {
      return _i48.InvoiceListPage.fromJson(data) as T;
    }
    if (t == _i49.InvoicePaymentStatus) {
      return _i49.InvoicePaymentStatus.fromJson(data) as T;
    }
    if (t == _i50.InvoiceStatus) {
      return _i50.InvoiceStatus.fromJson(data) as T;
    }
    if (t == _i51.InvoiceTemplate) {
      return _i51.InvoiceTemplate.fromJson(data) as T;
    }
    if (t == _i52.InvoiceType) {
      return _i52.InvoiceType.fromJson(data) as T;
    }
    if (t == _i53.PaymentMethod) {
      return _i53.PaymentMethod.fromJson(data) as T;
    }
    if (t == _i54.PaymentRecord) {
      return _i54.PaymentRecord.fromJson(data) as T;
    }
    if (t == _i55.RecordPaymentRequest) {
      return _i55.RecordPaymentRequest.fromJson(data) as T;
    }
    if (t == _i56.RecurrenceInterval) {
      return _i56.RecurrenceInterval.fromJson(data) as T;
    }
    if (t == _i57.Reminder) {
      return _i57.Reminder.fromJson(data) as T;
    }
    if (t == _i58.UpdateCustomerRequest) {
      return _i58.UpdateCustomerRequest.fromJson(data) as T;
    }
    if (t == _i59.UpdateInvoiceRequest) {
      return _i59.UpdateInvoiceRequest.fromJson(data) as T;
    }
    if (t == _i60.UpdateInvoiceTemplateRequest) {
      return _i60.UpdateInvoiceTemplateRequest.fromJson(data) as T;
    }
    if (t == _i61.UpdateRecurringScheduleRequest) {
      return _i61.UpdateRecurringScheduleRequest.fromJson(data) as T;
    }
    if (t == _i62.VatRate) {
      return _i62.VatRate.fromJson(data) as T;
    }
    if (t == _i63.CreateProjectRequest) {
      return _i63.CreateProjectRequest.fromJson(data) as T;
    }
    if (t == _i64.CreateTaskRequest) {
      return _i64.CreateTaskRequest.fromJson(data) as T;
    }
    if (t == _i65.CreateTimeEntriesInvoiceRequest) {
      return _i65.CreateTimeEntriesInvoiceRequest.fromJson(data) as T;
    }
    if (t == _i66.CreateTimeEntryRequest) {
      return _i66.CreateTimeEntryRequest.fromJson(data) as T;
    }
    if (t == _i67.Project) {
      return _i67.Project.fromJson(data) as T;
    }
    if (t == _i68.ProjectStatus) {
      return _i68.ProjectStatus.fromJson(data) as T;
    }
    if (t == _i69.StartTimerRequest) {
      return _i69.StartTimerRequest.fromJson(data) as T;
    }
    if (t == _i70.Task) {
      return _i70.Task.fromJson(data) as T;
    }
    if (t == _i71.TaskStatus) {
      return _i71.TaskStatus.fromJson(data) as T;
    }
    if (t == _i72.TimeEntry) {
      return _i72.TimeEntry.fromJson(data) as T;
    }
    if (t == _i73.TimeReport) {
      return _i73.TimeReport.fromJson(data) as T;
    }
    if (t == _i74.TimeReportLine) {
      return _i74.TimeReportLine.fromJson(data) as T;
    }
    if (t == _i75.UpdateProjectRequest) {
      return _i75.UpdateProjectRequest.fromJson(data) as T;
    }
    if (t == _i76.UpdateTaskRequest) {
      return _i76.UpdateTaskRequest.fromJson(data) as T;
    }
    if (t == _i77.UpdateTimeEntryRequest) {
      return _i77.UpdateTimeEntryRequest.fromJson(data) as T;
    }
    if (t == _i78.AppTheme) {
      return _i78.AppTheme.fromJson(data) as T;
    }
    if (t == _i79.UpdateUserProfileRequest) {
      return _i79.UpdateUserProfileRequest.fromJson(data) as T;
    }
    if (t == _i80.UserProfile) {
      return _i80.UserProfile.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Feature?>()) {
      return (data != null ? _i2.Feature.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.ConflictException?>()) {
      return (data != null ? _i3.ConflictException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.ForbiddenException?>()) {
      return (data != null ? _i4.ForbiddenException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.NotFoundException?>()) {
      return (data != null ? _i5.NotFoundException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ValidationException?>()) {
      return (data != null ? _i6.ValidationException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.AccountingTransaction?>()) {
      return (data != null ? _i7.AccountingTransaction.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.CreateTransactionRequest?>()) {
      return (data != null ? _i8.CreateTransactionRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.ProfitLossLine?>()) {
      return (data != null ? _i9.ProfitLossLine.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.ProfitLossReport?>()) {
      return (data != null ? _i10.ProfitLossReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.TransactionCategory?>()) {
      return (data != null ? _i11.TransactionCategory.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.TransactionType?>()) {
      return (data != null ? _i12.TransactionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.UpdateTransactionRequest?>()) {
      return (data != null
              ? _i13.UpdateTransactionRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i14.Address?>()) {
      return (data != null ? _i14.Address.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Business?>()) {
      return (data != null ? _i15.Business.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.BusinessSettings?>()) {
      return (data != null ? _i16.BusinessSettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.Country?>()) {
      return (data != null ? _i17.Country.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.CreateBusinessRequest?>()) {
      return (data != null ? _i18.CreateBusinessRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.Currency?>()) {
      return (data != null ? _i19.Currency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.LegalForm?>()) {
      return (data != null ? _i20.LegalForm.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.Locale?>()) {
      return (data != null ? _i21.Locale.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.Membership?>()) {
      return (data != null ? _i22.Membership.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.MembershipRole?>()) {
      return (data != null ? _i23.MembershipRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.RoundingMode?>()) {
      return (data != null ? _i24.RoundingMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.UpdateBusinessRequest?>()) {
      return (data != null ? _i25.UpdateBusinessRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.UpdateBusinessSettingsRequest?>()) {
      return (data != null
              ? _i26.UpdateBusinessSettingsRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i27.Document?>()) {
      return (data != null ? _i27.Document.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.DocumentKind?>()) {
      return (data != null ? _i28.DocumentKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.StorageLocation?>()) {
      return (data != null ? _i29.StorageLocation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.UploadDocumentRequest?>()) {
      return (data != null ? _i30.UploadDocumentRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.ChecklistDefinition?>()) {
      return (data != null ? _i31.ChecklistDefinition.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i32.ChecklistItemDefinition?>()) {
      return (data != null ? _i32.ChecklistItemDefinition.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i33.GuidanceTip?>()) {
      return (data != null ? _i33.GuidanceTip.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.UserGuidanceProgress?>()) {
      return (data != null ? _i34.UserGuidanceProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i35.CreateCustomerRequest?>()) {
      return (data != null ? _i35.CreateCustomerRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i36.CreateInvoiceRequest?>()) {
      return (data != null ? _i36.CreateInvoiceRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i37.CreateInvoiceTemplateRequest?>()) {
      return (data != null
              ? _i37.CreateInvoiceTemplateRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i38.CreateRecurringScheduleRequest?>()) {
      return (data != null
              ? _i38.CreateRecurringScheduleRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i39.Customer?>()) {
      return (data != null ? _i39.Customer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.CustomerCursorPage?>()) {
      return (data != null ? _i40.CustomerCursorPage.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i41.CustomerListPage?>()) {
      return (data != null ? _i41.CustomerListPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.CustomerStatus?>()) {
      return (data != null ? _i42.CustomerStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.Invoice?>()) {
      return (data != null ? _i43.Invoice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.InvoiceCursorPage?>()) {
      return (data != null ? _i44.InvoiceCursorPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.InvoiceItem?>()) {
      return (data != null ? _i45.InvoiceItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.InvoiceItemRequest?>()) {
      return (data != null ? _i46.InvoiceItemRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i47.InvoiceItemUnit?>()) {
      return (data != null ? _i47.InvoiceItemUnit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.InvoiceListPage?>()) {
      return (data != null ? _i48.InvoiceListPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.InvoicePaymentStatus?>()) {
      return (data != null ? _i49.InvoicePaymentStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i50.InvoiceStatus?>()) {
      return (data != null ? _i50.InvoiceStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.InvoiceTemplate?>()) {
      return (data != null ? _i51.InvoiceTemplate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.InvoiceType?>()) {
      return (data != null ? _i52.InvoiceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.PaymentMethod?>()) {
      return (data != null ? _i53.PaymentMethod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.PaymentRecord?>()) {
      return (data != null ? _i54.PaymentRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.RecordPaymentRequest?>()) {
      return (data != null ? _i55.RecordPaymentRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i56.RecurrenceInterval?>()) {
      return (data != null ? _i56.RecurrenceInterval.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i57.Reminder?>()) {
      return (data != null ? _i57.Reminder.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.UpdateCustomerRequest?>()) {
      return (data != null ? _i58.UpdateCustomerRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i59.UpdateInvoiceRequest?>()) {
      return (data != null ? _i59.UpdateInvoiceRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i60.UpdateInvoiceTemplateRequest?>()) {
      return (data != null
              ? _i60.UpdateInvoiceTemplateRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i61.UpdateRecurringScheduleRequest?>()) {
      return (data != null
              ? _i61.UpdateRecurringScheduleRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i62.VatRate?>()) {
      return (data != null ? _i62.VatRate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.CreateProjectRequest?>()) {
      return (data != null ? _i63.CreateProjectRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i64.CreateTaskRequest?>()) {
      return (data != null ? _i64.CreateTaskRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.CreateTimeEntriesInvoiceRequest?>()) {
      return (data != null
              ? _i65.CreateTimeEntriesInvoiceRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i66.CreateTimeEntryRequest?>()) {
      return (data != null ? _i66.CreateTimeEntryRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i67.Project?>()) {
      return (data != null ? _i67.Project.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.ProjectStatus?>()) {
      return (data != null ? _i68.ProjectStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.StartTimerRequest?>()) {
      return (data != null ? _i69.StartTimerRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i70.Task?>()) {
      return (data != null ? _i70.Task.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.TaskStatus?>()) {
      return (data != null ? _i71.TaskStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i72.TimeEntry?>()) {
      return (data != null ? _i72.TimeEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i73.TimeReport?>()) {
      return (data != null ? _i73.TimeReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i74.TimeReportLine?>()) {
      return (data != null ? _i74.TimeReportLine.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i75.UpdateProjectRequest?>()) {
      return (data != null ? _i75.UpdateProjectRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i76.UpdateTaskRequest?>()) {
      return (data != null ? _i76.UpdateTaskRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i77.UpdateTimeEntryRequest?>()) {
      return (data != null ? _i77.UpdateTimeEntryRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i78.AppTheme?>()) {
      return (data != null ? _i78.AppTheme.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i79.UpdateUserProfileRequest?>()) {
      return (data != null
              ? _i79.UpdateUserProfileRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i80.UserProfile?>()) {
      return (data != null ? _i80.UserProfile.fromJson(data) : null) as T;
    }
    if (t == List<_i9.ProfitLossLine>) {
      return (data as List)
              .map((e) => deserialize<_i9.ProfitLossLine>(e))
              .toList()
          as T;
    }
    if (t == List<_i32.ChecklistItemDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i32.ChecklistItemDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i46.InvoiceItemRequest>) {
      return (data as List)
              .map((e) => deserialize<_i46.InvoiceItemRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_i39.Customer>) {
      return (data as List).map((e) => deserialize<_i39.Customer>(e)).toList()
          as T;
    }
    if (t == List<_i43.Invoice>) {
      return (data as List).map((e) => deserialize<_i43.Invoice>(e)).toList()
          as T;
    }
    if (t == List<_i54.PaymentRecord>) {
      return (data as List)
              .map((e) => deserialize<_i54.PaymentRecord>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i74.TimeReportLine>) {
      return (data as List)
              .map((e) => deserialize<_i74.TimeReportLine>(e))
              .toList()
          as T;
    }
    if (t == List<_i81.Feature>) {
      return (data as List).map((e) => deserialize<_i81.Feature>(e)).toList()
          as T;
    }
    if (t == List<_i82.AccountingTransaction>) {
      return (data as List)
              .map((e) => deserialize<_i82.AccountingTransaction>(e))
              .toList()
          as T;
    }
    if (t == List<_i83.Business>) {
      return (data as List).map((e) => deserialize<_i83.Business>(e)).toList()
          as T;
    }
    if (t == List<_i84.Document>) {
      return (data as List).map((e) => deserialize<_i84.Document>(e)).toList()
          as T;
    }
    if (t == List<_i85.GuidanceTip>) {
      return (data as List)
              .map((e) => deserialize<_i85.GuidanceTip>(e))
              .toList()
          as T;
    }
    if (t == List<_i86.ChecklistDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i86.ChecklistDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i87.UserGuidanceProgress>) {
      return (data as List)
              .map((e) => deserialize<_i87.UserGuidanceProgress>(e))
              .toList()
          as T;
    }
    if (t == List<_i88.Customer>) {
      return (data as List).map((e) => deserialize<_i88.Customer>(e)).toList()
          as T;
    }
    if (t == List<_i89.InvoiceItem>) {
      return (data as List)
              .map((e) => deserialize<_i89.InvoiceItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i90.Invoice>) {
      return (data as List).map((e) => deserialize<_i90.Invoice>(e)).toList()
          as T;
    }
    if (t == List<_i91.InvoiceTemplate>) {
      return (data as List)
              .map((e) => deserialize<_i91.InvoiceTemplate>(e))
              .toList()
          as T;
    }
    if (t == List<_i92.Reminder>) {
      return (data as List).map((e) => deserialize<_i92.Reminder>(e)).toList()
          as T;
    }
    if (t == List<_i93.Task>) {
      return (data as List).map((e) => deserialize<_i93.Task>(e)).toList() as T;
    }
    if (t == List<_i94.Project>) {
      return (data as List).map((e) => deserialize<_i94.Project>(e)).toList()
          as T;
    }
    if (t == List<_i95.TimeEntry>) {
      return (data as List).map((e) => deserialize<_i95.TimeEntry>(e)).toList()
          as T;
    }
    try {
      return _i96.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i97.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i98.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Feature => 'Feature',
      _i3.ConflictException => 'ConflictException',
      _i4.ForbiddenException => 'ForbiddenException',
      _i5.NotFoundException => 'NotFoundException',
      _i6.ValidationException => 'ValidationException',
      _i7.AccountingTransaction => 'AccountingTransaction',
      _i8.CreateTransactionRequest => 'CreateTransactionRequest',
      _i9.ProfitLossLine => 'ProfitLossLine',
      _i10.ProfitLossReport => 'ProfitLossReport',
      _i11.TransactionCategory => 'TransactionCategory',
      _i12.TransactionType => 'TransactionType',
      _i13.UpdateTransactionRequest => 'UpdateTransactionRequest',
      _i14.Address => 'Address',
      _i15.Business => 'Business',
      _i16.BusinessSettings => 'BusinessSettings',
      _i17.Country => 'Country',
      _i18.CreateBusinessRequest => 'CreateBusinessRequest',
      _i19.Currency => 'Currency',
      _i20.LegalForm => 'LegalForm',
      _i21.Locale => 'Locale',
      _i22.Membership => 'Membership',
      _i23.MembershipRole => 'MembershipRole',
      _i24.RoundingMode => 'RoundingMode',
      _i25.UpdateBusinessRequest => 'UpdateBusinessRequest',
      _i26.UpdateBusinessSettingsRequest => 'UpdateBusinessSettingsRequest',
      _i27.Document => 'Document',
      _i28.DocumentKind => 'DocumentKind',
      _i29.StorageLocation => 'StorageLocation',
      _i30.UploadDocumentRequest => 'UploadDocumentRequest',
      _i31.ChecklistDefinition => 'ChecklistDefinition',
      _i32.ChecklistItemDefinition => 'ChecklistItemDefinition',
      _i33.GuidanceTip => 'GuidanceTip',
      _i34.UserGuidanceProgress => 'UserGuidanceProgress',
      _i35.CreateCustomerRequest => 'CreateCustomerRequest',
      _i36.CreateInvoiceRequest => 'CreateInvoiceRequest',
      _i37.CreateInvoiceTemplateRequest => 'CreateInvoiceTemplateRequest',
      _i38.CreateRecurringScheduleRequest => 'CreateRecurringScheduleRequest',
      _i39.Customer => 'Customer',
      _i40.CustomerCursorPage => 'CustomerCursorPage',
      _i41.CustomerListPage => 'CustomerListPage',
      _i42.CustomerStatus => 'CustomerStatus',
      _i43.Invoice => 'Invoice',
      _i44.InvoiceCursorPage => 'InvoiceCursorPage',
      _i45.InvoiceItem => 'InvoiceItem',
      _i46.InvoiceItemRequest => 'InvoiceItemRequest',
      _i47.InvoiceItemUnit => 'InvoiceItemUnit',
      _i48.InvoiceListPage => 'InvoiceListPage',
      _i49.InvoicePaymentStatus => 'InvoicePaymentStatus',
      _i50.InvoiceStatus => 'InvoiceStatus',
      _i51.InvoiceTemplate => 'InvoiceTemplate',
      _i52.InvoiceType => 'InvoiceType',
      _i53.PaymentMethod => 'PaymentMethod',
      _i54.PaymentRecord => 'PaymentRecord',
      _i55.RecordPaymentRequest => 'RecordPaymentRequest',
      _i56.RecurrenceInterval => 'RecurrenceInterval',
      _i57.Reminder => 'Reminder',
      _i58.UpdateCustomerRequest => 'UpdateCustomerRequest',
      _i59.UpdateInvoiceRequest => 'UpdateInvoiceRequest',
      _i60.UpdateInvoiceTemplateRequest => 'UpdateInvoiceTemplateRequest',
      _i61.UpdateRecurringScheduleRequest => 'UpdateRecurringScheduleRequest',
      _i62.VatRate => 'VatRate',
      _i63.CreateProjectRequest => 'CreateProjectRequest',
      _i64.CreateTaskRequest => 'CreateTaskRequest',
      _i65.CreateTimeEntriesInvoiceRequest => 'CreateTimeEntriesInvoiceRequest',
      _i66.CreateTimeEntryRequest => 'CreateTimeEntryRequest',
      _i67.Project => 'Project',
      _i68.ProjectStatus => 'ProjectStatus',
      _i69.StartTimerRequest => 'StartTimerRequest',
      _i70.Task => 'Task',
      _i71.TaskStatus => 'TaskStatus',
      _i72.TimeEntry => 'TimeEntry',
      _i73.TimeReport => 'TimeReport',
      _i74.TimeReportLine => 'TimeReportLine',
      _i75.UpdateProjectRequest => 'UpdateProjectRequest',
      _i76.UpdateTaskRequest => 'UpdateTaskRequest',
      _i77.UpdateTimeEntryRequest => 'UpdateTimeEntryRequest',
      _i78.AppTheme => 'AppTheme',
      _i79.UpdateUserProfileRequest => 'UpdateUserProfileRequest',
      _i80.UserProfile => 'UserProfile',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'gewerber_backend.',
        '',
      );
    }

    switch (data) {
      case _i2.Feature():
        return 'Feature';
      case _i3.ConflictException():
        return 'ConflictException';
      case _i4.ForbiddenException():
        return 'ForbiddenException';
      case _i5.NotFoundException():
        return 'NotFoundException';
      case _i6.ValidationException():
        return 'ValidationException';
      case _i7.AccountingTransaction():
        return 'AccountingTransaction';
      case _i8.CreateTransactionRequest():
        return 'CreateTransactionRequest';
      case _i9.ProfitLossLine():
        return 'ProfitLossLine';
      case _i10.ProfitLossReport():
        return 'ProfitLossReport';
      case _i11.TransactionCategory():
        return 'TransactionCategory';
      case _i12.TransactionType():
        return 'TransactionType';
      case _i13.UpdateTransactionRequest():
        return 'UpdateTransactionRequest';
      case _i14.Address():
        return 'Address';
      case _i15.Business():
        return 'Business';
      case _i16.BusinessSettings():
        return 'BusinessSettings';
      case _i17.Country():
        return 'Country';
      case _i18.CreateBusinessRequest():
        return 'CreateBusinessRequest';
      case _i19.Currency():
        return 'Currency';
      case _i20.LegalForm():
        return 'LegalForm';
      case _i21.Locale():
        return 'Locale';
      case _i22.Membership():
        return 'Membership';
      case _i23.MembershipRole():
        return 'MembershipRole';
      case _i24.RoundingMode():
        return 'RoundingMode';
      case _i25.UpdateBusinessRequest():
        return 'UpdateBusinessRequest';
      case _i26.UpdateBusinessSettingsRequest():
        return 'UpdateBusinessSettingsRequest';
      case _i27.Document():
        return 'Document';
      case _i28.DocumentKind():
        return 'DocumentKind';
      case _i29.StorageLocation():
        return 'StorageLocation';
      case _i30.UploadDocumentRequest():
        return 'UploadDocumentRequest';
      case _i31.ChecklistDefinition():
        return 'ChecklistDefinition';
      case _i32.ChecklistItemDefinition():
        return 'ChecklistItemDefinition';
      case _i33.GuidanceTip():
        return 'GuidanceTip';
      case _i34.UserGuidanceProgress():
        return 'UserGuidanceProgress';
      case _i35.CreateCustomerRequest():
        return 'CreateCustomerRequest';
      case _i36.CreateInvoiceRequest():
        return 'CreateInvoiceRequest';
      case _i37.CreateInvoiceTemplateRequest():
        return 'CreateInvoiceTemplateRequest';
      case _i38.CreateRecurringScheduleRequest():
        return 'CreateRecurringScheduleRequest';
      case _i39.Customer():
        return 'Customer';
      case _i40.CustomerCursorPage():
        return 'CustomerCursorPage';
      case _i41.CustomerListPage():
        return 'CustomerListPage';
      case _i42.CustomerStatus():
        return 'CustomerStatus';
      case _i43.Invoice():
        return 'Invoice';
      case _i44.InvoiceCursorPage():
        return 'InvoiceCursorPage';
      case _i45.InvoiceItem():
        return 'InvoiceItem';
      case _i46.InvoiceItemRequest():
        return 'InvoiceItemRequest';
      case _i47.InvoiceItemUnit():
        return 'InvoiceItemUnit';
      case _i48.InvoiceListPage():
        return 'InvoiceListPage';
      case _i49.InvoicePaymentStatus():
        return 'InvoicePaymentStatus';
      case _i50.InvoiceStatus():
        return 'InvoiceStatus';
      case _i51.InvoiceTemplate():
        return 'InvoiceTemplate';
      case _i52.InvoiceType():
        return 'InvoiceType';
      case _i53.PaymentMethod():
        return 'PaymentMethod';
      case _i54.PaymentRecord():
        return 'PaymentRecord';
      case _i55.RecordPaymentRequest():
        return 'RecordPaymentRequest';
      case _i56.RecurrenceInterval():
        return 'RecurrenceInterval';
      case _i57.Reminder():
        return 'Reminder';
      case _i58.UpdateCustomerRequest():
        return 'UpdateCustomerRequest';
      case _i59.UpdateInvoiceRequest():
        return 'UpdateInvoiceRequest';
      case _i60.UpdateInvoiceTemplateRequest():
        return 'UpdateInvoiceTemplateRequest';
      case _i61.UpdateRecurringScheduleRequest():
        return 'UpdateRecurringScheduleRequest';
      case _i62.VatRate():
        return 'VatRate';
      case _i63.CreateProjectRequest():
        return 'CreateProjectRequest';
      case _i64.CreateTaskRequest():
        return 'CreateTaskRequest';
      case _i65.CreateTimeEntriesInvoiceRequest():
        return 'CreateTimeEntriesInvoiceRequest';
      case _i66.CreateTimeEntryRequest():
        return 'CreateTimeEntryRequest';
      case _i67.Project():
        return 'Project';
      case _i68.ProjectStatus():
        return 'ProjectStatus';
      case _i69.StartTimerRequest():
        return 'StartTimerRequest';
      case _i70.Task():
        return 'Task';
      case _i71.TaskStatus():
        return 'TaskStatus';
      case _i72.TimeEntry():
        return 'TimeEntry';
      case _i73.TimeReport():
        return 'TimeReport';
      case _i74.TimeReportLine():
        return 'TimeReportLine';
      case _i75.UpdateProjectRequest():
        return 'UpdateProjectRequest';
      case _i76.UpdateTaskRequest():
        return 'UpdateTaskRequest';
      case _i77.UpdateTimeEntryRequest():
        return 'UpdateTimeEntryRequest';
      case _i78.AppTheme():
        return 'AppTheme';
      case _i79.UpdateUserProfileRequest():
        return 'UpdateUserProfileRequest';
      case _i80.UserProfile():
        return 'UserProfile';
    }
    className = _i96.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'gewerber_commercial.$className';
    }
    className = _i97.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _i98.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Feature') {
      return deserialize<_i2.Feature>(data['data']);
    }
    if (dataClassName == 'ConflictException') {
      return deserialize<_i3.ConflictException>(data['data']);
    }
    if (dataClassName == 'ForbiddenException') {
      return deserialize<_i4.ForbiddenException>(data['data']);
    }
    if (dataClassName == 'NotFoundException') {
      return deserialize<_i5.NotFoundException>(data['data']);
    }
    if (dataClassName == 'ValidationException') {
      return deserialize<_i6.ValidationException>(data['data']);
    }
    if (dataClassName == 'AccountingTransaction') {
      return deserialize<_i7.AccountingTransaction>(data['data']);
    }
    if (dataClassName == 'CreateTransactionRequest') {
      return deserialize<_i8.CreateTransactionRequest>(data['data']);
    }
    if (dataClassName == 'ProfitLossLine') {
      return deserialize<_i9.ProfitLossLine>(data['data']);
    }
    if (dataClassName == 'ProfitLossReport') {
      return deserialize<_i10.ProfitLossReport>(data['data']);
    }
    if (dataClassName == 'TransactionCategory') {
      return deserialize<_i11.TransactionCategory>(data['data']);
    }
    if (dataClassName == 'TransactionType') {
      return deserialize<_i12.TransactionType>(data['data']);
    }
    if (dataClassName == 'UpdateTransactionRequest') {
      return deserialize<_i13.UpdateTransactionRequest>(data['data']);
    }
    if (dataClassName == 'Address') {
      return deserialize<_i14.Address>(data['data']);
    }
    if (dataClassName == 'Business') {
      return deserialize<_i15.Business>(data['data']);
    }
    if (dataClassName == 'BusinessSettings') {
      return deserialize<_i16.BusinessSettings>(data['data']);
    }
    if (dataClassName == 'Country') {
      return deserialize<_i17.Country>(data['data']);
    }
    if (dataClassName == 'CreateBusinessRequest') {
      return deserialize<_i18.CreateBusinessRequest>(data['data']);
    }
    if (dataClassName == 'Currency') {
      return deserialize<_i19.Currency>(data['data']);
    }
    if (dataClassName == 'LegalForm') {
      return deserialize<_i20.LegalForm>(data['data']);
    }
    if (dataClassName == 'Locale') {
      return deserialize<_i21.Locale>(data['data']);
    }
    if (dataClassName == 'Membership') {
      return deserialize<_i22.Membership>(data['data']);
    }
    if (dataClassName == 'MembershipRole') {
      return deserialize<_i23.MembershipRole>(data['data']);
    }
    if (dataClassName == 'RoundingMode') {
      return deserialize<_i24.RoundingMode>(data['data']);
    }
    if (dataClassName == 'UpdateBusinessRequest') {
      return deserialize<_i25.UpdateBusinessRequest>(data['data']);
    }
    if (dataClassName == 'UpdateBusinessSettingsRequest') {
      return deserialize<_i26.UpdateBusinessSettingsRequest>(data['data']);
    }
    if (dataClassName == 'Document') {
      return deserialize<_i27.Document>(data['data']);
    }
    if (dataClassName == 'DocumentKind') {
      return deserialize<_i28.DocumentKind>(data['data']);
    }
    if (dataClassName == 'StorageLocation') {
      return deserialize<_i29.StorageLocation>(data['data']);
    }
    if (dataClassName == 'UploadDocumentRequest') {
      return deserialize<_i30.UploadDocumentRequest>(data['data']);
    }
    if (dataClassName == 'ChecklistDefinition') {
      return deserialize<_i31.ChecklistDefinition>(data['data']);
    }
    if (dataClassName == 'ChecklistItemDefinition') {
      return deserialize<_i32.ChecklistItemDefinition>(data['data']);
    }
    if (dataClassName == 'GuidanceTip') {
      return deserialize<_i33.GuidanceTip>(data['data']);
    }
    if (dataClassName == 'UserGuidanceProgress') {
      return deserialize<_i34.UserGuidanceProgress>(data['data']);
    }
    if (dataClassName == 'CreateCustomerRequest') {
      return deserialize<_i35.CreateCustomerRequest>(data['data']);
    }
    if (dataClassName == 'CreateInvoiceRequest') {
      return deserialize<_i36.CreateInvoiceRequest>(data['data']);
    }
    if (dataClassName == 'CreateInvoiceTemplateRequest') {
      return deserialize<_i37.CreateInvoiceTemplateRequest>(data['data']);
    }
    if (dataClassName == 'CreateRecurringScheduleRequest') {
      return deserialize<_i38.CreateRecurringScheduleRequest>(data['data']);
    }
    if (dataClassName == 'Customer') {
      return deserialize<_i39.Customer>(data['data']);
    }
    if (dataClassName == 'CustomerCursorPage') {
      return deserialize<_i40.CustomerCursorPage>(data['data']);
    }
    if (dataClassName == 'CustomerListPage') {
      return deserialize<_i41.CustomerListPage>(data['data']);
    }
    if (dataClassName == 'CustomerStatus') {
      return deserialize<_i42.CustomerStatus>(data['data']);
    }
    if (dataClassName == 'Invoice') {
      return deserialize<_i43.Invoice>(data['data']);
    }
    if (dataClassName == 'InvoiceCursorPage') {
      return deserialize<_i44.InvoiceCursorPage>(data['data']);
    }
    if (dataClassName == 'InvoiceItem') {
      return deserialize<_i45.InvoiceItem>(data['data']);
    }
    if (dataClassName == 'InvoiceItemRequest') {
      return deserialize<_i46.InvoiceItemRequest>(data['data']);
    }
    if (dataClassName == 'InvoiceItemUnit') {
      return deserialize<_i47.InvoiceItemUnit>(data['data']);
    }
    if (dataClassName == 'InvoiceListPage') {
      return deserialize<_i48.InvoiceListPage>(data['data']);
    }
    if (dataClassName == 'InvoicePaymentStatus') {
      return deserialize<_i49.InvoicePaymentStatus>(data['data']);
    }
    if (dataClassName == 'InvoiceStatus') {
      return deserialize<_i50.InvoiceStatus>(data['data']);
    }
    if (dataClassName == 'InvoiceTemplate') {
      return deserialize<_i51.InvoiceTemplate>(data['data']);
    }
    if (dataClassName == 'InvoiceType') {
      return deserialize<_i52.InvoiceType>(data['data']);
    }
    if (dataClassName == 'PaymentMethod') {
      return deserialize<_i53.PaymentMethod>(data['data']);
    }
    if (dataClassName == 'PaymentRecord') {
      return deserialize<_i54.PaymentRecord>(data['data']);
    }
    if (dataClassName == 'RecordPaymentRequest') {
      return deserialize<_i55.RecordPaymentRequest>(data['data']);
    }
    if (dataClassName == 'RecurrenceInterval') {
      return deserialize<_i56.RecurrenceInterval>(data['data']);
    }
    if (dataClassName == 'Reminder') {
      return deserialize<_i57.Reminder>(data['data']);
    }
    if (dataClassName == 'UpdateCustomerRequest') {
      return deserialize<_i58.UpdateCustomerRequest>(data['data']);
    }
    if (dataClassName == 'UpdateInvoiceRequest') {
      return deserialize<_i59.UpdateInvoiceRequest>(data['data']);
    }
    if (dataClassName == 'UpdateInvoiceTemplateRequest') {
      return deserialize<_i60.UpdateInvoiceTemplateRequest>(data['data']);
    }
    if (dataClassName == 'UpdateRecurringScheduleRequest') {
      return deserialize<_i61.UpdateRecurringScheduleRequest>(data['data']);
    }
    if (dataClassName == 'VatRate') {
      return deserialize<_i62.VatRate>(data['data']);
    }
    if (dataClassName == 'CreateProjectRequest') {
      return deserialize<_i63.CreateProjectRequest>(data['data']);
    }
    if (dataClassName == 'CreateTaskRequest') {
      return deserialize<_i64.CreateTaskRequest>(data['data']);
    }
    if (dataClassName == 'CreateTimeEntriesInvoiceRequest') {
      return deserialize<_i65.CreateTimeEntriesInvoiceRequest>(data['data']);
    }
    if (dataClassName == 'CreateTimeEntryRequest') {
      return deserialize<_i66.CreateTimeEntryRequest>(data['data']);
    }
    if (dataClassName == 'Project') {
      return deserialize<_i67.Project>(data['data']);
    }
    if (dataClassName == 'ProjectStatus') {
      return deserialize<_i68.ProjectStatus>(data['data']);
    }
    if (dataClassName == 'StartTimerRequest') {
      return deserialize<_i69.StartTimerRequest>(data['data']);
    }
    if (dataClassName == 'Task') {
      return deserialize<_i70.Task>(data['data']);
    }
    if (dataClassName == 'TaskStatus') {
      return deserialize<_i71.TaskStatus>(data['data']);
    }
    if (dataClassName == 'TimeEntry') {
      return deserialize<_i72.TimeEntry>(data['data']);
    }
    if (dataClassName == 'TimeReport') {
      return deserialize<_i73.TimeReport>(data['data']);
    }
    if (dataClassName == 'TimeReportLine') {
      return deserialize<_i74.TimeReportLine>(data['data']);
    }
    if (dataClassName == 'UpdateProjectRequest') {
      return deserialize<_i75.UpdateProjectRequest>(data['data']);
    }
    if (dataClassName == 'UpdateTaskRequest') {
      return deserialize<_i76.UpdateTaskRequest>(data['data']);
    }
    if (dataClassName == 'UpdateTimeEntryRequest') {
      return deserialize<_i77.UpdateTimeEntryRequest>(data['data']);
    }
    if (dataClassName == 'AppTheme') {
      return deserialize<_i78.AppTheme>(data['data']);
    }
    if (dataClassName == 'UpdateUserProfileRequest') {
      return deserialize<_i79.UpdateUserProfileRequest>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_i80.UserProfile>(data['data']);
    }
    if (dataClassName.startsWith('gewerber_commercial.')) {
      data['className'] = dataClassName.substring(20);
      return _i96.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i97.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i98.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _i96.Protocol().registerHostProtocol('gewerber_backend', this);
    _i97.Protocol().registerHostProtocol('gewerber_backend', this);
    _i98.Protocol().registerHostProtocol('gewerber_backend', this);
  }

  @override
  String getModuleName() => 'gewerber_backend';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i96.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i97.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i98.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
