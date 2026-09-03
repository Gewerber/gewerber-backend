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

import 'package:serverpod/serverpod.dart' as _is;
import '../../../modules/invoicing/models/invoice_item_unit.dart' as _irh1ud1f;
import '../../../modules/invoicing/models/vat_rate.dart' as _icqbpm4p;

abstract class InvoiceItemRequest
    implements _is.SerializableModel, _is.ProtocolSerialization {
  InvoiceItemRequest._({
    required this.description,
    double? quantity,
    _irh1ud1f.InvoiceItemUnit? unit,
    int? unitPriceCents,
    _icqbpm4p.VatRate? vatRate,
  }) : quantity = quantity ?? 1.0,
       unit = unit ?? _irh1ud1f.InvoiceItemUnit.hour,
       unitPriceCents = unitPriceCents ?? 0,
       vatRate = vatRate ?? _icqbpm4p.VatRate.standard;

  factory InvoiceItemRequest({
    required String description,
    double? quantity,
    _irh1ud1f.InvoiceItemUnit? unit,
    int? unitPriceCents,
    _icqbpm4p.VatRate? vatRate,
  }) = _InvoiceItemRequestImpl;

  factory InvoiceItemRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return InvoiceItemRequest(
      description: jsonSerialization['description'] as String,
      quantity: (jsonSerialization['quantity'] as num?)?.toDouble(),
      unit: jsonSerialization['unit'] == null
          ? null
          : _irh1ud1f.InvoiceItemUnit.fromJson(
              (jsonSerialization['unit'] as String),
            ),
      unitPriceCents: jsonSerialization['unitPriceCents'] as int?,
      vatRate: jsonSerialization['vatRate'] == null
          ? null
          : _icqbpm4p.VatRate.fromJson(
              (jsonSerialization['vatRate'] as String),
            ),
    );
  }

  String description;

  double quantity;

  _irh1ud1f.InvoiceItemUnit unit;

  int unitPriceCents;

  _icqbpm4p.VatRate vatRate;

  /// Returns a shallow copy of this [InvoiceItemRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  InvoiceItemRequest copyWith({
    String? description,
    double? quantity,
    _irh1ud1f.InvoiceItemUnit? unit,
    int? unitPriceCents,
    _icqbpm4p.VatRate? vatRate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InvoiceItemRequest',
      'description': description,
      'quantity': quantity,
      'unit': unit.toJson(),
      'unitPriceCents': unitPriceCents,
      'vatRate': vatRate.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InvoiceItemRequest',
      'description': description,
      'quantity': quantity,
      'unit': unit.toJson(),
      'unitPriceCents': unitPriceCents,
      'vatRate': vatRate.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _InvoiceItemRequestImpl extends InvoiceItemRequest {
  _InvoiceItemRequestImpl({
    required String description,
    double? quantity,
    _irh1ud1f.InvoiceItemUnit? unit,
    int? unitPriceCents,
    _icqbpm4p.VatRate? vatRate,
  }) : super._(
         description: description,
         quantity: quantity,
         unit: unit,
         unitPriceCents: unitPriceCents,
         vatRate: vatRate,
       );

  /// Returns a shallow copy of this [InvoiceItemRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  InvoiceItemRequest copyWith({
    String? description,
    double? quantity,
    _irh1ud1f.InvoiceItemUnit? unit,
    int? unitPriceCents,
    _icqbpm4p.VatRate? vatRate,
  }) {
    return InvoiceItemRequest(
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      unitPriceCents: unitPriceCents ?? this.unitPriceCents,
      vatRate: vatRate ?? this.vatRate,
    );
  }
}
