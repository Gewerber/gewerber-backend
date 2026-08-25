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

abstract class DebtorSummary
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DebtorSummary._({
    this.customerId,
    this.customerName,
    required this.openCount,
    required this.openTotalCents,
    required this.overdueTotalCents,
    this.oldestDueDate,
  });

  factory DebtorSummary({
    int? customerId,
    String? customerName,
    required int openCount,
    required int openTotalCents,
    required int overdueTotalCents,
    DateTime? oldestDueDate,
  }) = _DebtorSummaryImpl;

  factory DebtorSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return DebtorSummary(
      customerId: jsonSerialization['customerId'] as int?,
      customerName: jsonSerialization['customerName'] as String?,
      openCount: jsonSerialization['openCount'] as int,
      openTotalCents: jsonSerialization['openTotalCents'] as int,
      overdueTotalCents: jsonSerialization['overdueTotalCents'] as int,
      oldestDueDate: jsonSerialization['oldestDueDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['oldestDueDate'],
            ),
    );
  }

  int? customerId;

  String? customerName;

  int openCount;

  int openTotalCents;

  int overdueTotalCents;

  DateTime? oldestDueDate;

  /// Returns a shallow copy of this [DebtorSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DebtorSummary copyWith({
    int? customerId,
    String? customerName,
    int? openCount,
    int? openTotalCents,
    int? overdueTotalCents,
    DateTime? oldestDueDate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DebtorSummary',
      if (customerId != null) 'customerId': customerId,
      if (customerName != null) 'customerName': customerName,
      'openCount': openCount,
      'openTotalCents': openTotalCents,
      'overdueTotalCents': overdueTotalCents,
      if (oldestDueDate != null) 'oldestDueDate': oldestDueDate?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DebtorSummary',
      if (customerId != null) 'customerId': customerId,
      if (customerName != null) 'customerName': customerName,
      'openCount': openCount,
      'openTotalCents': openTotalCents,
      'overdueTotalCents': overdueTotalCents,
      if (oldestDueDate != null) 'oldestDueDate': oldestDueDate?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DebtorSummaryImpl extends DebtorSummary {
  _DebtorSummaryImpl({
    int? customerId,
    String? customerName,
    required int openCount,
    required int openTotalCents,
    required int overdueTotalCents,
    DateTime? oldestDueDate,
  }) : super._(
         customerId: customerId,
         customerName: customerName,
         openCount: openCount,
         openTotalCents: openTotalCents,
         overdueTotalCents: overdueTotalCents,
         oldestDueDate: oldestDueDate,
       );

  /// Returns a shallow copy of this [DebtorSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DebtorSummary copyWith({
    Object? customerId = _Undefined,
    Object? customerName = _Undefined,
    int? openCount,
    int? openTotalCents,
    int? overdueTotalCents,
    Object? oldestDueDate = _Undefined,
  }) {
    return DebtorSummary(
      customerId: customerId is int? ? customerId : this.customerId,
      customerName: customerName is String? ? customerName : this.customerName,
      openCount: openCount ?? this.openCount,
      openTotalCents: openTotalCents ?? this.openTotalCents,
      overdueTotalCents: overdueTotalCents ?? this.overdueTotalCents,
      oldestDueDate: oldestDueDate is DateTime?
          ? oldestDueDate
          : this.oldestDueDate,
    );
  }
}
