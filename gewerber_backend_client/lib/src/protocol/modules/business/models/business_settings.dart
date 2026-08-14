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
import '../../../modules/business/models/rounding_mode.dart' as _i2;

abstract class BusinessSettings
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  BusinessSettings._({
    this.id,
    required this.businessId,
    int? paymentTermsDays,
    this.invoiceNumberPrefix,
    bool? invoiceNumberIncludeYear,
    int? invoiceNumberMinDigits,
    _i2.RoundingMode? roundingMode,
    int? roundingGranularityMinutes,
    DateTime? updatedAt,
  }) : paymentTermsDays = paymentTermsDays ?? 14,
       invoiceNumberIncludeYear = invoiceNumberIncludeYear ?? true,
       invoiceNumberMinDigits = invoiceNumberMinDigits ?? 4,
       roundingMode = roundingMode ?? _i2.RoundingMode.none,
       roundingGranularityMinutes = roundingGranularityMinutes ?? 1,
       updatedAt = updatedAt ?? DateTime.now();

  factory BusinessSettings({
    int? id,
    required int businessId,
    int? paymentTermsDays,
    String? invoiceNumberPrefix,
    bool? invoiceNumberIncludeYear,
    int? invoiceNumberMinDigits,
    _i2.RoundingMode? roundingMode,
    int? roundingGranularityMinutes,
    DateTime? updatedAt,
  }) = _BusinessSettingsImpl;

  factory BusinessSettings.fromJson(Map<String, dynamic> jsonSerialization) {
    return BusinessSettings(
      id: jsonSerialization['id'] as int?,
      businessId: jsonSerialization['businessId'] as int,
      paymentTermsDays: jsonSerialization['paymentTermsDays'] as int?,
      invoiceNumberPrefix: jsonSerialization['invoiceNumberPrefix'] as String?,
      invoiceNumberIncludeYear:
          jsonSerialization['invoiceNumberIncludeYear'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['invoiceNumberIncludeYear'],
            ),
      invoiceNumberMinDigits:
          jsonSerialization['invoiceNumberMinDigits'] as int?,
      roundingMode: jsonSerialization['roundingMode'] == null
          ? null
          : _i2.RoundingMode.fromJson(
              (jsonSerialization['roundingMode'] as String),
            ),
      roundingGranularityMinutes:
          jsonSerialization['roundingGranularityMinutes'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int businessId;

  int paymentTermsDays;

  String? invoiceNumberPrefix;

  bool invoiceNumberIncludeYear;

  int invoiceNumberMinDigits;

  _i2.RoundingMode roundingMode;

  int roundingGranularityMinutes;

  DateTime updatedAt;

  /// Returns a shallow copy of this [BusinessSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BusinessSettings copyWith({
    int? id,
    int? businessId,
    int? paymentTermsDays,
    String? invoiceNumberPrefix,
    bool? invoiceNumberIncludeYear,
    int? invoiceNumberMinDigits,
    _i2.RoundingMode? roundingMode,
    int? roundingGranularityMinutes,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BusinessSettings',
      if (id != null) 'id': id,
      'businessId': businessId,
      'paymentTermsDays': paymentTermsDays,
      if (invoiceNumberPrefix != null)
        'invoiceNumberPrefix': invoiceNumberPrefix,
      'invoiceNumberIncludeYear': invoiceNumberIncludeYear,
      'invoiceNumberMinDigits': invoiceNumberMinDigits,
      'roundingMode': roundingMode.toJson(),
      'roundingGranularityMinutes': roundingGranularityMinutes,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BusinessSettings',
      if (id != null) 'id': id,
      'businessId': businessId,
      'paymentTermsDays': paymentTermsDays,
      if (invoiceNumberPrefix != null)
        'invoiceNumberPrefix': invoiceNumberPrefix,
      'invoiceNumberIncludeYear': invoiceNumberIncludeYear,
      'invoiceNumberMinDigits': invoiceNumberMinDigits,
      'roundingMode': roundingMode.toJson(),
      'roundingGranularityMinutes': roundingGranularityMinutes,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BusinessSettingsImpl extends BusinessSettings {
  _BusinessSettingsImpl({
    int? id,
    required int businessId,
    int? paymentTermsDays,
    String? invoiceNumberPrefix,
    bool? invoiceNumberIncludeYear,
    int? invoiceNumberMinDigits,
    _i2.RoundingMode? roundingMode,
    int? roundingGranularityMinutes,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         businessId: businessId,
         paymentTermsDays: paymentTermsDays,
         invoiceNumberPrefix: invoiceNumberPrefix,
         invoiceNumberIncludeYear: invoiceNumberIncludeYear,
         invoiceNumberMinDigits: invoiceNumberMinDigits,
         roundingMode: roundingMode,
         roundingGranularityMinutes: roundingGranularityMinutes,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [BusinessSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BusinessSettings copyWith({
    Object? id = _Undefined,
    int? businessId,
    int? paymentTermsDays,
    Object? invoiceNumberPrefix = _Undefined,
    bool? invoiceNumberIncludeYear,
    int? invoiceNumberMinDigits,
    _i2.RoundingMode? roundingMode,
    int? roundingGranularityMinutes,
    DateTime? updatedAt,
  }) {
    return BusinessSettings(
      id: id is int? ? id : this.id,
      businessId: businessId ?? this.businessId,
      paymentTermsDays: paymentTermsDays ?? this.paymentTermsDays,
      invoiceNumberPrefix: invoiceNumberPrefix is String?
          ? invoiceNumberPrefix
          : this.invoiceNumberPrefix,
      invoiceNumberIncludeYear:
          invoiceNumberIncludeYear ?? this.invoiceNumberIncludeYear,
      invoiceNumberMinDigits:
          invoiceNumberMinDigits ?? this.invoiceNumberMinDigits,
      roundingMode: roundingMode ?? this.roundingMode,
      roundingGranularityMinutes:
          roundingGranularityMinutes ?? this.roundingGranularityMinutes,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
