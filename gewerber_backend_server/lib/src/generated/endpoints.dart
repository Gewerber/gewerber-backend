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
import '../modules/business/endpoints/business_endpoint.dart' as _i5;
import '../modules/business/endpoints/business_settings_endpoint.dart' as _i6;
import '../modules/documents/endpoints/document_endpoint.dart' as _i7;
import '../modules/invoicing/endpoints/customer_endpoint.dart' as _i8;
import '../modules/invoicing/endpoints/invoice_endpoint.dart' as _i9;
import '../modules/invoicing/endpoints/invoice_template_endpoint.dart' as _i10;
import '../modules/invoicing/endpoints/payment_endpoint.dart' as _i11;
import '../modules/user/endpoints/user_profile_endpoint.dart' as _i12;
import 'package:gewerber_backend_server/src/generated/modules/business/models/create_business_request.dart'
    as _i13;
import 'package:gewerber_backend_server/src/generated/modules/business/models/update_business_request.dart'
    as _i14;
import 'package:gewerber_backend_server/src/generated/modules/business/models/update_business_settings_request.dart'
    as _i15;
import 'package:gewerber_backend_server/src/generated/modules/documents/models/upload_document_request.dart'
    as _i16;
import 'package:gewerber_backend_server/src/generated/modules/documents/models/document_kind.dart'
    as _i17;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/create_customer_request.dart'
    as _i18;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/update_customer_request.dart'
    as _i19;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/customer_status.dart'
    as _i20;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/create_invoice_request.dart'
    as _i21;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/update_invoice_request.dart'
    as _i22;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/invoice_status.dart'
    as _i23;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/create_invoice_template_request.dart'
    as _i24;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/update_invoice_template_request.dart'
    as _i25;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/record_payment_request.dart'
    as _i26;
import 'package:gewerber_backend_server/src/generated/modules/user/models/update_user_profile_request.dart'
    as _i27;
import 'package:gewerber_commercial_server/gewerber_commercial_server.dart'
    as _i28;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i29;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i30;

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
      'business': _i5.BusinessEndpoint()
        ..initialize(
          server,
          'business',
          null,
        ),
      'businessSettings': _i6.BusinessSettingsEndpoint()
        ..initialize(
          server,
          'businessSettings',
          null,
        ),
      'document': _i7.DocumentEndpoint()
        ..initialize(
          server,
          'document',
          null,
        ),
      'customer': _i8.CustomerEndpoint()
        ..initialize(
          server,
          'customer',
          null,
        ),
      'invoice': _i9.InvoiceEndpoint()
        ..initialize(
          server,
          'invoice',
          null,
        ),
      'invoiceTemplate': _i10.InvoiceTemplateEndpoint()
        ..initialize(
          server,
          'invoiceTemplate',
          null,
        ),
      'payment': _i11.PaymentEndpoint()
        ..initialize(
          server,
          'payment',
          null,
        ),
      'userProfile': _i12.UserProfileEndpoint()
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
    connectors['business'] = _i1.EndpointConnector(
      name: 'business',
      endpoint: endpoints['business']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i13.CreateBusinessRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['business'] as _i5.BusinessEndpoint).create(
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
              ) async => (endpoints['business'] as _i5.BusinessEndpoint).get(
                session,
                businessId: params['businessId'],
              ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i14.UpdateBusinessRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['business'] as _i5.BusinessEndpoint).update(
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
              ) async => (endpoints['business'] as _i5.BusinessEndpoint)
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
                          as _i6.BusinessSettingsEndpoint)
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
              type: _i1.getType<_i15.UpdateBusinessSettingsRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['businessSettings']
                          as _i6.BusinessSettingsEndpoint)
                      .update(
                        session,
                        params['request'],
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
              type: _i1.getType<_i16.UploadDocumentRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _i7.DocumentEndpoint).upload(
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
              type: _i1.getType<_i17.DocumentKind?>(),
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _i7.DocumentEndpoint).list(
                session,
                businessId: params['businessId'],
                kind: params['kind'],
                relatedEntityType: params['relatedEntityType'],
                relatedEntityId: params['relatedEntityId'],
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
              ) async => (endpoints['document'] as _i7.DocumentEndpoint).get(
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
                  (endpoints['document'] as _i7.DocumentEndpoint).download(
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
              ) async => (endpoints['document'] as _i7.DocumentEndpoint).delete(
                session,
                params['documentId'],
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
              type: _i1.getType<_i18.CreateCustomerRequest>(),
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
              ) async => (endpoints['customer'] as _i8.CustomerEndpoint).create(
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
              ) async => (endpoints['customer'] as _i8.CustomerEndpoint).get(
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
              type: _i1.getType<_i19.UpdateCustomerRequest>(),
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
              ) async => (endpoints['customer'] as _i8.CustomerEndpoint).update(
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
              type: _i1.getType<_i20.CustomerStatus?>(),
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
              ) async => (endpoints['customer'] as _i8.CustomerEndpoint).list(
                session,
                status: params['status'],
                limit: params['limit'],
                offset: params['offset'],
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
              type: _i1.getType<_i21.CreateInvoiceRequest>(),
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
              ) async => (endpoints['invoice'] as _i9.InvoiceEndpoint).create(
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
              ) async => (endpoints['invoice'] as _i9.InvoiceEndpoint).get(
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
              ) async => (endpoints['invoice'] as _i9.InvoiceEndpoint).getItems(
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
              type: _i1.getType<_i22.UpdateInvoiceRequest>(),
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
              ) async => (endpoints['invoice'] as _i9.InvoiceEndpoint).update(
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
              type: _i1.getType<_i23.InvoiceStatus?>(),
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
              ) async => (endpoints['invoice'] as _i9.InvoiceEndpoint).list(
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
              ) async => (endpoints['invoice'] as _i9.InvoiceEndpoint).delete(
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
              type: _i1.getType<_i24.CreateInvoiceTemplateRequest>(),
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
                  (endpoints['invoiceTemplate'] as _i10.InvoiceTemplateEndpoint)
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
                  (endpoints['invoiceTemplate'] as _i10.InvoiceTemplateEndpoint)
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
              type: _i1.getType<_i25.UpdateInvoiceTemplateRequest>(),
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
                  (endpoints['invoiceTemplate'] as _i10.InvoiceTemplateEndpoint)
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['invoiceTemplate'] as _i10.InvoiceTemplateEndpoint)
                      .list(
                        session,
                        businessId: params['businessId'],
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
              type: _i1.getType<_i26.RecordPaymentRequest>(),
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
              ) async => (endpoints['payment'] as _i11.PaymentEndpoint).record(
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
              ) async => (endpoints['payment'] as _i11.PaymentEndpoint).status(
                session,
                params['invoiceId'],
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
              ) async => (endpoints['userProfile'] as _i12.UserProfileEndpoint)
                  .getMyProfile(session),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i27.UpdateUserProfileRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfile'] as _i12.UserProfileEndpoint).update(
                    session,
                    params['request'],
                  ),
        ),
      },
    );
    modules['gewerber_commercial'] = _i28.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_idp'] = _i29.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i30.Endpoints()
      ..initializeEndpoints(server);
  }
}
