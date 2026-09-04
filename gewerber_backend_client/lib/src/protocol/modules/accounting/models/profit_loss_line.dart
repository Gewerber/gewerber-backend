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
import '../../../modules/accounting/models/transaction_category.dart'
    as _i1xoyxnt;

abstract class ProfitLossLine
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ProfitLossLine._({
    required this.category,
    required this.amountCents,
    required this.count,
  });

  factory ProfitLossLine({
    required _i1xoyxnt.TransactionCategory category,
    required int amountCents,
    required int count,
  }) = _ProfitLossLineImpl;

  factory ProfitLossLine.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProfitLossLine(
      category: _i1xoyxnt.TransactionCategory.fromJson(
        (jsonSerialization['category'] as String),
      ),
      amountCents: jsonSerialization['amountCents'] as int,
      count: jsonSerialization['count'] as int,
    );
  }

  _i1xoyxnt.TransactionCategory category;

  int amountCents;

  int count;

  /// Returns a shallow copy of this [ProfitLossLine]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ProfitLossLine copyWith({
    _i1xoyxnt.TransactionCategory? category,
    int? amountCents,
    int? count,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProfitLossLine',
      'category': category.toJson(),
      'amountCents': amountCents,
      'count': count,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProfitLossLine',
      'category': category.toJson(),
      'amountCents': amountCents,
      'count': count,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ProfitLossLineImpl extends ProfitLossLine {
  _ProfitLossLineImpl({
    required _i1xoyxnt.TransactionCategory category,
    required int amountCents,
    required int count,
  }) : super._(
         category: category,
         amountCents: amountCents,
         count: count,
       );

  /// Returns a shallow copy of this [ProfitLossLine]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ProfitLossLine copyWith({
    _i1xoyxnt.TransactionCategory? category,
    int? amountCents,
    int? count,
  }) {
    return ProfitLossLine(
      category: category ?? this.category,
      amountCents: amountCents ?? this.amountCents,
      count: count ?? this.count,
    );
  }
}
