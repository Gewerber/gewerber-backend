/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../auth/email_idp_endpoint.dart' as _i2;
import '../auth/jwt_refresh_endpoint.dart' as _i3;
import '../core/entitlement/endpoints/entitlement_endpoint.dart' as _i4;
import '../modules/accounting/endpoints/accounting_endpoint.dart' as _i5;
import '../modules/admin/endpoints/admin_audit_endpoint.dart' as _i6;
import '../modules/admin/endpoints/admin_businesses_endpoint.dart' as _i7;
import '../modules/admin/endpoints/admin_guidance_endpoint.dart' as _i8;
import '../modules/admin/endpoints/admin_invoices_endpoint.dart' as _i9;
import '../modules/admin/endpoints/admin_stats_endpoint.dart' as _i10;
import '../modules/admin/endpoints/admin_users_endpoint.dart' as _i11;
import '../modules/business/endpoints/business_endpoint.dart' as _i12;
import '../modules/business/endpoints/business_settings_endpoint.dart' as _i13;
import '../modules/dashboard/endpoints/dashboard_endpoint.dart' as _i14;
import '../modules/documents/endpoints/document_endpoint.dart' as _i15;
import '../modules/guidance/endpoints/guidance_endpoint.dart' as _i16;
import '../modules/invoicing/endpoints/customer_endpoint.dart' as _i17;
import '../modules/invoicing/endpoints/invoice_endpoint.dart' as _i18;
import '../modules/invoicing/endpoints/invoice_template_endpoint.dart' as _i19;
import '../modules/invoicing/endpoints/payment_endpoint.dart' as _i20;
import '../modules/invoicing/endpoints/recurring_schedule_endpoint.dart'
    as _i21;
import '../modules/invoicing/endpoints/reminder_endpoint.dart' as _i22;
import '../modules/time_tracking/endpoints/project_endpoint.dart' as _i23;
import '../modules/time_tracking/endpoints/task_endpoint.dart' as _i24;
import '../modules/time_tracking/endpoints/time_entry_endpoint.dart' as _i25;
import '../modules/user/endpoints/user_profile_endpoint.dart' as _i26;
import 'package:gewerber_backend_server/src/generated/modules/accounting/models/create_transaction_request.dart'
    as _i27;
import 'package:gewerber_backend_server/src/generated/modules/accounting/models/update_transaction_request.dart'
    as _i28;
import 'package:gewerber_backend_server/src/generated/modules/accounting/models/transaction_type.dart'
    as _i29;
import 'package:gewerber_backend_server/src/generated/modules/accounting/models/transaction_category.dart'
    as _i30;
import 'package:gewerber_backend_server/src/generated/modules/business/models/membership_role.dart'
    as _i31;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/invoice_status.dart'
    as _i32;
import 'package:gewerber_backend_server/src/generated/modules/business/models/create_business_request.dart'
    as _i33;
import 'package:gewerber_backend_server/src/generated/modules/business/models/update_business_request.dart'
    as _i34;
import 'package:gewerber_backend_server/src/generated/modules/business/models/update_business_settings_request.dart'
    as _i35;
import 'package:gewerber_backend_server/src/generated/modules/documents/models/upload_document_request.dart'
    as _i36;
import 'package:gewerber_backend_server/src/generated/modules/documents/models/document_kind.dart'
    as _i37;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/create_customer_request.dart'
    as _i38;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/update_customer_request.dart'
    as _i39;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/customer_status.dart'
    as _i40;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/create_invoice_request.dart'
    as _i41;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/update_invoice_request.dart'
    as _i42;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/create_invoice_template_request.dart'
    as _i43;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/update_invoice_template_request.dart'
    as _i44;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/record_payment_request.dart'
    as _i45;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/create_recurring_schedule_request.dart'
    as _i46;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/update_recurring_schedule_request.dart'
    as _i47;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/create_project_request.dart'
    as _i48;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/update_project_request.dart'
    as _i49;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/project_status.dart'
    as _i50;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/create_task_request.dart'
    as _i51;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/update_task_request.dart'
    as _i52;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/task_status.dart'
    as _i53;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/start_timer_request.dart'
    as _i54;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/create_time_entry_request.dart'
    as _i55;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/update_time_entry_request.dart'
    as _i56;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/create_time_entries_invoice_request.dart'
    as _i57;
import 'package:gewerber_backend_server/src/generated/modules/user/models/update_user_profile_request.dart'
    as _i58;
import 'package:gewerber_commercial_server/gewerber_commercial_server.dart'
    as _i59;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i60;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i61;
import 'package:gewerber_backend_server/src/generated/future_calls.dart'
    as _i62;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'emailIdp': _i2.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i3.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'entitlement': _i4.EntitlementEndpoint()
        ..initialize(
          server,
          'entitlement',
          null,
        ),
      'accounting': _i5.AccountingEndpoint()
        ..initialize(
          server,
          'accounting',
          null,
        ),
      'adminAudit': _i6.AdminAuditEndpoint()
        ..initialize(
          server,
          'adminAudit',
          null,
        ),
      'adminBusinesses': _i7.AdminBusinessesEndpoint()
        ..initialize(
          server,
          'adminBusinesses',
          null,
        ),
      'adminGuidance': _i8.AdminGuidanceEndpoint()
        ..initialize(
          server,
          'adminGuidance',
          null,
        ),
      'adminInvoices': _i9.AdminInvoicesEndpoint()
        ..initialize(
          server,
          'adminInvoices',
          null,
        ),
      'adminStats': _i10.AdminStatsEndpoint()
        ..initialize(
          server,
          'adminStats',
          null,
        ),
      'adminUsers': _i11.AdminUsersEndpoint()
        ..initialize(
          server,
          'adminUsers',
          null,
        ),
      'business': _i12.BusinessEndpoint()
        ..initialize(
          server,
          'business',
          null,
        ),
      'businessSettings': _i13.BusinessSettingsEndpoint()
        ..initialize(
          server,
          'businessSettings',
          null,
        ),
      'dashboard': _i14.DashboardEndpoint()
        ..initialize(
          server,
          'dashboard',
          null,
        ),
      'document': _i15.DocumentEndpoint()
        ..initialize(
          server,
          'document',
          null,
        ),
      'guidance': _i16.GuidanceEndpoint()
        ..initialize(
          server,
          'guidance',
          null,
        ),
      'customer': _i17.CustomerEndpoint()
        ..initialize(
          server,
          'customer',
          null,
        ),
      'invoice': _i18.InvoiceEndpoint()
        ..initialize(
          server,
          'invoice',
          null,
        ),
      'invoiceTemplate': _i19.InvoiceTemplateEndpoint()
        ..initialize(
          server,
          'invoiceTemplate',
          null,
        ),
      'payment': _i20.PaymentEndpoint()
        ..initialize(
          server,
          'payment',
          null,
        ),
      'recurringSchedule': _i21.RecurringScheduleEndpoint()
        ..initialize(
          server,
          'recurringSchedule',
          null,
        ),
      'reminder': _i22.ReminderEndpoint()
        ..initialize(
          server,
          'reminder',
          null,
        ),
      'project': _i23.ProjectEndpoint()
        ..initialize(
          server,
          'project',
          null,
        ),
      'task': _i24.TaskEndpoint()
        ..initialize(
          server,
          'task',
          null,
        ),
      'timeEntry': _i25.TimeEntryEndpoint()
        ..initialize(
          server,
          'timeEntry',
          null,
        ),
      'userProfile': _i26.UserProfileEndpoint()
        ..initialize(
          server,
          'userProfile',
          null,
        ),
    };
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _i1.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i3.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['entitlement'] = _i1.EndpointConnector(
      name: 'entitlement',
      endpoint: endpoints['entitlement']!,
      methodConnectors: {
        'list': _i1.MethodConnector(
          name: 'list',
          params: {
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['entitlement'] as _i4.EntitlementEndpoint).list(
                    session,
                    businessId: params['businessId'],
                  ),
        ),
      },
    );
    connectors['accounting'] = _i1.EndpointConnector(
      name: 'accounting',
      endpoint: endpoints['accounting']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i27.CreateTransactionRequest>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['accounting'] as _i5.AccountingEndpoint).create(
                    session,
                    params['request'],
                    businessId: params['businessId'],
                  ),
        ),
        'get': _i1.MethodConnector(
          name: 'get',
          params: {
            'transactionId': _i1.ParameterDescription(
              name: 'transactionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['accounting'] as _i5.AccountingEndpoint).get(
                    session,
                    params['transactionId'],
                    businessId: params['businessId'],
                  ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i28.UpdateTransactionRequest>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['accounting'] as _i5.AccountingEndpoint).update(
                    session,
                    params['request'],
                    businessId: params['businessId'],
                  ),
        ),
        'list': _i1.MethodConnector(
          name: 'list',
          params: {
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<_i29.TransactionType?>(),
              nullable: true,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<_i30.TransactionCategory?>(),
              nullable: true,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['accounting'] as _i5.AccountingEndpoint).list(
                    session,
                    type: params['type'],
                    category: params['category'],
                    from: params['from'],
                    to: params['to'],
                    limit: params['limit'],
                    offset: params['offset'],
                    businessId: params['businessId'],
                  ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'transactionId': _i1.ParameterDescription(
              name: 'transactionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['accounting'] as _i5.AccountingEndpoint).delete(
                    session,
                    params['transactionId'],
                    businessId: params['businessId'],
                  ),
        ),
        'profitLoss': _i1.MethodConnector(
          name: 'profitLoss',
          params: {
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['accounting'] as _i5.AccountingEndpoint)
                  .profitLoss(
                    session,
                    params['from'],
                    params['to'],
                    businessId: params['businessId'],
                  ),
        ),
        'exportCsv': _i1.MethodConnector(
          name: 'exportCsv',
          params: {
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<_i29.TransactionType?>(),
              nullable: true,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['accounting'] as _i5.AccountingEndpoint).exportCsv(
                    session,
                    type: params['type'],
                    from: params['from'],
                    to: params['to'],
                    businessId: params['businessId'],
                  ),
        ),
      },
    );
    connectors['adminAudit'] = _i1.EndpointConnector(
      name: 'adminAudit',
      endpoint: endpoints['adminAudit']!,
      methodConnectors: {
        'auditQuery': _i1.MethodConnector(
          name: 'auditQuery',
          params: {
            'actorUserId': _i1.ParameterDescription(
              name: 'actorUserId',
              type: _i1.getType<_i1.UuidValue?>(),
              nullable: true,
            ),
            'action': _i1.ParameterDescription(
              name: 'action',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'since': _i1.ParameterDescription(
              name: 'since',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['adminAudit'] as _i6.AdminAuditEndpoint)
                  .auditQuery(
                    session,
                    actorUserId: params['actorUserId'],
                    action: params['action'],
                    since: params['since'],
                    limit: params['limit'],
                  ),
        ),
      },
    );
    connectors['adminBusinesses'] = _i1.EndpointConnector(
      name: 'adminBusinesses',
      endpoint: endpoints['adminBusinesses']!,
      methodConnectors: {
        'businessesSearch': _i1.MethodConnector(
          name: 'businessesSearch',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'cursor': _i1.ParameterDescription(
              name: 'cursor',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminBusinesses'] as _i7.AdminBusinessesEndpoint)
                      .businessesSearch(
                        session,
                        query: params['query'],
                        limit: params['limit'],
                        cursor: params['cursor'],
                      ),
        ),
        'businessesGet': _i1.MethodConnector(
          name: 'businessesGet',
          params: {
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminBusinesses'] as _i7.AdminBusinessesEndpoint)
                      .businessesGet(
                        session,
                        params['businessId'],
                      ),
        ),
        'membershipsSetRole': _i1.MethodConnector(
          name: 'membershipsSetRole',
          params: {
            'membershipId': _i1.ParameterDescription(
              name: 'membershipId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<_i31.MembershipRole>(),
              nullable: false,
            ),
            'confirm': _i1.ParameterDescription(
              name: 'confirm',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminBusinesses'] as _i7.AdminBusinessesEndpoint)
                      .membershipsSetRole(
                        session,
                        membershipId: params['membershipId'],
                        role: params['role'],
                        confirm: params['confirm'],
                      ),
        ),
      },
    );
    connectors['adminGuidance'] = _i1.EndpointConnector(
      name: 'adminGuidance',
      endpoint: endpoints['adminGuidance']!,
      methodConnectors: {
        'guidanceTipsList': _i1.MethodConnector(
          name: 'guidanceTipsList',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminGuidance'] as _i8.AdminGuidanceEndpoint)
                      .guidanceTipsList(session),
        ),
        'guidanceTipUpsert': _i1.MethodConnector(
          name: 'guidanceTipUpsert',
          params: {
            'topic': _i1.ParameterDescription(
              name: 'topic',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'body': _i1.ParameterDescription(
              name: 'body',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'confirm': _i1.ParameterDescription(
              name: 'confirm',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminGuidance'] as _i8.AdminGuidanceEndpoint)
                      .guidanceTipUpsert(
                        session,
                        topic: params['topic'],
                        title: params['title'],
                        body: params['body'],
                        confirm: params['confirm'],
                      ),
        ),
      },
    );
    connectors['adminInvoices'] = _i1.EndpointConnector(
      name: 'adminInvoices',
      endpoint: endpoints['adminInvoices']!,
      methodConnectors: {
        'invoicesList': _i1.MethodConnector(
          name: 'invoicesList',
          params: {
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i32.InvoiceStatus?>(),
              nullable: true,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'cursor': _i1.ParameterDescription(
              name: 'cursor',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminInvoices'] as _i9.AdminInvoicesEndpoint)
                      .invoicesList(
                        session,
                        businessId: params['businessId'],
                        status: params['status'],
                        from: params['from'],
                        to: params['to'],
                        limit: params['limit'],
                        cursor: params['cursor'],
                      ),
        ),
        'invoicesGet': _i1.MethodConnector(
          name: 'invoicesGet',
          params: {
            'invoiceId': _i1.ParameterDescription(
              name: 'invoiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminInvoices'] as _i9.AdminInvoicesEndpoint)
                      .invoicesGet(
                        session,
                        params['invoiceId'],
                      ),
        ),
        'invoiceCancelAdmin': _i1.MethodConnector(
          name: 'invoiceCancelAdmin',
          params: {
            'invoiceId': _i1.ParameterDescription(
              name: 'invoiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'confirm': _i1.ParameterDescription(
              name: 'confirm',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminInvoices'] as _i9.AdminInvoicesEndpoint)
                      .invoiceCancelAdmin(
                        session,
                        invoiceId: params['invoiceId'],
                        reason: params['reason'],
                        confirm: params['confirm'],
                      ),
        ),
      },
    );
    connectors['adminStats'] = _i1.EndpointConnector(
      name: 'adminStats',
      endpoint: endpoints['adminStats']!,
      methodConnectors: {
        'statsOverview': _i1.MethodConnector(
          name: 'statsOverview',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['adminStats'] as _i10.AdminStatsEndpoint)
                  .statsOverview(session),
        ),
      },
    );
    connectors['adminUsers'] = _i1.EndpointConnector(
      name: 'adminUsers',
      endpoint: endpoints['adminUsers']!,
      methodConnectors: {
        'usersSearch': _i1.MethodConnector(
          name: 'usersSearch',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'cursor': _i1.ParameterDescription(
              name: 'cursor',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['adminUsers'] as _i11.AdminUsersEndpoint)
                  .usersSearch(
                    session,
                    query: params['query'],
                    limit: params['limit'],
                    cursor: params['cursor'],
                  ),
        ),
        'usersGet': _i1.MethodConnector(
          name: 'usersGet',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminUsers'] as _i11.AdminUsersEndpoint).usersGet(
                    session,
                    params['userId'],
                  ),
        ),
        'usersBan': _i1.MethodConnector(
          name: 'usersBan',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'confirm': _i1.ParameterDescription(
              name: 'confirm',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminUsers'] as _i11.AdminUsersEndpoint).usersBan(
                    session,
                    userId: params['userId'],
                    reason: params['reason'],
                    confirm: params['confirm'],
                  ),
        ),
        'usersUnban': _i1.MethodConnector(
          name: 'usersUnban',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'confirm': _i1.ParameterDescription(
              name: 'confirm',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['adminUsers'] as _i11.AdminUsersEndpoint)
                  .usersUnban(
                    session,
                    userId: params['userId'],
                    confirm: params['confirm'],
                  ),
        ),
        'usersVerifyEmail': _i1.MethodConnector(
          name: 'usersVerifyEmail',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['adminUsers'] as _i11.AdminUsersEndpoint)
                  .usersVerifyEmail(
                    session,
                    userId: params['userId'],
                  ),
        ),
      },
    );
    connectors['business'] = _i1.EndpointConnector(
      name: 'business',
      endpoint: endpoints['business']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i33.CreateBusinessRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['business'] as _i12.BusinessEndpoint).create(
                    session,
                    params['request'],
                  ),
        ),
        'get': _i1.MethodConnector(
          name: 'get',
          params: {
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['business'] as _i12.BusinessEndpoint).get(
                session,
                businessId: params['businessId'],
              ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i34.UpdateBusinessRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['business'] as _i12.BusinessEndpoint).update(
                    session,
                    params['request'],
                  ),
        ),
        'listMine': _i1.MethodConnector(
          name: 'listMine',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['business'] as _i12.BusinessEndpoint)
                  .listMine(session),
        ),
      },
    );
    connectors['businessSettings'] = _i1.EndpointConnector(
      name: 'businessSettings',
      endpoint: endpoints['businessSettings']!,
      methodConnectors: {
        'get': _i1.MethodConnector(
          name: 'get',
          params: {
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['businessSettings']
                          as _i13.BusinessSettingsEndpoint)
                      .get(
                        session,
                        businessId: params['businessId'],
                      ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i35.UpdateBusinessSettingsRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['businessSettings']
                          as _i13.BusinessSettingsEndpoint)
                      .update(
                        session,
                        params['request'],
                      ),
        ),
      },
    );
    connectors['dashboard'] = _i1.EndpointConnector(
      name: 'dashboard',
      endpoint: endpoints['dashboard']!,
      methodConnectors: {
        'getSummary': _i1.MethodConnector(
          name: 'getSummary',
          params: {
            'trendMonths': _i1.ParameterDescription(
              name: 'trendMonths',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'recentLimit': _i1.ParameterDescription(
              name: 'recentLimit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'overdueLimit': _i1.ParameterDescription(
              name: 'overdueLimit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'debtorLimit': _i1.ParameterDescription(
              name: 'debtorLimit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'asOf': _i1.ParameterDescription(
              name: 'asOf',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['dashboard'] as _i14.DashboardEndpoint).getSummary(
                    session,
                    trendMonths: params['trendMonths'],
                    recentLimit: params['recentLimit'],
                    overdueLimit: params['overdueLimit'],
                    debtorLimit: params['debtorLimit'],
                    asOf: params['asOf'],
                    businessId: params['businessId'],
                  ),
        ),
      },
    );
    connectors['document'] = _i1.EndpointConnector(
      name: 'document',
      endpoint: endpoints['document']!,
      methodConnectors: {
        'upload': _i1.MethodConnector(
          name: 'upload',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i36.UploadDocumentRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['document'] as _i15.DocumentEndpoint).upload(
                    session,
                    params['request'],
                  ),
        ),
        'list': _i1.MethodConnector(
          name: 'list',
          params: {
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'kind': _i1.ParameterDescription(
              name: 'kind',
              type: _i1.getType<_i37.DocumentKind?>(),
              nullable: true,
            ),
            'relatedEntityType': _i1.ParameterDescription(
              name: 'relatedEntityType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'relatedEntityId': _i1.ParameterDescription(
              name: 'relatedEntityId',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _i15.DocumentEndpoint).list(
                session,
                businessId: params['businessId'],
                kind: params['kind'],
                relatedEntityType: params['relatedEntityType'],
                relatedEntityId: params['relatedEntityId'],
                limit: params['limit'],
                offset: params['offset'],
              ),
        ),
        'get': _i1.MethodConnector(
          name: 'get',
          params: {
            'documentId': _i1.ParameterDescription(
              name: 'documentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _i15.DocumentEndpoint).get(
                session,
                params['documentId'],
              ),
        ),
        'download': _i1.MethodConnector(
          name: 'download',
          params: {
            'documentId': _i1.ParameterDescription(
              name: 'documentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['document'] as _i15.DocumentEndpoint).download(
                    session,
                    params['documentId'],
                  ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'documentId': _i1.ParameterDescription(
              name: 'documentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['document'] as _i15.DocumentEndpoint).delete(
                    session,
                    params['documentId'],
                  ),
        ),
      },
    );
    connectors['guidance'] = _i1.EndpointConnector(
      name: 'guidance',
      endpoint: endpoints['guidance']!,
      methodConnectors: {
        'tips': _i1.MethodConnector(
          name: 'tips',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['guidance'] as _i16.GuidanceEndpoint).tips(
                session,
              ),
        ),
        'checklists': _i1.MethodConnector(
          name: 'checklists',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['guidance'] as _i16.GuidanceEndpoint)
                  .checklists(session),
        ),
        'myProgress': _i1.MethodConnector(
          name: 'myProgress',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['guidance'] as _i16.GuidanceEndpoint)
                  .myProgress(session),
        ),
        'markCompleted': _i1.MethodConnector(
          name: 'markCompleted',
          params: {
            'itemKey': _i1.ParameterDescription(
              name: 'itemKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['guidance'] as _i16.GuidanceEndpoint)
                  .markCompleted(
                    session,
                    params['itemKey'],
                  ),
        ),
        'dismissTip': _i1.MethodConnector(
          name: 'dismissTip',
          params: {
            'topic': _i1.ParameterDescription(
              name: 'topic',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['guidance'] as _i16.GuidanceEndpoint).dismissTip(
                    session,
                    params['topic'],
                  ),
        ),
      },
    );
    connectors['customer'] = _i1.EndpointConnector(
      name: 'customer',
      endpoint: endpoints['customer']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i38.CreateCustomerRequest>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customer'] as _i17.CustomerEndpoint).create(
                    session,
                    params['request'],
                    businessId: params['businessId'],
                  ),
        ),
        'get': _i1.MethodConnector(
          name: 'get',
          params: {
            'customerId': _i1.ParameterDescription(
              name: 'customerId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['customer'] as _i17.CustomerEndpoint).get(
                session,
                params['customerId'],
                businessId: params['businessId'],
              ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i39.UpdateCustomerRequest>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customer'] as _i17.CustomerEndpoint).update(
                    session,
                    params['request'],
                    businessId: params['businessId'],
                  ),
        ),
        'list': _i1.MethodConnector(
          name: 'list',
          params: {
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i40.CustomerStatus?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['customer'] as _i17.CustomerEndpoint).list(
                session,
                status: params['status'],
                limit: params['limit'],
                offset: params['offset'],
                businessId: params['businessId'],
              ),
        ),
        'listPage': _i1.MethodConnector(
          name: 'listPage',
          params: {
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i40.CustomerStatus?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customer'] as _i17.CustomerEndpoint).listPage(
                    session,
                    status: params['status'],
                    limit: params['limit'],
                    offset: params['offset'],
                    businessId: params['businessId'],
                  ),
        ),
        'listCursorPage': _i1.MethodConnector(
          name: 'listCursorPage',
          params: {
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i40.CustomerStatus?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'cursor': _i1.ParameterDescription(
              name: 'cursor',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['customer'] as _i17.CustomerEndpoint)
                  .listCursorPage(
                    session,
                    status: params['status'],
                    limit: params['limit'],
                    cursor: params['cursor'],
                    businessId: params['businessId'],
                  ),
        ),
      },
    );
    connectors['invoice'] = _i1.EndpointConnector(
      name: 'invoice',
      endpoint: endpoints['invoice']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i41.CreateInvoiceRequest>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['invoice'] as _i18.InvoiceEndpoint).create(
                session,
                params['request'],
                businessId: params['businessId'],
              ),
        ),
        'get': _i1.MethodConnector(
          name: 'get',
          params: {
            'invoiceId': _i1.ParameterDescription(
              name: 'invoiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['invoice'] as _i18.InvoiceEndpoint).get(
                session,
                params['invoiceId'],
                businessId: params['businessId'],
              ),
        ),
        'getItems': _i1.MethodConnector(
          name: 'getItems',
          params: {
            'invoiceId': _i1.ParameterDescription(
              name: 'invoiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoice'] as _i18.InvoiceEndpoint).getItems(
                    session,
                    params['invoiceId'],
                    businessId: params['businessId'],
                  ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i42.UpdateInvoiceRequest>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['invoice'] as _i18.InvoiceEndpoint).update(
                session,
                params['request'],
                businessId: params['businessId'],
              ),
        ),
        'list': _i1.MethodConnector(
          name: 'list',
          params: {
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i32.InvoiceStatus?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['invoice'] as _i18.InvoiceEndpoint).list(
                session,
                status: params['status'],
                limit: params['limit'],
                offset: params['offset'],
                businessId: params['businessId'],
              ),
        ),
        'listPage': _i1.MethodConnector(
          name: 'listPage',
          params: {
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i32.InvoiceStatus?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoice'] as _i18.InvoiceEndpoint).listPage(
                    session,
                    status: params['status'],
                    limit: params['limit'],
                    offset: params['offset'],
                    businessId: params['businessId'],
                  ),
        ),
        'listCursorPage': _i1.MethodConnector(
          name: 'listCursorPage',
          params: {
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i32.InvoiceStatus?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'cursor': _i1.ParameterDescription(
              name: 'cursor',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoice'] as _i18.InvoiceEndpoint).listCursorPage(
                    session,
                    status: params['status'],
                    limit: params['limit'],
                    cursor: params['cursor'],
                    businessId: params['businessId'],
                  ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'invoiceId': _i1.ParameterDescription(
              name: 'invoiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['invoice'] as _i18.InvoiceEndpoint).delete(
                session,
                params['invoiceId'],
                businessId: params['businessId'],
              ),
        ),
        'markSent': _i1.MethodConnector(
          name: 'markSent',
          params: {
            'invoiceId': _i1.ParameterDescription(
              name: 'invoiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoice'] as _i18.InvoiceEndpoint).markSent(
                    session,
                    params['invoiceId'],
                    businessId: params['businessId'],
                  ),
        ),
        'cancel': _i1.MethodConnector(
          name: 'cancel',
          params: {
            'invoiceId': _i1.ParameterDescription(
              name: 'invoiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['invoice'] as _i18.InvoiceEndpoint).cancel(
                session,
                params['invoiceId'],
                businessId: params['businessId'],
              ),
        ),
        'exportCsv': _i1.MethodConnector(
          name: 'exportCsv',
          params: {
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i32.InvoiceStatus?>(),
              nullable: true,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoice'] as _i18.InvoiceEndpoint).exportCsv(
                    session,
                    status: params['status'],
                    businessId: params['businessId'],
                  ),
        ),
        'exportJson': _i1.MethodConnector(
          name: 'exportJson',
          params: {
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i32.InvoiceStatus?>(),
              nullable: true,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoice'] as _i18.InvoiceEndpoint).exportJson(
                    session,
                    status: params['status'],
                    businessId: params['businessId'],
                  ),
        ),
        'generatePdf': _i1.MethodConnector(
          name: 'generatePdf',
          params: {
            'invoiceId': _i1.ParameterDescription(
              name: 'invoiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoice'] as _i18.InvoiceEndpoint).generatePdf(
                    session,
                    params['invoiceId'],
                    businessId: params['businessId'],
                  ),
        ),
      },
    );
    connectors['invoiceTemplate'] = _i1.EndpointConnector(
      name: 'invoiceTemplate',
      endpoint: endpoints['invoiceTemplate']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i43.CreateInvoiceTemplateRequest>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoiceTemplate'] as _i19.InvoiceTemplateEndpoint)
                      .create(
                        session,
                        params['request'],
                        businessId: params['businessId'],
                      ),
        ),
        'get': _i1.MethodConnector(
          name: 'get',
          params: {
            'templateId': _i1.ParameterDescription(
              name: 'templateId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoiceTemplate'] as _i19.InvoiceTemplateEndpoint)
                      .get(
                        session,
                        params['templateId'],
                        businessId: params['businessId'],
                      ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i44.UpdateInvoiceTemplateRequest>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoiceTemplate'] as _i19.InvoiceTemplateEndpoint)
                      .update(
                        session,
                        params['request'],
                        businessId: params['businessId'],
                      ),
        ),
        'list': _i1.MethodConnector(
          name: 'list',
          params: {
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoiceTemplate'] as _i19.InvoiceTemplateEndpoint)
                      .list(
                        session,
                        businessId: params['businessId'],
                        limit: params['limit'],
                        offset: params['offset'],
                      ),
        ),
      },
    );
    connectors['payment'] = _i1.EndpointConnector(
      name: 'payment',
      endpoint: endpoints['payment']!,
      methodConnectors: {
        'record': _i1.MethodConnector(
          name: 'record',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i45.RecordPaymentRequest>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['payment'] as _i20.PaymentEndpoint).record(
                session,
                params['request'],
                businessId: params['businessId'],
              ),
        ),
        'status': _i1.MethodConnector(
          name: 'status',
          params: {
            'invoiceId': _i1.ParameterDescription(
              name: 'invoiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['payment'] as _i20.PaymentEndpoint).status(
                session,
                params['invoiceId'],
                businessId: params['businessId'],
              ),
        ),
      },
    );
    connectors['recurringSchedule'] = _i1.EndpointConnector(
      name: 'recurringSchedule',
      endpoint: endpoints['recurringSchedule']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i46.CreateRecurringScheduleRequest>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['recurringSchedule']
                          as _i21.RecurringScheduleEndpoint)
                      .create(
                        session,
                        params['request'],
                        businessId: params['businessId'],
                      ),
        ),
        'get': _i1.MethodConnector(
          name: 'get',
          params: {
            'invoiceId': _i1.ParameterDescription(
              name: 'invoiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['recurringSchedule']
                          as _i21.RecurringScheduleEndpoint)
                      .get(
                        session,
                        params['invoiceId'],
                        businessId: params['businessId'],
                      ),
        ),
        'list': _i1.MethodConnector(
          name: 'list',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['recurringSchedule']
                          as _i21.RecurringScheduleEndpoint)
                      .list(
                        session,
                        limit: params['limit'],
                        offset: params['offset'],
                        businessId: params['businessId'],
                      ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i47.UpdateRecurringScheduleRequest>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['recurringSchedule']
                          as _i21.RecurringScheduleEndpoint)
                      .update(
                        session,
                        params['request'],
                        businessId: params['businessId'],
                      ),
        ),
        'cancel': _i1.MethodConnector(
          name: 'cancel',
          params: {
            'invoiceId': _i1.ParameterDescription(
              name: 'invoiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['recurringSchedule']
                          as _i21.RecurringScheduleEndpoint)
                      .cancel(
                        session,
                        params['invoiceId'],
                        businessId: params['businessId'],
                      ),
        ),
      },
    );
    connectors['reminder'] = _i1.EndpointConnector(
      name: 'reminder',
      endpoint: endpoints['reminder']!,
      methodConnectors: {
        'list': _i1.MethodConnector(
          name: 'list',
          params: {
            'invoiceId': _i1.ParameterDescription(
              name: 'invoiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['reminder'] as _i22.ReminderEndpoint).list(
                session,
                params['invoiceId'],
                businessId: params['businessId'],
              ),
        ),
        'send': _i1.MethodConnector(
          name: 'send',
          params: {
            'invoiceId': _i1.ParameterDescription(
              name: 'invoiceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['reminder'] as _i22.ReminderEndpoint).send(
                session,
                params['invoiceId'],
                businessId: params['businessId'],
              ),
        ),
      },
    );
    connectors['project'] = _i1.EndpointConnector(
      name: 'project',
      endpoint: endpoints['project']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i48.CreateProjectRequest>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['project'] as _i23.ProjectEndpoint).create(
                session,
                params['request'],
                businessId: params['businessId'],
              ),
        ),
        'get': _i1.MethodConnector(
          name: 'get',
          params: {
            'projectId': _i1.ParameterDescription(
              name: 'projectId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['project'] as _i23.ProjectEndpoint).get(
                session,
                params['projectId'],
                businessId: params['businessId'],
              ),
        ),
        'getTasks': _i1.MethodConnector(
          name: 'getTasks',
          params: {
            'projectId': _i1.ParameterDescription(
              name: 'projectId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['project'] as _i23.ProjectEndpoint).getTasks(
                    session,
                    params['projectId'],
                    businessId: params['businessId'],
                  ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i49.UpdateProjectRequest>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['project'] as _i23.ProjectEndpoint).update(
                session,
                params['request'],
                businessId: params['businessId'],
              ),
        ),
        'list': _i1.MethodConnector(
          name: 'list',
          params: {
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i50.ProjectStatus?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['project'] as _i23.ProjectEndpoint).list(
                session,
                status: params['status'],
                limit: params['limit'],
                offset: params['offset'],
                businessId: params['businessId'],
              ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'projectId': _i1.ParameterDescription(
              name: 'projectId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['project'] as _i23.ProjectEndpoint).delete(
                session,
                params['projectId'],
                businessId: params['businessId'],
              ),
        ),
      },
    );
    connectors['task'] = _i1.EndpointConnector(
      name: 'task',
      endpoint: endpoints['task']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i51.CreateTaskRequest>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['task'] as _i24.TaskEndpoint).create(
                session,
                params['request'],
                businessId: params['businessId'],
              ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i52.UpdateTaskRequest>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['task'] as _i24.TaskEndpoint).update(
                session,
                params['request'],
                businessId: params['businessId'],
              ),
        ),
        'list': _i1.MethodConnector(
          name: 'list',
          params: {
            'projectId': _i1.ParameterDescription(
              name: 'projectId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i53.TaskStatus?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['task'] as _i24.TaskEndpoint).list(
                session,
                projectId: params['projectId'],
                status: params['status'],
                limit: params['limit'],
                offset: params['offset'],
                businessId: params['businessId'],
              ),
        ),
      },
    );
    connectors['timeEntry'] = _i1.EndpointConnector(
      name: 'timeEntry',
      endpoint: endpoints['timeEntry']!,
      methodConnectors: {
        'startTimer': _i1.MethodConnector(
          name: 'startTimer',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i54.StartTimerRequest>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['timeEntry'] as _i25.TimeEntryEndpoint).startTimer(
                    session,
                    params['request'],
                    businessId: params['businessId'],
                  ),
        ),
        'stopTimer': _i1.MethodConnector(
          name: 'stopTimer',
          params: {
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['timeEntry'] as _i25.TimeEntryEndpoint).stopTimer(
                    session,
                    businessId: params['businessId'],
                  ),
        ),
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i55.CreateTimeEntryRequest>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['timeEntry'] as _i25.TimeEntryEndpoint).create(
                    session,
                    params['request'],
                    businessId: params['businessId'],
                  ),
        ),
        'get': _i1.MethodConnector(
          name: 'get',
          params: {
            'timeEntryId': _i1.ParameterDescription(
              name: 'timeEntryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['timeEntry'] as _i25.TimeEntryEndpoint).get(
                session,
                params['timeEntryId'],
                businessId: params['businessId'],
              ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i56.UpdateTimeEntryRequest>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['timeEntry'] as _i25.TimeEntryEndpoint).update(
                    session,
                    params['request'],
                    businessId: params['businessId'],
                  ),
        ),
        'list': _i1.MethodConnector(
          name: 'list',
          params: {
            'projectId': _i1.ParameterDescription(
              name: 'projectId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'taskId': _i1.ParameterDescription(
              name: 'taskId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'billable': _i1.ParameterDescription(
              name: 'billable',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['timeEntry'] as _i25.TimeEntryEndpoint).list(
                    session,
                    projectId: params['projectId'],
                    taskId: params['taskId'],
                    from: params['from'],
                    to: params['to'],
                    billable: params['billable'],
                    limit: params['limit'],
                    offset: params['offset'],
                    businessId: params['businessId'],
                  ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {
            'timeEntryId': _i1.ParameterDescription(
              name: 'timeEntryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['timeEntry'] as _i25.TimeEntryEndpoint).delete(
                    session,
                    params['timeEntryId'],
                    businessId: params['businessId'],
                  ),
        ),
        'report': _i1.MethodConnector(
          name: 'report',
          params: {
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'projectId': _i1.ParameterDescription(
              name: 'projectId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['timeEntry'] as _i25.TimeEntryEndpoint).report(
                    session,
                    params['from'],
                    params['to'],
                    projectId: params['projectId'],
                    businessId: params['businessId'],
                  ),
        ),
        'createInvoice': _i1.MethodConnector(
          name: 'createInvoice',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i57.CreateTimeEntriesInvoiceRequest>(),
              nullable: false,
            ),
            'businessId': _i1.ParameterDescription(
              name: 'businessId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['timeEntry'] as _i25.TimeEntryEndpoint)
                  .createInvoice(
                    session,
                    params['request'],
                    businessId: params['businessId'],
                  ),
        ),
      },
    );
    connectors['userProfile'] = _i1.EndpointConnector(
      name: 'userProfile',
      endpoint: endpoints['userProfile']!,
      methodConnectors: {
        'getMyProfile': _i1.MethodConnector(
          name: 'getMyProfile',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['userProfile'] as _i26.UserProfileEndpoint)
                  .getMyProfile(session),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i58.UpdateUserProfileRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfile'] as _i26.UserProfileEndpoint).update(
                    session,
                    params['request'],
                  ),
        ),
        'deleteMyAccount': _i1.MethodConnector(
          name: 'deleteMyAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['userProfile'] as _i26.UserProfileEndpoint)
                  .deleteMyAccount(session),
        ),
        'exportMyData': _i1.MethodConnector(
          name: 'exportMyData',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['userProfile'] as _i26.UserProfileEndpoint)
                  .exportMyData(session),
        ),
      },
    );
    modules['gewerber_commercial'] = _i59.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i60.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_idp'] = _i61.Endpoints()
      ..initializeEndpoints(server);
  }

  @override
  _i1.FutureCallDispatch? get futureCalls {
    return _i62.FutureCalls();
  }
}
