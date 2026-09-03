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
// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async' as _ida;
import 'dart:io' as _idi;
import 'dart:typed_data' as _idt;
import 'package:gewerber_backend_server/src/generated/core/entitlement/feature.dart'
    as _ipb0z0gh;
import 'package:gewerber_backend_server/src/generated/future_calls.dart'
    as _i89u7n74;
import 'package:gewerber_backend_server/src/generated/modules/accounting/models/accounting_transaction.dart'
    as _ipjpfe96;
import 'package:gewerber_backend_server/src/generated/modules/accounting/models/create_transaction_request.dart'
    as _id2yvtsq;
import 'package:gewerber_backend_server/src/generated/modules/accounting/models/profit_loss_report.dart'
    as _ib57s6cq;
import 'package:gewerber_backend_server/src/generated/modules/accounting/models/transaction_category.dart'
    as _ivko09ij;
import 'package:gewerber_backend_server/src/generated/modules/accounting/models/transaction_type.dart'
    as _ii6adw80;
import 'package:gewerber_backend_server/src/generated/modules/accounting/models/update_transaction_request.dart'
    as _i5w1zupa;
import 'package:gewerber_backend_server/src/generated/modules/admin/models/admin_audit_page.dart'
    as _i4bjlxcf;
import 'package:gewerber_backend_server/src/generated/modules/admin/models/admin_auth_status.dart'
    as _iww85ue5;
import 'package:gewerber_backend_server/src/generated/modules/admin/models/admin_business_detail.dart'
    as _ijhbovo3;
import 'package:gewerber_backend_server/src/generated/modules/admin/models/admin_business_page.dart'
    as _i5grpjbb;
import 'package:gewerber_backend_server/src/generated/modules/admin/models/admin_invoice_page.dart'
    as _ijfc5yz9;
import 'package:gewerber_backend_server/src/generated/modules/admin/models/admin_stats_overview.dart'
    as _inru05c1;
import 'package:gewerber_backend_server/src/generated/modules/admin/models/admin_user_dossier.dart'
    as _ip9x0wyj;
import 'package:gewerber_backend_server/src/generated/modules/admin/models/admin_user_summary_page.dart'
    as _ia9j7kdo;
import 'package:gewerber_backend_server/src/generated/modules/business/models/business.dart'
    as _ipdla2qi;
import 'package:gewerber_backend_server/src/generated/modules/business/models/business_settings.dart'
    as _i995dlnj;
import 'package:gewerber_backend_server/src/generated/modules/business/models/create_business_request.dart'
    as _isstucd6;
import 'package:gewerber_backend_server/src/generated/modules/business/models/membership.dart'
    as _iteipox3;
import 'package:gewerber_backend_server/src/generated/modules/business/models/membership_role.dart'
    as _iwrkm0s7;
import 'package:gewerber_backend_server/src/generated/modules/business/models/update_business_request.dart'
    as _i6z7gqqp;
import 'package:gewerber_backend_server/src/generated/modules/business/models/update_business_settings_request.dart'
    as _ifzr12w9;
import 'package:gewerber_backend_server/src/generated/modules/dashboard/models/dashboard_summary.dart'
    as _ijw2fkaq;
import 'package:gewerber_backend_server/src/generated/modules/documents/models/document.dart'
    as _inbg4lrm;
import 'package:gewerber_backend_server/src/generated/modules/documents/models/document_kind.dart'
    as _ihaxsvej;
import 'package:gewerber_backend_server/src/generated/modules/documents/models/upload_document_request.dart'
    as _i2nxphic;
import 'package:gewerber_backend_server/src/generated/modules/guidance/models/checklist_definition.dart'
    as _i3jq3nn0;
import 'package:gewerber_backend_server/src/generated/modules/guidance/models/guidance_tip.dart'
    as _imqtlho5;
import 'package:gewerber_backend_server/src/generated/modules/guidance/models/user_guidance_progress.dart'
    as _ivw4ui03;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/create_customer_request.dart'
    as _i94n0ggq;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/create_invoice_request.dart'
    as _iz85641j;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/create_invoice_template_request.dart'
    as _ixky5b07;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/create_recurring_schedule_request.dart'
    as _iw4avqfy;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/customer.dart'
    as _i120uj2v;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/customer_cursor_page.dart'
    as _ihlvaant;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/customer_list_page.dart'
    as _i9jnoo25;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/customer_status.dart'
    as _it20r4b4;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/invoice.dart'
    as _icjfst50;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/invoice_cursor_page.dart'
    as _ie6jh68g;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/invoice_item.dart'
    as _i6zkktsi;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/invoice_list_page.dart'
    as _ia86lvmn;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/invoice_payment_status.dart'
    as _iz9w9j8i;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/invoice_status.dart'
    as _ipvtulo1;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/invoice_template.dart'
    as _ier3zpp5;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/payment_record.dart'
    as _i20s50p9;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/record_payment_request.dart'
    as _im2k94rf;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/reminder.dart'
    as _ilvs17xw;
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
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/project.dart'
    as _ido2dfrq;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/project_status.dart'
    as _isvak9w2;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/start_timer_request.dart'
    as _igg0g889;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/task.dart'
    as _icr6zs8m;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/task_status.dart'
    as _ieegmn8f;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/time_entry.dart'
    as _ict1xti5;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/time_report.dart'
    as _iudgjxd4;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/update_project_request.dart'
    as _ihd38d9q;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/update_task_request.dart'
    as _izsek7q6;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/update_time_entry_request.dart'
    as _in9wv2h5;
import 'package:gewerber_backend_server/src/generated/modules/user/models/my_identity.dart'
    as _i3ypcelp;
import 'package:gewerber_backend_server/src/generated/modules/user/models/update_user_profile_request.dart'
    as _ijhnvzba;
import 'package:gewerber_backend_server/src/generated/modules/user/models/user_profile.dart'
    as _iev352gu;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_test/serverpod_test.dart' as _ist;
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/generated/endpoints.dart';
export 'package:serverpod_test/serverpod_test_public_exports.dart';

/// Creates a new test group that takes a callback that can be used to write tests.
/// The callback has two parameters: `sessionBuilder` and `endpoints`.
/// `sessionBuilder` is used to build a `Session` object that represents the server state during an endpoint call and is used to set up scenarios.
/// `endpoints` contains all your Serverpod endpoints and lets you call them:
/// ```dart
/// withServerpod('Given Example endpoint', (sessionBuilder, endpoints) {
///   test('when calling `hello` then should return greeting', () async {
///     final greeting = await endpoints.example.hello(sessionBuilder, 'Michael');
///     expect(greeting, 'Hello Michael');
///   });
/// });
/// ```
///
/// **Configuration options**
///
/// [applyMigrations] Whether pending migrations should be applied when starting Serverpod. Defaults to `true`
///
/// [enableSessionLogging] Whether session logging should be enabled. Defaults to `false`
///
/// [rollbackDatabase] Options for when to rollback the database during the test lifecycle.
/// By default `withServerpod` does all database operations inside a transaction that is rolled back after each `test` case.
/// Just like the following enum describes, the behavior of the automatic rollbacks can be configured:
/// ```dart
/// /// Options for when to rollback the database during the test lifecycle.
/// enum RollbackDatabase {
///   /// After each test. This is the default.
///   afterEach,
///
///   /// After all tests.
///   afterAll,
///
///   /// Disable rolling back the database.
///   disabled,
/// }
/// ```
///
/// [runMode] The run mode that Serverpod should be running in. Defaults to `test`.
///
/// [serverpodLoggingMode] The logging mode used when creating Serverpod. Defaults to `ServerpodLoggingMode.normal`
///
/// [serverpodStartTimeout] The timeout to use when starting Serverpod, which connects to the database among other things. Defaults to `Duration(seconds: 120)`.
///
/// [testServerOutputMode] Options for controlling test server output during test execution. Defaults to `TestServerOutputMode.normal`.
/// ```dart
/// /// Options for controlling test server output during test execution.
/// enum TestServerOutputMode {
///   /// Default mode - only stderr is printed (stdout suppressed).
///   /// This hides normal startup/shutdown logs while preserving error messages.
///   normal,
///
///   /// All logging - both stdout and stderr are printed.
///   /// Useful for debugging when you need to see all server output.
///   verbose,
///
///   /// No logging - both stdout and stderr are suppressed.
///   /// Completely silent mode, useful when you don't want any server output.
///   silent,
/// }
/// ```
///
/// [configOverride] A function to override the server configuration. This function is called with
/// the default server configuration after it is loaded from the config/ directory
/// and before it is used to start the server. Use this to override particular
/// settings in the server configuration.
///
/// [databaseInterceptor] Optional interceptor that replaces the default database for each session.
/// See [Serverpod.databaseInterceptor] for more information.
///
/// [testGroupTagsOverride] By default Serverpod test tools tags the `withServerpod` test group with `"integration"`.
/// This is to provide a simple way to only run unit or integration tests.
/// This property allows this tag to be overridden to something else. Defaults to `['integration']`.
///
/// [experimentalFeatures] Optionally specify experimental features. See [Serverpod] for more information.
///
/// [serverDirectory] The server package directory `config/<runMode>.yaml`, `config/passwords.yaml`,
/// and `migrations/<module>/...` are resolved against. Defaults to
/// [Directory.current] at the time the test boots. Pass this when the test
/// isolate's cwd is not the server package root (e.g. running tests from a
/// workspace parent directory) so config and migrations are still loaded
/// from the right place.
@_ist.isTestGroup
void withServerpod(
  String testGroupName,
  _ist.TestClosure<TestEndpoints> testClosure, {
  bool? applyMigrations,
  _is.ServerpodConfig Function(_is.ServerpodConfig)? configOverride,
  _is.DatabaseInterceptor? databaseInterceptor,
  bool? enableSessionLogging,
  _is.ExperimentalFeatures? experimentalFeatures,
  _ist.RollbackDatabase? rollbackDatabase,
  String? runMode,
  _is.RuntimeParametersListBuilder? runtimeParametersBuilder,
  _idi.Directory? serverDirectory,
  _is.ServerpodLoggingMode? serverpodLoggingMode,
  Duration? serverpodStartTimeout,
  List<String>? testGroupTagsOverride,
  _ist.TestServerOutputMode? testServerOutputMode,
}) {
  _ist.buildWithServerpod<_InternalTestEndpoints>(
    testGroupName,
    _ist.TestServerpod(
      testEndpoints: _InternalTestEndpoints(),
      endpoints: Endpoints(),
      serializationManager: Protocol(),
      runMode: runMode,
      applyMigrations: applyMigrations,
      isDatabaseEnabled: true,
      serverpodLoggingMode: serverpodLoggingMode,
      testServerOutputMode: testServerOutputMode,
      serverDirectory: serverDirectory,
      experimentalFeatures: experimentalFeatures,
      configOverride: configOverride,
      runtimeParametersBuilder: runtimeParametersBuilder,
      databaseInterceptor: databaseInterceptor,
    ),
    maybeRollbackDatabase: rollbackDatabase,
    maybeEnableSessionLogging: enableSessionLogging,
    maybeTestGroupTagsOverride: testGroupTagsOverride,
    maybeServerpodStartTimeout: serverpodStartTimeout,
    maybeTestServerOutputMode: testServerOutputMode,
  )(testClosure);
}

class TestEndpoints {
  late final futureCalls = _FutureCalls();

  late final _EmailIdpEndpoint emailIdp;

  late final _JwtRefreshEndpoint jwtRefresh;

  late final _EntitlementEndpoint entitlement;

  late final _AccountingEndpoint accounting;

  late final _AdminAuditEndpoint adminAudit;

  late final _AdminBusinessesEndpoint adminBusinesses;

  late final _AdminGuidanceEndpoint adminGuidance;

  late final _AdminInvoicesEndpoint adminInvoices;

  late final _AdminStatsEndpoint adminStats;

  late final _AdminUsersEndpoint adminUsers;

  late final _BusinessEndpoint business;

  late final _BusinessSettingsEndpoint businessSettings;

  late final _DashboardEndpoint dashboard;

  late final _DocumentEndpoint document;

  late final _GuidanceEndpoint guidance;

  late final _CustomerEndpoint customer;

  late final _InvoiceEndpoint invoice;

  late final _InvoiceTemplateEndpoint invoiceTemplate;

  late final _PaymentEndpoint payment;

  late final _RecurringScheduleEndpoint recurringSchedule;

  late final _ReminderEndpoint reminder;

  late final _ProjectEndpoint project;

  late final _TaskEndpoint task;

  late final _TimeEntryEndpoint timeEntry;

  late final _UserProfileEndpoint userProfile;
}

class _InternalTestEndpoints extends TestEndpoints
    implements _ist.InternalTestEndpoints {
  @override
  void initialize(
    _is.SerializationManager serializationManager,
    _is.EndpointDispatch endpoints,
  ) {
    emailIdp = _EmailIdpEndpoint(
      endpoints,
      serializationManager,
    );
    jwtRefresh = _JwtRefreshEndpoint(
      endpoints,
      serializationManager,
    );
    entitlement = _EntitlementEndpoint(
      endpoints,
      serializationManager,
    );
    accounting = _AccountingEndpoint(
      endpoints,
      serializationManager,
    );
    adminAudit = _AdminAuditEndpoint(
      endpoints,
      serializationManager,
    );
    adminBusinesses = _AdminBusinessesEndpoint(
      endpoints,
      serializationManager,
    );
    adminGuidance = _AdminGuidanceEndpoint(
      endpoints,
      serializationManager,
    );
    adminInvoices = _AdminInvoicesEndpoint(
      endpoints,
      serializationManager,
    );
    adminStats = _AdminStatsEndpoint(
      endpoints,
      serializationManager,
    );
    adminUsers = _AdminUsersEndpoint(
      endpoints,
      serializationManager,
    );
    business = _BusinessEndpoint(
      endpoints,
      serializationManager,
    );
    businessSettings = _BusinessSettingsEndpoint(
      endpoints,
      serializationManager,
    );
    dashboard = _DashboardEndpoint(
      endpoints,
      serializationManager,
    );
    document = _DocumentEndpoint(
      endpoints,
      serializationManager,
    );
    guidance = _GuidanceEndpoint(
      endpoints,
      serializationManager,
    );
    customer = _CustomerEndpoint(
      endpoints,
      serializationManager,
    );
    invoice = _InvoiceEndpoint(
      endpoints,
      serializationManager,
    );
    invoiceTemplate = _InvoiceTemplateEndpoint(
      endpoints,
      serializationManager,
    );
    payment = _PaymentEndpoint(
      endpoints,
      serializationManager,
    );
    recurringSchedule = _RecurringScheduleEndpoint(
      endpoints,
      serializationManager,
    );
    reminder = _ReminderEndpoint(
      endpoints,
      serializationManager,
    );
    project = _ProjectEndpoint(
      endpoints,
      serializationManager,
    );
    task = _TaskEndpoint(
      endpoints,
      serializationManager,
    );
    timeEntry = _TimeEntryEndpoint(
      endpoints,
      serializationManager,
    );
    userProfile = _UserProfileEndpoint(
      endpoints,
      serializationManager,
    );
  }
}

class _FutureCalls {
  late final markOverdueInvoices = _MarkOverdueInvoicesFutureCall();

  late final processRecurringInvoices = _ProcessRecurringInvoicesFutureCall();
}

class _EmailIdpEndpoint {
  _EmailIdpEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_iacs.AuthSuccess> login(
    _ist.TestSessionBuilder sessionBuilder, {
    required String email,
    required String password,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'login',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'login',
          parameters: _ist.testObjectToJson({
            'email': email,
            'password': password,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iacs.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_is.UuidValue> startRegistration(
    _ist.TestSessionBuilder sessionBuilder, {
    required String email,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'startRegistration',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'startRegistration',
          parameters: _ist.testObjectToJson({'email': email}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_is.UuidValue>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<String> verifyRegistrationCode(
    _ist.TestSessionBuilder sessionBuilder, {
    required _is.UuidValue accountRequestId,
    required String verificationCode,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'verifyRegistrationCode',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'verifyRegistrationCode',
          parameters: _ist.testObjectToJson({
            'accountRequestId': accountRequestId,
            'verificationCode': verificationCode,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iacs.AuthSuccess> finishRegistration(
    _ist.TestSessionBuilder sessionBuilder, {
    required String registrationToken,
    required String password,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'finishRegistration',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'finishRegistration',
          parameters: _ist.testObjectToJson({
            'registrationToken': registrationToken,
            'password': password,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iacs.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_is.UuidValue> startPasswordReset(
    _ist.TestSessionBuilder sessionBuilder, {
    required String email,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'startPasswordReset',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'startPasswordReset',
          parameters: _ist.testObjectToJson({'email': email}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_is.UuidValue>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<String> verifyPasswordResetCode(
    _ist.TestSessionBuilder sessionBuilder, {
    required _is.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'verifyPasswordResetCode',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'verifyPasswordResetCode',
          parameters: _ist.testObjectToJson({
            'passwordResetRequestId': passwordResetRequestId,
            'verificationCode': verificationCode,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<void> finishPasswordReset(
    _ist.TestSessionBuilder sessionBuilder, {
    required String finishPasswordResetToken,
    required String newPassword,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'finishPasswordReset',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'finishPasswordReset',
          parameters: _ist.testObjectToJson({
            'finishPasswordResetToken': finishPasswordResetToken,
            'newPassword': newPassword,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<bool> hasAccount(_ist.TestSessionBuilder sessionBuilder) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'emailIdp',
            method: 'hasAccount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'emailIdp',
          methodName: 'hasAccount',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _JwtRefreshEndpoint {
  _JwtRefreshEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_iacs.AuthSuccess> refreshAccessToken(
    _ist.TestSessionBuilder sessionBuilder, {
    String? refreshToken,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'jwtRefresh',
            method: 'refreshAccessToken',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'jwtRefresh',
          methodName: 'refreshAccessToken',
          parameters: _ist.testObjectToJson({'refreshToken': refreshToken}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iacs.AuthSuccess>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _EntitlementEndpoint {
  _EntitlementEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<List<_ipb0z0gh.Feature>> list(
    _ist.TestSessionBuilder sessionBuilder, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'entitlement',
            method: 'list',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'entitlement',
          methodName: 'list',
          parameters: _ist.testObjectToJson({'businessId': businessId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_ipb0z0gh.Feature>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AccountingEndpoint {
  _AccountingEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_ipjpfe96.AccountingTransaction> create(
    _ist.TestSessionBuilder sessionBuilder,
    _id2yvtsq.CreateTransactionRequest request, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'accounting',
            method: 'create',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'accounting',
          methodName: 'create',
          parameters: _ist.testObjectToJson({
            'request': request,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ipjpfe96.AccountingTransaction>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ipjpfe96.AccountingTransaction> get(
    _ist.TestSessionBuilder sessionBuilder,
    int transactionId, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'accounting',
            method: 'get',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'accounting',
          methodName: 'get',
          parameters: _ist.testObjectToJson({
            'transactionId': transactionId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ipjpfe96.AccountingTransaction>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ipjpfe96.AccountingTransaction> update(
    _ist.TestSessionBuilder sessionBuilder,
    _i5w1zupa.UpdateTransactionRequest request, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'accounting',
            method: 'update',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'accounting',
          methodName: 'update',
          parameters: _ist.testObjectToJson({
            'request': request,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ipjpfe96.AccountingTransaction>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_ipjpfe96.AccountingTransaction>> list(
    _ist.TestSessionBuilder sessionBuilder, {
    _ii6adw80.TransactionType? type,
    _ivko09ij.TransactionCategory? category,
    DateTime? from,
    DateTime? to,
    int? limit,
    int? offset,
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'accounting',
            method: 'list',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'accounting',
          methodName: 'list',
          parameters: _ist.testObjectToJson({
            'type': type,
            'category': category,
            'from': from,
            'to': to,
            'limit': limit,
            'offset': offset,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_ipjpfe96.AccountingTransaction>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<void> delete(
    _ist.TestSessionBuilder sessionBuilder,
    int transactionId, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'accounting',
            method: 'delete',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'accounting',
          methodName: 'delete',
          parameters: _ist.testObjectToJson({
            'transactionId': transactionId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ib57s6cq.ProfitLossReport> profitLoss(
    _ist.TestSessionBuilder sessionBuilder,
    DateTime from,
    DateTime to, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'accounting',
            method: 'profitLoss',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'accounting',
          methodName: 'profitLoss',
          parameters: _ist.testObjectToJson({
            'from': from,
            'to': to,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ib57s6cq.ProfitLossReport>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<String> exportCsv(
    _ist.TestSessionBuilder sessionBuilder, {
    _ii6adw80.TransactionType? type,
    DateTime? from,
    DateTime? to,
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'accounting',
            method: 'exportCsv',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'accounting',
          methodName: 'exportCsv',
          parameters: _ist.testObjectToJson({
            'type': type,
            'from': from,
            'to': to,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AdminAuditEndpoint {
  _AdminAuditEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_i4bjlxcf.AdminAuditPage> auditQuery(
    _ist.TestSessionBuilder sessionBuilder, {
    _is.UuidValue? actorUserId,
    String? action,
    DateTime? since,
    int? limit,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminAudit',
            method: 'auditQuery',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminAudit',
          methodName: 'auditQuery',
          parameters: _ist.testObjectToJson({
            'actorUserId': actorUserId,
            'action': action,
            'since': since,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i4bjlxcf.AdminAuditPage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AdminBusinessesEndpoint {
  _AdminBusinessesEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_i5grpjbb.AdminBusinessPage> businessesSearch(
    _ist.TestSessionBuilder sessionBuilder, {
    String? query,
    int? limit,
    String? cursor,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminBusinesses',
            method: 'businessesSearch',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminBusinesses',
          methodName: 'businessesSearch',
          parameters: _ist.testObjectToJson({
            'query': query,
            'limit': limit,
            'cursor': cursor,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i5grpjbb.AdminBusinessPage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ijhbovo3.AdminBusinessDetail> businessesGet(
    _ist.TestSessionBuilder sessionBuilder,
    int businessId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminBusinesses',
            method: 'businessesGet',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminBusinesses',
          methodName: 'businessesGet',
          parameters: _ist.testObjectToJson({'businessId': businessId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ijhbovo3.AdminBusinessDetail>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iteipox3.Membership> membershipsSetRole(
    _ist.TestSessionBuilder sessionBuilder, {
    required int membershipId,
    required _iwrkm0s7.MembershipRole role,
    required bool confirm,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminBusinesses',
            method: 'membershipsSetRole',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminBusinesses',
          methodName: 'membershipsSetRole',
          parameters: _ist.testObjectToJson({
            'membershipId': membershipId,
            'role': role,
            'confirm': confirm,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iteipox3.Membership>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AdminGuidanceEndpoint {
  _AdminGuidanceEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<List<_imqtlho5.GuidanceTip>> guidanceTipsList(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminGuidance',
            method: 'guidanceTipsList',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminGuidance',
          methodName: 'guidanceTipsList',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_imqtlho5.GuidanceTip>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_imqtlho5.GuidanceTip> guidanceTipUpsert(
    _ist.TestSessionBuilder sessionBuilder, {
    required String topic,
    required String title,
    required String body,
    required bool confirm,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminGuidance',
            method: 'guidanceTipUpsert',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminGuidance',
          methodName: 'guidanceTipUpsert',
          parameters: _ist.testObjectToJson({
            'topic': topic,
            'title': title,
            'body': body,
            'confirm': confirm,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_imqtlho5.GuidanceTip>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AdminInvoicesEndpoint {
  _AdminInvoicesEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_ijfc5yz9.AdminInvoicePage> invoicesList(
    _ist.TestSessionBuilder sessionBuilder, {
    int? businessId,
    _ipvtulo1.InvoiceStatus? status,
    DateTime? from,
    DateTime? to,
    int? limit,
    String? cursor,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminInvoices',
            method: 'invoicesList',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminInvoices',
          methodName: 'invoicesList',
          parameters: _ist.testObjectToJson({
            'businessId': businessId,
            'status': status,
            'from': from,
            'to': to,
            'limit': limit,
            'cursor': cursor,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ijfc5yz9.AdminInvoicePage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_icjfst50.Invoice> invoicesGet(
    _ist.TestSessionBuilder sessionBuilder,
    int invoiceId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminInvoices',
            method: 'invoicesGet',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminInvoices',
          methodName: 'invoicesGet',
          parameters: _ist.testObjectToJson({'invoiceId': invoiceId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_icjfst50.Invoice>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_icjfst50.Invoice> invoiceCancelAdmin(
    _ist.TestSessionBuilder sessionBuilder, {
    required int invoiceId,
    required String reason,
    required bool confirm,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminInvoices',
            method: 'invoiceCancelAdmin',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminInvoices',
          methodName: 'invoiceCancelAdmin',
          parameters: _ist.testObjectToJson({
            'invoiceId': invoiceId,
            'reason': reason,
            'confirm': confirm,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_icjfst50.Invoice>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AdminStatsEndpoint {
  _AdminStatsEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_inru05c1.AdminStatsOverview> statsOverview(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminStats',
            method: 'statsOverview',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminStats',
          methodName: 'statsOverview',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_inru05c1.AdminStatsOverview>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AdminUsersEndpoint {
  _AdminUsersEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_ia9j7kdo.AdminUserSummaryPage> usersSearch(
    _ist.TestSessionBuilder sessionBuilder, {
    String? query,
    int? limit,
    String? cursor,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminUsers',
            method: 'usersSearch',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminUsers',
          methodName: 'usersSearch',
          parameters: _ist.testObjectToJson({
            'query': query,
            'limit': limit,
            'cursor': cursor,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ia9j7kdo.AdminUserSummaryPage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ip9x0wyj.AdminUserDossier> usersGet(
    _ist.TestSessionBuilder sessionBuilder,
    _is.UuidValue userId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminUsers',
            method: 'usersGet',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminUsers',
          methodName: 'usersGet',
          parameters: _ist.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ip9x0wyj.AdminUserDossier>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ip9x0wyj.AdminUserDossier> usersBan(
    _ist.TestSessionBuilder sessionBuilder, {
    required _is.UuidValue userId,
    required String reason,
    required bool confirm,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminUsers',
            method: 'usersBan',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminUsers',
          methodName: 'usersBan',
          parameters: _ist.testObjectToJson({
            'userId': userId,
            'reason': reason,
            'confirm': confirm,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ip9x0wyj.AdminUserDossier>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ip9x0wyj.AdminUserDossier> usersUnban(
    _ist.TestSessionBuilder sessionBuilder, {
    required _is.UuidValue userId,
    required bool confirm,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminUsers',
            method: 'usersUnban',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminUsers',
          methodName: 'usersUnban',
          parameters: _ist.testObjectToJson({
            'userId': userId,
            'confirm': confirm,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ip9x0wyj.AdminUserDossier>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iww85ue5.AdminAuthStatus> usersVerifyEmail(
    _ist.TestSessionBuilder sessionBuilder, {
    required _is.UuidValue userId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'adminUsers',
            method: 'usersVerifyEmail',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'adminUsers',
          methodName: 'usersVerifyEmail',
          parameters: _ist.testObjectToJson({'userId': userId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iww85ue5.AdminAuthStatus>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _BusinessEndpoint {
  _BusinessEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_ipdla2qi.Business> create(
    _ist.TestSessionBuilder sessionBuilder,
    _isstucd6.CreateBusinessRequest request,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'business',
            method: 'create',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'business',
          methodName: 'create',
          parameters: _ist.testObjectToJson({'request': request}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ipdla2qi.Business>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ipdla2qi.Business> get(
    _ist.TestSessionBuilder sessionBuilder, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'business',
            method: 'get',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'business',
          methodName: 'get',
          parameters: _ist.testObjectToJson({'businessId': businessId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ipdla2qi.Business>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ipdla2qi.Business> update(
    _ist.TestSessionBuilder sessionBuilder,
    _i6z7gqqp.UpdateBusinessRequest request,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'business',
            method: 'update',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'business',
          methodName: 'update',
          parameters: _ist.testObjectToJson({'request': request}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ipdla2qi.Business>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_ipdla2qi.Business>> listMine(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'business',
            method: 'listMine',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'business',
          methodName: 'listMine',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_ipdla2qi.Business>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _BusinessSettingsEndpoint {
  _BusinessSettingsEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_i995dlnj.BusinessSettings> get(
    _ist.TestSessionBuilder sessionBuilder, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'businessSettings',
            method: 'get',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'businessSettings',
          methodName: 'get',
          parameters: _ist.testObjectToJson({'businessId': businessId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i995dlnj.BusinessSettings>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i995dlnj.BusinessSettings> update(
    _ist.TestSessionBuilder sessionBuilder,
    _ifzr12w9.UpdateBusinessSettingsRequest request,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'businessSettings',
            method: 'update',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'businessSettings',
          methodName: 'update',
          parameters: _ist.testObjectToJson({'request': request}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i995dlnj.BusinessSettings>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _DashboardEndpoint {
  _DashboardEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_ijw2fkaq.DashboardSummary> getSummary(
    _ist.TestSessionBuilder sessionBuilder, {
    int? trendMonths,
    int? recentLimit,
    int? overdueLimit,
    int? debtorLimit,
    DateTime? asOf,
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'dashboard',
            method: 'getSummary',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'dashboard',
          methodName: 'getSummary',
          parameters: _ist.testObjectToJson({
            'trendMonths': trendMonths,
            'recentLimit': recentLimit,
            'overdueLimit': overdueLimit,
            'debtorLimit': debtorLimit,
            'asOf': asOf,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ijw2fkaq.DashboardSummary>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _DocumentEndpoint {
  _DocumentEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_inbg4lrm.Document> upload(
    _ist.TestSessionBuilder sessionBuilder,
    _i2nxphic.UploadDocumentRequest request,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'document',
            method: 'upload',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'document',
          methodName: 'upload',
          parameters: _ist.testObjectToJson({'request': request}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_inbg4lrm.Document>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_inbg4lrm.Document>> list(
    _ist.TestSessionBuilder sessionBuilder, {
    int? businessId,
    _ihaxsvej.DocumentKind? kind,
    String? relatedEntityType,
    String? relatedEntityId,
    int? limit,
    int? offset,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'document',
            method: 'list',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'document',
          methodName: 'list',
          parameters: _ist.testObjectToJson({
            'businessId': businessId,
            'kind': kind,
            'relatedEntityType': relatedEntityType,
            'relatedEntityId': relatedEntityId,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_inbg4lrm.Document>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_inbg4lrm.Document> get(
    _ist.TestSessionBuilder sessionBuilder,
    int documentId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'document',
            method: 'get',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'document',
          methodName: 'get',
          parameters: _ist.testObjectToJson({'documentId': documentId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_inbg4lrm.Document>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_idt.ByteData> download(
    _ist.TestSessionBuilder sessionBuilder,
    int documentId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'document',
            method: 'download',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'document',
          methodName: 'download',
          parameters: _ist.testObjectToJson({'documentId': documentId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_idt.ByteData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<void> delete(
    _ist.TestSessionBuilder sessionBuilder,
    int documentId,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'document',
            method: 'delete',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'document',
          methodName: 'delete',
          parameters: _ist.testObjectToJson({'documentId': documentId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _GuidanceEndpoint {
  _GuidanceEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<List<_imqtlho5.GuidanceTip>> tips(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'guidance',
            method: 'tips',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'guidance',
          methodName: 'tips',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_imqtlho5.GuidanceTip>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i3jq3nn0.ChecklistDefinition>> checklists(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'guidance',
            method: 'checklists',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'guidance',
          methodName: 'checklists',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i3jq3nn0.ChecklistDefinition>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_ivw4ui03.UserGuidanceProgress>> myProgress(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'guidance',
            method: 'myProgress',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'guidance',
          methodName: 'myProgress',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_ivw4ui03.UserGuidanceProgress>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ivw4ui03.UserGuidanceProgress> markCompleted(
    _ist.TestSessionBuilder sessionBuilder,
    String itemKey,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'guidance',
            method: 'markCompleted',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'guidance',
          methodName: 'markCompleted',
          parameters: _ist.testObjectToJson({'itemKey': itemKey}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ivw4ui03.UserGuidanceProgress>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ivw4ui03.UserGuidanceProgress> dismissTip(
    _ist.TestSessionBuilder sessionBuilder,
    String topic,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'guidance',
            method: 'dismissTip',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'guidance',
          methodName: 'dismissTip',
          parameters: _ist.testObjectToJson({'topic': topic}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ivw4ui03.UserGuidanceProgress>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _CustomerEndpoint {
  _CustomerEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_i120uj2v.Customer> create(
    _ist.TestSessionBuilder sessionBuilder,
    _i94n0ggq.CreateCustomerRequest request, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'customer',
            method: 'create',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'customer',
          methodName: 'create',
          parameters: _ist.testObjectToJson({
            'request': request,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i120uj2v.Customer>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i120uj2v.Customer> get(
    _ist.TestSessionBuilder sessionBuilder,
    int customerId, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'customer',
            method: 'get',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'customer',
          methodName: 'get',
          parameters: _ist.testObjectToJson({
            'customerId': customerId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i120uj2v.Customer>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i120uj2v.Customer> update(
    _ist.TestSessionBuilder sessionBuilder,
    _iyf4jy29.UpdateCustomerRequest request, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'customer',
            method: 'update',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'customer',
          methodName: 'update',
          parameters: _ist.testObjectToJson({
            'request': request,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i120uj2v.Customer>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i120uj2v.Customer>> list(
    _ist.TestSessionBuilder sessionBuilder, {
    _it20r4b4.CustomerStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'customer',
            method: 'list',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'customer',
          methodName: 'list',
          parameters: _ist.testObjectToJson({
            'status': status,
            'limit': limit,
            'offset': offset,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i120uj2v.Customer>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i9jnoo25.CustomerListPage> listPage(
    _ist.TestSessionBuilder sessionBuilder, {
    _it20r4b4.CustomerStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'customer',
            method: 'listPage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'customer',
          methodName: 'listPage',
          parameters: _ist.testObjectToJson({
            'status': status,
            'limit': limit,
            'offset': offset,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i9jnoo25.CustomerListPage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ihlvaant.CustomerCursorPage> listCursorPage(
    _ist.TestSessionBuilder sessionBuilder, {
    _it20r4b4.CustomerStatus? status,
    int? limit,
    String? cursor,
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'customer',
            method: 'listCursorPage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'customer',
          methodName: 'listCursorPage',
          parameters: _ist.testObjectToJson({
            'status': status,
            'limit': limit,
            'cursor': cursor,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ihlvaant.CustomerCursorPage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _InvoiceEndpoint {
  _InvoiceEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_icjfst50.Invoice> create(
    _ist.TestSessionBuilder sessionBuilder,
    _iz85641j.CreateInvoiceRequest request, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'invoice',
            method: 'create',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'invoice',
          methodName: 'create',
          parameters: _ist.testObjectToJson({
            'request': request,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_icjfst50.Invoice>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_icjfst50.Invoice> get(
    _ist.TestSessionBuilder sessionBuilder,
    int invoiceId, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'invoice',
            method: 'get',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'invoice',
          methodName: 'get',
          parameters: _ist.testObjectToJson({
            'invoiceId': invoiceId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_icjfst50.Invoice>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_i6zkktsi.InvoiceItem>> getItems(
    _ist.TestSessionBuilder sessionBuilder,
    int invoiceId, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'invoice',
            method: 'getItems',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'invoice',
          methodName: 'getItems',
          parameters: _ist.testObjectToJson({
            'invoiceId': invoiceId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_i6zkktsi.InvoiceItem>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_icjfst50.Invoice> update(
    _ist.TestSessionBuilder sessionBuilder,
    _ij04q7rg.UpdateInvoiceRequest request, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'invoice',
            method: 'update',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'invoice',
          methodName: 'update',
          parameters: _ist.testObjectToJson({
            'request': request,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_icjfst50.Invoice>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_icjfst50.Invoice>> list(
    _ist.TestSessionBuilder sessionBuilder, {
    _ipvtulo1.InvoiceStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'invoice',
            method: 'list',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'invoice',
          methodName: 'list',
          parameters: _ist.testObjectToJson({
            'status': status,
            'limit': limit,
            'offset': offset,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_icjfst50.Invoice>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ia86lvmn.InvoiceListPage> listPage(
    _ist.TestSessionBuilder sessionBuilder, {
    _ipvtulo1.InvoiceStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'invoice',
            method: 'listPage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'invoice',
          methodName: 'listPage',
          parameters: _ist.testObjectToJson({
            'status': status,
            'limit': limit,
            'offset': offset,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ia86lvmn.InvoiceListPage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ie6jh68g.InvoiceCursorPage> listCursorPage(
    _ist.TestSessionBuilder sessionBuilder, {
    _ipvtulo1.InvoiceStatus? status,
    int? limit,
    String? cursor,
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'invoice',
            method: 'listCursorPage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'invoice',
          methodName: 'listCursorPage',
          parameters: _ist.testObjectToJson({
            'status': status,
            'limit': limit,
            'cursor': cursor,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ie6jh68g.InvoiceCursorPage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<void> delete(
    _ist.TestSessionBuilder sessionBuilder,
    int invoiceId, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'invoice',
            method: 'delete',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'invoice',
          methodName: 'delete',
          parameters: _ist.testObjectToJson({
            'invoiceId': invoiceId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_icjfst50.Invoice> markSent(
    _ist.TestSessionBuilder sessionBuilder,
    int invoiceId, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'invoice',
            method: 'markSent',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'invoice',
          methodName: 'markSent',
          parameters: _ist.testObjectToJson({
            'invoiceId': invoiceId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_icjfst50.Invoice>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_icjfst50.Invoice> cancel(
    _ist.TestSessionBuilder sessionBuilder,
    int invoiceId, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'invoice',
            method: 'cancel',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'invoice',
          methodName: 'cancel',
          parameters: _ist.testObjectToJson({
            'invoiceId': invoiceId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_icjfst50.Invoice>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<String> exportCsv(
    _ist.TestSessionBuilder sessionBuilder, {
    _ipvtulo1.InvoiceStatus? status,
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'invoice',
            method: 'exportCsv',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'invoice',
          methodName: 'exportCsv',
          parameters: _ist.testObjectToJson({
            'status': status,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<String> exportJson(
    _ist.TestSessionBuilder sessionBuilder, {
    _ipvtulo1.InvoiceStatus? status,
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'invoice',
            method: 'exportJson',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'invoice',
          methodName: 'exportJson',
          parameters: _ist.testObjectToJson({
            'status': status,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_inbg4lrm.Document> generatePdf(
    _ist.TestSessionBuilder sessionBuilder,
    int invoiceId, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'invoice',
            method: 'generatePdf',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'invoice',
          methodName: 'generatePdf',
          parameters: _ist.testObjectToJson({
            'invoiceId': invoiceId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_inbg4lrm.Document>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _InvoiceTemplateEndpoint {
  _InvoiceTemplateEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_ier3zpp5.InvoiceTemplate> create(
    _ist.TestSessionBuilder sessionBuilder,
    _ixky5b07.CreateInvoiceTemplateRequest request, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'invoiceTemplate',
            method: 'create',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'invoiceTemplate',
          methodName: 'create',
          parameters: _ist.testObjectToJson({
            'request': request,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ier3zpp5.InvoiceTemplate>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ier3zpp5.InvoiceTemplate> get(
    _ist.TestSessionBuilder sessionBuilder,
    int templateId, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'invoiceTemplate',
            method: 'get',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'invoiceTemplate',
          methodName: 'get',
          parameters: _ist.testObjectToJson({
            'templateId': templateId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ier3zpp5.InvoiceTemplate>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ier3zpp5.InvoiceTemplate> update(
    _ist.TestSessionBuilder sessionBuilder,
    _ial27ozf.UpdateInvoiceTemplateRequest request, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'invoiceTemplate',
            method: 'update',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'invoiceTemplate',
          methodName: 'update',
          parameters: _ist.testObjectToJson({
            'request': request,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ier3zpp5.InvoiceTemplate>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_ier3zpp5.InvoiceTemplate>> list(
    _ist.TestSessionBuilder sessionBuilder, {
    int? businessId,
    int? limit,
    int? offset,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'invoiceTemplate',
            method: 'list',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'invoiceTemplate',
          methodName: 'list',
          parameters: _ist.testObjectToJson({
            'businessId': businessId,
            'limit': limit,
            'offset': offset,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_ier3zpp5.InvoiceTemplate>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _PaymentEndpoint {
  _PaymentEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_i20s50p9.PaymentRecord> record(
    _ist.TestSessionBuilder sessionBuilder,
    _im2k94rf.RecordPaymentRequest request, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'payment',
            method: 'record',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'payment',
          methodName: 'record',
          parameters: _ist.testObjectToJson({
            'request': request,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i20s50p9.PaymentRecord>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iz9w9j8i.InvoicePaymentStatus> status(
    _ist.TestSessionBuilder sessionBuilder,
    int invoiceId, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'payment',
            method: 'status',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'payment',
          methodName: 'status',
          parameters: _ist.testObjectToJson({
            'invoiceId': invoiceId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iz9w9j8i.InvoicePaymentStatus>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _RecurringScheduleEndpoint {
  _RecurringScheduleEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_icjfst50.Invoice> create(
    _ist.TestSessionBuilder sessionBuilder,
    _iw4avqfy.CreateRecurringScheduleRequest request, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'recurringSchedule',
            method: 'create',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'recurringSchedule',
          methodName: 'create',
          parameters: _ist.testObjectToJson({
            'request': request,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_icjfst50.Invoice>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_icjfst50.Invoice> get(
    _ist.TestSessionBuilder sessionBuilder,
    int invoiceId, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'recurringSchedule',
            method: 'get',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'recurringSchedule',
          methodName: 'get',
          parameters: _ist.testObjectToJson({
            'invoiceId': invoiceId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_icjfst50.Invoice>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_icjfst50.Invoice>> list(
    _ist.TestSessionBuilder sessionBuilder, {
    int? limit,
    int? offset,
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'recurringSchedule',
            method: 'list',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'recurringSchedule',
          methodName: 'list',
          parameters: _ist.testObjectToJson({
            'limit': limit,
            'offset': offset,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_icjfst50.Invoice>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_icjfst50.Invoice> update(
    _ist.TestSessionBuilder sessionBuilder,
    _it7xg7ig.UpdateRecurringScheduleRequest request, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'recurringSchedule',
            method: 'update',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'recurringSchedule',
          methodName: 'update',
          parameters: _ist.testObjectToJson({
            'request': request,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_icjfst50.Invoice>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_icjfst50.Invoice> cancel(
    _ist.TestSessionBuilder sessionBuilder,
    int invoiceId, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'recurringSchedule',
            method: 'cancel',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'recurringSchedule',
          methodName: 'cancel',
          parameters: _ist.testObjectToJson({
            'invoiceId': invoiceId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_icjfst50.Invoice>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _ReminderEndpoint {
  _ReminderEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<List<_ilvs17xw.Reminder>> list(
    _ist.TestSessionBuilder sessionBuilder,
    int invoiceId, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'reminder',
            method: 'list',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'reminder',
          methodName: 'list',
          parameters: _ist.testObjectToJson({
            'invoiceId': invoiceId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_ilvs17xw.Reminder>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ilvs17xw.Reminder> send(
    _ist.TestSessionBuilder sessionBuilder,
    int invoiceId, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'reminder',
            method: 'send',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'reminder',
          methodName: 'send',
          parameters: _ist.testObjectToJson({
            'invoiceId': invoiceId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ilvs17xw.Reminder>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _ProjectEndpoint {
  _ProjectEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_ido2dfrq.Project> create(
    _ist.TestSessionBuilder sessionBuilder,
    _idq7abw3.CreateProjectRequest request, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'project',
            method: 'create',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'project',
          methodName: 'create',
          parameters: _ist.testObjectToJson({
            'request': request,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ido2dfrq.Project>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ido2dfrq.Project> get(
    _ist.TestSessionBuilder sessionBuilder,
    int projectId, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'project',
            method: 'get',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'project',
          methodName: 'get',
          parameters: _ist.testObjectToJson({
            'projectId': projectId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ido2dfrq.Project>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_icr6zs8m.Task>> getTasks(
    _ist.TestSessionBuilder sessionBuilder,
    int projectId, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'project',
            method: 'getTasks',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'project',
          methodName: 'getTasks',
          parameters: _ist.testObjectToJson({
            'projectId': projectId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_icr6zs8m.Task>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ido2dfrq.Project> update(
    _ist.TestSessionBuilder sessionBuilder,
    _ihd38d9q.UpdateProjectRequest request, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'project',
            method: 'update',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'project',
          methodName: 'update',
          parameters: _ist.testObjectToJson({
            'request': request,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ido2dfrq.Project>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_ido2dfrq.Project>> list(
    _ist.TestSessionBuilder sessionBuilder, {
    _isvak9w2.ProjectStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'project',
            method: 'list',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'project',
          methodName: 'list',
          parameters: _ist.testObjectToJson({
            'status': status,
            'limit': limit,
            'offset': offset,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_ido2dfrq.Project>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<void> delete(
    _ist.TestSessionBuilder sessionBuilder,
    int projectId, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'project',
            method: 'delete',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'project',
          methodName: 'delete',
          parameters: _ist.testObjectToJson({
            'projectId': projectId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _TaskEndpoint {
  _TaskEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_icr6zs8m.Task> create(
    _ist.TestSessionBuilder sessionBuilder,
    _is7jk28e.CreateTaskRequest request, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'task',
            method: 'create',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'task',
          methodName: 'create',
          parameters: _ist.testObjectToJson({
            'request': request,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_icr6zs8m.Task>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_icr6zs8m.Task> update(
    _ist.TestSessionBuilder sessionBuilder,
    _izsek7q6.UpdateTaskRequest request, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'task',
            method: 'update',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'task',
          methodName: 'update',
          parameters: _ist.testObjectToJson({
            'request': request,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_icr6zs8m.Task>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_icr6zs8m.Task>> list(
    _ist.TestSessionBuilder sessionBuilder, {
    int? projectId,
    _ieegmn8f.TaskStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'task',
            method: 'list',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'task',
          methodName: 'list',
          parameters: _ist.testObjectToJson({
            'projectId': projectId,
            'status': status,
            'limit': limit,
            'offset': offset,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_icr6zs8m.Task>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _TimeEntryEndpoint {
  _TimeEntryEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_ict1xti5.TimeEntry> startTimer(
    _ist.TestSessionBuilder sessionBuilder,
    _igg0g889.StartTimerRequest request, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'timeEntry',
            method: 'startTimer',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timeEntry',
          methodName: 'startTimer',
          parameters: _ist.testObjectToJson({
            'request': request,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ict1xti5.TimeEntry>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ict1xti5.TimeEntry> stopTimer(
    _ist.TestSessionBuilder sessionBuilder, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'timeEntry',
            method: 'stopTimer',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timeEntry',
          methodName: 'stopTimer',
          parameters: _ist.testObjectToJson({'businessId': businessId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ict1xti5.TimeEntry>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ict1xti5.TimeEntry> create(
    _ist.TestSessionBuilder sessionBuilder,
    _imayenfo.CreateTimeEntryRequest request, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'timeEntry',
            method: 'create',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timeEntry',
          methodName: 'create',
          parameters: _ist.testObjectToJson({
            'request': request,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ict1xti5.TimeEntry>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ict1xti5.TimeEntry> get(
    _ist.TestSessionBuilder sessionBuilder,
    int timeEntryId, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'timeEntry',
            method: 'get',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timeEntry',
          methodName: 'get',
          parameters: _ist.testObjectToJson({
            'timeEntryId': timeEntryId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ict1xti5.TimeEntry>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_ict1xti5.TimeEntry> update(
    _ist.TestSessionBuilder sessionBuilder,
    _in9wv2h5.UpdateTimeEntryRequest request, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'timeEntry',
            method: 'update',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timeEntry',
          methodName: 'update',
          parameters: _ist.testObjectToJson({
            'request': request,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_ict1xti5.TimeEntry>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<List<_ict1xti5.TimeEntry>> list(
    _ist.TestSessionBuilder sessionBuilder, {
    int? projectId,
    int? taskId,
    DateTime? from,
    DateTime? to,
    bool? billable,
    int? limit,
    int? offset,
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'timeEntry',
            method: 'list',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timeEntry',
          methodName: 'list',
          parameters: _ist.testObjectToJson({
            'projectId': projectId,
            'taskId': taskId,
            'from': from,
            'to': to,
            'billable': billable,
            'limit': limit,
            'offset': offset,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<List<_ict1xti5.TimeEntry>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<void> delete(
    _ist.TestSessionBuilder sessionBuilder,
    int timeEntryId, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'timeEntry',
            method: 'delete',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timeEntry',
          methodName: 'delete',
          parameters: _ist.testObjectToJson({
            'timeEntryId': timeEntryId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iudgjxd4.TimeReport> report(
    _ist.TestSessionBuilder sessionBuilder,
    DateTime from,
    DateTime to, {
    int? projectId,
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'timeEntry',
            method: 'report',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timeEntry',
          methodName: 'report',
          parameters: _ist.testObjectToJson({
            'from': from,
            'to': to,
            'projectId': projectId,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iudgjxd4.TimeReport>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_icjfst50.Invoice> createInvoice(
    _ist.TestSessionBuilder sessionBuilder,
    _if6v8yof.CreateTimeEntriesInvoiceRequest request, {
    int? businessId,
  }) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'timeEntry',
            method: 'createInvoice',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'timeEntry',
          methodName: 'createInvoice',
          parameters: _ist.testObjectToJson({
            'request': request,
            'businessId': businessId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_icjfst50.Invoice>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _UserProfileEndpoint {
  _UserProfileEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _is.EndpointDispatch _endpointDispatch;

  final _is.SerializationManager _serializationManager;

  _ida.Future<_iev352gu.UserProfile> getMyProfile(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'userProfile',
            method: 'getMyProfile',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'userProfile',
          methodName: 'getMyProfile',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iev352gu.UserProfile>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_i3ypcelp.MyIdentity> me(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'userProfile',
            method: 'me',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'userProfile',
          methodName: 'me',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_i3ypcelp.MyIdentity>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_iev352gu.UserProfile> update(
    _ist.TestSessionBuilder sessionBuilder,
    _ijhnvzba.UpdateUserProfileRequest request,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'userProfile',
            method: 'update',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'userProfile',
          methodName: 'update',
          parameters: _ist.testObjectToJson({'request': request}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_iev352gu.UserProfile>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<void> deleteMyAccount(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'userProfile',
            method: 'deleteMyAccount',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'userProfile',
          methodName: 'deleteMyAccount',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _ida.Future<_idt.ByteData> exportMyData(
    _ist.TestSessionBuilder sessionBuilder,
  ) async {
    return _ist.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild(
            endpoint: 'userProfile',
            method: 'exportMyData',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'userProfile',
          methodName: 'exportMyData',
          parameters: _ist.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _ida.Future<_idt.ByteData>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _MarkOverdueInvoicesFutureCall {
  Future<void> process(_ist.TestSessionBuilder sessionBuilder) async {
    var _localUniqueSession =
        (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild();
    try {
      await _i89u7n74.MarkOverdueInvoicesProcessFutureCall().invoke(
        _localUniqueSession,
        null,
      );
    } finally {
      await _localUniqueSession.close();
    }
  }
}

class _ProcessRecurringInvoicesFutureCall {
  Future<void> process(_ist.TestSessionBuilder sessionBuilder) async {
    var _localUniqueSession =
        (sessionBuilder as _ist.InternalTestSessionBuilder).internalBuild();
    try {
      await _i89u7n74.ProcessRecurringInvoicesProcessFutureCall().invoke(
        _localUniqueSession,
        null,
      );
    } finally {
      await _localUniqueSession.close();
    }
  }
}
