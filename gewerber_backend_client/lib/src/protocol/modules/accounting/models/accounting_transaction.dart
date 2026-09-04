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
import '../../../modules/accounting/models/transaction_category.dart'
    as _i1xoyxnt;
import '../../../modules/accounting/models/transaction_type.dart' as _i74jrgmd;

abstract class AccountingTransaction
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AccountingTransaction._({
    this.id,
    required this.businessId,
    required this.type,
    required this.category,
    this.description,
    required this.occurredAt,
    required this.amountCents,
    this.receiptDocumentId,
    this.relatedInvoiceId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory AccountingTransaction({
    int? id,
    required int businessId,
    required _i74jrgmd.TransactionType type,
    required _i1xoyxnt.TransactionCategory category,
    String? description,
    required DateTime occurredAt,
    required int amountCents,
    int? receiptDocumentId,
    int? relatedInvoiceId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AccountingTransactionImpl;

  factory AccountingTransaction.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AccountingTransaction(
      id: jsonSerialization['id'] as int?,
      businessId: jsonSerialization['businessId'] as int,
      type: _i74jrgmd.TransactionType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      category: _i1xoyxnt.TransactionCategory.fromJson(
        (jsonSerialization['category'] as String),
      ),
      description: jsonSerialization['description'] as String?,
      occurredAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredAt'],
      ),
      amountCents: jsonSerialization['amountCents'] as int,
      receiptDocumentId: jsonSerialization['receiptDocumentId'] as int?,
      relatedInvoiceId: jsonSerialization['relatedInvoiceId'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int businessId;

  _i74jrgmd.TransactionType type;

  _i1xoyxnt.TransactionCategory category;

  String? description;

  DateTime occurredAt;

  int amountCents;

  int? receiptDocumentId;

  int? relatedInvoiceId;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [AccountingTransaction]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AccountingTransaction copyWith({
    int? id,
    int? businessId,
    _i74jrgmd.TransactionType? type,
    _i1xoyxnt.TransactionCategory? category,
    String? description,
    DateTime? occurredAt,
    int? amountCents,
    int? receiptDocumentId,
    int? relatedInvoiceId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AccountingTransaction',
      if (id != null) 'id': id,
      'businessId': businessId,
      'type': type.toJson(),
      'category': category.toJson(),
      if (description != null) 'description': description,
      'occurredAt': occurredAt.toJson(),
      'amountCents': amountCents,
      if (receiptDocumentId != null) 'receiptDocumentId': receiptDocumentId,
      if (relatedInvoiceId != null) 'relatedInvoiceId': relatedInvoiceId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AccountingTransaction',
      if (id != null) 'id': id,
      'businessId': businessId,
      'type': type.toJson(),
      'category': category.toJson(),
      if (description != null) 'description': description,
      'occurredAt': occurredAt.toJson(),
      'amountCents': amountCents,
      if (receiptDocumentId != null) 'receiptDocumentId': receiptDocumentId,
      if (relatedInvoiceId != null) 'relatedInvoiceId': relatedInvoiceId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AccountingTransactionImpl extends AccountingTransaction {
  _AccountingTransactionImpl({
    int? id,
    required int businessId,
    required _i74jrgmd.TransactionType type,
    required _i1xoyxnt.TransactionCategory category,
    String? description,
    required DateTime occurredAt,
    required int amountCents,
    int? receiptDocumentId,
    int? relatedInvoiceId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         businessId: businessId,
         type: type,
         category: category,
         description: description,
         occurredAt: occurredAt,
         amountCents: amountCents,
         receiptDocumentId: receiptDocumentId,
         relatedInvoiceId: relatedInvoiceId,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [AccountingTransaction]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AccountingTransaction copyWith({
    Object? id = _Undefined,
    int? businessId,
    _i74jrgmd.TransactionType? type,
    _i1xoyxnt.TransactionCategory? category,
    Object? description = _Undefined,
    DateTime? occurredAt,
    int? amountCents,
    Object? receiptDocumentId = _Undefined,
    Object? relatedInvoiceId = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AccountingTransaction(
      id: id is int? ? id : this.id,
      businessId: businessId ?? this.businessId,
      type: type ?? this.type,
      category: category ?? this.category,
      description: description is String? ? description : this.description,
      occurredAt: occurredAt ?? this.occurredAt,
      amountCents: amountCents ?? this.amountCents,
      receiptDocumentId: receiptDocumentId is int?
          ? receiptDocumentId
          : this.receiptDocumentId,
      relatedInvoiceId: relatedInvoiceId is int?
          ? relatedInvoiceId
          : this.relatedInvoiceId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
