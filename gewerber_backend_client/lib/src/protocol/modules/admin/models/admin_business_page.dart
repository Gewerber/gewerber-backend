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
import '../../../modules/business/models/business.dart' as _i2;
import 'package:gewerber_backend_client/src/protocol/protocol.dart' as _i3;

abstract class AdminBusinessPage
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AdminBusinessPage._({
    required this.items,
    this.nextCursor,
    required this.limit,
  });

  factory AdminBusinessPage({
    required List<_i2.Business> items,
    String? nextCursor,
    required int limit,
  }) = _AdminBusinessPageImpl;

  factory AdminBusinessPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminBusinessPage(
      items: _i3.Protocol().deserialize<List<_i2.Business>>(
        jsonSerialization['items'],
      ),
      nextCursor: jsonSerialization['nextCursor'] as String?,
      limit: jsonSerialization['limit'] as int,
    );
  }

  List<_i2.Business> items;

  String? nextCursor;

  int limit;

  /// Returns a shallow copy of this [AdminBusinessPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminBusinessPage copyWith({
    List<_i2.Business>? items,
    String? nextCursor,
    int? limit,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminBusinessPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      if (nextCursor != null) 'nextCursor': nextCursor,
      'limit': limit,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminBusinessPage',
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

class _AdminBusinessPageImpl extends AdminBusinessPage {
  _AdminBusinessPageImpl({
    required List<_i2.Business> items,
    String? nextCursor,
    required int limit,
  }) : super._(
         items: items,
         nextCursor: nextCursor,
         limit: limit,
       );

  /// Returns a shallow copy of this [AdminBusinessPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminBusinessPage copyWith({
    List<_i2.Business>? items,
    Object? nextCursor = _Undefined,
    int? limit,
  }) {
    return AdminBusinessPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      nextCursor: nextCursor is String? ? nextCursor : this.nextCursor,
      limit: limit ?? this.limit,
    );
  }
}
