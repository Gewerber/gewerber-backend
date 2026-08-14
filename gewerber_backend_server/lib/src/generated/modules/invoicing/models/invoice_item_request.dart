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
import '../../../modules/invoicing/models/invoice_item_unit.dart' as _i2;
import '../../../modules/invoicing/models/vat_rate.dart' as _i3;

abstract class InvoiceItemRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  InvoiceItemRequest._({
    required this.description,
    double? quantity,
    _i2.InvoiceItemUnit? unit,
    int? unitPriceCents,
    _i3.VatRate? vatRate,
  }) : quantity = quantity ?? 1.0,
       unit = unit ?? _i2.InvoiceItemUnit.hour,
       unitPriceCents = unitPriceCents ?? 0,
       vatRate = vatRate ?? _i3.VatRate.standard;

  factory InvoiceItemRequest({
    required String description,
    double? quantity,
    _i2.InvoiceItemUnit? unit,
    int? unitPriceCents,
    _i3.VatRate? vatRate,
  }) = _InvoiceItemRequestImpl;

  factory InvoiceItemRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return InvoiceItemRequest(
      description: jsonSerialization['description'] as String,
      quantity: (jsonSerialization['quantity'] as num?)?.toDouble(),
      unit: jsonSerialization['unit'] == null
          ? null
          : _i2.InvoiceItemUnit.fromJson((jsonSerialization['unit'] as String)),
      unitPriceCents: jsonSerialization['unitPriceCents'] as int?,
      vatRate: jsonSerialization['vatRate'] == null
          ? null
          : _i3.VatRate.fromJson((jsonSerialization['vatRate'] as String)),
    );
  }

  String description;

  double quantity;

  _i2.InvoiceItemUnit unit;

  int unitPriceCents;

  _i3.VatRate vatRate;

  /// Returns a shallow copy of this [InvoiceItemRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InvoiceItemRequest copyWith({
    String? description,
    double? quantity,
    _i2.InvoiceItemUnit? unit,
    int? unitPriceCents,
    _i3.VatRate? vatRate,
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
    return _i1.SerializationManager.encode(this);
  }
}

class _InvoiceItemRequestImpl extends InvoiceItemRequest {
  _InvoiceItemRequestImpl({
    required String description,
    double? quantity,
    _i2.InvoiceItemUnit? unit,
    int? unitPriceCents,
    _i3.VatRate? vatRate,
  }) : super._(
         description: description,
         quantity: quantity,
         unit: unit,
         unitPriceCents: unitPriceCents,
         vatRate: vatRate,
       );

  /// Returns a shallow copy of this [InvoiceItemRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InvoiceItemRequest copyWith({
    String? description,
    double? quantity,
    _i2.InvoiceItemUnit? unit,
    int? unitPriceCents,
    _i3.VatRate? vatRate,
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
