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

import 'package:gewerber_backend_server/src/generated/protocol.dart'
    as _itzp2rm6;
import 'package:serverpod/serverpod.dart' as _is;
import '../../../modules/invoicing/models/invoice.dart' as _i2lykh97;

abstract class InvoiceCursorPage
    implements _is.SerializableModel, _is.ProtocolSerialization {
  InvoiceCursorPage._({
    required this.items,
    this.nextCursor,
    required this.limit,
  });

  factory InvoiceCursorPage({
    required List<_i2lykh97.Invoice> items,
    String? nextCursor,
    required int limit,
  }) = _InvoiceCursorPageImpl;

  factory InvoiceCursorPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return InvoiceCursorPage(
      items: _itzp2rm6.Protocol().deserialize<List<_i2lykh97.Invoice>>(
        jsonSerialization['items'],
      ),
      nextCursor: jsonSerialization['nextCursor'] as String?,
      limit: jsonSerialization['limit'] as int,
    );
  }

  List<_i2lykh97.Invoice> items;

  String? nextCursor;

  int limit;

  /// Returns a shallow copy of this [InvoiceCursorPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  InvoiceCursorPage copyWith({
    List<_i2lykh97.Invoice>? items,
    String? nextCursor,
    int? limit,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InvoiceCursorPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      if (nextCursor != null) 'nextCursor': nextCursor,
      'limit': limit,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InvoiceCursorPage',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (nextCursor != null) 'nextCursor': nextCursor,
      'limit': limit,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InvoiceCursorPageImpl extends InvoiceCursorPage {
  _InvoiceCursorPageImpl({
    required List<_i2lykh97.Invoice> items,
    String? nextCursor,
    required int limit,
  }) : super._(
         items: items,
         nextCursor: nextCursor,
         limit: limit,
       );

  /// Returns a shallow copy of this [InvoiceCursorPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  InvoiceCursorPage copyWith({
    List<_i2lykh97.Invoice>? items,
    Object? nextCursor = _Undefined,
    int? limit,
  }) {
    return InvoiceCursorPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      nextCursor: nextCursor is String? ? nextCursor : this.nextCursor,
      limit: limit ?? this.limit,
    );
  }
}
