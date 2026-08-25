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
import 'package:gewerber_backend_client/src/protocol/modules/accounting/models/accounting_transaction.dart'
    as _i6;
import 'package:gewerber_backend_client/src/protocol/modules/accounting/models/create_transaction_request.dart'
    as _i7;
import 'package:gewerber_backend_client/src/protocol/modules/accounting/models/update_transaction_request.dart'
    as _i8;
import 'package:gewerber_backend_client/src/protocol/modules/accounting/models/transaction_type.dart'
    as _i9;
import 'package:gewerber_backend_client/src/protocol/modules/accounting/models/transaction_category.dart'
    as _i10;
import 'package:gewerber_backend_client/src/protocol/modules/accounting/models/profit_loss_report.dart'
    as _i11;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/business.dart'
    as _i12;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/create_business_request.dart'
    as _i13;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/update_business_request.dart'
    as _i14;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/business_settings.dart'
    as _i15;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/update_business_settings_request.dart'
    as _i16;
import 'package:gewerber_backend_client/src/protocol/modules/dashboard/models/dashboard_summary.dart'
    as _i17;
import 'package:gewerber_backend_client/src/protocol/modules/documents/models/document.dart'
    as _i18;
import 'package:gewerber_backend_client/src/protocol/modules/documents/models/upload_document_request.dart'
    as _i19;
import 'package:gewerber_backend_client/src/protocol/modules/documents/models/document_kind.dart'
    as _i20;
import 'dart:typed_data' as _i21;
import 'package:gewerber_backend_client/src/protocol/modules/guidance/models/guidance_tip.dart'
    as _i22;
import 'package:gewerber_backend_client/src/protocol/modules/guidance/models/checklist_definition.dart'
    as _i23;
import 'package:gewerber_backend_client/src/protocol/modules/guidance/models/user_guidance_progress.dart'
    as _i24;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/customer.dart'
    as _i25;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/create_customer_request.dart'
    as _i26;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/update_customer_request.dart'
    as _i27;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/customer_status.dart'
    as _i28;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/customer_list_page.dart'
    as _i29;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/customer_cursor_page.dart'
    as _i30;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice.dart'
    as _i31;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/create_invoice_request.dart'
    as _i32;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice_item.dart'
    as _i33;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/update_invoice_request.dart'
    as _i34;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice_status.dart'
    as _i35;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice_list_page.dart'
    as _i36;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice_cursor_page.dart'
    as _i37;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice_template.dart'
    as _i38;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/create_invoice_template_request.dart'
    as _i39;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/update_invoice_template_request.dart'
    as _i40;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/payment_record.dart'
    as _i41;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/record_payment_request.dart'
    as _i42;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice_payment_status.dart'
    as _i43;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/create_recurring_schedule_request.dart'
    as _i44;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/update_recurring_schedule_request.dart'
    as _i45;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/reminder.dart'
    as _i46;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/project.dart'
    as _i47;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/create_project_request.dart'
    as _i48;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/task.dart'
    as _i49;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/update_project_request.dart'
    as _i50;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/project_status.dart'
    as _i51;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/create_task_request.dart'
    as _i52;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/update_task_request.dart'
    as _i53;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/task_status.dart'
    as _i54;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/time_entry.dart'
    as _i55;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/start_timer_request.dart'
    as _i56;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/create_time_entry_request.dart'
    as _i57;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/update_time_entry_request.dart'
    as _i58;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/time_report.dart'
    as _i59;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/create_time_entries_invoice_request.dart'
    as _i60;
import 'package:gewerber_backend_client/src/protocol/modules/user/models/user_profile.dart'
    as _i61;
import 'package:gewerber_backend_client/src/protocol/modules/user/models/update_user_profile_request.dart'
    as _i62;
import 'package:gewerber_commercial_client/gewerber_commercial_client.dart'
    as _i63;
import 'package:http/http.dart' as _i64;
import 'protocol.dart' as _i65;

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
class EndpointAccounting extends EndpointBusinessScoped {
  EndpointAccounting(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'accounting';

  /// Records an income or expense transaction.
  _i3.Future<_i6.AccountingTransaction> create(
    _i7.CreateTransactionRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i6.AccountingTransaction>(
    'accounting',
    'create',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<_i6.AccountingTransaction> get(
    int transactionId, {
    int? businessId,
  }) => caller.callServerEndpoint<_i6.AccountingTransaction>(
    'accounting',
    'get',
    {
      'transactionId': transactionId,
      'businessId': businessId,
    },
  );

  _i3.Future<_i6.AccountingTransaction> update(
    _i8.UpdateTransactionRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i6.AccountingTransaction>(
    'accounting',
    'update',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<List<_i6.AccountingTransaction>> list({
    _i9.TransactionType? type,
    _i10.TransactionCategory? category,
    DateTime? from,
    DateTime? to,
    int? limit,
    int? offset,
    int? businessId,
  }) => caller.callServerEndpoint<List<_i6.AccountingTransaction>>(
    'accounting',
    'list',
    {
      'type': type,
      'category': category,
      'from': from,
      'to': to,
      'limit': limit,
      'offset': offset,
      'businessId': businessId,
    },
  );

  _i3.Future<void> delete(
    int transactionId, {
    int? businessId,
  }) => caller.callServerEndpoint<void>(
    'accounting',
    'delete',
    {
      'transactionId': transactionId,
      'businessId': businessId,
    },
  );

  /// Basic profit & loss (EÜR style) for the period.
  _i3.Future<_i11.ProfitLossReport> profitLoss(
    DateTime from,
    DateTime to, {
    int? businessId,
  }) => caller.callServerEndpoint<_i11.ProfitLossReport>(
    'accounting',
    'profitLoss',
    {
      'from': from,
      'to': to,
      'businessId': businessId,
    },
  );

  /// Exports transactions as CSV.
  _i3.Future<String> exportCsv({
    _i9.TransactionType? type,
    DateTime? from,
    DateTime? to,
    int? businessId,
  }) => caller.callServerEndpoint<String>(
    'accounting',
    'exportCsv',
    {
      'type': type,
      'from': from,
      'to': to,
      'businessId': businessId,
    },
  );
}

/// {@category Endpoint}
class EndpointBusiness extends EndpointBusinessScoped {
  EndpointBusiness(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'business';

  _i3.Future<_i12.Business> create(_i13.CreateBusinessRequest request) =>
      caller.callServerEndpoint<_i12.Business>(
        'business',
        'create',
        {'request': request},
      );

  _i3.Future<_i12.Business> get({int? businessId}) =>
      caller.callServerEndpoint<_i12.Business>(
        'business',
        'get',
        {'businessId': businessId},
      );

  _i3.Future<_i12.Business> update(_i14.UpdateBusinessRequest request) =>
      caller.callServerEndpoint<_i12.Business>(
        'business',
        'update',
        {'request': request},
      );

  _i3.Future<List<_i12.Business>> listMine() =>
      caller.callServerEndpoint<List<_i12.Business>>(
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

  _i3.Future<_i15.BusinessSettings> get({int? businessId}) =>
      caller.callServerEndpoint<_i15.BusinessSettings>(
        'businessSettings',
        'get',
        {'businessId': businessId},
      );

  _i3.Future<_i15.BusinessSettings> update(
    _i16.UpdateBusinessSettingsRequest request,
  ) => caller.callServerEndpoint<_i15.BusinessSettings>(
    'businessSettings',
    'update',
    {'request': request},
  );
}

/// {@category Endpoint}
class EndpointDashboard extends EndpointBusinessScoped {
  EndpointDashboard(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dashboard';

  /// Aggregated dashboard summary of the tenant: current-month KPIs, monthly
  /// trend, recent activity feeds and open receivables. All list sizes are
  /// clamped server-side; [asOf] anchors every window (tests only).
  _i3.Future<_i17.DashboardSummary> getSummary({
    int? trendMonths,
    int? recentLimit,
    int? overdueLimit,
    int? debtorLimit,
    DateTime? asOf,
    int? businessId,
  }) => caller.callServerEndpoint<_i17.DashboardSummary>(
    'dashboard',
    'getSummary',
    {
      'trendMonths': trendMonths,
      'recentLimit': recentLimit,
      'overdueLimit': overdueLimit,
      'debtorLimit': debtorLimit,
      'asOf': asOf,
      'businessId': businessId,
    },
  );
}

/// {@category Endpoint}
class EndpointDocument extends EndpointBusinessScoped {
  EndpointDocument(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'document';

  _i3.Future<_i18.Document> upload(_i19.UploadDocumentRequest request) =>
      caller.callServerEndpoint<_i18.Document>(
        'document',
        'upload',
        {'request': request},
      );

  _i3.Future<List<_i18.Document>> list({
    int? businessId,
    _i20.DocumentKind? kind,
    String? relatedEntityType,
    String? relatedEntityId,
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<List<_i18.Document>>(
    'document',
    'list',
    {
      'businessId': businessId,
      'kind': kind,
      'relatedEntityType': relatedEntityType,
      'relatedEntityId': relatedEntityId,
      'limit': limit,
      'offset': offset,
    },
  );

  _i3.Future<_i18.Document> get(int documentId) =>
      caller.callServerEndpoint<_i18.Document>(
        'document',
        'get',
        {'documentId': documentId},
      );

  _i3.Future<_i21.ByteData> download(int documentId) =>
      caller.callServerEndpoint<_i21.ByteData>(
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

/// Serves curated guidance content (tooltips, checklists, "What is this?"
/// popups) and tracks per-user progress. User-scoped, requires login.
/// {@category Endpoint}
class EndpointGuidance extends _i2.EndpointRef {
  EndpointGuidance(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'guidance';

  /// All contextual tooltips.
  _i3.Future<List<_i22.GuidanceTip>> tips() =>
      caller.callServerEndpoint<List<_i22.GuidanceTip>>(
        'guidance',
        'tips',
        {},
      );

  /// All checklists with their items.
  _i3.Future<List<_i23.ChecklistDefinition>> checklists() =>
      caller.callServerEndpoint<List<_i23.ChecklistDefinition>>(
        'guidance',
        'checklists',
        {},
      );

  /// The signed-in user's progress (completed/dismissed items).
  _i3.Future<List<_i24.UserGuidanceProgress>> myProgress() =>
      caller.callServerEndpoint<List<_i24.UserGuidanceProgress>>(
        'guidance',
        'myProgress',
        {},
      );

  /// Marks a checklist item (or any guidance item key) as completed.
  _i3.Future<_i24.UserGuidanceProgress> markCompleted(String itemKey) =>
      caller.callServerEndpoint<_i24.UserGuidanceProgress>(
        'guidance',
        'markCompleted',
        {'itemKey': itemKey},
      );

  /// Dismisses a tooltip so it is not shown again.
  _i3.Future<_i24.UserGuidanceProgress> dismissTip(String topic) =>
      caller.callServerEndpoint<_i24.UserGuidanceProgress>(
        'guidance',
        'dismissTip',
        {'topic': topic},
      );
}

/// {@category Endpoint}
class EndpointCustomer extends EndpointBusinessScoped {
  EndpointCustomer(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'customer';

  _i3.Future<_i25.Customer> create(
    _i26.CreateCustomerRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i25.Customer>(
    'customer',
    'create',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<_i25.Customer> get(
    int customerId, {
    int? businessId,
  }) => caller.callServerEndpoint<_i25.Customer>(
    'customer',
    'get',
    {
      'customerId': customerId,
      'businessId': businessId,
    },
  );

  _i3.Future<_i25.Customer> update(
    _i27.UpdateCustomerRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i25.Customer>(
    'customer',
    'update',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<List<_i25.Customer>> list({
    _i28.CustomerStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) => caller.callServerEndpoint<List<_i25.Customer>>(
    'customer',
    'list',
    {
      'status': status,
      'limit': limit,
      'offset': offset,
      'businessId': businessId,
    },
  );

  /// Paged variant of [list] that additionally returns the total number of
  /// matching rows. The page size cap is applied as in [list].
  _i3.Future<_i29.CustomerListPage> listPage({
    _i28.CustomerStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) => caller.callServerEndpoint<_i29.CustomerListPage>(
    'customer',
    'listPage',
    {
      'status': status,
      'limit': limit,
      'offset': offset,
      'businessId': businessId,
    },
  );

  /// Keyset-paginated variant of [list] for very large lists. Stable order:
  /// `createdAt DESC, id DESC`. Pass the previous page's
  /// [CustomerCursorPage.nextCursor] back as `cursor` (`null` = first page);
  /// a `null` result cursor marks the end. Cursors are tenant-scoped: one
  /// minted for another business is rejected with a [ValidationException]
  /// (field `cursor`), just like a malformed or tampered cursor. The page
  /// size cap is applied as in [list]; no total count is computed.
  _i3.Future<_i30.CustomerCursorPage> listCursorPage({
    _i28.CustomerStatus? status,
    int? limit,
    String? cursor,
    int? businessId,
  }) => caller.callServerEndpoint<_i30.CustomerCursorPage>(
    'customer',
    'listCursorPage',
    {
      'status': status,
      'limit': limit,
      'cursor': cursor,
      'businessId': businessId,
    },
  );
}

/// {@category Endpoint}
class EndpointInvoice extends EndpointBusinessScoped {
  EndpointInvoice(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'invoice';

  _i3.Future<_i31.Invoice> create(
    _i32.CreateInvoiceRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i31.Invoice>(
    'invoice',
    'create',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<_i31.Invoice> get(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<_i31.Invoice>(
    'invoice',
    'get',
    {
      'invoiceId': invoiceId,
      'businessId': businessId,
    },
  );

  _i3.Future<List<_i33.InvoiceItem>> getItems(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<List<_i33.InvoiceItem>>(
    'invoice',
    'getItems',
    {
      'invoiceId': invoiceId,
      'businessId': businessId,
    },
  );

  _i3.Future<_i31.Invoice> update(
    _i34.UpdateInvoiceRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i31.Invoice>(
    'invoice',
    'update',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<List<_i31.Invoice>> list({
    _i35.InvoiceStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) => caller.callServerEndpoint<List<_i31.Invoice>>(
    'invoice',
    'list',
    {
      'status': status,
      'limit': limit,
      'offset': offset,
      'businessId': businessId,
    },
  );

  /// Paged variant of [list] that additionally returns the total number of
  /// matching rows. The page size cap is applied as in [list].
  _i3.Future<_i36.InvoiceListPage> listPage({
    _i35.InvoiceStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) => caller.callServerEndpoint<_i36.InvoiceListPage>(
    'invoice',
    'listPage',
    {
      'status': status,
      'limit': limit,
      'offset': offset,
      'businessId': businessId,
    },
  );

  /// Keyset-paginated variant of [list] for very large lists. Stable order:
  /// `issueDate DESC, id DESC`. Pass the previous page's
  /// [InvoiceCursorPage.nextCursor] back as `cursor` (`null` = first page);
  /// a `null` result cursor marks the end. Cursors are tenant-scoped: one
  /// minted for another business is rejected with a [ValidationException]
  /// (field `cursor`), just like a malformed or tampered cursor. The page
  /// size cap is applied as in [list]; no total count is computed.
  _i3.Future<_i37.InvoiceCursorPage> listCursorPage({
    _i35.InvoiceStatus? status,
    int? limit,
    String? cursor,
    int? businessId,
  }) => caller.callServerEndpoint<_i37.InvoiceCursorPage>(
    'invoice',
    'listCursorPage',
    {
      'status': status,
      'limit': limit,
      'cursor': cursor,
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

  /// Transitions a draft invoice to `sent`.
  _i3.Future<_i31.Invoice> markSent(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<_i31.Invoice>(
    'invoice',
    'markSent',
    {
      'invoiceId': invoiceId,
      'businessId': businessId,
    },
  );

  /// Cancels an invoice that is not paid or already cancelled.
  _i3.Future<_i31.Invoice> cancel(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<_i31.Invoice>(
    'invoice',
    'cancel',
    {
      'invoiceId': invoiceId,
      'businessId': businessId,
    },
  );

  /// Exports invoices as CSV (semicolon-separated, comma decimals).
  _i3.Future<String> exportCsv({
    _i35.InvoiceStatus? status,
    int? businessId,
  }) => caller.callServerEndpoint<String>(
    'invoice',
    'exportCsv',
    {
      'status': status,
      'businessId': businessId,
    },
  );

  /// Exports invoices (with items) as a JSON string.
  _i3.Future<String> exportJson({
    _i35.InvoiceStatus? status,
    int? businessId,
  }) => caller.callServerEndpoint<String>(
    'invoice',
    'exportJson',
    {
      'status': status,
      'businessId': businessId,
    },
  );

  /// Generates the PDF for the invoice, stores it as a private document and
  /// returns the document metadata. Download via `document.download`.
  _i3.Future<_i18.Document> generatePdf(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<_i18.Document>(
    'invoice',
    'generatePdf',
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

  _i3.Future<_i38.InvoiceTemplate> create(
    _i39.CreateInvoiceTemplateRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i38.InvoiceTemplate>(
    'invoiceTemplate',
    'create',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<_i38.InvoiceTemplate> get(
    int templateId, {
    int? businessId,
  }) => caller.callServerEndpoint<_i38.InvoiceTemplate>(
    'invoiceTemplate',
    'get',
    {
      'templateId': templateId,
      'businessId': businessId,
    },
  );

  _i3.Future<_i38.InvoiceTemplate> update(
    _i40.UpdateInvoiceTemplateRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i38.InvoiceTemplate>(
    'invoiceTemplate',
    'update',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<List<_i38.InvoiceTemplate>> list({
    int? businessId,
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<List<_i38.InvoiceTemplate>>(
    'invoiceTemplate',
    'list',
    {
      'businessId': businessId,
      'limit': limit,
      'offset': offset,
    },
  );
}

/// {@category Endpoint}
class EndpointPayment extends EndpointBusinessScoped {
  EndpointPayment(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'payment';

  _i3.Future<_i41.PaymentRecord> record(
    _i42.RecordPaymentRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i41.PaymentRecord>(
    'payment',
    'record',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<_i43.InvoicePaymentStatus> status(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<_i43.InvoicePaymentStatus>(
    'payment',
    'status',
    {
      'invoiceId': invoiceId,
      'businessId': businessId,
    },
  );
}

/// Management of recurring invoice schedules.
///
/// A schedule is the recurrence configuration of a source invoice; due
/// schedules are materialized into new draft invoices by the
/// `process-recurring-invoices` background job.
/// {@category Endpoint}
class EndpointRecurringSchedule extends EndpointBusinessScoped {
  EndpointRecurringSchedule(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'recurringSchedule';

  /// Attaches a recurring schedule to an invoice. The next issue date is
  /// recalculated from the invoice's issue date when not given explicitly.
  _i3.Future<_i31.Invoice> create(
    _i44.CreateRecurringScheduleRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i31.Invoice>(
    'recurringSchedule',
    'create',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  /// Returns the schedule (i.e. its source invoice) or `NotFoundException`
  /// when it does not exist.
  _i3.Future<_i31.Invoice> get(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<_i31.Invoice>(
    'recurringSchedule',
    'get',
    {
      'invoiceId': invoiceId,
      'businessId': businessId,
    },
  );

  /// Lists all schedules of the tenant, upcoming next issue first.
  _i3.Future<List<_i31.Invoice>> list({
    int? limit,
    int? offset,
    int? businessId,
  }) => caller.callServerEndpoint<List<_i31.Invoice>>(
    'recurringSchedule',
    'list',
    {
      'limit': limit,
      'offset': offset,
      'businessId': businessId,
    },
  );

  /// Updates schedule settings (`null` fields keep their current value).
  _i3.Future<_i31.Invoice> update(
    _i45.UpdateRecurringScheduleRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i31.Invoice>(
    'recurringSchedule',
    'update',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  /// Cancels the schedule; already materialized invoices are kept.
  _i3.Future<_i31.Invoice> cancel(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<_i31.Invoice>(
    'recurringSchedule',
    'cancel',
    {
      'invoiceId': invoiceId,
      'businessId': businessId,
    },
  );
}

/// {@category Endpoint}
class EndpointReminder extends EndpointBusinessScoped {
  EndpointReminder(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'reminder';

  /// Lists all reminders sent for the invoice, ordered by send date.
  _i3.Future<List<_i46.Reminder>> list(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<List<_i46.Reminder>>(
    'reminder',
    'list',
    {
      'invoiceId': invoiceId,
      'businessId': businessId,
    },
  );

  /// Sends a payment reminder to the customer and records it. The reminder
  /// level is incremented on every send and mirrored to the invoice's
  /// `dunningLevel`.
  _i3.Future<_i46.Reminder> send(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<_i46.Reminder>(
    'reminder',
    'send',
    {
      'invoiceId': invoiceId,
      'businessId': businessId,
    },
  );
}

/// {@category Endpoint}
class EndpointProject extends EndpointBusinessScoped {
  EndpointProject(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'project';

  _i3.Future<_i47.Project> create(
    _i48.CreateProjectRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i47.Project>(
    'project',
    'create',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<_i47.Project> get(
    int projectId, {
    int? businessId,
  }) => caller.callServerEndpoint<_i47.Project>(
    'project',
    'get',
    {
      'projectId': projectId,
      'businessId': businessId,
    },
  );

  _i3.Future<List<_i49.Task>> getTasks(
    int projectId, {
    int? businessId,
  }) => caller.callServerEndpoint<List<_i49.Task>>(
    'project',
    'getTasks',
    {
      'projectId': projectId,
      'businessId': businessId,
    },
  );

  _i3.Future<_i47.Project> update(
    _i50.UpdateProjectRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i47.Project>(
    'project',
    'update',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<List<_i47.Project>> list({
    _i51.ProjectStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) => caller.callServerEndpoint<List<_i47.Project>>(
    'project',
    'list',
    {
      'status': status,
      'limit': limit,
      'offset': offset,
      'businessId': businessId,
    },
  );

  _i3.Future<void> delete(
    int projectId, {
    int? businessId,
  }) => caller.callServerEndpoint<void>(
    'project',
    'delete',
    {
      'projectId': projectId,
      'businessId': businessId,
    },
  );
}

/// {@category Endpoint}
class EndpointTask extends EndpointBusinessScoped {
  EndpointTask(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'task';

  _i3.Future<_i49.Task> create(
    _i52.CreateTaskRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i49.Task>(
    'task',
    'create',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<_i49.Task> update(
    _i53.UpdateTaskRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i49.Task>(
    'task',
    'update',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<List<_i49.Task>> list({
    int? projectId,
    _i54.TaskStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) => caller.callServerEndpoint<List<_i49.Task>>(
    'task',
    'list',
    {
      'projectId': projectId,
      'status': status,
      'limit': limit,
      'offset': offset,
      'businessId': businessId,
    },
  );
}

/// {@category Endpoint}
class EndpointTimeEntry extends EndpointBusinessScoped {
  EndpointTimeEntry(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'timeEntry';

  /// Starts a timer. Only one timer may run per business.
  _i3.Future<_i55.TimeEntry> startTimer(
    _i56.StartTimerRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i55.TimeEntry>(
    'timeEntry',
    'startTimer',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  /// Stops the running timer and stores the (rounded) duration.
  _i3.Future<_i55.TimeEntry> stopTimer({int? businessId}) =>
      caller.callServerEndpoint<_i55.TimeEntry>(
        'timeEntry',
        'stopTimer',
        {'businessId': businessId},
      );

  /// Creates a manual time entry.
  _i3.Future<_i55.TimeEntry> create(
    _i57.CreateTimeEntryRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i55.TimeEntry>(
    'timeEntry',
    'create',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<_i55.TimeEntry> get(
    int timeEntryId, {
    int? businessId,
  }) => caller.callServerEndpoint<_i55.TimeEntry>(
    'timeEntry',
    'get',
    {
      'timeEntryId': timeEntryId,
      'businessId': businessId,
    },
  );

  _i3.Future<_i55.TimeEntry> update(
    _i58.UpdateTimeEntryRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i55.TimeEntry>(
    'timeEntry',
    'update',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _i3.Future<List<_i55.TimeEntry>> list({
    int? projectId,
    int? taskId,
    DateTime? from,
    DateTime? to,
    bool? billable,
    int? limit,
    int? offset,
    int? businessId,
  }) => caller.callServerEndpoint<List<_i55.TimeEntry>>(
    'timeEntry',
    'list',
    {
      'projectId': projectId,
      'taskId': taskId,
      'from': from,
      'to': to,
      'billable': billable,
      'limit': limit,
      'offset': offset,
      'businessId': businessId,
    },
  );

  _i3.Future<void> delete(
    int timeEntryId, {
    int? businessId,
  }) => caller.callServerEndpoint<void>(
    'timeEntry',
    'delete',
    {
      'timeEntryId': timeEntryId,
      'businessId': businessId,
    },
  );

  /// Aggregates stopped time entries of the period into a report.
  _i3.Future<_i59.TimeReport> report(
    DateTime from,
    DateTime to, {
    int? projectId,
    int? businessId,
  }) => caller.callServerEndpoint<_i59.TimeReport>(
    'timeEntry',
    'report',
    {
      'from': from,
      'to': to,
      'projectId': projectId,
      'businessId': businessId,
    },
  );

  /// Converts billable, uninvoiced time entries of a project into a draft
  /// invoice.
  _i3.Future<_i31.Invoice> createInvoice(
    _i60.CreateTimeEntriesInvoiceRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i31.Invoice>(
    'timeEntry',
    'createInvoice',
    {
      'request': request,
      'businessId': businessId,
    },
  );
}

/// {@category Endpoint}
class EndpointUserProfile extends _i2.EndpointRef {
  EndpointUserProfile(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'userProfile';

  _i3.Future<_i61.UserProfile> getMyProfile() =>
      caller.callServerEndpoint<_i61.UserProfile>(
        'userProfile',
        'getMyProfile',
        {},
      );

  _i3.Future<_i61.UserProfile> update(_i62.UpdateUserProfileRequest request) =>
      caller.callServerEndpoint<_i61.UserProfile>(
        'userProfile',
        'update',
        {'request': request},
      );

  /// Soft-deletes the account of the logged-in user (GDPR Art. 17): sets a
  /// `deletedAt` marker and severs all personal links in retained business
  /// data (GoBD retention). Repeating the call throws [NotFoundException].
  _i3.Future<void> deleteMyAccount() => caller.callServerEndpoint<void>(
    'userProfile',
    'deleteMyAccount',
    {},
  );

  /// Exports all data of the logged-in user as a ZIP archive (GDPR Art. 20):
  /// profile, memberships, guidance progress and every business the user is
  /// a member of with its customers, invoices (+items), projects, tasks,
  /// time entries, transactions and documents. Foreign tenants are not
  /// included.
  _i3.Future<_i21.ByteData> exportMyData() =>
      caller.callServerEndpoint<_i21.ByteData>(
        'userProfile',
        'exportMyData',
        {},
      );
}

class Modules {
  Modules(Client client) {
    commercial = _i63.Caller(client);
    serverpod_auth_idp = _i1.Caller(client);
    serverpod_auth_core = _i4.Caller(client);
  }

  late final _i63.Caller commercial;

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
    _i64.Client? httpClientOverride,
  }) : super(
         host,
         _i65.Protocol(),
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
    accounting = EndpointAccounting(this);
    business = EndpointBusiness(this);
    businessSettings = EndpointBusinessSettings(this);
    dashboard = EndpointDashboard(this);
    document = EndpointDocument(this);
    guidance = EndpointGuidance(this);
    customer = EndpointCustomer(this);
    invoice = EndpointInvoice(this);
    invoiceTemplate = EndpointInvoiceTemplate(this);
    payment = EndpointPayment(this);
    recurringSchedule = EndpointRecurringSchedule(this);
    reminder = EndpointReminder(this);
    project = EndpointProject(this);
    task = EndpointTask(this);
    timeEntry = EndpointTimeEntry(this);
    userProfile = EndpointUserProfile(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointEntitlement entitlement;

  late final EndpointAccounting accounting;

  late final EndpointBusiness business;

  late final EndpointBusinessSettings businessSettings;

  late final EndpointDashboard dashboard;

  late final EndpointDocument document;

  late final EndpointGuidance guidance;

  late final EndpointCustomer customer;

  late final EndpointInvoice invoice;

  late final EndpointInvoiceTemplate invoiceTemplate;

  late final EndpointPayment payment;

  late final EndpointRecurringSchedule recurringSchedule;

  late final EndpointReminder reminder;

  late final EndpointProject project;

  late final EndpointTask task;

  late final EndpointTimeEntry timeEntry;

  late final EndpointUserProfile userProfile;

  late final Modules modules;

  @override
  Map<String, _i2.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'entitlement': entitlement,
    'accounting': accounting,
    'business': business,
    'businessSettings': businessSettings,
    'dashboard': dashboard,
    'document': document,
    'guidance': guidance,
    'customer': customer,
    'invoice': invoice,
    'invoiceTemplate': invoiceTemplate,
    'payment': payment,
    'recurringSchedule': recurringSchedule,
    'reminder': reminder,
    'project': project,
    'task': task,
    'timeEntry': timeEntry,
    'userProfile': userProfile,
  };

  @override
  Map<String, _i2.ModuleEndpointCaller> get moduleLookup => {
    'commercial': modules.commercial,
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
