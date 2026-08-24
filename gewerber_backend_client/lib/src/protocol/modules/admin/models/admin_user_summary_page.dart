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
import '../../../modules/admin/models/admin_user_summary.dart' as _i2;
import 'package:gewerber_backend_client/src/protocol/protocol.dart' as _i3;

abstract class AdminUserSummaryPage
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AdminUserSummaryPage._({
    required this.items,
    this.nextCursor,
    required this.limit,
  });

  factory AdminUserSummaryPage({
    required List<_i2.AdminUserSummary> items,
    String? nextCursor,
    required int limit,
  }) = _AdminUserSummaryPageImpl;

  factory AdminUserSummaryPage.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AdminUserSummaryPage(
      items: _i3.Protocol().deserialize<List<_i2.AdminUserSummary>>(
        jsonSerialization['items'],
      ),
      nextCursor: jsonSerialization['nextCursor'] as String?,
      limit: jsonSerialization['limit'] as int,
    );
  }

  List<_i2.AdminUserSummary> items;

  String? nextCursor;

  int limit;

  /// Returns a shallow copy of this [AdminUserSummaryPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminUserSummaryPage copyWith({
    List<_i2.AdminUserSummary>? items,
    String? nextCursor,
    int? limit,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminUserSummaryPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      if (nextCursor != null) 'nextCursor': nextCursor,
      'limit': limit,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminUserSummaryPage',
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

class _AdminUserSummaryPageImpl extends AdminUserSummaryPage {
  _AdminUserSummaryPageImpl({
    required List<_i2.AdminUserSummary> items,
    String? nextCursor,
    required int limit,
  }) : super._(
         items: items,
         nextCursor: nextCursor,
         limit: limit,
       );

  /// Returns a shallow copy of this [AdminUserSummaryPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminUserSummaryPage copyWith({
    List<_i2.AdminUserSummary>? items,
    Object? nextCursor = _Undefined,
    int? limit,
  }) {
    return AdminUserSummaryPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      nextCursor: nextCursor is String? ? nextCursor : this.nextCursor,
      limit: limit ?? this.limit,
    );
  }
}
