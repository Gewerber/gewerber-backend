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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'core/errors/conflict_exception.dart' as _i2;
import 'core/errors/forbidden_exception.dart' as _i3;
import 'core/errors/not_found_exception.dart' as _i4;
import 'core/errors/validation_exception.dart' as _i5;
import 'modules/business/models/address.dart' as _i6;
import 'modules/business/models/business.dart' as _i7;
import 'modules/business/models/create_business_request.dart' as _i8;
import 'modules/business/models/legal_form.dart' as _i9;
import 'modules/business/models/membership.dart' as _i10;
import 'modules/business/models/membership_role.dart' as _i11;
import 'modules/business/models/update_business_request.dart' as _i12;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/business.dart'
    as _i13;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i14;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i15;
export 'core/errors/conflict_exception.dart';
export 'core/errors/forbidden_exception.dart';
export 'core/errors/not_found_exception.dart';
export 'core/errors/validation_exception.dart';
export 'modules/business/models/address.dart';
export 'modules/business/models/business.dart';
export 'modules/business/models/create_business_request.dart';
export 'modules/business/models/legal_form.dart';
export 'modules/business/models/membership.dart';
export 'modules/business/models/membership_role.dart';
export 'modules/business/models/update_business_request.dart';
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

    if (t == _i2.ConflictException) {
      return _i2.ConflictException.fromJson(data) as T;
    }
    if (t == _i3.ForbiddenException) {
      return _i3.ForbiddenException.fromJson(data) as T;
    }
    if (t == _i4.NotFoundException) {
      return _i4.NotFoundException.fromJson(data) as T;
    }
    if (t == _i5.ValidationException) {
      return _i5.ValidationException.fromJson(data) as T;
    }
    if (t == _i6.Address) {
      return _i6.Address.fromJson(data) as T;
    }
    if (t == _i7.Business) {
      return _i7.Business.fromJson(data) as T;
    }
    if (t == _i8.CreateBusinessRequest) {
      return _i8.CreateBusinessRequest.fromJson(data) as T;
    }
    if (t == _i9.LegalForm) {
      return _i9.LegalForm.fromJson(data) as T;
    }
    if (t == _i10.Membership) {
      return _i10.Membership.fromJson(data) as T;
    }
    if (t == _i11.MembershipRole) {
      return _i11.MembershipRole.fromJson(data) as T;
    }
    if (t == _i12.UpdateBusinessRequest) {
      return _i12.UpdateBusinessRequest.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.ConflictException?>()) {
      return (data != null ? _i2.ConflictException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.ForbiddenException?>()) {
      return (data != null ? _i3.ForbiddenException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.NotFoundException?>()) {
      return (data != null ? _i4.NotFoundException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.ValidationException?>()) {
      return (data != null ? _i5.ValidationException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.Address?>()) {
      return (data != null ? _i6.Address.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Business?>()) {
      return (data != null ? _i7.Business.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.CreateBusinessRequest?>()) {
      return (data != null ? _i8.CreateBusinessRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.LegalForm?>()) {
      return (data != null ? _i9.LegalForm.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Membership?>()) {
      return (data != null ? _i10.Membership.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.MembershipRole?>()) {
      return (data != null ? _i11.MembershipRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.UpdateBusinessRequest?>()) {
      return (data != null ? _i12.UpdateBusinessRequest.fromJson(data) : null)
          as T;
    }
    if (t == List<_i13.Business>) {
      return (data as List).map((e) => deserialize<_i13.Business>(e)).toList()
          as T;
    }
    try {
      return _i14.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i15.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.ConflictException => 'ConflictException',
      _i3.ForbiddenException => 'ForbiddenException',
      _i4.NotFoundException => 'NotFoundException',
      _i5.ValidationException => 'ValidationException',
      _i6.Address => 'Address',
      _i7.Business => 'Business',
      _i8.CreateBusinessRequest => 'CreateBusinessRequest',
      _i9.LegalForm => 'LegalForm',
      _i10.Membership => 'Membership',
      _i11.MembershipRole => 'MembershipRole',
      _i12.UpdateBusinessRequest => 'UpdateBusinessRequest',
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
      case _i2.ConflictException():
        return 'ConflictException';
      case _i3.ForbiddenException():
        return 'ForbiddenException';
      case _i4.NotFoundException():
        return 'NotFoundException';
      case _i5.ValidationException():
        return 'ValidationException';
      case _i6.Address():
        return 'Address';
      case _i7.Business():
        return 'Business';
      case _i8.CreateBusinessRequest():
        return 'CreateBusinessRequest';
      case _i9.LegalForm():
        return 'LegalForm';
      case _i10.Membership():
        return 'Membership';
      case _i11.MembershipRole():
        return 'MembershipRole';
      case _i12.UpdateBusinessRequest():
        return 'UpdateBusinessRequest';
    }
    className = _i14.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _i15.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'ConflictException') {
      return deserialize<_i2.ConflictException>(data['data']);
    }
    if (dataClassName == 'ForbiddenException') {
      return deserialize<_i3.ForbiddenException>(data['data']);
    }
    if (dataClassName == 'NotFoundException') {
      return deserialize<_i4.NotFoundException>(data['data']);
    }
    if (dataClassName == 'ValidationException') {
      return deserialize<_i5.ValidationException>(data['data']);
    }
    if (dataClassName == 'Address') {
      return deserialize<_i6.Address>(data['data']);
    }
    if (dataClassName == 'Business') {
      return deserialize<_i7.Business>(data['data']);
    }
    if (dataClassName == 'CreateBusinessRequest') {
      return deserialize<_i8.CreateBusinessRequest>(data['data']);
    }
    if (dataClassName == 'LegalForm') {
      return deserialize<_i9.LegalForm>(data['data']);
    }
    if (dataClassName == 'Membership') {
      return deserialize<_i10.Membership>(data['data']);
    }
    if (dataClassName == 'MembershipRole') {
      return deserialize<_i11.MembershipRole>(data['data']);
    }
    if (dataClassName == 'UpdateBusinessRequest') {
      return deserialize<_i12.UpdateBusinessRequest>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i14.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i15.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _i14.Protocol().registerHostProtocol('gewerber_backend', this);
    _i15.Protocol().registerHostProtocol('gewerber_backend', this);
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
      return _i14.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i15.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
