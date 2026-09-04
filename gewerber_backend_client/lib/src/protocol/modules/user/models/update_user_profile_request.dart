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

import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../../modules/business/models/locale.dart' as _ie5v8zdc;
import '../../../modules/user/models/app_theme.dart' as _ipe4su3u;

abstract class UpdateUserProfileRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  UpdateUserProfileRequest._({
    this.displayName,
    required this.locale,
    this.timeZone,
    required this.themeMode,
  });

  factory UpdateUserProfileRequest({
    String? displayName,
    required _ie5v8zdc.Locale locale,
    String? timeZone,
    required _ipe4su3u.AppTheme themeMode,
  }) = _UpdateUserProfileRequestImpl;

  factory UpdateUserProfileRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UpdateUserProfileRequest(
      displayName: jsonSerialization['displayName'] as String?,
      locale: _ie5v8zdc.Locale.fromJson(
        (jsonSerialization['locale'] as String),
      ),
      timeZone: jsonSerialization['timeZone'] as String?,
      themeMode: _ipe4su3u.AppTheme.fromJson(
        (jsonSerialization['themeMode'] as String),
      ),
    );
  }

  String? displayName;

  _ie5v8zdc.Locale locale;

  String? timeZone;

  _ipe4su3u.AppTheme themeMode;

  /// Returns a shallow copy of this [UpdateUserProfileRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  UpdateUserProfileRequest copyWith({
    String? displayName,
    _ie5v8zdc.Locale? locale,
    String? timeZone,
    _ipe4su3u.AppTheme? themeMode,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UpdateUserProfileRequest',
      if (displayName != null) 'displayName': displayName,
      'locale': locale.toJson(),
      if (timeZone != null) 'timeZone': timeZone,
      'themeMode': themeMode.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UpdateUserProfileRequest',
      if (displayName != null) 'displayName': displayName,
      'locale': locale.toJson(),
      if (timeZone != null) 'timeZone': timeZone,
      'themeMode': themeMode.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UpdateUserProfileRequestImpl extends UpdateUserProfileRequest {
  _UpdateUserProfileRequestImpl({
    String? displayName,
    required _ie5v8zdc.Locale locale,
    String? timeZone,
    required _ipe4su3u.AppTheme themeMode,
  }) : super._(
         displayName: displayName,
         locale: locale,
         timeZone: timeZone,
         themeMode: themeMode,
       );

  /// Returns a shallow copy of this [UpdateUserProfileRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  UpdateUserProfileRequest copyWith({
    Object? displayName = _Undefined,
    _ie5v8zdc.Locale? locale,
    Object? timeZone = _Undefined,
    _ipe4su3u.AppTheme? themeMode,
  }) {
    return UpdateUserProfileRequest(
      displayName: displayName is String? ? displayName : this.displayName,
      locale: locale ?? this.locale,
      timeZone: timeZone is String? ? timeZone : this.timeZone,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
