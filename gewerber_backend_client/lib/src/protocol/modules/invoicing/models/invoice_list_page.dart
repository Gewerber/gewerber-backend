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
import '../../../modules/invoicing/models/invoice.dart' as _i2lykh97;

abstract class InvoiceListPage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  InvoiceListPage._({
    required this.items,
    required this.totalCount,
    required this.limit,
    required this.offset,
  });

  factory InvoiceListPage({
    required List<_i2lykh97.Invoice> items,
    required int totalCount,
    required int limit,
    required int offset,
  }) = _InvoiceListPageImpl;

  factory InvoiceListPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return InvoiceListPage(
      items: _iipbhyvd.Protocol().deserialize<List<_i2lykh97.Invoice>>(
        jsonSerialization['items'],
      ),
      totalCount: jsonSerialization['totalCount'] as int,
      limit: jsonSerialization['limit'] as int,
      offset: jsonSerialization['offset'] as int,
    );
  }

  List<_i2lykh97.Invoice> items;

  int totalCount;

  int limit;

  int offset;

  /// Returns a shallow copy of this [InvoiceListPage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  InvoiceListPage copyWith({
    List<_i2lykh97.Invoice>? items,
    int? totalCount,
    int? limit,
    int? offset,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InvoiceListPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'totalCount': totalCount,
      'limit': limit,
      'offset': offset,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InvoiceListPage',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'totalCount': totalCount,
      'limit': limit,
      'offset': offset,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _InvoiceListPageImpl extends InvoiceListPage {
  _InvoiceListPageImpl({
    required List<_i2lykh97.Invoice> items,
    required int totalCount,
    required int limit,
    required int offset,
  }) : super._(
         items: items,
         totalCount: totalCount,
         limit: limit,
         offset: offset,
       );

  /// Returns a shallow copy of this [InvoiceListPage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  InvoiceListPage copyWith({
    List<_i2lykh97.Invoice>? items,
    int? totalCount,
    int? limit,
    int? offset,
  }) {
    return InvoiceListPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      totalCount: totalCount ?? this.totalCount,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }
}
