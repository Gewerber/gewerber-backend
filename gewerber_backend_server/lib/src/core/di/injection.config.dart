// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../modules/accounting/application/create_transaction_use_case.dart'
    as _i196;
import '../../modules/accounting/application/delete_transaction_use_case.dart'
    as _i108;
import '../../modules/accounting/application/export_transactions_use_case.dart'
    as _i661;
import '../../modules/accounting/application/get_transaction_use_case.dart'
    as _i872;
import '../../modules/accounting/application/list_transactions_use_case.dart'
    as _i91;
import '../../modules/accounting/application/profit_loss_use_case.dart'
    as _i151;
import '../../modules/accounting/application/update_transaction_use_case.dart'
    as _i142;
import '../../modules/accounting/data/serverpod_transaction_gateway.dart'
    as _i223;
import '../../modules/accounting/domain/transaction_gateway.dart' as _i1065;
import '../../modules/accounting/domain/transaction_reference_validator.dart'
    as _i394;
import '../../modules/business/application/create_business_use_case.dart'
    as _i1059;
import '../../modules/business/application/get_business_settings_use_case.dart'
    as _i529;
import '../../modules/business/application/get_business_use_case.dart' as _i910;
import '../../modules/business/application/list_my_businesses_use_case.dart'
    as _i28;
import '../../modules/business/application/update_business_settings_use_case.dart'
    as _i130;
import '../../modules/business/application/update_business_use_case.dart'
    as _i748;
import '../../modules/business/data/serverpod_business_gateway.dart' as _i8;
import '../../modules/business/data/serverpod_business_settings_gateway.dart'
    as _i823;
import '../../modules/business/data/serverpod_membership_gateway.dart' as _i257;
import '../../modules/business/data/serverpod_tenant_resolver.dart' as _i707;
import '../../modules/business/domain/business_gateway.dart' as _i647;
import '../../modules/business/domain/business_settings_gateway.dart' as _i141;
import '../../modules/business/domain/membership_gateway.dart' as _i688;
import '../../modules/documents/application/delete_document_use_case.dart'
    as _i877;
import '../../modules/documents/application/download_document_use_case.dart'
    as _i1004;
import '../../modules/documents/application/get_document_use_case.dart'
    as _i166;
import '../../modules/documents/application/list_documents_use_case.dart'
    as _i259;
import '../../modules/documents/application/upload_document_use_case.dart'
    as _i131;
import '../../modules/documents/data/serverpod_document_gateway.dart' as _i249;
import '../../modules/documents/domain/document_gateway.dart' as _i643;
import '../../modules/guidance/application/guidance_use_cases.dart' as _i912;
import '../../modules/guidance/data/serverpod_user_guidance_progress_gateway.dart'
    as _i851;
import '../../modules/guidance/domain/guidance_content_provider.dart' as _i993;
import '../../modules/guidance/domain/user_guidance_progress_gateway.dart'
    as _i783;
import '../../modules/invoicing/application/cancel_invoice_use_case.dart'
    as _i6;
import '../../modules/invoicing/application/cancel_recurring_schedule_use_case.dart'
    as _i162;
import '../../modules/invoicing/application/create_customer_use_case.dart'
    as _i795;
import '../../modules/invoicing/application/create_invoice_template_use_case.dart'
    as _i1032;
import '../../modules/invoicing/application/create_invoice_use_case.dart'
    as _i1013;
import '../../modules/invoicing/application/create_recurring_schedule_use_case.dart'
    as _i185;
import '../../modules/invoicing/application/delete_invoice_use_case.dart'
    as _i439;
import '../../modules/invoicing/application/export_invoices_use_case.dart'
    as _i308;
import '../../modules/invoicing/application/generate_invoice_pdf_use_case.dart'
    as _i425;
import '../../modules/invoicing/application/get_customer_use_case.dart'
    as _i318;
import '../../modules/invoicing/application/get_invoice_template_use_case.dart'
    as _i238;
import '../../modules/invoicing/application/get_invoice_use_case.dart' as _i344;
import '../../modules/invoicing/application/get_payment_status_use_case.dart'
    as _i236;
import '../../modules/invoicing/application/get_recurring_schedule_use_case.dart'
    as _i382;
import '../../modules/invoicing/application/list_customers_cursor_page_use_case.dart'
    as _i907;
import '../../modules/invoicing/application/list_customers_page_use_case.dart'
    as _i658;
import '../../modules/invoicing/application/list_customers_use_case.dart'
    as _i893;
import '../../modules/invoicing/application/list_invoice_templates_use_case.dart'
    as _i558;
import '../../modules/invoicing/application/list_invoices_cursor_page_use_case.dart'
    as _i749;
import '../../modules/invoicing/application/list_invoices_page_use_case.dart'
    as _i255;
import '../../modules/invoicing/application/list_invoices_use_case.dart'
    as _i787;
import '../../modules/invoicing/application/list_recurring_schedules_use_case.dart'
    as _i1001;
import '../../modules/invoicing/application/list_reminders_use_case.dart'
    as _i674;
import '../../modules/invoicing/application/mark_invoice_sent_use_case.dart'
    as _i706;
import '../../modules/invoicing/application/mark_overdue_invoices_use_case.dart'
    as _i780;
import '../../modules/invoicing/application/process_recurring_invoices_use_case.dart'
    as _i556;
import '../../modules/invoicing/application/record_payment_use_case.dart'
    as _i197;
import '../../modules/invoicing/application/send_payment_reminder_use_case.dart'
    as _i562;
import '../../modules/invoicing/application/update_customer_use_case.dart'
    as _i472;
import '../../modules/invoicing/application/update_invoice_template_use_case.dart'
    as _i833;
import '../../modules/invoicing/application/update_invoice_use_case.dart'
    as _i421;
import '../../modules/invoicing/application/update_recurring_schedule_use_case.dart'
    as _i521;
import '../../modules/invoicing/data/pdf_invoice_generator.dart' as _i1030;
import '../../modules/invoicing/data/serverpod_customer_gateway.dart' as _i356;
import '../../modules/invoicing/data/serverpod_invoice_gateway.dart' as _i109;
import '../../modules/invoicing/data/serverpod_invoice_item_gateway.dart'
    as _i1012;
import '../../modules/invoicing/data/serverpod_invoice_template_gateway.dart'
    as _i27;
import '../../modules/invoicing/data/serverpod_payment_record_gateway.dart'
    as _i438;
import '../../modules/invoicing/data/serverpod_reminder_gateway.dart' as _i754;
import '../../modules/invoicing/domain/customer_gateway.dart' as _i696;
import '../../modules/invoicing/domain/invoice_gateway.dart' as _i517;
import '../../modules/invoicing/domain/invoice_item_gateway.dart' as _i20;
import '../../modules/invoicing/domain/invoice_number_service.dart' as _i988;
import '../../modules/invoicing/domain/invoice_pdf_generator.dart' as _i668;
import '../../modules/invoicing/domain/invoice_template_gateway.dart' as _i331;
import '../../modules/invoicing/domain/payment_record_gateway.dart' as _i1025;
import '../../modules/invoicing/domain/reminder_gateway.dart' as _i788;
import '../../modules/invoicing/domain/tax_rule_engine.dart' as _i755;
import '../../modules/time_tracking/application/create_project_use_case.dart'
    as _i315;
import '../../modules/time_tracking/application/create_task_use_case.dart'
    as _i640;
import '../../modules/time_tracking/application/create_time_entries_invoice_use_case.dart'
    as _i950;
import '../../modules/time_tracking/application/create_time_entry_use_case.dart'
    as _i975;
import '../../modules/time_tracking/application/delete_project_use_case.dart'
    as _i401;
import '../../modules/time_tracking/application/delete_time_entry_use_case.dart'
    as _i1027;
import '../../modules/time_tracking/application/get_project_use_case.dart'
    as _i873;
import '../../modules/time_tracking/application/get_time_entry_use_case.dart'
    as _i747;
import '../../modules/time_tracking/application/get_time_report_use_case.dart'
    as _i388;
import '../../modules/time_tracking/application/list_projects_use_case.dart'
    as _i226;
import '../../modules/time_tracking/application/list_tasks_use_case.dart'
    as _i137;
import '../../modules/time_tracking/application/list_time_entries_use_case.dart'
    as _i198;
import '../../modules/time_tracking/application/start_timer_use_case.dart'
    as _i796;
import '../../modules/time_tracking/application/stop_timer_use_case.dart'
    as _i756;
import '../../modules/time_tracking/application/update_project_use_case.dart'
    as _i98;
import '../../modules/time_tracking/application/update_task_use_case.dart'
    as _i789;
import '../../modules/time_tracking/application/update_time_entry_use_case.dart'
    as _i518;
import '../../modules/time_tracking/data/serverpod_project_gateway.dart'
    as _i616;
import '../../modules/time_tracking/data/serverpod_task_gateway.dart' as _i810;
import '../../modules/time_tracking/data/serverpod_time_entry_gateway.dart'
    as _i132;
import '../../modules/time_tracking/domain/project_gateway.dart' as _i974;
import '../../modules/time_tracking/domain/task_gateway.dart' as _i18;
import '../../modules/time_tracking/domain/time_entry_gateway.dart' as _i417;
import '../../modules/user/application/delete_my_account_use_case.dart'
    as _i710;
import '../../modules/user/application/export_my_data_use_case.dart' as _i435;
import '../../modules/user/application/get_my_profile_use_case.dart' as _i325;
import '../../modules/user/application/update_user_profile_use_case.dart'
    as _i282;
import '../../modules/user/data/serverpod_account_anonymization_gateway.dart'
    as _i1024;
import '../../modules/user/data/serverpod_user_profile_gateway.dart' as _i693;
import '../../modules/user/domain/account_anonymization_gateway.dart' as _i655;
import '../../modules/user/domain/user_profile_gateway.dart' as _i467;
import '../audit/audit_service.dart' as _i473;
import '../entitlement/all_features_entitlement_provider.dart' as _i398;
import '../entitlement/entitlement_provider.dart' as _i664;
import '../events/event_bus.dart' as _i557;
import '../events/message_central_event_bus.dart' as _i991;
import '../mail/mail_service.dart' as _i1069;
import '../sequence/data/serverpod_sequence_gateway.dart' as _i445;
import '../sequence/domain/sequence_gateway.dart' as _i559;
import '../tenant/tenant_resolver.dart' as _i343;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i473.AuditService>(() => _i473.AuditService());
    gh.singleton<_i1069.MailService>(() => _i1069.MailService());
    gh.singleton<_i993.GuidanceContentProvider>(
      () => _i993.GuidanceContentProvider(),
    );
    gh.singleton<_i755.TaxRuleEngine>(() => _i755.TaxRuleEngine());
    gh.singleton<_i783.UserGuidanceProgressGateway>(
      () => _i851.ServerpodUserGuidanceProgressGateway(),
    );
    gh.singleton<_i974.ProjectGateway>(() => _i616.ServerpodProjectGateway());
    gh.singleton<_i559.SequenceGateway>(() => _i445.ServerpodSequenceGateway());
    gh.singleton<_i988.InvoiceNumberService>(
      () => _i988.InvoiceNumberService(gh<_i559.SequenceGateway>()),
    );
    gh.singleton<_i668.InvoicePdfGenerator>(
      () => const _i1030.PdfInvoiceGenerator(),
    );
    gh.singleton<_i647.BusinessGateway>(() => _i8.ServerpodBusinessGateway());
    gh.singleton<_i655.AccountAnonymizationGateway>(
      () => _i1024.ServerpodAccountAnonymizationGateway(),
    );
    gh.singleton<_i696.CustomerGateway>(() => _i356.ServerpodCustomerGateway());
    gh.singleton<_i1025.PaymentRecordGateway>(
      () => _i438.ServerpodPaymentRecordGateway(),
    );
    gh.singleton<_i18.TaskGateway>(() => _i810.ServerpodTaskGateway());
    gh.singleton<_i331.InvoiceTemplateGateway>(
      () => _i27.ServerpodInvoiceTemplateGateway(),
    );
    gh.singleton<_i517.InvoiceGateway>(() => _i109.ServerpodInvoiceGateway());
    gh.singleton<_i688.MembershipGateway>(
      () => _i257.ServerpodMembershipGateway(),
    );
    gh.singleton<_i1065.TransactionGateway>(
      () => _i223.ServerpodTransactionGateway(),
    );
    gh.singleton<_i664.EntitlementProvider>(
      () => _i398.AllFeaturesEntitlementProvider(),
    );
    gh.singleton<_i467.UserProfileGateway>(
      () => _i693.ServerpodUserProfileGateway(),
    );
    gh.singleton<_i417.TimeEntryGateway>(
      () => _i132.ServerpodTimeEntryGateway(),
    );
    gh.singleton<_i557.EventBus>(() => _i991.MessageCentralEventBus());
    gh.singleton<_i643.DocumentGateway>(() => _i249.ServerpodDocumentGateway());
    gh.singleton<_i141.BusinessSettingsGateway>(
      () => _i823.ServerpodBusinessSettingsGateway(),
    );
    gh.singleton<_i20.InvoiceItemGateway>(
      () => _i1012.ServerpodInvoiceItemGateway(),
    );
    gh.singleton<_i788.ReminderGateway>(() => _i754.ServerpodReminderGateway());
    gh.singleton<_i282.UpdateUserProfileUseCase>(
      () => _i282.UpdateUserProfileUseCase(
        gh<_i467.UserProfileGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i435.ExportMyDataUseCase>(
      () => _i435.ExportMyDataUseCase(
        gh<_i467.UserProfileGateway>(),
        gh<_i688.MembershipGateway>(),
        gh<_i696.CustomerGateway>(),
        gh<_i517.InvoiceGateway>(),
        gh<_i20.InvoiceItemGateway>(),
        gh<_i1025.PaymentRecordGateway>(),
        gh<_i788.ReminderGateway>(),
        gh<_i974.ProjectGateway>(),
        gh<_i18.TaskGateway>(),
        gh<_i417.TimeEntryGateway>(),
        gh<_i1065.TransactionGateway>(),
        gh<_i643.DocumentGateway>(),
        gh<_i783.UserGuidanceProgressGateway>(),
      ),
    );
    gh.singleton<_i780.MarkOverdueInvoicesUseCase>(
      () => _i780.MarkOverdueInvoicesUseCase(gh<_i517.InvoiceGateway>()),
    );
    gh.singleton<_i556.ProcessRecurringInvoicesUseCase>(
      () => _i556.ProcessRecurringInvoicesUseCase(
        gh<_i517.InvoiceGateway>(),
        gh<_i20.InvoiceItemGateway>(),
        gh<_i647.BusinessGateway>(),
        gh<_i141.BusinessSettingsGateway>(),
        gh<_i988.InvoiceNumberService>(),
        gh<_i755.TaxRuleEngine>(),
      ),
    );
    gh.singleton<_i1059.CreateBusinessUseCase>(
      () => _i1059.CreateBusinessUseCase(
        gh<_i647.BusinessGateway>(),
        gh<_i688.MembershipGateway>(),
        gh<_i467.UserProfileGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i394.TransactionReferenceValidator>(
      () => _i394.TransactionReferenceValidator(
        gh<_i643.DocumentGateway>(),
        gh<_i517.InvoiceGateway>(),
      ),
    );
    gh.singleton<_i343.TenantResolver>(
      () => _i707.ServerpodTenantResolver(gh<_i688.MembershipGateway>()),
    );
    gh.singleton<_i28.ListMyBusinessesUseCase>(
      () => _i28.ListMyBusinessesUseCase(
        gh<_i647.BusinessGateway>(),
        gh<_i688.MembershipGateway>(),
      ),
    );
    gh.singleton<_i710.DeleteMyAccountUseCase>(
      () => _i710.DeleteMyAccountUseCase(
        gh<_i467.UserProfileGateway>(),
        gh<_i655.AccountAnonymizationGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i912.GuidanceSessionService>(
      () => _i912.GuidanceSessionService(gh<_i467.UserProfileGateway>()),
    );
    gh.singleton<_i325.GetMyProfileUseCase>(
      () => _i325.GetMyProfileUseCase(gh<_i467.UserProfileGateway>()),
    );
    gh.singleton<_i529.GetBusinessSettingsUseCase>(
      () => _i529.GetBusinessSettingsUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i141.BusinessSettingsGateway>(),
      ),
    );
    gh.singleton<_i382.GetRecurringScheduleUseCase>(
      () => _i382.GetRecurringScheduleUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i517.InvoiceGateway>(),
      ),
    );
    gh.singleton<_i749.ListInvoicesCursorPageUseCase>(
      () => _i749.ListInvoicesCursorPageUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i517.InvoiceGateway>(),
      ),
    );
    gh.singleton<_i255.ListInvoicesPageUseCase>(
      () => _i255.ListInvoicesPageUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i517.InvoiceGateway>(),
      ),
    );
    gh.singleton<_i787.ListInvoicesUseCase>(
      () => _i787.ListInvoicesUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i517.InvoiceGateway>(),
      ),
    );
    gh.singleton<_i1001.ListRecurringSchedulesUseCase>(
      () => _i1001.ListRecurringSchedulesUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i517.InvoiceGateway>(),
      ),
    );
    gh.singleton<_i318.GetCustomerUseCase>(
      () => _i318.GetCustomerUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i696.CustomerGateway>(),
      ),
    );
    gh.singleton<_i907.ListCustomersCursorPageUseCase>(
      () => _i907.ListCustomersCursorPageUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i696.CustomerGateway>(),
      ),
    );
    gh.singleton<_i658.ListCustomersPageUseCase>(
      () => _i658.ListCustomersPageUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i696.CustomerGateway>(),
      ),
    );
    gh.singleton<_i893.ListCustomersUseCase>(
      () => _i893.ListCustomersUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i696.CustomerGateway>(),
      ),
    );
    gh.singleton<_i166.GetDocumentUseCase>(
      () => _i166.GetDocumentUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i643.DocumentGateway>(),
      ),
    );
    gh.singleton<_i259.ListDocumentsUseCase>(
      () => _i259.ListDocumentsUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i643.DocumentGateway>(),
      ),
    );
    gh.singleton<_i975.CreateTimeEntryUseCase>(
      () => _i975.CreateTimeEntryUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i417.TimeEntryGateway>(),
        gh<_i974.ProjectGateway>(),
        gh<_i18.TaskGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i796.StartTimerUseCase>(
      () => _i796.StartTimerUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i417.TimeEntryGateway>(),
        gh<_i974.ProjectGateway>(),
        gh<_i18.TaskGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i518.UpdateTimeEntryUseCase>(
      () => _i518.UpdateTimeEntryUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i417.TimeEntryGateway>(),
        gh<_i974.ProjectGateway>(),
        gh<_i18.TaskGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i196.CreateTransactionUseCase>(
      () => _i196.CreateTransactionUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i1065.TransactionGateway>(),
        gh<_i394.TransactionReferenceValidator>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i142.UpdateTransactionUseCase>(
      () => _i142.UpdateTransactionUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i1065.TransactionGateway>(),
        gh<_i394.TransactionReferenceValidator>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i421.UpdateInvoiceUseCase>(
      () => _i421.UpdateInvoiceUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i517.InvoiceGateway>(),
        gh<_i20.InvoiceItemGateway>(),
        gh<_i647.BusinessGateway>(),
        gh<_i696.CustomerGateway>(),
        gh<_i331.InvoiceTemplateGateway>(),
        gh<_i755.TaxRuleEngine>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i344.GetInvoiceUseCase>(
      () => _i344.GetInvoiceUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i517.InvoiceGateway>(),
        gh<_i20.InvoiceItemGateway>(),
      ),
    );
    gh.singleton<_i748.UpdateBusinessUseCase>(
      () => _i748.UpdateBusinessUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i647.BusinessGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i108.DeleteTransactionUseCase>(
      () => _i108.DeleteTransactionUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i1065.TransactionGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i238.GetInvoiceTemplateUseCase>(
      () => _i238.GetInvoiceTemplateUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i331.InvoiceTemplateGateway>(),
      ),
    );
    gh.singleton<_i558.ListInvoiceTemplatesUseCase>(
      () => _i558.ListInvoiceTemplatesUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i331.InvoiceTemplateGateway>(),
      ),
    );
    gh.singleton<_i1027.DeleteTimeEntryUseCase>(
      () => _i1027.DeleteTimeEntryUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i417.TimeEntryGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i6.CancelInvoiceUseCase>(
      () => _i6.CancelInvoiceUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i517.InvoiceGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i162.CancelRecurringScheduleUseCase>(
      () => _i162.CancelRecurringScheduleUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i517.InvoiceGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i185.CreateRecurringScheduleUseCase>(
      () => _i185.CreateRecurringScheduleUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i517.InvoiceGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i439.DeleteInvoiceUseCase>(
      () => _i439.DeleteInvoiceUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i517.InvoiceGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i706.MarkInvoiceSentUseCase>(
      () => _i706.MarkInvoiceSentUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i517.InvoiceGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i521.UpdateRecurringScheduleUseCase>(
      () => _i521.UpdateRecurringScheduleUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i517.InvoiceGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i562.SendPaymentReminderUseCase>(
      () => _i562.SendPaymentReminderUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i517.InvoiceGateway>(),
        gh<_i696.CustomerGateway>(),
        gh<_i647.BusinessGateway>(),
        gh<_i788.ReminderGateway>(),
        gh<_i1069.MailService>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i795.CreateCustomerUseCase>(
      () => _i795.CreateCustomerUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i696.CustomerGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i472.UpdateCustomerUseCase>(
      () => _i472.UpdateCustomerUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i696.CustomerGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i1013.CreateInvoiceUseCase>(
      () => _i1013.CreateInvoiceUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i517.InvoiceGateway>(),
        gh<_i20.InvoiceItemGateway>(),
        gh<_i647.BusinessGateway>(),
        gh<_i141.BusinessSettingsGateway>(),
        gh<_i696.CustomerGateway>(),
        gh<_i331.InvoiceTemplateGateway>(),
        gh<_i988.InvoiceNumberService>(),
        gh<_i755.TaxRuleEngine>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i674.ListRemindersUseCase>(
      () => _i674.ListRemindersUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i517.InvoiceGateway>(),
        gh<_i788.ReminderGateway>(),
      ),
    );
    gh.singleton<_i388.GetTimeReportUseCase>(
      () => _i388.GetTimeReportUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i417.TimeEntryGateway>(),
        gh<_i974.ProjectGateway>(),
        gh<_i18.TaskGateway>(),
        gh<_i141.BusinessSettingsGateway>(),
      ),
    );
    gh.singleton<_i661.ExportTransactionsUseCase>(
      () => _i661.ExportTransactionsUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i1065.TransactionGateway>(),
      ),
    );
    gh.singleton<_i872.GetTransactionUseCase>(
      () => _i872.GetTransactionUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i1065.TransactionGateway>(),
      ),
    );
    gh.singleton<_i91.ListTransactionsUseCase>(
      () => _i91.ListTransactionsUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i1065.TransactionGateway>(),
      ),
    );
    gh.singleton<_i151.ProfitLossUseCase>(
      () => _i151.ProfitLossUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i1065.TransactionGateway>(),
      ),
    );
    gh.singleton<_i197.RecordPaymentUseCase>(
      () => _i197.RecordPaymentUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i517.InvoiceGateway>(),
        gh<_i1025.PaymentRecordGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i747.GetTimeEntryUseCase>(
      () => _i747.GetTimeEntryUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i417.TimeEntryGateway>(),
      ),
    );
    gh.singleton<_i198.ListTimeEntriesUseCase>(
      () => _i198.ListTimeEntriesUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i417.TimeEntryGateway>(),
      ),
    );
    gh.singleton<_i308.ExportInvoicesUseCase>(
      () => _i308.ExportInvoicesUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i517.InvoiceGateway>(),
        gh<_i20.InvoiceItemGateway>(),
        gh<_i696.CustomerGateway>(),
      ),
    );
    gh.singleton<_i756.StopTimerUseCase>(
      () => _i756.StopTimerUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i417.TimeEntryGateway>(),
        gh<_i141.BusinessSettingsGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i640.CreateTaskUseCase>(
      () => _i640.CreateTaskUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i974.ProjectGateway>(),
        gh<_i18.TaskGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i236.GetPaymentStatusUseCase>(
      () => _i236.GetPaymentStatusUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i517.InvoiceGateway>(),
        gh<_i1025.PaymentRecordGateway>(),
      ),
    );
    gh.singleton<_i910.GetBusinessUseCase>(
      () => _i910.GetBusinessUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i647.BusinessGateway>(),
      ),
    );
    gh.singleton<_i130.UpdateBusinessSettingsUseCase>(
      () => _i130.UpdateBusinessSettingsUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i141.BusinessSettingsGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i226.ListProjectsUseCase>(
      () => _i226.ListProjectsUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i974.ProjectGateway>(),
      ),
    );
    gh.singleton<_i131.UploadDocumentUseCase>(
      () => _i131.UploadDocumentUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i643.DocumentGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i873.GetProjectUseCase>(
      () => _i873.GetProjectUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i974.ProjectGateway>(),
        gh<_i18.TaskGateway>(),
      ),
    );
    gh.singleton<_i137.ListTasksUseCase>(
      () => _i137.ListTasksUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i974.ProjectGateway>(),
        gh<_i18.TaskGateway>(),
      ),
    );
    gh.singleton<_i1032.CreateInvoiceTemplateUseCase>(
      () => _i1032.CreateInvoiceTemplateUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i331.InvoiceTemplateGateway>(),
        gh<_i643.DocumentGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i833.UpdateInvoiceTemplateUseCase>(
      () => _i833.UpdateInvoiceTemplateUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i331.InvoiceTemplateGateway>(),
        gh<_i643.DocumentGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i950.CreateTimeEntriesInvoiceUseCase>(
      () => _i950.CreateTimeEntriesInvoiceUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i974.ProjectGateway>(),
        gh<_i18.TaskGateway>(),
        gh<_i417.TimeEntryGateway>(),
        gh<_i1013.CreateInvoiceUseCase>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i1004.DownloadDocumentUseCase>(
      () => _i1004.DownloadDocumentUseCase(gh<_i166.GetDocumentUseCase>()),
    );
    gh.singleton<_i401.DeleteProjectUseCase>(
      () => _i401.DeleteProjectUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i974.ProjectGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i912.MarkGuidanceCompletedUseCase>(
      () => _i912.MarkGuidanceCompletedUseCase(
        gh<_i912.GuidanceSessionService>(),
        gh<_i783.UserGuidanceProgressGateway>(),
      ),
    );
    gh.singleton<_i912.DismissGuidanceTipUseCase>(
      () => _i912.DismissGuidanceTipUseCase(
        gh<_i912.GuidanceSessionService>(),
        gh<_i783.UserGuidanceProgressGateway>(),
      ),
    );
    gh.singleton<_i877.DeleteDocumentUseCase>(
      () => _i877.DeleteDocumentUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i166.GetDocumentUseCase>(),
        gh<_i643.DocumentGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i789.UpdateTaskUseCase>(
      () => _i789.UpdateTaskUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i18.TaskGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i315.CreateProjectUseCase>(
      () => _i315.CreateProjectUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i974.ProjectGateway>(),
        gh<_i696.CustomerGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i98.UpdateProjectUseCase>(
      () => _i98.UpdateProjectUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i974.ProjectGateway>(),
        gh<_i696.CustomerGateway>(),
        gh<_i473.AuditService>(),
      ),
    );
    gh.singleton<_i425.GenerateInvoicePdfUseCase>(
      () => _i425.GenerateInvoicePdfUseCase(
        gh<_i343.TenantResolver>(),
        gh<_i517.InvoiceGateway>(),
        gh<_i20.InvoiceItemGateway>(),
        gh<_i696.CustomerGateway>(),
        gh<_i647.BusinessGateway>(),
        gh<_i331.InvoiceTemplateGateway>(),
        gh<_i643.DocumentGateway>(),
        gh<_i668.InvoicePdfGenerator>(),
        gh<_i473.AuditService>(),
      ),
    );
    return this;
  }
}
