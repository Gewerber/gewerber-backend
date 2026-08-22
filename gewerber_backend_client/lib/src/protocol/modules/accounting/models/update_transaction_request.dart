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
import '../../../modules/accounting/models/transaction_type.dart' as _i2;
import '../../../modules/accounting/models/transaction_category.dart' as _i3;

abstract class UpdateTransactionRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  UpdateTransactionRequest._({
    required this.transactionId,
    required this.type,
    required this.category,
    this.description,
    required this.occurredAt,
    required this.amountCents,
    this.receiptDocumentId,
    this.relatedInvoiceId,
  });

  factory UpdateTransactionRequest({
    required int transactionId,
    required _i2.TransactionType type,
    required _i3.TransactionCategory category,
    String? description,
    required DateTime occurredAt,
    required int amountCents,
    int? receiptDocumentId,
    int? relatedInvoiceId,
  }) = _UpdateTransactionRequestImpl;

  factory UpdateTransactionRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UpdateTransactionRequest(
      transactionId: jsonSerialization['transactionId'] as int,
      type: _i2.TransactionType.fromJson((jsonSerialization['type'] as String)),
      category: _i3.TransactionCategory.fromJson(
        (jsonSerialization['category'] as String),
      ),
      description: jsonSerialization['description'] as String?,
      occurredAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredAt'],
      ),
      amountCents: jsonSerialization['amountCents'] as int,
      receiptDocumentId: jsonSerialization['receiptDocumentId'] as int?,
      relatedInvoiceId: jsonSerialization['relatedInvoiceId'] as int?,
    );
  }

  int transactionId;

  _i2.TransactionType type;

  _i3.TransactionCategory category;

  String? description;

  DateTime occurredAt;

  int amountCents;

  int? receiptDocumentId;

  int? relatedInvoiceId;

  /// Returns a shallow copy of this [UpdateTransactionRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UpdateTransactionRequest copyWith({
    int? transactionId,
    _i2.TransactionType? type,
    _i3.TransactionCategory? category,
    String? description,
    DateTime? occurredAt,
    int? amountCents,
    int? receiptDocumentId,
    int? relatedInvoiceId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UpdateTransactionRequest',
      'transactionId': transactionId,
      'type': type.toJson(),
      'category': category.toJson(),
      if (description != null) 'description': description,
      'occurredAt': occurredAt.toJson(),
      'amountCents': amountCents,
      if (receiptDocumentId != null) 'receiptDocumentId': receiptDocumentId,
      if (relatedInvoiceId != null) 'relatedInvoiceId': relatedInvoiceId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UpdateTransactionRequest',
      'transactionId': transactionId,
      'type': type.toJson(),
      'category': category.toJson(),
      if (description != null) 'description': description,
      'occurredAt': occurredAt.toJson(),
      'amountCents': amountCents,
      if (receiptDocumentId != null) 'receiptDocumentId': receiptDocumentId,
      if (relatedInvoiceId != null) 'relatedInvoiceId': relatedInvoiceId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UpdateTransactionRequestImpl extends UpdateTransactionRequest {
  _UpdateTransactionRequestImpl({
    required int transactionId,
    required _i2.TransactionType type,
    required _i3.TransactionCategory category,
    String? description,
    required DateTime occurredAt,
    required int amountCents,
    int? receiptDocumentId,
    int? relatedInvoiceId,
  }) : super._(
         transactionId: transactionId,
         type: type,
         category: category,
         description: description,
         occurredAt: occurredAt,
         amountCents: amountCents,
         receiptDocumentId: receiptDocumentId,
         relatedInvoiceId: relatedInvoiceId,
       );

  /// Returns a shallow copy of this [UpdateTransactionRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UpdateTransactionRequest copyWith({
    int? transactionId,
    _i2.TransactionType? type,
    _i3.TransactionCategory? category,
    Object? description = _Undefined,
    DateTime? occurredAt,
    int? amountCents,
    Object? receiptDocumentId = _Undefined,
    Object? relatedInvoiceId = _Undefined,
  }) {
    return UpdateTransactionRequest(
      transactionId: transactionId ?? this.transactionId,
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
    );
  }
}
