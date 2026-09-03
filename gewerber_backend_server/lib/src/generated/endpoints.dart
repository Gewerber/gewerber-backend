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

import 'package:gewerber_backend_commercial_server/gewerber_backend_commercial_server.dart'
    as _if53ofrw;
import 'package:gewerber_backend_server/src/generated/future_calls.dart'
    as _i89u7n74;
import 'package:gewerber_backend_server/src/generated/modules/accounting/models/create_transaction_request.dart'
    as _id2yvtsq;
import 'package:gewerber_backend_server/src/generated/modules/accounting/models/transaction_category.dart'
    as _ivko09ij;
import 'package:gewerber_backend_server/src/generated/modules/accounting/models/transaction_type.dart'
    as _ii6adw80;
import 'package:gewerber_backend_server/src/generated/modules/accounting/models/update_transaction_request.dart'
    as _i5w1zupa;
import 'package:gewerber_backend_server/src/generated/modules/business/models/create_business_request.dart'
    as _isstucd6;
import 'package:gewerber_backend_server/src/generated/modules/business/models/membership_role.dart'
    as _iwrkm0s7;
import 'package:gewerber_backend_server/src/generated/modules/business/models/update_business_request.dart'
    as _i6z7gqqp;
import 'package:gewerber_backend_server/src/generated/modules/business/models/update_business_settings_request.dart'
    as _ifzr12w9;
import 'package:gewerber_backend_server/src/generated/modules/documents/models/document_kind.dart'
    as _ihaxsvej;
import 'package:gewerber_backend_server/src/generated/modules/documents/models/upload_document_request.dart'
    as _i2nxphic;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/create_customer_request.dart'
    as _i94n0ggq;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/create_invoice_request.dart'
    as _iz85641j;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/create_invoice_template_request.dart'
    as _ixky5b07;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/create_recurring_schedule_request.dart'
    as _iw4avqfy;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/customer_status.dart'
    as _it20r4b4;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/invoice_status.dart'
    as _ipvtulo1;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/record_payment_request.dart'
    as _im2k94rf;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/update_customer_request.dart'
    as _iyf4jy29;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/update_invoice_request.dart'
    as _ij04q7rg;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/update_invoice_template_request.dart'
    as _ial27ozf;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/update_recurring_schedule_request.dart'
    as _it7xg7ig;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/create_project_request.dart'
    as _idq7abw3;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/create_task_request.dart'
    as _is7jk28e;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/create_time_entries_invoice_request.dart'
    as _if6v8yof;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/create_time_entry_request.dart'
    as _imayenfo;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/project_status.dart'
    as _isvak9w2;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/start_timer_request.dart'
    as _igg0g889;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/task_status.dart'
    as _ieegmn8f;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/update_project_request.dart'
    as _ihd38d9q;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/update_task_request.dart'
    as _izsek7q6;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/update_time_entry_request.dart'
    as _in9wv2h5;
import 'package:gewerber_backend_server/src/generated/modules/user/models/update_user_profile_request.dart'
    as _ijhnvzba;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../core/entitlement/endpoints/entitlement_endpoint.dart' as _i09fae2w;
import '../modules/accounting/endpoints/accounting_endpoint.dart' as _iikez0ve;
import '../modules/admin/endpoints/admin_audit_endpoint.dart' as _i457hz4y;
import '../modules/admin/endpoints/admin_businesses_endpoint.dart' as _iorism89;
import '../modules/admin/endpoints/admin_guidance_endpoint.dart' as _ikvysh9d;
import '../modules/admin/endpoints/admin_invoices_endpoint.dart' as _ia8spgsc;
import '../modules/admin/endpoints/admin_stats_endpoint.dart' as _i9q292f5;
import '../modules/admin/endpoints/admin_users_endpoint.dart' as _inisjdnw;
import '../modules/business/endpoints/business_endpoint.dart' as _ib36hea6;
import '../modules/business/endpoints/business_settings_endpoint.dart'
    as _i4lilyfv;
import '../modules/dashboard/endpoints/dashboard_endpoint.dart' as _i84efzii;
import '../modules/documents/endpoints/document_endpoint.dart' as _imbeifl5;
import '../modules/guidance/endpoints/guidance_endpoint.dart' as _imo0z6i8;
import '../modules/invoicing/endpoints/customer_endpoint.dart' as _ie5gsjdr;
import '../modules/invoicing/endpoints/invoice_endpoint.dart' as _ihd954jk;
import '../modules/invoicing/endpoints/invoice_template_endpoint.dart'
    as _iyn5t8t5;
import '../modules/invoicing/endpoints/payment_endpoint.dart' as _iav9fv0x;
import '../modules/invoicing/endpoints/recurring_schedule_endpoint.dart'
    as _i4u78k79;
import '../modules/invoicing/endpoints/reminder_endpoint.dart' as _i7tlupxj;
import '../modules/time_tracking/endpoints/project_endpoint.dart' as _i1zs7nt6;
import '../modules/time_tracking/endpoints/task_endpoint.dart' as _imngl5di;
import '../modules/time_tracking/endpoints/time_entry_endpoint.dart'
    as _if9674pm;
import '../modules/user/endpoints/user_profile_endpoint.dart' as _irfbpg3g;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'entitlement': _i09fae2w.EntitlementEndpoint()
        ..initialize(
          server,
          'entitlement',
          null,
        ),
      'accounting': _iikez0ve.AccountingEndpoint()
        ..initialize(
          server,
          'accounting',
          null,
        ),
      'adminAudit': _i457hz4y.AdminAuditEndpoint()
        ..initialize(
          server,
          'adminAudit',
          null,
        ),
      'adminBusinesses': _iorism89.AdminBusinessesEndpoint()
        ..initialize(
          server,
          'adminBusinesses',
          null,
        ),
      'adminGuidance': _ikvysh9d.AdminGuidanceEndpoint()
        ..initialize(
          server,
          'adminGuidance',
          null,
        ),
      'adminInvoices': _ia8spgsc.AdminInvoicesEndpoint()
        ..initialize(
          server,
          'adminInvoices',
          null,
        ),
      'adminStats': _i9q292f5.AdminStatsEndpoint()
        ..initialize(
          server,
          'adminStats',
          null,
        ),
      'adminUsers': _inisjdnw.AdminUsersEndpoint()
        ..initialize(
          server,
          'adminUsers',
          null,
        ),
      'business': _ib36hea6.BusinessEndpoint()
        ..initialize(
          server,
          'business',
          null,
        ),
      'businessSettings': _i4lilyfv.BusinessSettingsEndpoint()
        ..initialize(
          server,
          'businessSettings',
          null,
        ),
      'dashboard': _i84efzii.DashboardEndpoint()
        ..initialize(
          server,
          'dashboard',
          null,
        ),
      'document': _imbeifl5.DocumentEndpoint()
        ..initialize(
          server,
          'document',
          null,
        ),
      'guidance': _imo0z6i8.GuidanceEndpoint()
        ..initialize(
          server,
          'guidance',
          null,
        ),
      'customer': _ie5gsjdr.CustomerEndpoint()
        ..initialize(
          server,
          'customer',
          null,
        ),
      'invoice': _ihd954jk.InvoiceEndpoint()
        ..initialize(
          server,
          'invoice',
          null,
        ),
      'invoiceTemplate': _iyn5t8t5.InvoiceTemplateEndpoint()
        ..initialize(
          server,
          'invoiceTemplate',
          null,
        ),
      'payment': _iav9fv0x.PaymentEndpoint()
        ..initialize(
          server,
          'payment',
          null,
        ),
      'recurringSchedule': _i4u78k79.RecurringScheduleEndpoint()
        ..initialize(
          server,
          'recurringSchedule',
          null,
        ),
      'reminder': _i7tlupxj.ReminderEndpoint()
        ..initialize(
          server,
          'reminder',
          null,
        ),
      'project': _i1zs7nt6.ProjectEndpoint()
        ..initialize(
          server,
          'project',
          null,
        ),
      'task': _imngl5di.TaskEndpoint()
        ..initialize(
          server,
          'task',
          null,
        ),
      'timeEntry': _if9674pm.TimeEntryEndpoint()
        ..initialize(
          server,
          'timeEntry',
          null,
        ),
      'userProfile': _irfbpg3g.UserProfileEndpoint()
        ..initialize(
          server,
          'userProfile',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['entitlement'] = _is.EndpointConnector(
      name: 'entitlement',
      endpoint: endpoints['entitlement']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['entitlement'] as _i09fae2w.EntitlementEndpoint)
                      .list(
                        session,
                        businessId: params['businessId'],
                      ),
        ),
      },
    );
    connectors['accounting'] = _is.EndpointConnector(
      name: 'accounting',
      endpoint: endpoints['accounting']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_id2yvtsq.CreateTransactionRequest>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['accounting'] as _iikez0ve.AccountingEndpoint)
                      .create(
                        session,
                        params['request'],
                        businessId: params['businessId'],
                      ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'transactionId': _is.ParameterDescription(
              name: 'transactionId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['accounting'] as _iikez0ve.AccountingEndpoint).get(
                    session,
                    params['transactionId'],
                    businessId: params['businessId'],
                  ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_i5w1zupa.UpdateTransactionRequest>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['accounting'] as _iikez0ve.AccountingEndpoint)
                      .update(
                        session,
                        params['request'],
                        businessId: params['businessId'],
                      ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'type': _is.ParameterDescription(
              name: 'type',
              type: _is.getType<_ii6adw80.TransactionType?>(),
              nullable: true,
            ),
            'category': _is.ParameterDescription(
              name: 'category',
              type: _is.getType<_ivko09ij.TransactionCategory?>(),
              nullable: true,
            ),
            'from': _is.ParameterDescription(
              name: 'from',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'to': _is.ParameterDescription(
              name: 'to',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['accounting'] as _iikez0ve.AccountingEndpoint)
                      .list(
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
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'transactionId': _is.ParameterDescription(
              name: 'transactionId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['accounting'] as _iikez0ve.AccountingEndpoint)
                      .delete(
                        session,
                        params['transactionId'],
                        businessId: params['businessId'],
                      ),
        ),
        'profitLoss': _is.MethodConnector(
          name: 'profitLoss',
          params: {
            'from': _is.ParameterDescription(
              name: 'from',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'to': _is.ParameterDescription(
              name: 'to',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['accounting'] as _iikez0ve.AccountingEndpoint)
                      .profitLoss(
                        session,
                        params['from'],
                        params['to'],
                        businessId: params['businessId'],
                      ),
        ),
        'exportCsv': _is.MethodConnector(
          name: 'exportCsv',
          params: {
            'type': _is.ParameterDescription(
              name: 'type',
              type: _is.getType<_ii6adw80.TransactionType?>(),
              nullable: true,
            ),
            'from': _is.ParameterDescription(
              name: 'from',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'to': _is.ParameterDescription(
              name: 'to',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['accounting'] as _iikez0ve.AccountingEndpoint)
                      .exportCsv(
                        session,
                        type: params['type'],
                        from: params['from'],
                        to: params['to'],
                        businessId: params['businessId'],
                      ),
        ),
      },
    );
    connectors['adminAudit'] = _is.EndpointConnector(
      name: 'adminAudit',
      endpoint: endpoints['adminAudit']!,
      methodConnectors: {
        'auditQuery': _is.MethodConnector(
          name: 'auditQuery',
          params: {
            'actorUserId': _is.ParameterDescription(
              name: 'actorUserId',
              type: _is.getType<_is.UuidValue?>(),
              nullable: true,
            ),
            'action': _is.ParameterDescription(
              name: 'action',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'since': _is.ParameterDescription(
              name: 'since',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminAudit'] as _i457hz4y.AdminAuditEndpoint)
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
    connectors['adminBusinesses'] = _is.EndpointConnector(
      name: 'adminBusinesses',
      endpoint: endpoints['adminBusinesses']!,
      methodConnectors: {
        'businessesSearch': _is.MethodConnector(
          name: 'businessesSearch',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'cursor': _is.ParameterDescription(
              name: 'cursor',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminBusinesses']
                          as _iorism89.AdminBusinessesEndpoint)
                      .businessesSearch(
                        session,
                        query: params['query'],
                        limit: params['limit'],
                        cursor: params['cursor'],
                      ),
        ),
        'businessesGet': _is.MethodConnector(
          name: 'businessesGet',
          params: {
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminBusinesses']
                          as _iorism89.AdminBusinessesEndpoint)
                      .businessesGet(
                        session,
                        params['businessId'],
                      ),
        ),
        'membershipsSetRole': _is.MethodConnector(
          name: 'membershipsSetRole',
          params: {
            'membershipId': _is.ParameterDescription(
              name: 'membershipId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'role': _is.ParameterDescription(
              name: 'role',
              type: _is.getType<_iwrkm0s7.MembershipRole>(),
              nullable: false,
            ),
            'confirm': _is.ParameterDescription(
              name: 'confirm',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminBusinesses']
                          as _iorism89.AdminBusinessesEndpoint)
                      .membershipsSetRole(
                        session,
                        membershipId: params['membershipId'],
                        role: params['role'],
                        confirm: params['confirm'],
                      ),
        ),
      },
    );
    connectors['adminGuidance'] = _is.EndpointConnector(
      name: 'adminGuidance',
      endpoint: endpoints['adminGuidance']!,
      methodConnectors: {
        'guidanceTipsList': _is.MethodConnector(
          name: 'guidanceTipsList',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminGuidance']
                          as _ikvysh9d.AdminGuidanceEndpoint)
                      .guidanceTipsList(session),
        ),
        'guidanceTipUpsert': _is.MethodConnector(
          name: 'guidanceTipUpsert',
          params: {
            'topic': _is.ParameterDescription(
              name: 'topic',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'body': _is.ParameterDescription(
              name: 'body',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'confirm': _is.ParameterDescription(
              name: 'confirm',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminGuidance']
                          as _ikvysh9d.AdminGuidanceEndpoint)
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
    connectors['adminInvoices'] = _is.EndpointConnector(
      name: 'adminInvoices',
      endpoint: endpoints['adminInvoices']!,
      methodConnectors: {
        'invoicesList': _is.MethodConnector(
          name: 'invoicesList',
          params: {
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_ipvtulo1.InvoiceStatus?>(),
              nullable: true,
            ),
            'from': _is.ParameterDescription(
              name: 'from',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'to': _is.ParameterDescription(
              name: 'to',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'cursor': _is.ParameterDescription(
              name: 'cursor',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminInvoices']
                          as _ia8spgsc.AdminInvoicesEndpoint)
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
        'invoicesGet': _is.MethodConnector(
          name: 'invoicesGet',
          params: {
            'invoiceId': _is.ParameterDescription(
              name: 'invoiceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminInvoices']
                          as _ia8spgsc.AdminInvoicesEndpoint)
                      .invoicesGet(
                        session,
                        params['invoiceId'],
                      ),
        ),
        'invoiceCancelAdmin': _is.MethodConnector(
          name: 'invoiceCancelAdmin',
          params: {
            'invoiceId': _is.ParameterDescription(
              name: 'invoiceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'confirm': _is.ParameterDescription(
              name: 'confirm',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminInvoices']
                          as _ia8spgsc.AdminInvoicesEndpoint)
                      .invoiceCancelAdmin(
                        session,
                        invoiceId: params['invoiceId'],
                        reason: params['reason'],
                        confirm: params['confirm'],
                      ),
        ),
      },
    );
    connectors['adminStats'] = _is.EndpointConnector(
      name: 'adminStats',
      endpoint: endpoints['adminStats']!,
      methodConnectors: {
        'statsOverview': _is.MethodConnector(
          name: 'statsOverview',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminStats'] as _i9q292f5.AdminStatsEndpoint)
                      .statsOverview(session),
        ),
      },
    );
    connectors['adminUsers'] = _is.EndpointConnector(
      name: 'adminUsers',
      endpoint: endpoints['adminUsers']!,
      methodConnectors: {
        'usersSearch': _is.MethodConnector(
          name: 'usersSearch',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'cursor': _is.ParameterDescription(
              name: 'cursor',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminUsers'] as _inisjdnw.AdminUsersEndpoint)
                      .usersSearch(
                        session,
                        query: params['query'],
                        limit: params['limit'],
                        cursor: params['cursor'],
                      ),
        ),
        'usersGet': _is.MethodConnector(
          name: 'usersGet',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminUsers'] as _inisjdnw.AdminUsersEndpoint)
                      .usersGet(
                        session,
                        params['userId'],
                      ),
        ),
        'usersBan': _is.MethodConnector(
          name: 'usersBan',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'confirm': _is.ParameterDescription(
              name: 'confirm',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminUsers'] as _inisjdnw.AdminUsersEndpoint)
                      .usersBan(
                        session,
                        userId: params['userId'],
                        reason: params['reason'],
                        confirm: params['confirm'],
                      ),
        ),
        'usersUnban': _is.MethodConnector(
          name: 'usersUnban',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'confirm': _is.ParameterDescription(
              name: 'confirm',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminUsers'] as _inisjdnw.AdminUsersEndpoint)
                      .usersUnban(
                        session,
                        userId: params['userId'],
                        confirm: params['confirm'],
                      ),
        ),
        'usersVerifyEmail': _is.MethodConnector(
          name: 'usersVerifyEmail',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['adminUsers'] as _inisjdnw.AdminUsersEndpoint)
                      .usersVerifyEmail(
                        session,
                        userId: params['userId'],
                      ),
        ),
      },
    );
    connectors['business'] = _is.EndpointConnector(
      name: 'business',
      endpoint: endpoints['business']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_isstucd6.CreateBusinessRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['business'] as _ib36hea6.BusinessEndpoint).create(
                    session,
                    params['request'],
                  ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['business'] as _ib36hea6.BusinessEndpoint).get(
                    session,
                    businessId: params['businessId'],
                  ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_i6z7gqqp.UpdateBusinessRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['business'] as _ib36hea6.BusinessEndpoint).update(
                    session,
                    params['request'],
                  ),
        ),
        'listMine': _is.MethodConnector(
          name: 'listMine',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['business'] as _ib36hea6.BusinessEndpoint)
                  .listMine(session),
        ),
      },
    );
    connectors['businessSettings'] = _is.EndpointConnector(
      name: 'businessSettings',
      endpoint: endpoints['businessSettings']!,
      methodConnectors: {
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['businessSettings']
                          as _i4lilyfv.BusinessSettingsEndpoint)
                      .get(
                        session,
                        businessId: params['businessId'],
                      ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ifzr12w9.UpdateBusinessSettingsRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['businessSettings']
                          as _i4lilyfv.BusinessSettingsEndpoint)
                      .update(
                        session,
                        params['request'],
                      ),
        ),
      },
    );
    connectors['dashboard'] = _is.EndpointConnector(
      name: 'dashboard',
      endpoint: endpoints['dashboard']!,
      methodConnectors: {
        'getSummary': _is.MethodConnector(
          name: 'getSummary',
          params: {
            'trendMonths': _is.ParameterDescription(
              name: 'trendMonths',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'recentLimit': _is.ParameterDescription(
              name: 'recentLimit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'overdueLimit': _is.ParameterDescription(
              name: 'overdueLimit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'debtorLimit': _is.ParameterDescription(
              name: 'debtorLimit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'asOf': _is.ParameterDescription(
              name: 'asOf',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i84efzii.DashboardEndpoint)
                  .getSummary(
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
    connectors['document'] = _is.EndpointConnector(
      name: 'document',
      endpoint: endpoints['document']!,
      methodConnectors: {
        'upload': _is.MethodConnector(
          name: 'upload',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_i2nxphic.UploadDocumentRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['document'] as _imbeifl5.DocumentEndpoint).upload(
                    session,
                    params['request'],
                  ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'kind': _is.ParameterDescription(
              name: 'kind',
              type: _is.getType<_ihaxsvej.DocumentKind?>(),
              nullable: true,
            ),
            'relatedEntityType': _is.ParameterDescription(
              name: 'relatedEntityType',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'relatedEntityId': _is.ParameterDescription(
              name: 'relatedEntityId',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['document'] as _imbeifl5.DocumentEndpoint).list(
                    session,
                    businessId: params['businessId'],
                    kind: params['kind'],
                    relatedEntityType: params['relatedEntityType'],
                    relatedEntityId: params['relatedEntityId'],
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'documentId': _is.ParameterDescription(
              name: 'documentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['document'] as _imbeifl5.DocumentEndpoint).get(
                    session,
                    params['documentId'],
                  ),
        ),
        'download': _is.MethodConnector(
          name: 'download',
          params: {
            'documentId': _is.ParameterDescription(
              name: 'documentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _imbeifl5.DocumentEndpoint)
                  .download(
                    session,
                    params['documentId'],
                  ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'documentId': _is.ParameterDescription(
              name: 'documentId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['document'] as _imbeifl5.DocumentEndpoint).delete(
                    session,
                    params['documentId'],
                  ),
        ),
      },
    );
    connectors['guidance'] = _is.EndpointConnector(
      name: 'guidance',
      endpoint: endpoints['guidance']!,
      methodConnectors: {
        'tips': _is.MethodConnector(
          name: 'tips',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['guidance'] as _imo0z6i8.GuidanceEndpoint)
                  .tips(session),
        ),
        'checklists': _is.MethodConnector(
          name: 'checklists',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['guidance'] as _imo0z6i8.GuidanceEndpoint)
                  .checklists(session),
        ),
        'myProgress': _is.MethodConnector(
          name: 'myProgress',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['guidance'] as _imo0z6i8.GuidanceEndpoint)
                  .myProgress(session),
        ),
        'markCompleted': _is.MethodConnector(
          name: 'markCompleted',
          params: {
            'itemKey': _is.ParameterDescription(
              name: 'itemKey',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['guidance'] as _imo0z6i8.GuidanceEndpoint)
                  .markCompleted(
                    session,
                    params['itemKey'],
                  ),
        ),
        'dismissTip': _is.MethodConnector(
          name: 'dismissTip',
          params: {
            'topic': _is.ParameterDescription(
              name: 'topic',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['guidance'] as _imo0z6i8.GuidanceEndpoint)
                  .dismissTip(
                    session,
                    params['topic'],
                  ),
        ),
      },
    );
    connectors['customer'] = _is.EndpointConnector(
      name: 'customer',
      endpoint: endpoints['customer']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_i94n0ggq.CreateCustomerRequest>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customer'] as _ie5gsjdr.CustomerEndpoint).create(
                    session,
                    params['request'],
                    businessId: params['businessId'],
                  ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'customerId': _is.ParameterDescription(
              name: 'customerId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customer'] as _ie5gsjdr.CustomerEndpoint).get(
                    session,
                    params['customerId'],
                    businessId: params['businessId'],
                  ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_iyf4jy29.UpdateCustomerRequest>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customer'] as _ie5gsjdr.CustomerEndpoint).update(
                    session,
                    params['request'],
                    businessId: params['businessId'],
                  ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_it20r4b4.CustomerStatus?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['customer'] as _ie5gsjdr.CustomerEndpoint).list(
                    session,
                    status: params['status'],
                    limit: params['limit'],
                    offset: params['offset'],
                    businessId: params['businessId'],
                  ),
        ),
        'listPage': _is.MethodConnector(
          name: 'listPage',
          params: {
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_it20r4b4.CustomerStatus?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['customer'] as _ie5gsjdr.CustomerEndpoint)
                  .listPage(
                    session,
                    status: params['status'],
                    limit: params['limit'],
                    offset: params['offset'],
                    businessId: params['businessId'],
                  ),
        ),
        'listCursorPage': _is.MethodConnector(
          name: 'listCursorPage',
          params: {
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_it20r4b4.CustomerStatus?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'cursor': _is.ParameterDescription(
              name: 'cursor',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['customer'] as _ie5gsjdr.CustomerEndpoint)
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
    connectors['invoice'] = _is.EndpointConnector(
      name: 'invoice',
      endpoint: endpoints['invoice']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_iz85641j.CreateInvoiceRequest>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoice'] as _ihd954jk.InvoiceEndpoint).create(
                    session,
                    params['request'],
                    businessId: params['businessId'],
                  ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'invoiceId': _is.ParameterDescription(
              name: 'invoiceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoice'] as _ihd954jk.InvoiceEndpoint).get(
                    session,
                    params['invoiceId'],
                    businessId: params['businessId'],
                  ),
        ),
        'getItems': _is.MethodConnector(
          name: 'getItems',
          params: {
            'invoiceId': _is.ParameterDescription(
              name: 'invoiceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoice'] as _ihd954jk.InvoiceEndpoint).getItems(
                    session,
                    params['invoiceId'],
                    businessId: params['businessId'],
                  ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ij04q7rg.UpdateInvoiceRequest>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoice'] as _ihd954jk.InvoiceEndpoint).update(
                    session,
                    params['request'],
                    businessId: params['businessId'],
                  ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_ipvtulo1.InvoiceStatus?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoice'] as _ihd954jk.InvoiceEndpoint).list(
                    session,
                    status: params['status'],
                    limit: params['limit'],
                    offset: params['offset'],
                    businessId: params['businessId'],
                  ),
        ),
        'listPage': _is.MethodConnector(
          name: 'listPage',
          params: {
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_ipvtulo1.InvoiceStatus?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoice'] as _ihd954jk.InvoiceEndpoint).listPage(
                    session,
                    status: params['status'],
                    limit: params['limit'],
                    offset: params['offset'],
                    businessId: params['businessId'],
                  ),
        ),
        'listCursorPage': _is.MethodConnector(
          name: 'listCursorPage',
          params: {
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_ipvtulo1.InvoiceStatus?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'cursor': _is.ParameterDescription(
              name: 'cursor',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['invoice'] as _ihd954jk.InvoiceEndpoint)
                  .listCursorPage(
                    session,
                    status: params['status'],
                    limit: params['limit'],
                    cursor: params['cursor'],
                    businessId: params['businessId'],
                  ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'invoiceId': _is.ParameterDescription(
              name: 'invoiceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoice'] as _ihd954jk.InvoiceEndpoint).delete(
                    session,
                    params['invoiceId'],
                    businessId: params['businessId'],
                  ),
        ),
        'markSent': _is.MethodConnector(
          name: 'markSent',
          params: {
            'invoiceId': _is.ParameterDescription(
              name: 'invoiceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoice'] as _ihd954jk.InvoiceEndpoint).markSent(
                    session,
                    params['invoiceId'],
                    businessId: params['businessId'],
                  ),
        ),
        'cancel': _is.MethodConnector(
          name: 'cancel',
          params: {
            'invoiceId': _is.ParameterDescription(
              name: 'invoiceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoice'] as _ihd954jk.InvoiceEndpoint).cancel(
                    session,
                    params['invoiceId'],
                    businessId: params['businessId'],
                  ),
        ),
        'exportCsv': _is.MethodConnector(
          name: 'exportCsv',
          params: {
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_ipvtulo1.InvoiceStatus?>(),
              nullable: true,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoice'] as _ihd954jk.InvoiceEndpoint).exportCsv(
                    session,
                    status: params['status'],
                    businessId: params['businessId'],
                  ),
        ),
        'exportJson': _is.MethodConnector(
          name: 'exportJson',
          params: {
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_ipvtulo1.InvoiceStatus?>(),
              nullable: true,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['invoice'] as _ihd954jk.InvoiceEndpoint)
                  .exportJson(
                    session,
                    status: params['status'],
                    businessId: params['businessId'],
                  ),
        ),
        'generatePdf': _is.MethodConnector(
          name: 'generatePdf',
          params: {
            'invoiceId': _is.ParameterDescription(
              name: 'invoiceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['invoice'] as _ihd954jk.InvoiceEndpoint)
                  .generatePdf(
                    session,
                    params['invoiceId'],
                    businessId: params['businessId'],
                  ),
        ),
      },
    );
    connectors['invoiceTemplate'] = _is.EndpointConnector(
      name: 'invoiceTemplate',
      endpoint: endpoints['invoiceTemplate']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ixky5b07.CreateInvoiceTemplateRequest>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoiceTemplate']
                          as _iyn5t8t5.InvoiceTemplateEndpoint)
                      .create(
                        session,
                        params['request'],
                        businessId: params['businessId'],
                      ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'templateId': _is.ParameterDescription(
              name: 'templateId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoiceTemplate']
                          as _iyn5t8t5.InvoiceTemplateEndpoint)
                      .get(
                        session,
                        params['templateId'],
                        businessId: params['businessId'],
                      ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ial27ozf.UpdateInvoiceTemplateRequest>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoiceTemplate']
                          as _iyn5t8t5.InvoiceTemplateEndpoint)
                      .update(
                        session,
                        params['request'],
                        businessId: params['businessId'],
                      ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoiceTemplate']
                          as _iyn5t8t5.InvoiceTemplateEndpoint)
                      .list(
                        session,
                        businessId: params['businessId'],
                        limit: params['limit'],
                        offset: params['offset'],
                      ),
        ),
      },
    );
    connectors['payment'] = _is.EndpointConnector(
      name: 'payment',
      endpoint: endpoints['payment']!,
      methodConnectors: {
        'record': _is.MethodConnector(
          name: 'record',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_im2k94rf.RecordPaymentRequest>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['payment'] as _iav9fv0x.PaymentEndpoint).record(
                    session,
                    params['request'],
                    businessId: params['businessId'],
                  ),
        ),
        'status': _is.MethodConnector(
          name: 'status',
          params: {
            'invoiceId': _is.ParameterDescription(
              name: 'invoiceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['payment'] as _iav9fv0x.PaymentEndpoint).status(
                    session,
                    params['invoiceId'],
                    businessId: params['businessId'],
                  ),
        ),
      },
    );
    connectors['recurringSchedule'] = _is.EndpointConnector(
      name: 'recurringSchedule',
      endpoint: endpoints['recurringSchedule']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_iw4avqfy.CreateRecurringScheduleRequest>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['recurringSchedule']
                          as _i4u78k79.RecurringScheduleEndpoint)
                      .create(
                        session,
                        params['request'],
                        businessId: params['businessId'],
                      ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'invoiceId': _is.ParameterDescription(
              name: 'invoiceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['recurringSchedule']
                          as _i4u78k79.RecurringScheduleEndpoint)
                      .get(
                        session,
                        params['invoiceId'],
                        businessId: params['businessId'],
                      ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['recurringSchedule']
                          as _i4u78k79.RecurringScheduleEndpoint)
                      .list(
                        session,
                        limit: params['limit'],
                        offset: params['offset'],
                        businessId: params['businessId'],
                      ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_it7xg7ig.UpdateRecurringScheduleRequest>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['recurringSchedule']
                          as _i4u78k79.RecurringScheduleEndpoint)
                      .update(
                        session,
                        params['request'],
                        businessId: params['businessId'],
                      ),
        ),
        'cancel': _is.MethodConnector(
          name: 'cancel',
          params: {
            'invoiceId': _is.ParameterDescription(
              name: 'invoiceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['recurringSchedule']
                          as _i4u78k79.RecurringScheduleEndpoint)
                      .cancel(
                        session,
                        params['invoiceId'],
                        businessId: params['businessId'],
                      ),
        ),
      },
    );
    connectors['reminder'] = _is.EndpointConnector(
      name: 'reminder',
      endpoint: endpoints['reminder']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'invoiceId': _is.ParameterDescription(
              name: 'invoiceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reminder'] as _i7tlupxj.ReminderEndpoint).list(
                    session,
                    params['invoiceId'],
                    businessId: params['businessId'],
                  ),
        ),
        'send': _is.MethodConnector(
          name: 'send',
          params: {
            'invoiceId': _is.ParameterDescription(
              name: 'invoiceId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['reminder'] as _i7tlupxj.ReminderEndpoint).send(
                    session,
                    params['invoiceId'],
                    businessId: params['businessId'],
                  ),
        ),
      },
    );
    connectors['project'] = _is.EndpointConnector(
      name: 'project',
      endpoint: endpoints['project']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_idq7abw3.CreateProjectRequest>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['project'] as _i1zs7nt6.ProjectEndpoint).create(
                    session,
                    params['request'],
                    businessId: params['businessId'],
                  ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['project'] as _i1zs7nt6.ProjectEndpoint).get(
                    session,
                    params['projectId'],
                    businessId: params['businessId'],
                  ),
        ),
        'getTasks': _is.MethodConnector(
          name: 'getTasks',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['project'] as _i1zs7nt6.ProjectEndpoint).getTasks(
                    session,
                    params['projectId'],
                    businessId: params['businessId'],
                  ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ihd38d9q.UpdateProjectRequest>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['project'] as _i1zs7nt6.ProjectEndpoint).update(
                    session,
                    params['request'],
                    businessId: params['businessId'],
                  ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_isvak9w2.ProjectStatus?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['project'] as _i1zs7nt6.ProjectEndpoint).list(
                    session,
                    status: params['status'],
                    limit: params['limit'],
                    offset: params['offset'],
                    businessId: params['businessId'],
                  ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['project'] as _i1zs7nt6.ProjectEndpoint).delete(
                    session,
                    params['projectId'],
                    businessId: params['businessId'],
                  ),
        ),
      },
    );
    connectors['task'] = _is.EndpointConnector(
      name: 'task',
      endpoint: endpoints['task']!,
      methodConnectors: {
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_is7jk28e.CreateTaskRequest>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['task'] as _imngl5di.TaskEndpoint).create(
                session,
                params['request'],
                businessId: params['businessId'],
              ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_izsek7q6.UpdateTaskRequest>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['task'] as _imngl5di.TaskEndpoint).update(
                session,
                params['request'],
                businessId: params['businessId'],
              ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_ieegmn8f.TaskStatus?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['task'] as _imngl5di.TaskEndpoint).list(
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
    connectors['timeEntry'] = _is.EndpointConnector(
      name: 'timeEntry',
      endpoint: endpoints['timeEntry']!,
      methodConnectors: {
        'startTimer': _is.MethodConnector(
          name: 'startTimer',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_igg0g889.StartTimerRequest>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['timeEntry'] as _if9674pm.TimeEntryEndpoint)
                  .startTimer(
                    session,
                    params['request'],
                    businessId: params['businessId'],
                  ),
        ),
        'stopTimer': _is.MethodConnector(
          name: 'stopTimer',
          params: {
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['timeEntry'] as _if9674pm.TimeEntryEndpoint)
                  .stopTimer(
                    session,
                    businessId: params['businessId'],
                  ),
        ),
        'create': _is.MethodConnector(
          name: 'create',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_imayenfo.CreateTimeEntryRequest>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['timeEntry'] as _if9674pm.TimeEntryEndpoint)
                  .create(
                    session,
                    params['request'],
                    businessId: params['businessId'],
                  ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'timeEntryId': _is.ParameterDescription(
              name: 'timeEntryId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['timeEntry'] as _if9674pm.TimeEntryEndpoint).get(
                    session,
                    params['timeEntryId'],
                    businessId: params['businessId'],
                  ),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_in9wv2h5.UpdateTimeEntryRequest>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['timeEntry'] as _if9674pm.TimeEntryEndpoint)
                  .update(
                    session,
                    params['request'],
                    businessId: params['businessId'],
                  ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'taskId': _is.ParameterDescription(
              name: 'taskId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'from': _is.ParameterDescription(
              name: 'from',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'to': _is.ParameterDescription(
              name: 'to',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'billable': _is.ParameterDescription(
              name: 'billable',
              type: _is.getType<bool?>(),
              nullable: true,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'offset': _is.ParameterDescription(
              name: 'offset',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['timeEntry'] as _if9674pm.TimeEntryEndpoint).list(
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
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'timeEntryId': _is.ParameterDescription(
              name: 'timeEntryId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['timeEntry'] as _if9674pm.TimeEntryEndpoint)
                  .delete(
                    session,
                    params['timeEntryId'],
                    businessId: params['businessId'],
                  ),
        ),
        'report': _is.MethodConnector(
          name: 'report',
          params: {
            'from': _is.ParameterDescription(
              name: 'from',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'to': _is.ParameterDescription(
              name: 'to',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'projectId': _is.ParameterDescription(
              name: 'projectId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['timeEntry'] as _if9674pm.TimeEntryEndpoint)
                  .report(
                    session,
                    params['from'],
                    params['to'],
                    projectId: params['projectId'],
                    businessId: params['businessId'],
                  ),
        ),
        'createInvoice': _is.MethodConnector(
          name: 'createInvoice',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_if6v8yof.CreateTimeEntriesInvoiceRequest>(),
              nullable: false,
            ),
            'businessId': _is.ParameterDescription(
              name: 'businessId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['timeEntry'] as _if9674pm.TimeEntryEndpoint)
                  .createInvoice(
                    session,
                    params['request'],
                    businessId: params['businessId'],
                  ),
        ),
      },
    );
    connectors['userProfile'] = _is.EndpointConnector(
      name: 'userProfile',
      endpoint: endpoints['userProfile']!,
      methodConnectors: {
        'getMyProfile': _is.MethodConnector(
          name: 'getMyProfile',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfile'] as _irfbpg3g.UserProfileEndpoint)
                      .getMyProfile(session),
        ),
        'me': _is.MethodConnector(
          name: 'me',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfile'] as _irfbpg3g.UserProfileEndpoint)
                      .me(session),
        ),
        'update': _is.MethodConnector(
          name: 'update',
          params: {
            'request': _is.ParameterDescription(
              name: 'request',
              type: _is.getType<_ijhnvzba.UpdateUserProfileRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfile'] as _irfbpg3g.UserProfileEndpoint)
                      .update(
                        session,
                        params['request'],
                      ),
        ),
        'deleteMyAccount': _is.MethodConnector(
          name: 'deleteMyAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfile'] as _irfbpg3g.UserProfileEndpoint)
                      .deleteMyAccount(session),
        ),
        'exportMyData': _is.MethodConnector(
          name: 'exportMyData',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfile'] as _irfbpg3g.UserProfileEndpoint)
                      .exportMyData(session),
        ),
      },
    );
    modules['gewerber_backend_commercial'] = _if53ofrw.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
  }

  @override
  _is.FutureCallDispatch? get futureCalls {
    return _i89u7n74.FutureCalls();
  }
}
