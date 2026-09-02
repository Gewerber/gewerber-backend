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
import 'core/admin/admin_role.dart' as _i2;
import 'core/entitlement/feature.dart' as _i3;
import 'core/errors/conflict_exception.dart' as _i4;
import 'core/errors/forbidden_exception.dart' as _i5;
import 'core/errors/not_found_exception.dart' as _i6;
import 'core/errors/validation_exception.dart' as _i7;
import 'modules/accounting/models/accounting_transaction.dart' as _i8;
import 'modules/accounting/models/create_transaction_request.dart' as _i9;
import 'modules/accounting/models/profit_loss_line.dart' as _i10;
import 'modules/accounting/models/profit_loss_report.dart' as _i11;
import 'modules/accounting/models/transaction_category.dart' as _i12;
import 'modules/accounting/models/transaction_type.dart' as _i13;
import 'modules/accounting/models/update_transaction_request.dart' as _i14;
import 'modules/admin/models/admin_audit_entry.dart' as _i15;
import 'modules/admin/models/admin_audit_page.dart' as _i16;
import 'modules/admin/models/admin_auth_status.dart' as _i17;
import 'modules/admin/models/admin_business_detail.dart' as _i18;
import 'modules/admin/models/admin_business_page.dart' as _i19;
import 'modules/admin/models/admin_invoice_page.dart' as _i20;
import 'modules/admin/models/admin_membership_info.dart' as _i21;
import 'modules/admin/models/admin_stats_overview.dart' as _i22;
import 'modules/admin/models/admin_user_dossier.dart' as _i23;
import 'modules/admin/models/admin_user_summary.dart' as _i24;
import 'modules/admin/models/admin_user_summary_page.dart' as _i25;
import 'modules/admin/models/invoice_status_count.dart' as _i26;
import 'modules/business/models/address.dart' as _i27;
import 'modules/business/models/business.dart' as _i28;
import 'modules/business/models/business_settings.dart' as _i29;
import 'modules/business/models/country.dart' as _i30;
import 'modules/business/models/create_business_request.dart' as _i31;
import 'modules/business/models/currency.dart' as _i32;
import 'modules/business/models/legal_form.dart' as _i33;
import 'modules/business/models/locale.dart' as _i34;
import 'modules/business/models/membership.dart' as _i35;
import 'modules/business/models/membership_role.dart' as _i36;
import 'modules/business/models/rounding_mode.dart' as _i37;
import 'modules/business/models/update_business_request.dart' as _i38;
import 'modules/business/models/update_business_settings_request.dart' as _i39;
import 'modules/dashboard/models/dashboard_kpis.dart' as _i40;
import 'modules/dashboard/models/dashboard_summary.dart' as _i41;
import 'modules/dashboard/models/debtor_summary.dart' as _i42;
import 'modules/dashboard/models/monthly_trend_point.dart' as _i43;
import 'modules/dashboard/models/receivables_summary.dart' as _i44;
import 'modules/dashboard/models/recent_time_entry.dart' as _i45;
import 'modules/documents/models/document.dart' as _i46;
import 'modules/documents/models/document_kind.dart' as _i47;
import 'modules/documents/models/storage_location.dart' as _i48;
import 'modules/documents/models/upload_document_request.dart' as _i49;
import 'modules/guidance/models/checklist_definition.dart' as _i50;
import 'modules/guidance/models/checklist_item_definition.dart' as _i51;
import 'modules/guidance/models/guidance_tip.dart' as _i52;
import 'modules/guidance/models/user_guidance_progress.dart' as _i53;
import 'modules/invoicing/models/create_customer_request.dart' as _i54;
import 'modules/invoicing/models/create_invoice_request.dart' as _i55;
import 'modules/invoicing/models/create_invoice_template_request.dart' as _i56;
import 'modules/invoicing/models/create_recurring_schedule_request.dart'
    as _i57;
import 'modules/invoicing/models/customer.dart' as _i58;
import 'modules/invoicing/models/customer_cursor_page.dart' as _i59;
import 'modules/invoicing/models/customer_list_page.dart' as _i60;
import 'modules/invoicing/models/customer_status.dart' as _i61;
import 'modules/invoicing/models/invoice.dart' as _i62;
import 'modules/invoicing/models/invoice_cursor_page.dart' as _i63;
import 'modules/invoicing/models/invoice_item.dart' as _i64;
import 'modules/invoicing/models/invoice_item_request.dart' as _i65;
import 'modules/invoicing/models/invoice_item_unit.dart' as _i66;
import 'modules/invoicing/models/invoice_list_page.dart' as _i67;
import 'modules/invoicing/models/invoice_payment_status.dart' as _i68;
import 'modules/invoicing/models/invoice_status.dart' as _i69;
import 'modules/invoicing/models/invoice_template.dart' as _i70;
import 'modules/invoicing/models/invoice_type.dart' as _i71;
import 'modules/invoicing/models/payment_method.dart' as _i72;
import 'modules/invoicing/models/payment_record.dart' as _i73;
import 'modules/invoicing/models/record_payment_request.dart' as _i74;
import 'modules/invoicing/models/recurrence_interval.dart' as _i75;
import 'modules/invoicing/models/reminder.dart' as _i76;
import 'modules/invoicing/models/update_customer_request.dart' as _i77;
import 'modules/invoicing/models/update_invoice_request.dart' as _i78;
import 'modules/invoicing/models/update_invoice_template_request.dart' as _i79;
import 'modules/invoicing/models/update_recurring_schedule_request.dart'
    as _i80;
import 'modules/invoicing/models/vat_rate.dart' as _i81;
import 'modules/time_tracking/models/create_project_request.dart' as _i82;
import 'modules/time_tracking/models/create_task_request.dart' as _i83;
import 'modules/time_tracking/models/create_time_entries_invoice_request.dart'
    as _i84;
import 'modules/time_tracking/models/create_time_entry_request.dart' as _i85;
import 'modules/time_tracking/models/project.dart' as _i86;
import 'modules/time_tracking/models/project_status.dart' as _i87;
import 'modules/time_tracking/models/start_timer_request.dart' as _i88;
import 'modules/time_tracking/models/task.dart' as _i89;
import 'modules/time_tracking/models/task_status.dart' as _i90;
import 'modules/time_tracking/models/time_entry.dart' as _i91;
import 'modules/time_tracking/models/time_report.dart' as _i92;
import 'modules/time_tracking/models/time_report_line.dart' as _i93;
import 'modules/time_tracking/models/update_project_request.dart' as _i94;
import 'modules/time_tracking/models/update_task_request.dart' as _i95;
import 'modules/time_tracking/models/update_time_entry_request.dart' as _i96;
import 'modules/user/models/app_theme.dart' as _i97;
import 'modules/user/models/my_identity.dart' as _i98;
import 'modules/user/models/my_membership_info.dart' as _i99;
import 'modules/user/models/update_user_profile_request.dart' as _i100;
import 'modules/user/models/user_profile.dart' as _i101;
import 'package:gewerber_backend_client/src/protocol/core/entitlement/feature.dart'
    as _i102;
import 'package:gewerber_backend_client/src/protocol/modules/accounting/models/accounting_transaction.dart'
    as _i103;
import 'package:gewerber_backend_client/src/protocol/modules/guidance/models/guidance_tip.dart'
    as _i104;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/business.dart'
    as _i105;
import 'package:gewerber_backend_client/src/protocol/modules/documents/models/document.dart'
    as _i106;
import 'package:gewerber_backend_client/src/protocol/modules/guidance/models/checklist_definition.dart'
    as _i107;
import 'package:gewerber_backend_client/src/protocol/modules/guidance/models/user_guidance_progress.dart'
    as _i108;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/customer.dart'
    as _i109;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice_item.dart'
    as _i110;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice.dart'
    as _i111;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice_template.dart'
    as _i112;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/reminder.dart'
    as _i113;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/task.dart'
    as _i114;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/project.dart'
    as _i115;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/time_entry.dart'
    as _i116;
import 'package:gewerber_backend_commercial_client/gewerber_backend_commercial_client.dart'
    as _i117;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i118;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i119;
export 'core/admin/admin_role.dart';
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
export 'modules/admin/models/admin_audit_entry.dart';
export 'modules/admin/models/admin_audit_page.dart';
export 'modules/admin/models/admin_auth_status.dart';
export 'modules/admin/models/admin_business_detail.dart';
export 'modules/admin/models/admin_business_page.dart';
export 'modules/admin/models/admin_invoice_page.dart';
export 'modules/admin/models/admin_membership_info.dart';
export 'modules/admin/models/admin_stats_overview.dart';
export 'modules/admin/models/admin_user_dossier.dart';
export 'modules/admin/models/admin_user_summary.dart';
export 'modules/admin/models/admin_user_summary_page.dart';
export 'modules/admin/models/invoice_status_count.dart';
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
export 'modules/dashboard/models/dashboard_kpis.dart';
export 'modules/dashboard/models/dashboard_summary.dart';
export 'modules/dashboard/models/debtor_summary.dart';
export 'modules/dashboard/models/monthly_trend_point.dart';
export 'modules/dashboard/models/receivables_summary.dart';
export 'modules/dashboard/models/recent_time_entry.dart';
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
export 'modules/user/models/my_identity.dart';
export 'modules/user/models/my_membership_info.dart';
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

    if (t == _i2.AdminRole) {
      return _i2.AdminRole.fromJson(data) as T;
    }
    if (t == _i3.Feature) {
      return _i3.Feature.fromJson(data) as T;
    }
    if (t == _i4.ConflictException) {
      return _i4.ConflictException.fromJson(data) as T;
    }
    if (t == _i5.ForbiddenException) {
      return _i5.ForbiddenException.fromJson(data) as T;
    }
    if (t == _i6.NotFoundException) {
      return _i6.NotFoundException.fromJson(data) as T;
    }
    if (t == _i7.ValidationException) {
      return _i7.ValidationException.fromJson(data) as T;
    }
    if (t == _i8.AccountingTransaction) {
      return _i8.AccountingTransaction.fromJson(data) as T;
    }
    if (t == _i9.CreateTransactionRequest) {
      return _i9.CreateTransactionRequest.fromJson(data) as T;
    }
    if (t == _i10.ProfitLossLine) {
      return _i10.ProfitLossLine.fromJson(data) as T;
    }
    if (t == _i11.ProfitLossReport) {
      return _i11.ProfitLossReport.fromJson(data) as T;
    }
    if (t == _i12.TransactionCategory) {
      return _i12.TransactionCategory.fromJson(data) as T;
    }
    if (t == _i13.TransactionType) {
      return _i13.TransactionType.fromJson(data) as T;
    }
    if (t == _i14.UpdateTransactionRequest) {
      return _i14.UpdateTransactionRequest.fromJson(data) as T;
    }
    if (t == _i15.AdminAuditEntry) {
      return _i15.AdminAuditEntry.fromJson(data) as T;
    }
    if (t == _i16.AdminAuditPage) {
      return _i16.AdminAuditPage.fromJson(data) as T;
    }
    if (t == _i17.AdminAuthStatus) {
      return _i17.AdminAuthStatus.fromJson(data) as T;
    }
    if (t == _i18.AdminBusinessDetail) {
      return _i18.AdminBusinessDetail.fromJson(data) as T;
    }
    if (t == _i19.AdminBusinessPage) {
      return _i19.AdminBusinessPage.fromJson(data) as T;
    }
    if (t == _i20.AdminInvoicePage) {
      return _i20.AdminInvoicePage.fromJson(data) as T;
    }
    if (t == _i21.AdminMembershipInfo) {
      return _i21.AdminMembershipInfo.fromJson(data) as T;
    }
    if (t == _i22.AdminStatsOverview) {
      return _i22.AdminStatsOverview.fromJson(data) as T;
    }
    if (t == _i23.AdminUserDossier) {
      return _i23.AdminUserDossier.fromJson(data) as T;
    }
    if (t == _i24.AdminUserSummary) {
      return _i24.AdminUserSummary.fromJson(data) as T;
    }
    if (t == _i25.AdminUserSummaryPage) {
      return _i25.AdminUserSummaryPage.fromJson(data) as T;
    }
    if (t == _i26.InvoiceStatusCount) {
      return _i26.InvoiceStatusCount.fromJson(data) as T;
    }
    if (t == _i27.Address) {
      return _i27.Address.fromJson(data) as T;
    }
    if (t == _i28.Business) {
      return _i28.Business.fromJson(data) as T;
    }
    if (t == _i29.BusinessSettings) {
      return _i29.BusinessSettings.fromJson(data) as T;
    }
    if (t == _i30.Country) {
      return _i30.Country.fromJson(data) as T;
    }
    if (t == _i31.CreateBusinessRequest) {
      return _i31.CreateBusinessRequest.fromJson(data) as T;
    }
    if (t == _i32.Currency) {
      return _i32.Currency.fromJson(data) as T;
    }
    if (t == _i33.LegalForm) {
      return _i33.LegalForm.fromJson(data) as T;
    }
    if (t == _i34.Locale) {
      return _i34.Locale.fromJson(data) as T;
    }
    if (t == _i35.Membership) {
      return _i35.Membership.fromJson(data) as T;
    }
    if (t == _i36.MembershipRole) {
      return _i36.MembershipRole.fromJson(data) as T;
    }
    if (t == _i37.RoundingMode) {
      return _i37.RoundingMode.fromJson(data) as T;
    }
    if (t == _i38.UpdateBusinessRequest) {
      return _i38.UpdateBusinessRequest.fromJson(data) as T;
    }
    if (t == _i39.UpdateBusinessSettingsRequest) {
      return _i39.UpdateBusinessSettingsRequest.fromJson(data) as T;
    }
    if (t == _i40.DashboardKpis) {
      return _i40.DashboardKpis.fromJson(data) as T;
    }
    if (t == _i41.DashboardSummary) {
      return _i41.DashboardSummary.fromJson(data) as T;
    }
    if (t == _i42.DebtorSummary) {
      return _i42.DebtorSummary.fromJson(data) as T;
    }
    if (t == _i43.MonthlyTrendPoint) {
      return _i43.MonthlyTrendPoint.fromJson(data) as T;
    }
    if (t == _i44.ReceivablesSummary) {
      return _i44.ReceivablesSummary.fromJson(data) as T;
    }
    if (t == _i45.RecentTimeEntry) {
      return _i45.RecentTimeEntry.fromJson(data) as T;
    }
    if (t == _i46.Document) {
      return _i46.Document.fromJson(data) as T;
    }
    if (t == _i47.DocumentKind) {
      return _i47.DocumentKind.fromJson(data) as T;
    }
    if (t == _i48.StorageLocation) {
      return _i48.StorageLocation.fromJson(data) as T;
    }
    if (t == _i49.UploadDocumentRequest) {
      return _i49.UploadDocumentRequest.fromJson(data) as T;
    }
    if (t == _i50.ChecklistDefinition) {
      return _i50.ChecklistDefinition.fromJson(data) as T;
    }
    if (t == _i51.ChecklistItemDefinition) {
      return _i51.ChecklistItemDefinition.fromJson(data) as T;
    }
    if (t == _i52.GuidanceTip) {
      return _i52.GuidanceTip.fromJson(data) as T;
    }
    if (t == _i53.UserGuidanceProgress) {
      return _i53.UserGuidanceProgress.fromJson(data) as T;
    }
    if (t == _i54.CreateCustomerRequest) {
      return _i54.CreateCustomerRequest.fromJson(data) as T;
    }
    if (t == _i55.CreateInvoiceRequest) {
      return _i55.CreateInvoiceRequest.fromJson(data) as T;
    }
    if (t == _i56.CreateInvoiceTemplateRequest) {
      return _i56.CreateInvoiceTemplateRequest.fromJson(data) as T;
    }
    if (t == _i57.CreateRecurringScheduleRequest) {
      return _i57.CreateRecurringScheduleRequest.fromJson(data) as T;
    }
    if (t == _i58.Customer) {
      return _i58.Customer.fromJson(data) as T;
    }
    if (t == _i59.CustomerCursorPage) {
      return _i59.CustomerCursorPage.fromJson(data) as T;
    }
    if (t == _i60.CustomerListPage) {
      return _i60.CustomerListPage.fromJson(data) as T;
    }
    if (t == _i61.CustomerStatus) {
      return _i61.CustomerStatus.fromJson(data) as T;
    }
    if (t == _i62.Invoice) {
      return _i62.Invoice.fromJson(data) as T;
    }
    if (t == _i63.InvoiceCursorPage) {
      return _i63.InvoiceCursorPage.fromJson(data) as T;
    }
    if (t == _i64.InvoiceItem) {
      return _i64.InvoiceItem.fromJson(data) as T;
    }
    if (t == _i65.InvoiceItemRequest) {
      return _i65.InvoiceItemRequest.fromJson(data) as T;
    }
    if (t == _i66.InvoiceItemUnit) {
      return _i66.InvoiceItemUnit.fromJson(data) as T;
    }
    if (t == _i67.InvoiceListPage) {
      return _i67.InvoiceListPage.fromJson(data) as T;
    }
    if (t == _i68.InvoicePaymentStatus) {
      return _i68.InvoicePaymentStatus.fromJson(data) as T;
    }
    if (t == _i69.InvoiceStatus) {
      return _i69.InvoiceStatus.fromJson(data) as T;
    }
    if (t == _i70.InvoiceTemplate) {
      return _i70.InvoiceTemplate.fromJson(data) as T;
    }
    if (t == _i71.InvoiceType) {
      return _i71.InvoiceType.fromJson(data) as T;
    }
    if (t == _i72.PaymentMethod) {
      return _i72.PaymentMethod.fromJson(data) as T;
    }
    if (t == _i73.PaymentRecord) {
      return _i73.PaymentRecord.fromJson(data) as T;
    }
    if (t == _i74.RecordPaymentRequest) {
      return _i74.RecordPaymentRequest.fromJson(data) as T;
    }
    if (t == _i75.RecurrenceInterval) {
      return _i75.RecurrenceInterval.fromJson(data) as T;
    }
    if (t == _i76.Reminder) {
      return _i76.Reminder.fromJson(data) as T;
    }
    if (t == _i77.UpdateCustomerRequest) {
      return _i77.UpdateCustomerRequest.fromJson(data) as T;
    }
    if (t == _i78.UpdateInvoiceRequest) {
      return _i78.UpdateInvoiceRequest.fromJson(data) as T;
    }
    if (t == _i79.UpdateInvoiceTemplateRequest) {
      return _i79.UpdateInvoiceTemplateRequest.fromJson(data) as T;
    }
    if (t == _i80.UpdateRecurringScheduleRequest) {
      return _i80.UpdateRecurringScheduleRequest.fromJson(data) as T;
    }
    if (t == _i81.VatRate) {
      return _i81.VatRate.fromJson(data) as T;
    }
    if (t == _i82.CreateProjectRequest) {
      return _i82.CreateProjectRequest.fromJson(data) as T;
    }
    if (t == _i83.CreateTaskRequest) {
      return _i83.CreateTaskRequest.fromJson(data) as T;
    }
    if (t == _i84.CreateTimeEntriesInvoiceRequest) {
      return _i84.CreateTimeEntriesInvoiceRequest.fromJson(data) as T;
    }
    if (t == _i85.CreateTimeEntryRequest) {
      return _i85.CreateTimeEntryRequest.fromJson(data) as T;
    }
    if (t == _i86.Project) {
      return _i86.Project.fromJson(data) as T;
    }
    if (t == _i87.ProjectStatus) {
      return _i87.ProjectStatus.fromJson(data) as T;
    }
    if (t == _i88.StartTimerRequest) {
      return _i88.StartTimerRequest.fromJson(data) as T;
    }
    if (t == _i89.Task) {
      return _i89.Task.fromJson(data) as T;
    }
    if (t == _i90.TaskStatus) {
      return _i90.TaskStatus.fromJson(data) as T;
    }
    if (t == _i91.TimeEntry) {
      return _i91.TimeEntry.fromJson(data) as T;
    }
    if (t == _i92.TimeReport) {
      return _i92.TimeReport.fromJson(data) as T;
    }
    if (t == _i93.TimeReportLine) {
      return _i93.TimeReportLine.fromJson(data) as T;
    }
    if (t == _i94.UpdateProjectRequest) {
      return _i94.UpdateProjectRequest.fromJson(data) as T;
    }
    if (t == _i95.UpdateTaskRequest) {
      return _i95.UpdateTaskRequest.fromJson(data) as T;
    }
    if (t == _i96.UpdateTimeEntryRequest) {
      return _i96.UpdateTimeEntryRequest.fromJson(data) as T;
    }
    if (t == _i97.AppTheme) {
      return _i97.AppTheme.fromJson(data) as T;
    }
    if (t == _i98.MyIdentity) {
      return _i98.MyIdentity.fromJson(data) as T;
    }
    if (t == _i99.MyMembershipInfo) {
      return _i99.MyMembershipInfo.fromJson(data) as T;
    }
    if (t == _i100.UpdateUserProfileRequest) {
      return _i100.UpdateUserProfileRequest.fromJson(data) as T;
    }
    if (t == _i101.UserProfile) {
      return _i101.UserProfile.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AdminRole?>()) {
      return (data != null ? _i2.AdminRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Feature?>()) {
      return (data != null ? _i3.Feature.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.ConflictException?>()) {
      return (data != null ? _i4.ConflictException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.ForbiddenException?>()) {
      return (data != null ? _i5.ForbiddenException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.NotFoundException?>()) {
      return (data != null ? _i6.NotFoundException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.ValidationException?>()) {
      return (data != null ? _i7.ValidationException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.AccountingTransaction?>()) {
      return (data != null ? _i8.AccountingTransaction.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.CreateTransactionRequest?>()) {
      return (data != null ? _i9.CreateTransactionRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.ProfitLossLine?>()) {
      return (data != null ? _i10.ProfitLossLine.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.ProfitLossReport?>()) {
      return (data != null ? _i11.ProfitLossReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.TransactionCategory?>()) {
      return (data != null ? _i12.TransactionCategory.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.TransactionType?>()) {
      return (data != null ? _i13.TransactionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.UpdateTransactionRequest?>()) {
      return (data != null
              ? _i14.UpdateTransactionRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i15.AdminAuditEntry?>()) {
      return (data != null ? _i15.AdminAuditEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.AdminAuditPage?>()) {
      return (data != null ? _i16.AdminAuditPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.AdminAuthStatus?>()) {
      return (data != null ? _i17.AdminAuthStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.AdminBusinessDetail?>()) {
      return (data != null ? _i18.AdminBusinessDetail.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.AdminBusinessPage?>()) {
      return (data != null ? _i19.AdminBusinessPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.AdminInvoicePage?>()) {
      return (data != null ? _i20.AdminInvoicePage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.AdminMembershipInfo?>()) {
      return (data != null ? _i21.AdminMembershipInfo.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.AdminStatsOverview?>()) {
      return (data != null ? _i22.AdminStatsOverview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.AdminUserDossier?>()) {
      return (data != null ? _i23.AdminUserDossier.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.AdminUserSummary?>()) {
      return (data != null ? _i24.AdminUserSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.AdminUserSummaryPage?>()) {
      return (data != null ? _i25.AdminUserSummaryPage.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.InvoiceStatusCount?>()) {
      return (data != null ? _i26.InvoiceStatusCount.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.Address?>()) {
      return (data != null ? _i27.Address.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.Business?>()) {
      return (data != null ? _i28.Business.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.BusinessSettings?>()) {
      return (data != null ? _i29.BusinessSettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.Country?>()) {
      return (data != null ? _i30.Country.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.CreateBusinessRequest?>()) {
      return (data != null ? _i31.CreateBusinessRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i32.Currency?>()) {
      return (data != null ? _i32.Currency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.LegalForm?>()) {
      return (data != null ? _i33.LegalForm.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.Locale?>()) {
      return (data != null ? _i34.Locale.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.Membership?>()) {
      return (data != null ? _i35.Membership.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.MembershipRole?>()) {
      return (data != null ? _i36.MembershipRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.RoundingMode?>()) {
      return (data != null ? _i37.RoundingMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.UpdateBusinessRequest?>()) {
      return (data != null ? _i38.UpdateBusinessRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i39.UpdateBusinessSettingsRequest?>()) {
      return (data != null
              ? _i39.UpdateBusinessSettingsRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i40.DashboardKpis?>()) {
      return (data != null ? _i40.DashboardKpis.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.DashboardSummary?>()) {
      return (data != null ? _i41.DashboardSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.DebtorSummary?>()) {
      return (data != null ? _i42.DebtorSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.MonthlyTrendPoint?>()) {
      return (data != null ? _i43.MonthlyTrendPoint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.ReceivablesSummary?>()) {
      return (data != null ? _i44.ReceivablesSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i45.RecentTimeEntry?>()) {
      return (data != null ? _i45.RecentTimeEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.Document?>()) {
      return (data != null ? _i46.Document.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.DocumentKind?>()) {
      return (data != null ? _i47.DocumentKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.StorageLocation?>()) {
      return (data != null ? _i48.StorageLocation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.UploadDocumentRequest?>()) {
      return (data != null ? _i49.UploadDocumentRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i50.ChecklistDefinition?>()) {
      return (data != null ? _i50.ChecklistDefinition.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i51.ChecklistItemDefinition?>()) {
      return (data != null ? _i51.ChecklistItemDefinition.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i52.GuidanceTip?>()) {
      return (data != null ? _i52.GuidanceTip.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.UserGuidanceProgress?>()) {
      return (data != null ? _i53.UserGuidanceProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i54.CreateCustomerRequest?>()) {
      return (data != null ? _i54.CreateCustomerRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i55.CreateInvoiceRequest?>()) {
      return (data != null ? _i55.CreateInvoiceRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i56.CreateInvoiceTemplateRequest?>()) {
      return (data != null
              ? _i56.CreateInvoiceTemplateRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i57.CreateRecurringScheduleRequest?>()) {
      return (data != null
              ? _i57.CreateRecurringScheduleRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i58.Customer?>()) {
      return (data != null ? _i58.Customer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.CustomerCursorPage?>()) {
      return (data != null ? _i59.CustomerCursorPage.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i60.CustomerListPage?>()) {
      return (data != null ? _i60.CustomerListPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.CustomerStatus?>()) {
      return (data != null ? _i61.CustomerStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.Invoice?>()) {
      return (data != null ? _i62.Invoice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.InvoiceCursorPage?>()) {
      return (data != null ? _i63.InvoiceCursorPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.InvoiceItem?>()) {
      return (data != null ? _i64.InvoiceItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.InvoiceItemRequest?>()) {
      return (data != null ? _i65.InvoiceItemRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i66.InvoiceItemUnit?>()) {
      return (data != null ? _i66.InvoiceItemUnit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.InvoiceListPage?>()) {
      return (data != null ? _i67.InvoiceListPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.InvoicePaymentStatus?>()) {
      return (data != null ? _i68.InvoicePaymentStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i69.InvoiceStatus?>()) {
      return (data != null ? _i69.InvoiceStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i70.InvoiceTemplate?>()) {
      return (data != null ? _i70.InvoiceTemplate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.InvoiceType?>()) {
      return (data != null ? _i71.InvoiceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i72.PaymentMethod?>()) {
      return (data != null ? _i72.PaymentMethod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i73.PaymentRecord?>()) {
      return (data != null ? _i73.PaymentRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i74.RecordPaymentRequest?>()) {
      return (data != null ? _i74.RecordPaymentRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i75.RecurrenceInterval?>()) {
      return (data != null ? _i75.RecurrenceInterval.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i76.Reminder?>()) {
      return (data != null ? _i76.Reminder.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i77.UpdateCustomerRequest?>()) {
      return (data != null ? _i77.UpdateCustomerRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i78.UpdateInvoiceRequest?>()) {
      return (data != null ? _i78.UpdateInvoiceRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i79.UpdateInvoiceTemplateRequest?>()) {
      return (data != null
              ? _i79.UpdateInvoiceTemplateRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i80.UpdateRecurringScheduleRequest?>()) {
      return (data != null
              ? _i80.UpdateRecurringScheduleRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i81.VatRate?>()) {
      return (data != null ? _i81.VatRate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i82.CreateProjectRequest?>()) {
      return (data != null ? _i82.CreateProjectRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i83.CreateTaskRequest?>()) {
      return (data != null ? _i83.CreateTaskRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i84.CreateTimeEntriesInvoiceRequest?>()) {
      return (data != null
              ? _i84.CreateTimeEntriesInvoiceRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i85.CreateTimeEntryRequest?>()) {
      return (data != null ? _i85.CreateTimeEntryRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i86.Project?>()) {
      return (data != null ? _i86.Project.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i87.ProjectStatus?>()) {
      return (data != null ? _i87.ProjectStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i88.StartTimerRequest?>()) {
      return (data != null ? _i88.StartTimerRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i89.Task?>()) {
      return (data != null ? _i89.Task.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i90.TaskStatus?>()) {
      return (data != null ? _i90.TaskStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i91.TimeEntry?>()) {
      return (data != null ? _i91.TimeEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i92.TimeReport?>()) {
      return (data != null ? _i92.TimeReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i93.TimeReportLine?>()) {
      return (data != null ? _i93.TimeReportLine.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i94.UpdateProjectRequest?>()) {
      return (data != null ? _i94.UpdateProjectRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i95.UpdateTaskRequest?>()) {
      return (data != null ? _i95.UpdateTaskRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i96.UpdateTimeEntryRequest?>()) {
      return (data != null ? _i96.UpdateTimeEntryRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i97.AppTheme?>()) {
      return (data != null ? _i97.AppTheme.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i98.MyIdentity?>()) {
      return (data != null ? _i98.MyIdentity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i99.MyMembershipInfo?>()) {
      return (data != null ? _i99.MyMembershipInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i100.UpdateUserProfileRequest?>()) {
      return (data != null
              ? _i100.UpdateUserProfileRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i101.UserProfile?>()) {
      return (data != null ? _i101.UserProfile.fromJson(data) : null) as T;
    }
    if (t == List<_i10.ProfitLossLine>) {
      return (data as List)
              .map((e) => deserialize<_i10.ProfitLossLine>(e))
              .toList()
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<String>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_i15.AdminAuditEntry>) {
      return (data as List)
              .map((e) => deserialize<_i15.AdminAuditEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.AdminMembershipInfo>) {
      return (data as List)
              .map((e) => deserialize<_i21.AdminMembershipInfo>(e))
              .toList()
          as T;
    }
    if (t == List<_i28.Business>) {
      return (data as List).map((e) => deserialize<_i28.Business>(e)).toList()
          as T;
    }
    if (t == List<_i62.Invoice>) {
      return (data as List).map((e) => deserialize<_i62.Invoice>(e)).toList()
          as T;
    }
    if (t == List<_i26.InvoiceStatusCount>) {
      return (data as List)
              .map((e) => deserialize<_i26.InvoiceStatusCount>(e))
              .toList()
          as T;
    }
    if (t == List<_i24.AdminUserSummary>) {
      return (data as List)
              .map((e) => deserialize<_i24.AdminUserSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i43.MonthlyTrendPoint>) {
      return (data as List)
              .map((e) => deserialize<_i43.MonthlyTrendPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_i8.AccountingTransaction>) {
      return (data as List)
              .map((e) => deserialize<_i8.AccountingTransaction>(e))
              .toList()
          as T;
    }
    if (t == List<_i45.RecentTimeEntry>) {
      return (data as List)
              .map((e) => deserialize<_i45.RecentTimeEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i42.DebtorSummary>) {
      return (data as List)
              .map((e) => deserialize<_i42.DebtorSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i51.ChecklistItemDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i51.ChecklistItemDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i65.InvoiceItemRequest>) {
      return (data as List)
              .map((e) => deserialize<_i65.InvoiceItemRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_i58.Customer>) {
      return (data as List).map((e) => deserialize<_i58.Customer>(e)).toList()
          as T;
    }
    if (t == List<_i73.PaymentRecord>) {
      return (data as List)
              .map((e) => deserialize<_i73.PaymentRecord>(e))
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
    if (t == List<_i93.TimeReportLine>) {
      return (data as List)
              .map((e) => deserialize<_i93.TimeReportLine>(e))
              .toList()
          as T;
    }
    if (t == List<_i99.MyMembershipInfo>) {
      return (data as List)
              .map((e) => deserialize<_i99.MyMembershipInfo>(e))
              .toList()
          as T;
    }
    if (t == List<_i102.Feature>) {
      return (data as List).map((e) => deserialize<_i102.Feature>(e)).toList()
          as T;
    }
    if (t == List<_i103.AccountingTransaction>) {
      return (data as List)
              .map((e) => deserialize<_i103.AccountingTransaction>(e))
              .toList()
          as T;
    }
    if (t == List<_i104.GuidanceTip>) {
      return (data as List)
              .map((e) => deserialize<_i104.GuidanceTip>(e))
              .toList()
          as T;
    }
    if (t == List<_i105.Business>) {
      return (data as List).map((e) => deserialize<_i105.Business>(e)).toList()
          as T;
    }
    if (t == List<_i106.Document>) {
      return (data as List).map((e) => deserialize<_i106.Document>(e)).toList()
          as T;
    }
    if (t == List<_i107.ChecklistDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i107.ChecklistDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i108.UserGuidanceProgress>) {
      return (data as List)
              .map((e) => deserialize<_i108.UserGuidanceProgress>(e))
              .toList()
          as T;
    }
    if (t == List<_i109.Customer>) {
      return (data as List).map((e) => deserialize<_i109.Customer>(e)).toList()
          as T;
    }
    if (t == List<_i110.InvoiceItem>) {
      return (data as List)
              .map((e) => deserialize<_i110.InvoiceItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i111.Invoice>) {
      return (data as List).map((e) => deserialize<_i111.Invoice>(e)).toList()
          as T;
    }
    if (t == List<_i112.InvoiceTemplate>) {
      return (data as List)
              .map((e) => deserialize<_i112.InvoiceTemplate>(e))
              .toList()
          as T;
    }
    if (t == List<_i113.Reminder>) {
      return (data as List).map((e) => deserialize<_i113.Reminder>(e)).toList()
          as T;
    }
    if (t == List<_i114.Task>) {
      return (data as List).map((e) => deserialize<_i114.Task>(e)).toList()
          as T;
    }
    if (t == List<_i115.Project>) {
      return (data as List).map((e) => deserialize<_i115.Project>(e)).toList()
          as T;
    }
    if (t == List<_i116.TimeEntry>) {
      return (data as List).map((e) => deserialize<_i116.TimeEntry>(e)).toList()
          as T;
    }
    try {
      return _i117.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i118.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i119.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AdminRole => 'AdminRole',
      _i3.Feature => 'Feature',
      _i4.ConflictException => 'ConflictException',
      _i5.ForbiddenException => 'ForbiddenException',
      _i6.NotFoundException => 'NotFoundException',
      _i7.ValidationException => 'ValidationException',
      _i8.AccountingTransaction => 'AccountingTransaction',
      _i9.CreateTransactionRequest => 'CreateTransactionRequest',
      _i10.ProfitLossLine => 'ProfitLossLine',
      _i11.ProfitLossReport => 'ProfitLossReport',
      _i12.TransactionCategory => 'TransactionCategory',
      _i13.TransactionType => 'TransactionType',
      _i14.UpdateTransactionRequest => 'UpdateTransactionRequest',
      _i15.AdminAuditEntry => 'AdminAuditEntry',
      _i16.AdminAuditPage => 'AdminAuditPage',
      _i17.AdminAuthStatus => 'AdminAuthStatus',
      _i18.AdminBusinessDetail => 'AdminBusinessDetail',
      _i19.AdminBusinessPage => 'AdminBusinessPage',
      _i20.AdminInvoicePage => 'AdminInvoicePage',
      _i21.AdminMembershipInfo => 'AdminMembershipInfo',
      _i22.AdminStatsOverview => 'AdminStatsOverview',
      _i23.AdminUserDossier => 'AdminUserDossier',
      _i24.AdminUserSummary => 'AdminUserSummary',
      _i25.AdminUserSummaryPage => 'AdminUserSummaryPage',
      _i26.InvoiceStatusCount => 'InvoiceStatusCount',
      _i27.Address => 'Address',
      _i28.Business => 'Business',
      _i29.BusinessSettings => 'BusinessSettings',
      _i30.Country => 'Country',
      _i31.CreateBusinessRequest => 'CreateBusinessRequest',
      _i32.Currency => 'Currency',
      _i33.LegalForm => 'LegalForm',
      _i34.Locale => 'Locale',
      _i35.Membership => 'Membership',
      _i36.MembershipRole => 'MembershipRole',
      _i37.RoundingMode => 'RoundingMode',
      _i38.UpdateBusinessRequest => 'UpdateBusinessRequest',
      _i39.UpdateBusinessSettingsRequest => 'UpdateBusinessSettingsRequest',
      _i40.DashboardKpis => 'DashboardKpis',
      _i41.DashboardSummary => 'DashboardSummary',
      _i42.DebtorSummary => 'DebtorSummary',
      _i43.MonthlyTrendPoint => 'MonthlyTrendPoint',
      _i44.ReceivablesSummary => 'ReceivablesSummary',
      _i45.RecentTimeEntry => 'RecentTimeEntry',
      _i46.Document => 'Document',
      _i47.DocumentKind => 'DocumentKind',
      _i48.StorageLocation => 'StorageLocation',
      _i49.UploadDocumentRequest => 'UploadDocumentRequest',
      _i50.ChecklistDefinition => 'ChecklistDefinition',
      _i51.ChecklistItemDefinition => 'ChecklistItemDefinition',
      _i52.GuidanceTip => 'GuidanceTip',
      _i53.UserGuidanceProgress => 'UserGuidanceProgress',
      _i54.CreateCustomerRequest => 'CreateCustomerRequest',
      _i55.CreateInvoiceRequest => 'CreateInvoiceRequest',
      _i56.CreateInvoiceTemplateRequest => 'CreateInvoiceTemplateRequest',
      _i57.CreateRecurringScheduleRequest => 'CreateRecurringScheduleRequest',
      _i58.Customer => 'Customer',
      _i59.CustomerCursorPage => 'CustomerCursorPage',
      _i60.CustomerListPage => 'CustomerListPage',
      _i61.CustomerStatus => 'CustomerStatus',
      _i62.Invoice => 'Invoice',
      _i63.InvoiceCursorPage => 'InvoiceCursorPage',
      _i64.InvoiceItem => 'InvoiceItem',
      _i65.InvoiceItemRequest => 'InvoiceItemRequest',
      _i66.InvoiceItemUnit => 'InvoiceItemUnit',
      _i67.InvoiceListPage => 'InvoiceListPage',
      _i68.InvoicePaymentStatus => 'InvoicePaymentStatus',
      _i69.InvoiceStatus => 'InvoiceStatus',
      _i70.InvoiceTemplate => 'InvoiceTemplate',
      _i71.InvoiceType => 'InvoiceType',
      _i72.PaymentMethod => 'PaymentMethod',
      _i73.PaymentRecord => 'PaymentRecord',
      _i74.RecordPaymentRequest => 'RecordPaymentRequest',
      _i75.RecurrenceInterval => 'RecurrenceInterval',
      _i76.Reminder => 'Reminder',
      _i77.UpdateCustomerRequest => 'UpdateCustomerRequest',
      _i78.UpdateInvoiceRequest => 'UpdateInvoiceRequest',
      _i79.UpdateInvoiceTemplateRequest => 'UpdateInvoiceTemplateRequest',
      _i80.UpdateRecurringScheduleRequest => 'UpdateRecurringScheduleRequest',
      _i81.VatRate => 'VatRate',
      _i82.CreateProjectRequest => 'CreateProjectRequest',
      _i83.CreateTaskRequest => 'CreateTaskRequest',
      _i84.CreateTimeEntriesInvoiceRequest => 'CreateTimeEntriesInvoiceRequest',
      _i85.CreateTimeEntryRequest => 'CreateTimeEntryRequest',
      _i86.Project => 'Project',
      _i87.ProjectStatus => 'ProjectStatus',
      _i88.StartTimerRequest => 'StartTimerRequest',
      _i89.Task => 'Task',
      _i90.TaskStatus => 'TaskStatus',
      _i91.TimeEntry => 'TimeEntry',
      _i92.TimeReport => 'TimeReport',
      _i93.TimeReportLine => 'TimeReportLine',
      _i94.UpdateProjectRequest => 'UpdateProjectRequest',
      _i95.UpdateTaskRequest => 'UpdateTaskRequest',
      _i96.UpdateTimeEntryRequest => 'UpdateTimeEntryRequest',
      _i97.AppTheme => 'AppTheme',
      _i98.MyIdentity => 'MyIdentity',
      _i99.MyMembershipInfo => 'MyMembershipInfo',
      _i100.UpdateUserProfileRequest => 'UpdateUserProfileRequest',
      _i101.UserProfile => 'UserProfile',
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
      case _i2.AdminRole():
        return 'AdminRole';
      case _i3.Feature():
        return 'Feature';
      case _i4.ConflictException():
        return 'ConflictException';
      case _i5.ForbiddenException():
        return 'ForbiddenException';
      case _i6.NotFoundException():
        return 'NotFoundException';
      case _i7.ValidationException():
        return 'ValidationException';
      case _i8.AccountingTransaction():
        return 'AccountingTransaction';
      case _i9.CreateTransactionRequest():
        return 'CreateTransactionRequest';
      case _i10.ProfitLossLine():
        return 'ProfitLossLine';
      case _i11.ProfitLossReport():
        return 'ProfitLossReport';
      case _i12.TransactionCategory():
        return 'TransactionCategory';
      case _i13.TransactionType():
        return 'TransactionType';
      case _i14.UpdateTransactionRequest():
        return 'UpdateTransactionRequest';
      case _i15.AdminAuditEntry():
        return 'AdminAuditEntry';
      case _i16.AdminAuditPage():
        return 'AdminAuditPage';
      case _i17.AdminAuthStatus():
        return 'AdminAuthStatus';
      case _i18.AdminBusinessDetail():
        return 'AdminBusinessDetail';
      case _i19.AdminBusinessPage():
        return 'AdminBusinessPage';
      case _i20.AdminInvoicePage():
        return 'AdminInvoicePage';
      case _i21.AdminMembershipInfo():
        return 'AdminMembershipInfo';
      case _i22.AdminStatsOverview():
        return 'AdminStatsOverview';
      case _i23.AdminUserDossier():
        return 'AdminUserDossier';
      case _i24.AdminUserSummary():
        return 'AdminUserSummary';
      case _i25.AdminUserSummaryPage():
        return 'AdminUserSummaryPage';
      case _i26.InvoiceStatusCount():
        return 'InvoiceStatusCount';
      case _i27.Address():
        return 'Address';
      case _i28.Business():
        return 'Business';
      case _i29.BusinessSettings():
        return 'BusinessSettings';
      case _i30.Country():
        return 'Country';
      case _i31.CreateBusinessRequest():
        return 'CreateBusinessRequest';
      case _i32.Currency():
        return 'Currency';
      case _i33.LegalForm():
        return 'LegalForm';
      case _i34.Locale():
        return 'Locale';
      case _i35.Membership():
        return 'Membership';
      case _i36.MembershipRole():
        return 'MembershipRole';
      case _i37.RoundingMode():
        return 'RoundingMode';
      case _i38.UpdateBusinessRequest():
        return 'UpdateBusinessRequest';
      case _i39.UpdateBusinessSettingsRequest():
        return 'UpdateBusinessSettingsRequest';
      case _i40.DashboardKpis():
        return 'DashboardKpis';
      case _i41.DashboardSummary():
        return 'DashboardSummary';
      case _i42.DebtorSummary():
        return 'DebtorSummary';
      case _i43.MonthlyTrendPoint():
        return 'MonthlyTrendPoint';
      case _i44.ReceivablesSummary():
        return 'ReceivablesSummary';
      case _i45.RecentTimeEntry():
        return 'RecentTimeEntry';
      case _i46.Document():
        return 'Document';
      case _i47.DocumentKind():
        return 'DocumentKind';
      case _i48.StorageLocation():
        return 'StorageLocation';
      case _i49.UploadDocumentRequest():
        return 'UploadDocumentRequest';
      case _i50.ChecklistDefinition():
        return 'ChecklistDefinition';
      case _i51.ChecklistItemDefinition():
        return 'ChecklistItemDefinition';
      case _i52.GuidanceTip():
        return 'GuidanceTip';
      case _i53.UserGuidanceProgress():
        return 'UserGuidanceProgress';
      case _i54.CreateCustomerRequest():
        return 'CreateCustomerRequest';
      case _i55.CreateInvoiceRequest():
        return 'CreateInvoiceRequest';
      case _i56.CreateInvoiceTemplateRequest():
        return 'CreateInvoiceTemplateRequest';
      case _i57.CreateRecurringScheduleRequest():
        return 'CreateRecurringScheduleRequest';
      case _i58.Customer():
        return 'Customer';
      case _i59.CustomerCursorPage():
        return 'CustomerCursorPage';
      case _i60.CustomerListPage():
        return 'CustomerListPage';
      case _i61.CustomerStatus():
        return 'CustomerStatus';
      case _i62.Invoice():
        return 'Invoice';
      case _i63.InvoiceCursorPage():
        return 'InvoiceCursorPage';
      case _i64.InvoiceItem():
        return 'InvoiceItem';
      case _i65.InvoiceItemRequest():
        return 'InvoiceItemRequest';
      case _i66.InvoiceItemUnit():
        return 'InvoiceItemUnit';
      case _i67.InvoiceListPage():
        return 'InvoiceListPage';
      case _i68.InvoicePaymentStatus():
        return 'InvoicePaymentStatus';
      case _i69.InvoiceStatus():
        return 'InvoiceStatus';
      case _i70.InvoiceTemplate():
        return 'InvoiceTemplate';
      case _i71.InvoiceType():
        return 'InvoiceType';
      case _i72.PaymentMethod():
        return 'PaymentMethod';
      case _i73.PaymentRecord():
        return 'PaymentRecord';
      case _i74.RecordPaymentRequest():
        return 'RecordPaymentRequest';
      case _i75.RecurrenceInterval():
        return 'RecurrenceInterval';
      case _i76.Reminder():
        return 'Reminder';
      case _i77.UpdateCustomerRequest():
        return 'UpdateCustomerRequest';
      case _i78.UpdateInvoiceRequest():
        return 'UpdateInvoiceRequest';
      case _i79.UpdateInvoiceTemplateRequest():
        return 'UpdateInvoiceTemplateRequest';
      case _i80.UpdateRecurringScheduleRequest():
        return 'UpdateRecurringScheduleRequest';
      case _i81.VatRate():
        return 'VatRate';
      case _i82.CreateProjectRequest():
        return 'CreateProjectRequest';
      case _i83.CreateTaskRequest():
        return 'CreateTaskRequest';
      case _i84.CreateTimeEntriesInvoiceRequest():
        return 'CreateTimeEntriesInvoiceRequest';
      case _i85.CreateTimeEntryRequest():
        return 'CreateTimeEntryRequest';
      case _i86.Project():
        return 'Project';
      case _i87.ProjectStatus():
        return 'ProjectStatus';
      case _i88.StartTimerRequest():
        return 'StartTimerRequest';
      case _i89.Task():
        return 'Task';
      case _i90.TaskStatus():
        return 'TaskStatus';
      case _i91.TimeEntry():
        return 'TimeEntry';
      case _i92.TimeReport():
        return 'TimeReport';
      case _i93.TimeReportLine():
        return 'TimeReportLine';
      case _i94.UpdateProjectRequest():
        return 'UpdateProjectRequest';
      case _i95.UpdateTaskRequest():
        return 'UpdateTaskRequest';
      case _i96.UpdateTimeEntryRequest():
        return 'UpdateTimeEntryRequest';
      case _i97.AppTheme():
        return 'AppTheme';
      case _i98.MyIdentity():
        return 'MyIdentity';
      case _i99.MyMembershipInfo():
        return 'MyMembershipInfo';
      case _i100.UpdateUserProfileRequest():
        return 'UpdateUserProfileRequest';
      case _i101.UserProfile():
        return 'UserProfile';
    }
    className = _i117.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'gewerber_backend_commercial.$className';
    }
    className = _i118.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _i119.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AdminRole') {
      return deserialize<_i2.AdminRole>(data['data']);
    }
    if (dataClassName == 'Feature') {
      return deserialize<_i3.Feature>(data['data']);
    }
    if (dataClassName == 'ConflictException') {
      return deserialize<_i4.ConflictException>(data['data']);
    }
    if (dataClassName == 'ForbiddenException') {
      return deserialize<_i5.ForbiddenException>(data['data']);
    }
    if (dataClassName == 'NotFoundException') {
      return deserialize<_i6.NotFoundException>(data['data']);
    }
    if (dataClassName == 'ValidationException') {
      return deserialize<_i7.ValidationException>(data['data']);
    }
    if (dataClassName == 'AccountingTransaction') {
      return deserialize<_i8.AccountingTransaction>(data['data']);
    }
    if (dataClassName == 'CreateTransactionRequest') {
      return deserialize<_i9.CreateTransactionRequest>(data['data']);
    }
    if (dataClassName == 'ProfitLossLine') {
      return deserialize<_i10.ProfitLossLine>(data['data']);
    }
    if (dataClassName == 'ProfitLossReport') {
      return deserialize<_i11.ProfitLossReport>(data['data']);
    }
    if (dataClassName == 'TransactionCategory') {
      return deserialize<_i12.TransactionCategory>(data['data']);
    }
    if (dataClassName == 'TransactionType') {
      return deserialize<_i13.TransactionType>(data['data']);
    }
    if (dataClassName == 'UpdateTransactionRequest') {
      return deserialize<_i14.UpdateTransactionRequest>(data['data']);
    }
    if (dataClassName == 'AdminAuditEntry') {
      return deserialize<_i15.AdminAuditEntry>(data['data']);
    }
    if (dataClassName == 'AdminAuditPage') {
      return deserialize<_i16.AdminAuditPage>(data['data']);
    }
    if (dataClassName == 'AdminAuthStatus') {
      return deserialize<_i17.AdminAuthStatus>(data['data']);
    }
    if (dataClassName == 'AdminBusinessDetail') {
      return deserialize<_i18.AdminBusinessDetail>(data['data']);
    }
    if (dataClassName == 'AdminBusinessPage') {
      return deserialize<_i19.AdminBusinessPage>(data['data']);
    }
    if (dataClassName == 'AdminInvoicePage') {
      return deserialize<_i20.AdminInvoicePage>(data['data']);
    }
    if (dataClassName == 'AdminMembershipInfo') {
      return deserialize<_i21.AdminMembershipInfo>(data['data']);
    }
    if (dataClassName == 'AdminStatsOverview') {
      return deserialize<_i22.AdminStatsOverview>(data['data']);
    }
    if (dataClassName == 'AdminUserDossier') {
      return deserialize<_i23.AdminUserDossier>(data['data']);
    }
    if (dataClassName == 'AdminUserSummary') {
      return deserialize<_i24.AdminUserSummary>(data['data']);
    }
    if (dataClassName == 'AdminUserSummaryPage') {
      return deserialize<_i25.AdminUserSummaryPage>(data['data']);
    }
    if (dataClassName == 'InvoiceStatusCount') {
      return deserialize<_i26.InvoiceStatusCount>(data['data']);
    }
    if (dataClassName == 'Address') {
      return deserialize<_i27.Address>(data['data']);
    }
    if (dataClassName == 'Business') {
      return deserialize<_i28.Business>(data['data']);
    }
    if (dataClassName == 'BusinessSettings') {
      return deserialize<_i29.BusinessSettings>(data['data']);
    }
    if (dataClassName == 'Country') {
      return deserialize<_i30.Country>(data['data']);
    }
    if (dataClassName == 'CreateBusinessRequest') {
      return deserialize<_i31.CreateBusinessRequest>(data['data']);
    }
    if (dataClassName == 'Currency') {
      return deserialize<_i32.Currency>(data['data']);
    }
    if (dataClassName == 'LegalForm') {
      return deserialize<_i33.LegalForm>(data['data']);
    }
    if (dataClassName == 'Locale') {
      return deserialize<_i34.Locale>(data['data']);
    }
    if (dataClassName == 'Membership') {
      return deserialize<_i35.Membership>(data['data']);
    }
    if (dataClassName == 'MembershipRole') {
      return deserialize<_i36.MembershipRole>(data['data']);
    }
    if (dataClassName == 'RoundingMode') {
      return deserialize<_i37.RoundingMode>(data['data']);
    }
    if (dataClassName == 'UpdateBusinessRequest') {
      return deserialize<_i38.UpdateBusinessRequest>(data['data']);
    }
    if (dataClassName == 'UpdateBusinessSettingsRequest') {
      return deserialize<_i39.UpdateBusinessSettingsRequest>(data['data']);
    }
    if (dataClassName == 'DashboardKpis') {
      return deserialize<_i40.DashboardKpis>(data['data']);
    }
    if (dataClassName == 'DashboardSummary') {
      return deserialize<_i41.DashboardSummary>(data['data']);
    }
    if (dataClassName == 'DebtorSummary') {
      return deserialize<_i42.DebtorSummary>(data['data']);
    }
    if (dataClassName == 'MonthlyTrendPoint') {
      return deserialize<_i43.MonthlyTrendPoint>(data['data']);
    }
    if (dataClassName == 'ReceivablesSummary') {
      return deserialize<_i44.ReceivablesSummary>(data['data']);
    }
    if (dataClassName == 'RecentTimeEntry') {
      return deserialize<_i45.RecentTimeEntry>(data['data']);
    }
    if (dataClassName == 'Document') {
      return deserialize<_i46.Document>(data['data']);
    }
    if (dataClassName == 'DocumentKind') {
      return deserialize<_i47.DocumentKind>(data['data']);
    }
    if (dataClassName == 'StorageLocation') {
      return deserialize<_i48.StorageLocation>(data['data']);
    }
    if (dataClassName == 'UploadDocumentRequest') {
      return deserialize<_i49.UploadDocumentRequest>(data['data']);
    }
    if (dataClassName == 'ChecklistDefinition') {
      return deserialize<_i50.ChecklistDefinition>(data['data']);
    }
    if (dataClassName == 'ChecklistItemDefinition') {
      return deserialize<_i51.ChecklistItemDefinition>(data['data']);
    }
    if (dataClassName == 'GuidanceTip') {
      return deserialize<_i52.GuidanceTip>(data['data']);
    }
    if (dataClassName == 'UserGuidanceProgress') {
      return deserialize<_i53.UserGuidanceProgress>(data['data']);
    }
    if (dataClassName == 'CreateCustomerRequest') {
      return deserialize<_i54.CreateCustomerRequest>(data['data']);
    }
    if (dataClassName == 'CreateInvoiceRequest') {
      return deserialize<_i55.CreateInvoiceRequest>(data['data']);
    }
    if (dataClassName == 'CreateInvoiceTemplateRequest') {
      return deserialize<_i56.CreateInvoiceTemplateRequest>(data['data']);
    }
    if (dataClassName == 'CreateRecurringScheduleRequest') {
      return deserialize<_i57.CreateRecurringScheduleRequest>(data['data']);
    }
    if (dataClassName == 'Customer') {
      return deserialize<_i58.Customer>(data['data']);
    }
    if (dataClassName == 'CustomerCursorPage') {
      return deserialize<_i59.CustomerCursorPage>(data['data']);
    }
    if (dataClassName == 'CustomerListPage') {
      return deserialize<_i60.CustomerListPage>(data['data']);
    }
    if (dataClassName == 'CustomerStatus') {
      return deserialize<_i61.CustomerStatus>(data['data']);
    }
    if (dataClassName == 'Invoice') {
      return deserialize<_i62.Invoice>(data['data']);
    }
    if (dataClassName == 'InvoiceCursorPage') {
      return deserialize<_i63.InvoiceCursorPage>(data['data']);
    }
    if (dataClassName == 'InvoiceItem') {
      return deserialize<_i64.InvoiceItem>(data['data']);
    }
    if (dataClassName == 'InvoiceItemRequest') {
      return deserialize<_i65.InvoiceItemRequest>(data['data']);
    }
    if (dataClassName == 'InvoiceItemUnit') {
      return deserialize<_i66.InvoiceItemUnit>(data['data']);
    }
    if (dataClassName == 'InvoiceListPage') {
      return deserialize<_i67.InvoiceListPage>(data['data']);
    }
    if (dataClassName == 'InvoicePaymentStatus') {
      return deserialize<_i68.InvoicePaymentStatus>(data['data']);
    }
    if (dataClassName == 'InvoiceStatus') {
      return deserialize<_i69.InvoiceStatus>(data['data']);
    }
    if (dataClassName == 'InvoiceTemplate') {
      return deserialize<_i70.InvoiceTemplate>(data['data']);
    }
    if (dataClassName == 'InvoiceType') {
      return deserialize<_i71.InvoiceType>(data['data']);
    }
    if (dataClassName == 'PaymentMethod') {
      return deserialize<_i72.PaymentMethod>(data['data']);
    }
    if (dataClassName == 'PaymentRecord') {
      return deserialize<_i73.PaymentRecord>(data['data']);
    }
    if (dataClassName == 'RecordPaymentRequest') {
      return deserialize<_i74.RecordPaymentRequest>(data['data']);
    }
    if (dataClassName == 'RecurrenceInterval') {
      return deserialize<_i75.RecurrenceInterval>(data['data']);
    }
    if (dataClassName == 'Reminder') {
      return deserialize<_i76.Reminder>(data['data']);
    }
    if (dataClassName == 'UpdateCustomerRequest') {
      return deserialize<_i77.UpdateCustomerRequest>(data['data']);
    }
    if (dataClassName == 'UpdateInvoiceRequest') {
      return deserialize<_i78.UpdateInvoiceRequest>(data['data']);
    }
    if (dataClassName == 'UpdateInvoiceTemplateRequest') {
      return deserialize<_i79.UpdateInvoiceTemplateRequest>(data['data']);
    }
    if (dataClassName == 'UpdateRecurringScheduleRequest') {
      return deserialize<_i80.UpdateRecurringScheduleRequest>(data['data']);
    }
    if (dataClassName == 'VatRate') {
      return deserialize<_i81.VatRate>(data['data']);
    }
    if (dataClassName == 'CreateProjectRequest') {
      return deserialize<_i82.CreateProjectRequest>(data['data']);
    }
    if (dataClassName == 'CreateTaskRequest') {
      return deserialize<_i83.CreateTaskRequest>(data['data']);
    }
    if (dataClassName == 'CreateTimeEntriesInvoiceRequest') {
      return deserialize<_i84.CreateTimeEntriesInvoiceRequest>(data['data']);
    }
    if (dataClassName == 'CreateTimeEntryRequest') {
      return deserialize<_i85.CreateTimeEntryRequest>(data['data']);
    }
    if (dataClassName == 'Project') {
      return deserialize<_i86.Project>(data['data']);
    }
    if (dataClassName == 'ProjectStatus') {
      return deserialize<_i87.ProjectStatus>(data['data']);
    }
    if (dataClassName == 'StartTimerRequest') {
      return deserialize<_i88.StartTimerRequest>(data['data']);
    }
    if (dataClassName == 'Task') {
      return deserialize<_i89.Task>(data['data']);
    }
    if (dataClassName == 'TaskStatus') {
      return deserialize<_i90.TaskStatus>(data['data']);
    }
    if (dataClassName == 'TimeEntry') {
      return deserialize<_i91.TimeEntry>(data['data']);
    }
    if (dataClassName == 'TimeReport') {
      return deserialize<_i92.TimeReport>(data['data']);
    }
    if (dataClassName == 'TimeReportLine') {
      return deserialize<_i93.TimeReportLine>(data['data']);
    }
    if (dataClassName == 'UpdateProjectRequest') {
      return deserialize<_i94.UpdateProjectRequest>(data['data']);
    }
    if (dataClassName == 'UpdateTaskRequest') {
      return deserialize<_i95.UpdateTaskRequest>(data['data']);
    }
    if (dataClassName == 'UpdateTimeEntryRequest') {
      return deserialize<_i96.UpdateTimeEntryRequest>(data['data']);
    }
    if (dataClassName == 'AppTheme') {
      return deserialize<_i97.AppTheme>(data['data']);
    }
    if (dataClassName == 'MyIdentity') {
      return deserialize<_i98.MyIdentity>(data['data']);
    }
    if (dataClassName == 'MyMembershipInfo') {
      return deserialize<_i99.MyMembershipInfo>(data['data']);
    }
    if (dataClassName == 'UpdateUserProfileRequest') {
      return deserialize<_i100.UpdateUserProfileRequest>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_i101.UserProfile>(data['data']);
    }
    if (dataClassName.startsWith('gewerber_backend_commercial.')) {
      data['className'] = dataClassName.substring(20);
      return _i117.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i118.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i119.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _i117.Protocol().registerHostProtocol('gewerber_backend', this);
    _i118.Protocol().registerHostProtocol('gewerber_backend', this);
    _i119.Protocol().registerHostProtocol('gewerber_backend', this);
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
      return _i117.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i118.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i119.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
