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
import '../../../modules/user/models/app_theme.dart' as _i3;

abstract class UserProfile
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  UserProfile._({
    this.id,
    required this.userId,
    this.displayName,
    _i2.Locale? locale,
    this.timeZone,
    _i3.AppTheme? themeMode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : locale = locale ?? _i2.Locale.de,
       themeMode = themeMode ?? _i3.AppTheme.system,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory UserProfile({
    int? id,
    required _i1.UuidValue userId,
    String? displayName,
    _i2.Locale? locale,
    String? timeZone,
    _i3.AppTheme? themeMode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserProfileImpl;

  factory UserProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserProfile(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      displayName: jsonSerialization['displayName'] as String?,
      locale: jsonSerialization['locale'] == null
          ? null
          : _i2.Locale.fromJson((jsonSerialization['locale'] as String)),
      timeZone: jsonSerialization['timeZone'] as String?,
      themeMode: jsonSerialization['themeMode'] == null
          ? null
          : _i3.AppTheme.fromJson((jsonSerialization['themeMode'] as String)),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue userId;

  String? displayName;

  _i2.Locale locale;

  String? timeZone;

  _i3.AppTheme themeMode;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [UserProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserProfile copyWith({
    int? id,
    _i1.UuidValue? userId,
    String? displayName,
    _i2.Locale? locale,
    String? timeZone,
    _i3.AppTheme? themeMode,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserProfile',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (displayName != null) 'displayName': displayName,
      'locale': locale.toJson(),
      if (timeZone != null) 'timeZone': timeZone,
      'themeMode': themeMode.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserProfile',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (displayName != null) 'displayName': displayName,
      'locale': locale.toJson(),
      if (timeZone != null) 'timeZone': timeZone,
      'themeMode': themeMode.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserProfileImpl extends UserProfile {
  _UserProfileImpl({
    int? id,
    required _i1.UuidValue userId,
    String? displayName,
    _i2.Locale? locale,
    String? timeZone,
    _i3.AppTheme? themeMode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         displayName: displayName,
         locale: locale,
         timeZone: timeZone,
         themeMode: themeMode,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [UserProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserProfile copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? displayName = _Undefined,
    _i2.Locale? locale,
    Object? timeZone = _Undefined,
    _i3.AppTheme? themeMode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      displayName: displayName is String? ? displayName : this.displayName,
      locale: locale ?? this.locale,
      timeZone: timeZone is String? ? timeZone : this.timeZone,
      themeMode: themeMode ?? this.themeMode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
