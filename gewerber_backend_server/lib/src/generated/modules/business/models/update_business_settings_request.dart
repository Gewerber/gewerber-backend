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

import 'package:serverpod/serverpod.dart' as _is;
import '../../../modules/business/models/rounding_mode.dart' as _ib9gbuqh;

abstract class UpdateBusinessSettingsRequest
    implements _is.SerializableModel, _is.ProtocolSerialization {
  UpdateBusinessSettingsRequest._({
    required this.businessId,
    required this.paymentTermsDays,
    this.invoiceNumberPrefix,
    required this.invoiceNumberIncludeYear,
    required this.invoiceNumberMinDigits,
    required this.roundingMode,
    required this.roundingGranularityMinutes,
  });

  factory UpdateBusinessSettingsRequest({
    required int businessId,
    required int paymentTermsDays,
    String? invoiceNumberPrefix,
    required bool invoiceNumberIncludeYear,
    required int invoiceNumberMinDigits,
    required _ib9gbuqh.RoundingMode roundingMode,
    required int roundingGranularityMinutes,
  }) = _UpdateBusinessSettingsRequestImpl;

  factory UpdateBusinessSettingsRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UpdateBusinessSettingsRequest(
      businessId: jsonSerialization['businessId'] as int,
      paymentTermsDays: jsonSerialization['paymentTermsDays'] as int,
      invoiceNumberPrefix: jsonSerialization['invoiceNumberPrefix'] as String?,
      invoiceNumberIncludeYear: _is.BoolJsonExtension.fromJson(
        jsonSerialization['invoiceNumberIncludeYear'],
      ),
      invoiceNumberMinDigits:
          jsonSerialization['invoiceNumberMinDigits'] as int,
      roundingMode: _ib9gbuqh.RoundingMode.fromJson(
        (jsonSerialization['roundingMode'] as String),
      ),
      roundingGranularityMinutes:
          jsonSerialization['roundingGranularityMinutes'] as int,
    );
  }

  int businessId;

  int paymentTermsDays;

  String? invoiceNumberPrefix;

  bool invoiceNumberIncludeYear;

  int invoiceNumberMinDigits;

  _ib9gbuqh.RoundingMode roundingMode;

  int roundingGranularityMinutes;

  /// Returns a shallow copy of this [UpdateBusinessSettingsRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  UpdateBusinessSettingsRequest copyWith({
    int? businessId,
    int? paymentTermsDays,
    String? invoiceNumberPrefix,
    bool? invoiceNumberIncludeYear,
    int? invoiceNumberMinDigits,
    _ib9gbuqh.RoundingMode? roundingMode,
    int? roundingGranularityMinutes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UpdateBusinessSettingsRequest',
      'businessId': businessId,
      'paymentTermsDays': paymentTermsDays,
      if (invoiceNumberPrefix != null)
        'invoiceNumberPrefix': invoiceNumberPrefix,
      'invoiceNumberIncludeYear': invoiceNumberIncludeYear,
      'invoiceNumberMinDigits': invoiceNumberMinDigits,
      'roundingMode': roundingMode.toJson(),
      'roundingGranularityMinutes': roundingGranularityMinutes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UpdateBusinessSettingsRequest',
      'businessId': businessId,
      'paymentTermsDays': paymentTermsDays,
      if (invoiceNumberPrefix != null)
        'invoiceNumberPrefix': invoiceNumberPrefix,
      'invoiceNumberIncludeYear': invoiceNumberIncludeYear,
      'invoiceNumberMinDigits': invoiceNumberMinDigits,
      'roundingMode': roundingMode.toJson(),
      'roundingGranularityMinutes': roundingGranularityMinutes,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UpdateBusinessSettingsRequestImpl extends UpdateBusinessSettingsRequest {
  _UpdateBusinessSettingsRequestImpl({
    required int businessId,
    required int paymentTermsDays,
    String? invoiceNumberPrefix,
    required bool invoiceNumberIncludeYear,
    required int invoiceNumberMinDigits,
    required _ib9gbuqh.RoundingMode roundingMode,
    required int roundingGranularityMinutes,
  }) : super._(
         businessId: businessId,
         paymentTermsDays: paymentTermsDays,
         invoiceNumberPrefix: invoiceNumberPrefix,
         invoiceNumberIncludeYear: invoiceNumberIncludeYear,
         invoiceNumberMinDigits: invoiceNumberMinDigits,
         roundingMode: roundingMode,
         roundingGranularityMinutes: roundingGranularityMinutes,
       );

  /// Returns a shallow copy of this [UpdateBusinessSettingsRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  UpdateBusinessSettingsRequest copyWith({
    int? businessId,
    int? paymentTermsDays,
    Object? invoiceNumberPrefix = _Undefined,
    bool? invoiceNumberIncludeYear,
    int? invoiceNumberMinDigits,
    _ib9gbuqh.RoundingMode? roundingMode,
    int? roundingGranularityMinutes,
  }) {
    return UpdateBusinessSettingsRequest(
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
    );
  }
}
