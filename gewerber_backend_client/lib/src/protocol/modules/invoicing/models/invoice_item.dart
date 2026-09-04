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

import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../../modules/invoicing/models/invoice_item_unit.dart' as _irh1ud1f;
import '../../../modules/invoicing/models/vat_rate.dart' as _icqbpm4p;

abstract class InvoiceItem
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  InvoiceItem._({
    this.id,
    required this.invoiceId,
    required this.position,
    required this.description,
    double? quantity,
    _irh1ud1f.InvoiceItemUnit? unit,
    int? unitPriceCents,
    _icqbpm4p.VatRate? vatRate,
    int? lineTotalCents,
  }) : quantity = quantity ?? 1.0,
       unit = unit ?? _irh1ud1f.InvoiceItemUnit.hour,
       unitPriceCents = unitPriceCents ?? 0,
       vatRate = vatRate ?? _icqbpm4p.VatRate.standard,
       lineTotalCents = lineTotalCents ?? 0;

  factory InvoiceItem({
    int? id,
    required int invoiceId,
    required int position,
    required String description,
    double? quantity,
    _irh1ud1f.InvoiceItemUnit? unit,
    int? unitPriceCents,
    _icqbpm4p.VatRate? vatRate,
    int? lineTotalCents,
  }) = _InvoiceItemImpl;

  factory InvoiceItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return InvoiceItem(
      id: jsonSerialization['id'] as int?,
      invoiceId: jsonSerialization['invoiceId'] as int,
      position: jsonSerialization['position'] as int,
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
      lineTotalCents: jsonSerialization['lineTotalCents'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int invoiceId;

  int position;

  String description;

  double quantity;

  _irh1ud1f.InvoiceItemUnit unit;

  int unitPriceCents;

  _icqbpm4p.VatRate vatRate;

  int lineTotalCents;

  /// Returns a shallow copy of this [InvoiceItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  InvoiceItem copyWith({
    int? id,
    int? invoiceId,
    int? position,
    String? description,
    double? quantity,
    _irh1ud1f.InvoiceItemUnit? unit,
    int? unitPriceCents,
    _icqbpm4p.VatRate? vatRate,
    int? lineTotalCents,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InvoiceItem',
      if (id != null) 'id': id,
      'invoiceId': invoiceId,
      'position': position,
      'description': description,
      'quantity': quantity,
      'unit': unit.toJson(),
      'unitPriceCents': unitPriceCents,
      'vatRate': vatRate.toJson(),
      'lineTotalCents': lineTotalCents,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InvoiceItem',
      if (id != null) 'id': id,
      'invoiceId': invoiceId,
      'position': position,
      'description': description,
      'quantity': quantity,
      'unit': unit.toJson(),
      'unitPriceCents': unitPriceCents,
      'vatRate': vatRate.toJson(),
      'lineTotalCents': lineTotalCents,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InvoiceItemImpl extends InvoiceItem {
  _InvoiceItemImpl({
    int? id,
    required int invoiceId,
    required int position,
    required String description,
    double? quantity,
    _irh1ud1f.InvoiceItemUnit? unit,
    int? unitPriceCents,
    _icqbpm4p.VatRate? vatRate,
    int? lineTotalCents,
  }) : super._(
         id: id,
         invoiceId: invoiceId,
         position: position,
         description: description,
         quantity: quantity,
         unit: unit,
         unitPriceCents: unitPriceCents,
         vatRate: vatRate,
         lineTotalCents: lineTotalCents,
       );

  /// Returns a shallow copy of this [InvoiceItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  InvoiceItem copyWith({
    Object? id = _Undefined,
    int? invoiceId,
    int? position,
    String? description,
    double? quantity,
    _irh1ud1f.InvoiceItemUnit? unit,
    int? unitPriceCents,
    _icqbpm4p.VatRate? vatRate,
    int? lineTotalCents,
  }) {
    return InvoiceItem(
      id: id is int? ? id : this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      position: position ?? this.position,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      unitPriceCents: unitPriceCents ?? this.unitPriceCents,
      vatRate: vatRate ?? this.vatRate,
      lineTotalCents: lineTotalCents ?? this.lineTotalCents,
    );
  }
}
