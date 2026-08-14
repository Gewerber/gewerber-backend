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
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i1;
import 'package:serverpod_client/serverpod_client.dart' as _i2;
import 'dart:async' as _i3;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i4;
import 'package:gewerber_backend_client/src/protocol/core/entitlement/feature.dart'
    as _i5;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/business.dart'
    as _i6;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/create_business_request.dart'
    as _i7;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/update_business_request.dart'
    as _i8;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/business_settings.dart'
    as _i9;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/update_business_settings_request.dart'
    as _i10;
import 'package:gewerber_backend_client/src/protocol/modules/documents/models/document.dart'
    as _i11;
import 'package:gewerber_backend_client/src/protocol/modules/documents/models/upload_document_request.dart'
    as _i12;
import 'package:gewerber_backend_client/src/protocol/modules/documents/models/document_kind.dart'
    as _i13;
import 'dart:typed_data' as _i14;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/customer.dart'
    as _i15;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/create_customer_request.dart'
    as _i16;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/update_customer_request.dart'
    as _i17;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/customer_status.dart'
    as _i18;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice.dart'
    as _i19;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/create_invoice_request.dart'
    as _i20;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice_item.dart'
    as _i21;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/update_invoice_request.dart'
    as _i22;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice_status.dart'
    as _i23;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice_template.dart'
    as _i24;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/create_invoice_template_request.dart'
    as _i25;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/update_invoice_template_request.dart'
    as _i26;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/payment_record.dart'
    as _i27;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/record_payment_request.dart'
    as _i28;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice_payment_status.dart'
    as _i29;
import 'package:gewerber_backend_client/src/protocol/modules/user/models/user_profile.dart'
    as _i30;
import 'package:gewerber_backend_client/src/protocol/modules/user/models/update_user_profile_request.dart'
    as _i31;
import 'package:gewerber_commercial_client/gewerber_commercial_client.dart'
    as _i32;
import 'package:http/http.dart' as _i33;
import 'protocol.dart' as _i34;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i1.EndpointEmailIdpBase {
  EndpointEmailIdp(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<_i4.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _i3.Future<_i2.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i3.Future<String> verifyRegistrationCode({
    required _i2.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i3.Future<_i4.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i3.Future<_i2.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i3.Future<String> verifyPasswordResetCode({
    required _i2.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _i3.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i4.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i3.Future<_i4.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// {@category Endpoint}
abstract class EndpointBusinessScoped extends _i2.EndpointRef {
  EndpointBusinessScoped(_i2.EndpointCaller caller) : super(caller);
}

/// {@category Endpoint}
class EndpointEntitlement extends EndpointBusinessScoped {
  EndpointEntitlement(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'entitlement';

  _i3.Future<List<_i5.Feature>> list({int? businessId}) =>
      caller.callServerEndpoint<List<_i5.Feature>>(
        'entitlement',
        'list',
        {'businessId': businessId},
      );
}

/// {@category Endpoint}
class EndpointBusiness extends EndpointBusinessScoped {
  EndpointBusiness(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'business';

  _i3.Future<_i6.Business> create(_i7.CreateBusinessRequest request) =>
      caller.callServerEndpoint<_i6.Business>(
        'business',
        'create',
        {'request': request},
      );

  _i3.Future<_i6.Business> get({int? businessId}) =>
      caller.callServerEndpoint<_i6.Business>(
        'business',
        'get',
        {'businessId': businessId},
      );

  _i3.Future<_i6.Business> update(_i8.UpdateBusinessRequest request) =>
      caller.callServerEndpoint<_i6.Business>(
        'business',
        'update',
        {'request': request},
      );

  _i3.Future<List<_i6.Business>> listMine() =>
      caller.callServerEndpoint<List<_i6.Business>>(
        'business',
        'listMine',
        {},
      );
}

/// {@category Endpoint}
class EndpointBusinessSettings extends EndpointBusinessScoped {
  EndpointBusinessSettings(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'businessSettings';

  _i3.Future<_i9.BusinessSettings> get({int? businessId}) =>
      caller.callServerEndpoint<_i9.BusinessSettings>(
        'businessSettings',
        'get',
        {'businessId': businessId},
      );

  _i3.Future<_i9.BusinessSettings> update(
    _i10.UpdateBusinessSettingsRequest request,
  ) => caller.callServerEndpoint<_i9.BusinessSettings>(
    'businessSettings',
    'update',
    {'request': request},
  );
}

/// {@category Endpoint}
class EndpointDocument extends EndpointBusinessScoped {
  EndpointDocument(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'document';

  _i3.Future<_i11.Document> upload(_i12.UploadDocumentRequest request) =>
      caller.callServerEndpoint<_i11.Document>(
        'document',
        'upload',
        {'request': request},
      );

  _i3.Future<List<_i11.Document>> list({
    int? businessId,
    _i13.DocumentKind? kind,
    String? relatedEntityType,
    String? relatedEntityId,
  }) => caller.callServerEndpoint<List<_i11.Document>>(
    'document',
    'list',
    {
      'businessId': businessId,
      'kind': kind,
      'relatedEntityType': relatedEntityType,
      'relatedEntityId': relatedEntityId,
    },
  );

  _i3.Future<_i11.Document> get(int documentId) =>
      caller.callServerEndpoint<_i11.Document>(
        'document',
        'get',
        {'documentId': documentId},
      );

  _i3.Future<_i14.ByteData> download(int documentId) =>
      caller.callServerEndpoint<_i14.ByteData>(
        'document',
        'download',
        {'documentId': documentId},
      );

  _i3.Future<void> delete(int documentId) => caller.callServerEndpoint<void>(
    'document',
    'delete',
    {'documentId': documentId},
  );
}

/// {@category Endpoint}
class EndpointCustomer extends EndpointBusinessScoped {
  EndpointCustomer(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'customer';

  _i3.Future<_i15.Customer> create(
    _i16.CreateCustomerRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i15.Customer>(
    'customer',
    'create',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<_i15.Customer> get(
    int customerId, {
    int? businessId,
  }) => caller.callServerEndpoint<_i15.Customer>(
    'customer',
    'get',
    {
      'customerId': customerId,
      'businessId': businessId,
    },
  );

  _i3.Future<_i15.Customer> update(
    _i17.UpdateCustomerRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i15.Customer>(
    'customer',
    'update',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<List<_i15.Customer>> list({
    _i18.CustomerStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) => caller.callServerEndpoint<List<_i15.Customer>>(
    'customer',
    'list',
    {
      'status': status,
      'limit': limit,
      'offset': offset,
      'businessId': businessId,
    },
  );
}

/// {@category Endpoint}
class EndpointInvoice extends EndpointBusinessScoped {
  EndpointInvoice(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'invoice';

  _i3.Future<_i19.Invoice> create(
    _i20.CreateInvoiceRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i19.Invoice>(
    'invoice',
    'create',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<_i19.Invoice> get(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<_i19.Invoice>(
    'invoice',
    'get',
    {
      'invoiceId': invoiceId,
      'businessId': businessId,
    },
  );

  _i3.Future<List<_i21.InvoiceItem>> getItems(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<List<_i21.InvoiceItem>>(
    'invoice',
    'getItems',
    {
      'invoiceId': invoiceId,
      'businessId': businessId,
    },
  );

  _i3.Future<_i19.Invoice> update(
    _i22.UpdateInvoiceRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i19.Invoice>(
    'invoice',
    'update',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<List<_i19.Invoice>> list({
    _i23.InvoiceStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) => caller.callServerEndpoint<List<_i19.Invoice>>(
    'invoice',
    'list',
    {
      'status': status,
      'limit': limit,
      'offset': offset,
      'businessId': businessId,
    },
  );

  _i3.Future<void> delete(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<void>(
    'invoice',
    'delete',
    {
      'invoiceId': invoiceId,
      'businessId': businessId,
    },
  );
}

/// {@category Endpoint}
class EndpointInvoiceTemplate extends EndpointBusinessScoped {
  EndpointInvoiceTemplate(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'invoiceTemplate';

  _i3.Future<_i24.InvoiceTemplate> create(
    _i25.CreateInvoiceTemplateRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i24.InvoiceTemplate>(
    'invoiceTemplate',
    'create',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<_i24.InvoiceTemplate> get(
    int templateId, {
    int? businessId,
  }) => caller.callServerEndpoint<_i24.InvoiceTemplate>(
    'invoiceTemplate',
    'get',
    {
      'templateId': templateId,
      'businessId': businessId,
    },
  );

  _i3.Future<_i24.InvoiceTemplate> update(
    _i26.UpdateInvoiceTemplateRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i24.InvoiceTemplate>(
    'invoiceTemplate',
    'update',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<List<_i24.InvoiceTemplate>> list({int? businessId}) =>
      caller.callServerEndpoint<List<_i24.InvoiceTemplate>>(
        'invoiceTemplate',
        'list',
        {'businessId': businessId},
      );
}

/// {@category Endpoint}
class EndpointPayment extends EndpointBusinessScoped {
  EndpointPayment(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'payment';

  _i3.Future<_i27.PaymentRecord> record(
    _i28.RecordPaymentRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i27.PaymentRecord>(
    'payment',
    'record',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<_i29.InvoicePaymentStatus> status(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<_i29.InvoicePaymentStatus>(
    'payment',
    'status',
    {
      'invoiceId': invoiceId,
      'businessId': businessId,
    },
  );
}

/// {@category Endpoint}
class EndpointUserProfile extends _i2.EndpointRef {
  EndpointUserProfile(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'userProfile';

  _i3.Future<_i30.UserProfile> getMyProfile() =>
      caller.callServerEndpoint<_i30.UserProfile>(
        'userProfile',
        'getMyProfile',
        {},
      );

  _i3.Future<_i30.UserProfile> update(_i31.UpdateUserProfileRequest request) =>
      caller.callServerEndpoint<_i30.UserProfile>(
        'userProfile',
        'update',
        {'request': request},
      );
}

class Modules {
  Modules(Client client) {
    commercial = _i32.Caller(client);
    serverpod_auth_idp = _i1.Caller(client);
    serverpod_auth_core = _i4.Caller(client);
  }

  late final _i32.Caller commercial;

  late final _i1.Caller serverpod_auth_idp;

  late final _i4.Caller serverpod_auth_core;
}

class Client extends _i2.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i2.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i2.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i33.Client? httpClientOverride,
  }) : super(
         host,
         _i34.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    entitlement = EndpointEntitlement(this);
    business = EndpointBusiness(this);
    businessSettings = EndpointBusinessSettings(this);
    document = EndpointDocument(this);
    customer = EndpointCustomer(this);
    invoice = EndpointInvoice(this);
    invoiceTemplate = EndpointInvoiceTemplate(this);
    payment = EndpointPayment(this);
    userProfile = EndpointUserProfile(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointEntitlement entitlement;

  late final EndpointBusiness business;

  late final EndpointBusinessSettings businessSettings;

  late final EndpointDocument document;

  late final EndpointCustomer customer;

  late final EndpointInvoice invoice;

  late final EndpointInvoiceTemplate invoiceTemplate;

  late final EndpointPayment payment;

  late final EndpointUserProfile userProfile;

  late final Modules modules;

  @override
  Map<String, _i2.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'entitlement': entitlement,
    'business': business,
    'businessSettings': businessSettings,
    'document': document,
    'customer': customer,
    'invoice': invoice,
    'invoiceTemplate': invoiceTemplate,
    'payment': payment,
    'userProfile': userProfile,
  };

  @override
  Map<String, _i2.ModuleEndpointCaller> get moduleLookup => {
    'commercial': modules.commercial,
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
