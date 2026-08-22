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
import 'package:serverpod/serverpod.dart' as _i1;
import '../../../modules/accounting/models/transaction_category.dart' as _i2;

abstract class ProfitLossLine
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ProfitLossLine._({
    required this.category,
    required this.amountCents,
    required this.count,
  });

  factory ProfitLossLine({
    required _i2.TransactionCategory category,
    required int amountCents,
    required int count,
  }) = _ProfitLossLineImpl;

  factory ProfitLossLine.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProfitLossLine(
      category: _i2.TransactionCategory.fromJson(
        (jsonSerialization['category'] as String),
      ),
      amountCents: jsonSerialization['amountCents'] as int,
      count: jsonSerialization['count'] as int,
    );
  }

  _i2.TransactionCategory category;

  int amountCents;

  int count;

  /// Returns a shallow copy of this [ProfitLossLine]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ProfitLossLine copyWith({
    _i2.TransactionCategory? category,
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
    return _i1.SerializationManager.encode(this);
  }
}

class _ProfitLossLineImpl extends ProfitLossLine {
  _ProfitLossLineImpl({
    required _i2.TransactionCategory category,
    required int amountCents,
    required int count,
  }) : super._(
         category: category,
         amountCents: amountCents,
         count: count,
       );

  /// Returns a shallow copy of this [ProfitLossLine]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ProfitLossLine copyWith({
    _i2.TransactionCategory? category,
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
