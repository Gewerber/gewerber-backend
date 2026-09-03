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

import 'dart:async' as _ida;
import 'dart:typed_data' as _idt;
import 'package:gewerber_backend_client/src/protocol/core/entitlement/feature.dart'
    as _i6zpily8;
import 'package:gewerber_backend_client/src/protocol/modules/accounting/models/accounting_transaction.dart'
    as _in4p196h;
import 'package:gewerber_backend_client/src/protocol/modules/accounting/models/create_transaction_request.dart'
    as _i940ddvz;
import 'package:gewerber_backend_client/src/protocol/modules/accounting/models/profit_loss_report.dart'
    as _idz9zlsq;
import 'package:gewerber_backend_client/src/protocol/modules/accounting/models/transaction_category.dart'
    as _ihmhz0vo;
import 'package:gewerber_backend_client/src/protocol/modules/accounting/models/transaction_type.dart'
    as _i7icww1r;
import 'package:gewerber_backend_client/src/protocol/modules/accounting/models/update_transaction_request.dart'
    as _ils99x0j;
import 'package:gewerber_backend_client/src/protocol/modules/admin/models/admin_audit_page.dart'
    as _i8hgem5u;
import 'package:gewerber_backend_client/src/protocol/modules/admin/models/admin_auth_status.dart'
    as _iq6he93g;
import 'package:gewerber_backend_client/src/protocol/modules/admin/models/admin_business_detail.dart'
    as _iefuveyw;
import 'package:gewerber_backend_client/src/protocol/modules/admin/models/admin_business_page.dart'
    as _iozqqwqx;
import 'package:gewerber_backend_client/src/protocol/modules/admin/models/admin_invoice_page.dart'
    as _iy4ysctt;
import 'package:gewerber_backend_client/src/protocol/modules/admin/models/admin_stats_overview.dart'
    as _ihntwe25;
import 'package:gewerber_backend_client/src/protocol/modules/admin/models/admin_user_dossier.dart'
    as _iefzmp6g;
import 'package:gewerber_backend_client/src/protocol/modules/admin/models/admin_user_summary_page.dart'
    as _ix76f7cm;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/business.dart'
    as _i0hkv0p3;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/business_settings.dart'
    as _iczo4y4i;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/create_business_request.dart'
    as _i9fj2qpm;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/membership.dart'
    as _ix3g4cwq;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/membership_role.dart'
    as _ifttlrdp;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/update_business_request.dart'
    as _i15sv7sl;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/update_business_settings_request.dart'
    as _i0xs9eor;
import 'package:gewerber_backend_client/src/protocol/modules/dashboard/models/dashboard_summary.dart'
    as _i4pjqjso;
import 'package:gewerber_backend_client/src/protocol/modules/documents/models/document.dart'
    as _i6dacf8x;
import 'package:gewerber_backend_client/src/protocol/modules/documents/models/document_kind.dart'
    as _iraft39b;
import 'package:gewerber_backend_client/src/protocol/modules/documents/models/upload_document_request.dart'
    as _ip7l1hs3;
import 'package:gewerber_backend_client/src/protocol/modules/guidance/models/checklist_definition.dart'
    as _iijoyams;
import 'package:gewerber_backend_client/src/protocol/modules/guidance/models/guidance_tip.dart'
    as _in4e0h8b;
import 'package:gewerber_backend_client/src/protocol/modules/guidance/models/user_guidance_progress.dart'
    as _i965vnjh;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/create_customer_request.dart'
    as _ive2a5q8;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/create_invoice_request.dart'
    as _ibk5pv65;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/create_invoice_template_request.dart'
    as _ijqbp2o4;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/create_recurring_schedule_request.dart'
    as _i298ulq3;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/customer.dart'
    as _inumhip7;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/customer_cursor_page.dart'
    as _ibffosi1;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/customer_list_page.dart'
    as _ih9ylpiu;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/customer_status.dart'
    as _imwu3m17;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice.dart'
    as _ijh06pcp;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice_cursor_page.dart'
    as _io7dgrjq;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice_item.dart'
    as _idltrgge;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice_list_page.dart'
    as _ic90por4;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice_payment_status.dart'
    as _ip6ughmw;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice_status.dart'
    as _i8f7xgzd;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/invoice_template.dart'
    as _ir2z9rpn;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/payment_record.dart'
    as _ivishbgw;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/record_payment_request.dart'
    as _is9y4m2k;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/reminder.dart'
    as _i89d689a;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/update_customer_request.dart'
    as _i24zvgea;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/update_invoice_request.dart'
    as _igq8e9wl;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/update_invoice_template_request.dart'
    as _i3plvypu;
import 'package:gewerber_backend_client/src/protocol/modules/invoicing/models/update_recurring_schedule_request.dart'
    as _i20dbxo9;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/create_project_request.dart'
    as _i101c7e7;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/create_task_request.dart'
    as _ii3x130u;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/create_time_entries_invoice_request.dart'
    as _iogoveqd;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/create_time_entry_request.dart'
    as _iokwn2fp;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/project.dart'
    as _i8k415ln;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/project_status.dart'
    as _i1hq5250;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/start_timer_request.dart'
    as _itx5fhp8;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/task.dart'
    as _ib31j0is;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/task_status.dart'
    as _ib7wqxla;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/time_entry.dart'
    as _iaj8oc9k;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/time_report.dart'
    as _iibh7kuq;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/update_project_request.dart'
    as _i7qhkd8r;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/update_task_request.dart'
    as _i3pvx6a0;
import 'package:gewerber_backend_client/src/protocol/modules/time_tracking/models/update_time_entry_request.dart'
    as _i3pgmtrg;
import 'package:gewerber_backend_client/src/protocol/modules/user/models/my_identity.dart'
    as _ikafidhq;
import 'package:gewerber_backend_client/src/protocol/modules/user/models/update_user_profile_request.dart'
    as _ipnx8g03;
import 'package:gewerber_backend_client/src/protocol/modules/user/models/user_profile.dart'
    as _i4pr0x0j;
import 'package:gewerber_backend_commercial_client/gewerber_backend_commercial_client.dart'
    as _ix6v1tim;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

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
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
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
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
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
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
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
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
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
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
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
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
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
  _ida.Future<void> finishPasswordReset({
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
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
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
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// Base class for global-administration endpoints (`modules/admin`).
///
/// Every method must start with [requireAdmin], which resolves the caller's
/// global role from the `admin_user` allowlist:
/// - `moderator` satisfies read-only calls,
/// - `admin` is required for mutations.
///
/// Mutations must additionally write an `AuditEntry` via [AuditService] with
/// the acting admin as actor.
/// {@category Endpoint}
abstract class EndpointAdmin extends _isc.EndpointRef {
  EndpointAdmin(_isc.EndpointCaller caller) : super(caller);
}

/// {@category Endpoint}
abstract class EndpointBusinessScoped extends _isc.EndpointRef {
  EndpointBusinessScoped(_isc.EndpointCaller caller) : super(caller);
}

/// {@category Endpoint}
class EndpointEntitlement extends EndpointBusinessScoped {
  EndpointEntitlement(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'entitlement';

  _ida.Future<List<_i6zpily8.Feature>> list({int? businessId}) =>
      caller.callServerEndpoint<List<_i6zpily8.Feature>>(
        'entitlement',
        'list',
        {'businessId': businessId},
      );
}

/// {@category Endpoint}
class EndpointAccounting extends EndpointBusinessScoped {
  EndpointAccounting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'accounting';

  /// Records an income or expense transaction.
  _ida.Future<_in4p196h.AccountingTransaction> create(
    _i940ddvz.CreateTransactionRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_in4p196h.AccountingTransaction>(
    'accounting',
    'create',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _ida.Future<_in4p196h.AccountingTransaction> get(
    int transactionId, {
    int? businessId,
  }) => caller.callServerEndpoint<_in4p196h.AccountingTransaction>(
    'accounting',
    'get',
    {
      'transactionId': transactionId,
      'businessId': businessId,
    },
  );

  _ida.Future<_in4p196h.AccountingTransaction> update(
    _ils99x0j.UpdateTransactionRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_in4p196h.AccountingTransaction>(
    'accounting',
    'update',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _ida.Future<List<_in4p196h.AccountingTransaction>> list({
    _i7icww1r.TransactionType? type,
    _ihmhz0vo.TransactionCategory? category,
    DateTime? from,
    DateTime? to,
    int? limit,
    int? offset,
    int? businessId,
  }) => caller.callServerEndpoint<List<_in4p196h.AccountingTransaction>>(
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

  _ida.Future<void> delete(
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
  _ida.Future<_idz9zlsq.ProfitLossReport> profitLoss(
    DateTime from,
    DateTime to, {
    int? businessId,
  }) => caller.callServerEndpoint<_idz9zlsq.ProfitLossReport>(
    'accounting',
    'profitLoss',
    {
      'from': from,
      'to': to,
      'businessId': businessId,
    },
  );

  /// Exports transactions as CSV.
  _ida.Future<String> exportCsv({
    _i7icww1r.TransactionType? type,
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

/// Read access to the audit trail for moderators.
/// {@category Endpoint}
class EndpointAdminAudit extends EndpointAdmin {
  EndpointAdminAudit(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminAudit';

  /// Newest-first audit entries, optionally filtered by acting user, action
  /// (exact match) and lower time bound. Limited pages, no cursor — use
  /// `since` of the oldest returned entry to page further.
  _ida.Future<_i8hgem5u.AdminAuditPage> auditQuery({
    _isc.UuidValue? actorUserId,
    String? action,
    DateTime? since,
    int? limit,
  }) => caller.callServerEndpoint<_i8hgem5u.AdminAuditPage>(
    'adminAudit',
    'auditQuery',
    {
      'actorUserId': actorUserId,
      'action': action,
      'since': since,
      'limit': limit,
    },
  );
}

/// Cross-tenant business and membership administration. Reads are available
/// to moderators; role changes require the `admin` role.
/// {@category Endpoint}
class EndpointAdminBusinesses extends EndpointAdmin {
  EndpointAdminBusinesses(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminBusinesses';

  /// Keyset-paginated business search by name substring.
  _ida.Future<_iozqqwqx.AdminBusinessPage> businessesSearch({
    String? query,
    int? limit,
    String? cursor,
  }) => caller.callServerEndpoint<_iozqqwqx.AdminBusinessPage>(
    'adminBusinesses',
    'businessesSearch',
    {
      'query': query,
      'limit': limit,
      'cursor': cursor,
    },
  );

  /// One business with all of its memberships.
  _ida.Future<_iefuveyw.AdminBusinessDetail> businessesGet(int businessId) =>
      caller.callServerEndpoint<_iefuveyw.AdminBusinessDetail>(
        'adminBusinesses',
        'businessesGet',
        {'businessId': businessId},
      );

  /// Changes the tenant role of a membership. Refuses to demote the last
  /// owner of a business ([ConflictException]).
  _ida.Future<_ix3g4cwq.Membership> membershipsSetRole({
    required int membershipId,
    required _ifttlrdp.MembershipRole role,
    required bool confirm,
  }) => caller.callServerEndpoint<_ix3g4cwq.Membership>(
    'adminBusinesses',
    'membershipsSetRole',
    {
      'membershipId': membershipId,
      'role': role,
      'confirm': confirm,
    },
  );
}

/// Administration of guidance content: read the effective tips (curated
/// in-code content merged with admin overrides), upsert overrides.
/// {@category Endpoint}
class EndpointAdminGuidance extends EndpointAdmin {
  EndpointAdminGuidance(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminGuidance';

  /// The effective tips as users see them in `guidance.tips`.
  _ida.Future<List<_in4e0h8b.GuidanceTip>> guidanceTipsList() =>
      caller.callServerEndpoint<List<_in4e0h8b.GuidanceTip>>(
        'adminGuidance',
        'guidanceTipsList',
        {},
      );

  /// Creates or replaces an admin-managed tip by its unique topic. A topic
  /// that matches a curated tip overrides it; other topics are appended as
  /// new tips.
  _ida.Future<_in4e0h8b.GuidanceTip> guidanceTipUpsert({
    required String topic,
    required String title,
    required String body,
    required bool confirm,
  }) => caller.callServerEndpoint<_in4e0h8b.GuidanceTip>(
    'adminGuidance',
    'guidanceTipUpsert',
    {
      'topic': topic,
      'title': title,
      'body': body,
      'confirm': confirm,
    },
  );
}

/// Cross-tenant invoice reads for support plus admin-side cancellation.
/// {@category Endpoint}
class EndpointAdminInvoices extends EndpointAdmin {
  EndpointAdminInvoices(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminInvoices';

  /// Keyset-paginated invoice list ordered by `issueDate DESC`, optionally
  /// filtered by tenant, status and issue-date range (`from` inclusive,
  /// `to` inclusive).
  _ida.Future<_iy4ysctt.AdminInvoicePage> invoicesList({
    int? businessId,
    _i8f7xgzd.InvoiceStatus? status,
    DateTime? from,
    DateTime? to,
    int? limit,
    String? cursor,
  }) => caller.callServerEndpoint<_iy4ysctt.AdminInvoicePage>(
    'adminInvoices',
    'invoicesList',
    {
      'businessId': businessId,
      'status': status,
      'from': from,
      'to': to,
      'limit': limit,
      'cursor': cursor,
    },
  );

  /// A single invoice across tenants.
  _ida.Future<_ijh06pcp.Invoice> invoicesGet(int invoiceId) =>
      caller.callServerEndpoint<_ijh06pcp.Invoice>(
        'adminInvoices',
        'invoicesGet',
        {'invoiceId': invoiceId},
      );

  /// Cancels an invoice in an open state (`sent`, `partiallyPaid`,
  /// `overdue`). Drafts belong to their owners; paid invoices are immutable
  /// (GoBD) — both are rejected with [ConflictException].
  _ida.Future<_ijh06pcp.Invoice> invoiceCancelAdmin({
    required int invoiceId,
    required String reason,
    required bool confirm,
  }) => caller.callServerEndpoint<_ijh06pcp.Invoice>(
    'adminInvoices',
    'invoiceCancelAdmin',
    {
      'invoiceId': invoiceId,
      'reason': reason,
      'confirm': confirm,
    },
  );
}

/// Platform-wide counters for the admin overview. Moderator and up.
/// {@category Endpoint}
class EndpointAdminStats extends EndpointAdmin {
  EndpointAdminStats(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminStats';

  /// User, business, invoice-status and running-timer counts across all
  /// tenants.
  _ida.Future<_ihntwe25.AdminStatsOverview> statsOverview() =>
      caller.callServerEndpoint<_ihntwe25.AdminStatsOverview>(
        'adminStats',
        'statsOverview',
        {},
      );
}

/// User directory reads and auth-level mutations (ban/unban/verify).
///
/// Reads are available to moderators; mutations require the `admin` role and
/// an explicit `confirm: true`.
/// {@category Endpoint}
class EndpointAdminUsers extends EndpointAdmin {
  EndpointAdminUsers(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'adminUsers';

  /// Keyset-paginated search over all users by email substring.
  _ida.Future<_ix76f7cm.AdminUserSummaryPage> usersSearch({
    String? query,
    int? limit,
    String? cursor,
  }) => caller.callServerEndpoint<_ix76f7cm.AdminUserSummaryPage>(
    'adminUsers',
    'usersSearch',
    {
      'query': query,
      'limit': limit,
      'cursor': cursor,
    },
  );

  /// Full dossier of one user: profile, memberships with business names and
  /// auth status.
  _ida.Future<_iefzmp6g.AdminUserDossier> usersGet(_isc.UuidValue userId) =>
      caller.callServerEndpoint<_iefzmp6g.AdminUserDossier>(
        'adminUsers',
        'usersGet',
        {'userId': userId},
      );

  /// Blocks a user on the authentication level. `reason` is mandatory and
  /// stored in the audit trail; refresh tokens are invalidated immediately.
  /// No user data is deleted.
  _ida.Future<_iefzmp6g.AdminUserDossier> usersBan({
    required _isc.UuidValue userId,
    required String reason,
    required bool confirm,
  }) => caller.callServerEndpoint<_iefzmp6g.AdminUserDossier>(
    'adminUsers',
    'usersBan',
    {
      'userId': userId,
      'reason': reason,
      'confirm': confirm,
    },
  );

  /// Lifts a ban. The user can sign in again; previously deleted refresh
  /// tokens are not restored.
  _ida.Future<_iefzmp6g.AdminUserDossier> usersUnban({
    required _isc.UuidValue userId,
    required bool confirm,
  }) => caller.callServerEndpoint<_iefzmp6g.AdminUserDossier>(
    'adminUsers',
    'usersUnban',
    {
      'userId': userId,
      'confirm': confirm,
    },
  );

  /// Reports the email verification state of a user. Read-only check
  /// (audited as `admin.verifyEmailCheck`): with the Serverpod email IdP an
  /// account only exists once its verification code was confirmed, so there
  /// is no unverified state to flip. Throws [NotFoundException] for users
  /// without any email account.
  _ida.Future<_iq6he93g.AdminAuthStatus> usersVerifyEmail({
    required _isc.UuidValue userId,
  }) => caller.callServerEndpoint<_iq6he93g.AdminAuthStatus>(
    'adminUsers',
    'usersVerifyEmail',
    {'userId': userId},
  );
}

/// {@category Endpoint}
class EndpointBusiness extends EndpointBusinessScoped {
  EndpointBusiness(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'business';

  _ida.Future<_i0hkv0p3.Business> create(
    _i9fj2qpm.CreateBusinessRequest request,
  ) => caller.callServerEndpoint<_i0hkv0p3.Business>(
    'business',
    'create',
    {'request': request},
  );

  _ida.Future<_i0hkv0p3.Business> get({int? businessId}) =>
      caller.callServerEndpoint<_i0hkv0p3.Business>(
        'business',
        'get',
        {'businessId': businessId},
      );

  _ida.Future<_i0hkv0p3.Business> update(
    _i15sv7sl.UpdateBusinessRequest request,
  ) => caller.callServerEndpoint<_i0hkv0p3.Business>(
    'business',
    'update',
    {'request': request},
  );

  _ida.Future<List<_i0hkv0p3.Business>> listMine() =>
      caller.callServerEndpoint<List<_i0hkv0p3.Business>>(
        'business',
        'listMine',
        {},
      );
}

/// {@category Endpoint}
class EndpointBusinessSettings extends EndpointBusinessScoped {
  EndpointBusinessSettings(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'businessSettings';

  _ida.Future<_iczo4y4i.BusinessSettings> get({int? businessId}) =>
      caller.callServerEndpoint<_iczo4y4i.BusinessSettings>(
        'businessSettings',
        'get',
        {'businessId': businessId},
      );

  _ida.Future<_iczo4y4i.BusinessSettings> update(
    _i0xs9eor.UpdateBusinessSettingsRequest request,
  ) => caller.callServerEndpoint<_iczo4y4i.BusinessSettings>(
    'businessSettings',
    'update',
    {'request': request},
  );
}

/// {@category Endpoint}
class EndpointDashboard extends EndpointBusinessScoped {
  EndpointDashboard(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dashboard';

  /// Aggregated dashboard summary of the tenant: current-month KPIs, monthly
  /// trend, recent activity feeds and open receivables. All list sizes are
  /// clamped server-side; [asOf] anchors every window (tests only).
  _ida.Future<_i4pjqjso.DashboardSummary> getSummary({
    int? trendMonths,
    int? recentLimit,
    int? overdueLimit,
    int? debtorLimit,
    DateTime? asOf,
    int? businessId,
  }) => caller.callServerEndpoint<_i4pjqjso.DashboardSummary>(
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
  EndpointDocument(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'document';

  _ida.Future<_i6dacf8x.Document> upload(
    _ip7l1hs3.UploadDocumentRequest request,
  ) => caller.callServerEndpoint<_i6dacf8x.Document>(
    'document',
    'upload',
    {'request': request},
  );

  _ida.Future<List<_i6dacf8x.Document>> list({
    int? businessId,
    _iraft39b.DocumentKind? kind,
    String? relatedEntityType,
    String? relatedEntityId,
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<List<_i6dacf8x.Document>>(
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

  _ida.Future<_i6dacf8x.Document> get(int documentId) =>
      caller.callServerEndpoint<_i6dacf8x.Document>(
        'document',
        'get',
        {'documentId': documentId},
      );

  _ida.Future<_idt.ByteData> download(int documentId) =>
      caller.callServerEndpoint<_idt.ByteData>(
        'document',
        'download',
        {'documentId': documentId},
      );

  _ida.Future<void> delete(int documentId) => caller.callServerEndpoint<void>(
    'document',
    'delete',
    {'documentId': documentId},
  );
}

/// Serves curated guidance content (tooltips, checklists, "What is this?"
/// popups) and tracks per-user progress. User-scoped, requires login.
/// {@category Endpoint}
class EndpointGuidance extends _isc.EndpointRef {
  EndpointGuidance(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'guidance';

  /// All contextual tooltips: curated in-code content with admin-managed
  /// overrides applied (see `adminGuidance.guidanceTipUpsert`).
  _ida.Future<List<_in4e0h8b.GuidanceTip>> tips() =>
      caller.callServerEndpoint<List<_in4e0h8b.GuidanceTip>>(
        'guidance',
        'tips',
        {},
      );

  /// All checklists with their items.
  _ida.Future<List<_iijoyams.ChecklistDefinition>> checklists() =>
      caller.callServerEndpoint<List<_iijoyams.ChecklistDefinition>>(
        'guidance',
        'checklists',
        {},
      );

  /// The signed-in user's progress (completed/dismissed items).
  _ida.Future<List<_i965vnjh.UserGuidanceProgress>> myProgress() =>
      caller.callServerEndpoint<List<_i965vnjh.UserGuidanceProgress>>(
        'guidance',
        'myProgress',
        {},
      );

  /// Marks a checklist item (or any guidance item key) as completed.
  _ida.Future<_i965vnjh.UserGuidanceProgress> markCompleted(String itemKey) =>
      caller.callServerEndpoint<_i965vnjh.UserGuidanceProgress>(
        'guidance',
        'markCompleted',
        {'itemKey': itemKey},
      );

  /// Dismisses a tooltip so it is not shown again.
  _ida.Future<_i965vnjh.UserGuidanceProgress> dismissTip(String topic) =>
      caller.callServerEndpoint<_i965vnjh.UserGuidanceProgress>(
        'guidance',
        'dismissTip',
        {'topic': topic},
      );
}

/// {@category Endpoint}
class EndpointCustomer extends EndpointBusinessScoped {
  EndpointCustomer(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'customer';

  _ida.Future<_inumhip7.Customer> create(
    _ive2a5q8.CreateCustomerRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_inumhip7.Customer>(
    'customer',
    'create',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _ida.Future<_inumhip7.Customer> get(
    int customerId, {
    int? businessId,
  }) => caller.callServerEndpoint<_inumhip7.Customer>(
    'customer',
    'get',
    {
      'customerId': customerId,
      'businessId': businessId,
    },
  );

  _ida.Future<_inumhip7.Customer> update(
    _i24zvgea.UpdateCustomerRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_inumhip7.Customer>(
    'customer',
    'update',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _ida.Future<List<_inumhip7.Customer>> list({
    _imwu3m17.CustomerStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) => caller.callServerEndpoint<List<_inumhip7.Customer>>(
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
  _ida.Future<_ih9ylpiu.CustomerListPage> listPage({
    _imwu3m17.CustomerStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) => caller.callServerEndpoint<_ih9ylpiu.CustomerListPage>(
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
  _ida.Future<_ibffosi1.CustomerCursorPage> listCursorPage({
    _imwu3m17.CustomerStatus? status,
    int? limit,
    String? cursor,
    int? businessId,
  }) => caller.callServerEndpoint<_ibffosi1.CustomerCursorPage>(
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
  EndpointInvoice(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'invoice';

  _ida.Future<_ijh06pcp.Invoice> create(
    _ibk5pv65.CreateInvoiceRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_ijh06pcp.Invoice>(
    'invoice',
    'create',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _ida.Future<_ijh06pcp.Invoice> get(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<_ijh06pcp.Invoice>(
    'invoice',
    'get',
    {
      'invoiceId': invoiceId,
      'businessId': businessId,
    },
  );

  _ida.Future<List<_idltrgge.InvoiceItem>> getItems(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<List<_idltrgge.InvoiceItem>>(
    'invoice',
    'getItems',
    {
      'invoiceId': invoiceId,
      'businessId': businessId,
    },
  );

  _ida.Future<_ijh06pcp.Invoice> update(
    _igq8e9wl.UpdateInvoiceRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_ijh06pcp.Invoice>(
    'invoice',
    'update',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _ida.Future<List<_ijh06pcp.Invoice>> list({
    _i8f7xgzd.InvoiceStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) => caller.callServerEndpoint<List<_ijh06pcp.Invoice>>(
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
  _ida.Future<_ic90por4.InvoiceListPage> listPage({
    _i8f7xgzd.InvoiceStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) => caller.callServerEndpoint<_ic90por4.InvoiceListPage>(
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
  _ida.Future<_io7dgrjq.InvoiceCursorPage> listCursorPage({
    _i8f7xgzd.InvoiceStatus? status,
    int? limit,
    String? cursor,
    int? businessId,
  }) => caller.callServerEndpoint<_io7dgrjq.InvoiceCursorPage>(
    'invoice',
    'listCursorPage',
    {
      'status': status,
      'limit': limit,
      'cursor': cursor,
      'businessId': businessId,
    },
  );

  _ida.Future<void> delete(
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
  _ida.Future<_ijh06pcp.Invoice> markSent(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<_ijh06pcp.Invoice>(
    'invoice',
    'markSent',
    {
      'invoiceId': invoiceId,
      'businessId': businessId,
    },
  );

  /// Cancels an invoice that is not paid or already cancelled.
  _ida.Future<_ijh06pcp.Invoice> cancel(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<_ijh06pcp.Invoice>(
    'invoice',
    'cancel',
    {
      'invoiceId': invoiceId,
      'businessId': businessId,
    },
  );

  /// Exports invoices as CSV (semicolon-separated, comma decimals).
  _ida.Future<String> exportCsv({
    _i8f7xgzd.InvoiceStatus? status,
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
  _ida.Future<String> exportJson({
    _i8f7xgzd.InvoiceStatus? status,
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
  _ida.Future<_i6dacf8x.Document> generatePdf(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<_i6dacf8x.Document>(
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
  EndpointInvoiceTemplate(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'invoiceTemplate';

  _ida.Future<_ir2z9rpn.InvoiceTemplate> create(
    _ijqbp2o4.CreateInvoiceTemplateRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_ir2z9rpn.InvoiceTemplate>(
    'invoiceTemplate',
    'create',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _ida.Future<_ir2z9rpn.InvoiceTemplate> get(
    int templateId, {
    int? businessId,
  }) => caller.callServerEndpoint<_ir2z9rpn.InvoiceTemplate>(
    'invoiceTemplate',
    'get',
    {
      'templateId': templateId,
      'businessId': businessId,
    },
  );

  _ida.Future<_ir2z9rpn.InvoiceTemplate> update(
    _i3plvypu.UpdateInvoiceTemplateRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_ir2z9rpn.InvoiceTemplate>(
    'invoiceTemplate',
    'update',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _ida.Future<List<_ir2z9rpn.InvoiceTemplate>> list({
    int? businessId,
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<List<_ir2z9rpn.InvoiceTemplate>>(
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
  EndpointPayment(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'payment';

  _ida.Future<_ivishbgw.PaymentRecord> record(
    _is9y4m2k.RecordPaymentRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_ivishbgw.PaymentRecord>(
    'payment',
    'record',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _ida.Future<_ip6ughmw.InvoicePaymentStatus> status(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<_ip6ughmw.InvoicePaymentStatus>(
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
  EndpointRecurringSchedule(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'recurringSchedule';

  /// Attaches a recurring schedule to an invoice. The next issue date is
  /// recalculated from the invoice's issue date when not given explicitly.
  _ida.Future<_ijh06pcp.Invoice> create(
    _i298ulq3.CreateRecurringScheduleRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_ijh06pcp.Invoice>(
    'recurringSchedule',
    'create',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  /// Returns the schedule (i.e. its source invoice) or `NotFoundException`
  /// when it does not exist.
  _ida.Future<_ijh06pcp.Invoice> get(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<_ijh06pcp.Invoice>(
    'recurringSchedule',
    'get',
    {
      'invoiceId': invoiceId,
      'businessId': businessId,
    },
  );

  /// Lists all schedules of the tenant, upcoming next issue first.
  _ida.Future<List<_ijh06pcp.Invoice>> list({
    int? limit,
    int? offset,
    int? businessId,
  }) => caller.callServerEndpoint<List<_ijh06pcp.Invoice>>(
    'recurringSchedule',
    'list',
    {
      'limit': limit,
      'offset': offset,
      'businessId': businessId,
    },
  );

  /// Updates schedule settings (`null` fields keep their current value).
  _ida.Future<_ijh06pcp.Invoice> update(
    _i20dbxo9.UpdateRecurringScheduleRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_ijh06pcp.Invoice>(
    'recurringSchedule',
    'update',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  /// Cancels the schedule; already materialized invoices are kept.
  _ida.Future<_ijh06pcp.Invoice> cancel(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<_ijh06pcp.Invoice>(
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
  EndpointReminder(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'reminder';

  /// Lists all reminders sent for the invoice, ordered by send date.
  _ida.Future<List<_i89d689a.Reminder>> list(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<List<_i89d689a.Reminder>>(
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
  _ida.Future<_i89d689a.Reminder> send(
    int invoiceId, {
    int? businessId,
  }) => caller.callServerEndpoint<_i89d689a.Reminder>(
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
  EndpointProject(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'project';

  _ida.Future<_i8k415ln.Project> create(
    _i101c7e7.CreateProjectRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i8k415ln.Project>(
    'project',
    'create',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _ida.Future<_i8k415ln.Project> get(
    int projectId, {
    int? businessId,
  }) => caller.callServerEndpoint<_i8k415ln.Project>(
    'project',
    'get',
    {
      'projectId': projectId,
      'businessId': businessId,
    },
  );

  _ida.Future<List<_ib31j0is.Task>> getTasks(
    int projectId, {
    int? businessId,
  }) => caller.callServerEndpoint<List<_ib31j0is.Task>>(
    'project',
    'getTasks',
    {
      'projectId': projectId,
      'businessId': businessId,
    },
  );

  _ida.Future<_i8k415ln.Project> update(
    _i7qhkd8r.UpdateProjectRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_i8k415ln.Project>(
    'project',
    'update',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _ida.Future<List<_i8k415ln.Project>> list({
    _i1hq5250.ProjectStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) => caller.callServerEndpoint<List<_i8k415ln.Project>>(
    'project',
    'list',
    {
      'status': status,
      'limit': limit,
      'offset': offset,
      'businessId': businessId,
    },
  );

  _ida.Future<void> delete(
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
  EndpointTask(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'task';

  _ida.Future<_ib31j0is.Task> create(
    _ii3x130u.CreateTaskRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_ib31j0is.Task>(
    'task',
    'create',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _ida.Future<_ib31j0is.Task> update(
    _i3pvx6a0.UpdateTaskRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_ib31j0is.Task>(
    'task',
    'update',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _ida.Future<List<_ib31j0is.Task>> list({
    int? projectId,
    _ib7wqxla.TaskStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) => caller.callServerEndpoint<List<_ib31j0is.Task>>(
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
  EndpointTimeEntry(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'timeEntry';

  /// Starts a timer. Only one timer may run per business.
  _ida.Future<_iaj8oc9k.TimeEntry> startTimer(
    _itx5fhp8.StartTimerRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_iaj8oc9k.TimeEntry>(
    'timeEntry',
    'startTimer',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  /// Stops the running timer and stores the (rounded) duration.
  _ida.Future<_iaj8oc9k.TimeEntry> stopTimer({int? businessId}) =>
      caller.callServerEndpoint<_iaj8oc9k.TimeEntry>(
        'timeEntry',
        'stopTimer',
        {'businessId': businessId},
      );

  /// Creates a manual time entry.
  _ida.Future<_iaj8oc9k.TimeEntry> create(
    _iokwn2fp.CreateTimeEntryRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_iaj8oc9k.TimeEntry>(
    'timeEntry',
    'create',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _ida.Future<_iaj8oc9k.TimeEntry> get(
    int timeEntryId, {
    int? businessId,
  }) => caller.callServerEndpoint<_iaj8oc9k.TimeEntry>(
    'timeEntry',
    'get',
    {
      'timeEntryId': timeEntryId,
      'businessId': businessId,
    },
  );

  _ida.Future<_iaj8oc9k.TimeEntry> update(
    _i3pgmtrg.UpdateTimeEntryRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_iaj8oc9k.TimeEntry>(
    'timeEntry',
    'update',
    {
      'request': request,
      'businessId': businessId,
    },
  );

  _ida.Future<List<_iaj8oc9k.TimeEntry>> list({
    int? projectId,
    int? taskId,
    DateTime? from,
    DateTime? to,
    bool? billable,
    int? limit,
    int? offset,
    int? businessId,
  }) => caller.callServerEndpoint<List<_iaj8oc9k.TimeEntry>>(
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

  _ida.Future<void> delete(
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
  _ida.Future<_iibh7kuq.TimeReport> report(
    DateTime from,
    DateTime to, {
    int? projectId,
    int? businessId,
  }) => caller.callServerEndpoint<_iibh7kuq.TimeReport>(
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
  _ida.Future<_ijh06pcp.Invoice> createInvoice(
    _iogoveqd.CreateTimeEntriesInvoiceRequest request, {
    int? businessId,
  }) => caller.callServerEndpoint<_ijh06pcp.Invoice>(
    'timeEntry',
    'createInvoice',
    {
      'request': request,
      'businessId': businessId,
    },
  );
}

/// {@category Endpoint}
class EndpointUserProfile extends _isc.EndpointRef {
  EndpointUserProfile(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'userProfile';

  _ida.Future<_i4pr0x0j.UserProfile> getMyProfile() =>
      caller.callServerEndpoint<_i4pr0x0j.UserProfile>(
        'userProfile',
        'getMyProfile',
        {},
      );

  /// Describes the authenticated caller's own identity: the global platform
  /// admin role (if any, from the `admin_user` allowlist) and all business
  /// memberships with business names, ordered by ascending `businessId`.
  /// Clients use this to discover what they can access — notably the MCP
  /// integration tooling opened up to regular users. Only the caller's own
  /// data is read.
  _ida.Future<_ikafidhq.MyIdentity> me() =>
      caller.callServerEndpoint<_ikafidhq.MyIdentity>(
        'userProfile',
        'me',
        {},
      );

  _ida.Future<_i4pr0x0j.UserProfile> update(
    _ipnx8g03.UpdateUserProfileRequest request,
  ) => caller.callServerEndpoint<_i4pr0x0j.UserProfile>(
    'userProfile',
    'update',
    {'request': request},
  );

  /// Soft-deletes the account of the logged-in user (GDPR Art. 17): sets a
  /// `deletedAt` marker and severs all personal links in retained business
  /// data (GoBD retention). Repeating the call throws [NotFoundException].
  _ida.Future<void> deleteMyAccount() => caller.callServerEndpoint<void>(
    'userProfile',
    'deleteMyAccount',
    {},
  );

  /// Exports all data of the logged-in user as a ZIP archive (GDPR Art. 20):
  /// profile, memberships, guidance progress and every business the user is
  /// a member of with its customers, invoices (+items), projects, tasks,
  /// time entries, transactions and documents. Foreign tenants are not
  /// included.
  _ida.Future<_idt.ByteData> exportMyData() =>
      caller.callServerEndpoint<_idt.ByteData>(
        'userProfile',
        'exportMyData',
        {},
      );
}

class Modules {
  Modules(Client client) {
    commercial = _ix6v1tim.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
    serverpod_auth_idp = _iaic.Caller(client);
  }

  late final _ix6v1tim.Caller commercial;

  late final _iacc.Caller serverpod_auth_core;

  late final _iaic.Caller serverpod_auth_idp;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
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
    adminAudit = EndpointAdminAudit(this);
    adminBusinesses = EndpointAdminBusinesses(this);
    adminGuidance = EndpointAdminGuidance(this);
    adminInvoices = EndpointAdminInvoices(this);
    adminStats = EndpointAdminStats(this);
    adminUsers = EndpointAdminUsers(this);
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

  late final EndpointAdminAudit adminAudit;

  late final EndpointAdminBusinesses adminBusinesses;

  late final EndpointAdminGuidance adminGuidance;

  late final EndpointAdminInvoices adminInvoices;

  late final EndpointAdminStats adminStats;

  late final EndpointAdminUsers adminUsers;

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
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'entitlement': entitlement,
    'accounting': accounting,
    'adminAudit': adminAudit,
    'adminBusinesses': adminBusinesses,
    'adminGuidance': adminGuidance,
    'adminInvoices': adminInvoices,
    'adminStats': adminStats,
    'adminUsers': adminUsers,
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
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'commercial': modules.commercial,
    'serverpod_auth_core': modules.serverpod_auth_core,
    'serverpod_auth_idp': modules.serverpod_auth_idp,
  };
}
