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
import '../../../modules/business/models/locale.dart' as _i2;

abstract class UpdateUserProfileRequest implements _i1.SerializableModel {
  UpdateUserProfileRequest._({
    this.displayName,
    required this.locale,
    this.timeZone,
  });

  factory UpdateUserProfileRequest({
    String? displayName,
    required _i2.Locale locale,
    String? timeZone,
  }) = _UpdateUserProfileRequestImpl;

  factory UpdateUserProfileRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UpdateUserProfileRequest(
      displayName: jsonSerialization['displayName'] as String?,
      locale: _i2.Locale.fromJson((jsonSerialization['locale'] as String)),
      timeZone: jsonSerialization['timeZone'] as String?,
    );
  }

  String? displayName;

  _i2.Locale locale;

  String? timeZone;

  /// Returns a shallow copy of this [UpdateUserProfileRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UpdateUserProfileRequest copyWith({
    String? displayName,
    _i2.Locale? locale,
    String? timeZone,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UpdateUserProfileRequest',
      if (displayName != null) 'displayName': displayName,
      'locale': locale.toJson(),
      if (timeZone != null) 'timeZone': timeZone,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UpdateUserProfileRequestImpl extends UpdateUserProfileRequest {
  _UpdateUserProfileRequestImpl({
    String? displayName,
    required _i2.Locale locale,
    String? timeZone,
  }) : super._(
         displayName: displayName,
         locale: locale,
         timeZone: timeZone,
       );

  /// Returns a shallow copy of this [UpdateUserProfileRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UpdateUserProfileRequest copyWith({
    Object? displayName = _Undefined,
    _i2.Locale? locale,
    Object? timeZone = _Undefined,
  }) {
    return UpdateUserProfileRequest(
      displayName: displayName is String? ? displayName : this.displayName,
      locale: locale ?? this.locale,
      timeZone: timeZone is String? ? timeZone : this.timeZone,
    );
  }
}
