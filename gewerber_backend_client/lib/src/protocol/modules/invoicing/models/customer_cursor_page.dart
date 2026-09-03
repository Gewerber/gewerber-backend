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

import 'package:gewerber_backend_client/src/protocol/protocol.dart'
    as _iipbhyvd;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../../modules/invoicing/models/customer.dart' as _ix5o1eh3;

abstract class CustomerCursorPage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CustomerCursorPage._({
    required this.items,
    this.nextCursor,
    required this.limit,
  });

  factory CustomerCursorPage({
    required List<_ix5o1eh3.Customer> items,
    String? nextCursor,
    required int limit,
  }) = _CustomerCursorPageImpl;

  factory CustomerCursorPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomerCursorPage(
      items: _iipbhyvd.Protocol().deserialize<List<_ix5o1eh3.Customer>>(
        jsonSerialization['items'],
      ),
      nextCursor: jsonSerialization['nextCursor'] as String?,
      limit: jsonSerialization['limit'] as int,
    );
  }

  List<_ix5o1eh3.Customer> items;

  String? nextCursor;

  int limit;

  /// Returns a shallow copy of this [CustomerCursorPage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CustomerCursorPage copyWith({
    List<_ix5o1eh3.Customer>? items,
    String? nextCursor,
    int? limit,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerCursorPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      if (nextCursor != null) 'nextCursor': nextCursor,
      'limit': limit,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerCursorPage',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (nextCursor != null) 'nextCursor': nextCursor,
      'limit': limit,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomerCursorPageImpl extends CustomerCursorPage {
  _CustomerCursorPageImpl({
    required List<_ix5o1eh3.Customer> items,
    String? nextCursor,
    required int limit,
  }) : super._(
         items: items,
         nextCursor: nextCursor,
         limit: limit,
       );

  /// Returns a shallow copy of this [CustomerCursorPage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CustomerCursorPage copyWith({
    List<_ix5o1eh3.Customer>? items,
    Object? nextCursor = _Undefined,
    int? limit,
  }) {
    return CustomerCursorPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      nextCursor: nextCursor is String? ? nextCursor : this.nextCursor,
      limit: limit ?? this.limit,
    );
  }
}
