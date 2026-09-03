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
import '../../../modules/admin/models/admin_user_summary.dart' as _icq7l3ts;

abstract class AdminUserSummaryPage
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AdminUserSummaryPage._({
    required this.items,
    this.nextCursor,
    required this.limit,
  });

  factory AdminUserSummaryPage({
    required List<_icq7l3ts.AdminUserSummary> items,
    String? nextCursor,
    required int limit,
  }) = _AdminUserSummaryPageImpl;

  factory AdminUserSummaryPage.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AdminUserSummaryPage(
      items: _itzp2rm6.Protocol().deserialize<List<_icq7l3ts.AdminUserSummary>>(
        jsonSerialization['items'],
      ),
      nextCursor: jsonSerialization['nextCursor'] as String?,
      limit: jsonSerialization['limit'] as int,
    );
  }

  List<_icq7l3ts.AdminUserSummary> items;

  String? nextCursor;

  int limit;

  /// Returns a shallow copy of this [AdminUserSummaryPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AdminUserSummaryPage copyWith({
    List<_icq7l3ts.AdminUserSummary>? items,
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
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminUserSummaryPageImpl extends AdminUserSummaryPage {
  _AdminUserSummaryPageImpl({
    required List<_icq7l3ts.AdminUserSummary> items,
    String? nextCursor,
    required int limit,
  }) : super._(
         items: items,
         nextCursor: nextCursor,
         limit: limit,
       );

  /// Returns a shallow copy of this [AdminUserSummaryPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AdminUserSummaryPage copyWith({
    List<_icq7l3ts.AdminUserSummary>? items,
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
