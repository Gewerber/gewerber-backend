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
import '../../../modules/invoicing/models/customer.dart' as _i2;
import 'package:gewerber_backend_server/src/generated/protocol.dart' as _i3;

abstract class CustomerCursorPage
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CustomerCursorPage._({
    required this.items,
    this.nextCursor,
    required this.limit,
  });

  factory CustomerCursorPage({
    required List<_i2.Customer> items,
    String? nextCursor,
    required int limit,
  }) = _CustomerCursorPageImpl;

  factory CustomerCursorPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomerCursorPage(
      items: _i3.Protocol().deserialize<List<_i2.Customer>>(
        jsonSerialization['items'],
      ),
      nextCursor: jsonSerialization['nextCursor'] as String?,
      limit: jsonSerialization['limit'] as int,
    );
  }

  List<_i2.Customer> items;

  String? nextCursor;

  int limit;

  /// Returns a shallow copy of this [CustomerCursorPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CustomerCursorPage copyWith({
    List<_i2.Customer>? items,
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
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomerCursorPageImpl extends CustomerCursorPage {
  _CustomerCursorPageImpl({
    required List<_i2.Customer> items,
    String? nextCursor,
    required int limit,
  }) : super._(
         items: items,
         nextCursor: nextCursor,
         limit: limit,
       );

  /// Returns a shallow copy of this [CustomerCursorPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CustomerCursorPage copyWith({
    List<_i2.Customer>? items,
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
