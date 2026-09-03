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
import '../../../modules/admin/models/admin_audit_entry.dart' as _ih554ctd;

abstract class AdminAuditPage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AdminAuditPage._({
    required this.items,
    required this.limit,
  });

  factory AdminAuditPage({
    required List<_ih554ctd.AdminAuditEntry> items,
    required int limit,
  }) = _AdminAuditPageImpl;

  factory AdminAuditPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminAuditPage(
      items: _iipbhyvd.Protocol().deserialize<List<_ih554ctd.AdminAuditEntry>>(
        jsonSerialization['items'],
      ),
      limit: jsonSerialization['limit'] as int,
    );
  }

  List<_ih554ctd.AdminAuditEntry> items;

  int limit;

  /// Returns a shallow copy of this [AdminAuditPage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AdminAuditPage copyWith({
    List<_ih554ctd.AdminAuditEntry>? items,
    int? limit,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminAuditPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'limit': limit,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminAuditPage',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'limit': limit,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _AdminAuditPageImpl extends AdminAuditPage {
  _AdminAuditPageImpl({
    required List<_ih554ctd.AdminAuditEntry> items,
    required int limit,
  }) : super._(
         items: items,
         limit: limit,
       );

  /// Returns a shallow copy of this [AdminAuditPage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AdminAuditPage copyWith({
    List<_ih554ctd.AdminAuditEntry>? items,
    int? limit,
  }) {
    return AdminAuditPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      limit: limit ?? this.limit,
    );
  }
}
