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

abstract class CreateCreditNoteRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CreateCreditNoteRequest._({
    required this.originalInvoiceId,
    this.issueDate,
    this.reason,
  });

  factory CreateCreditNoteRequest({
    required int originalInvoiceId,
    DateTime? issueDate,
    String? reason,
  }) = _CreateCreditNoteRequestImpl;

  factory CreateCreditNoteRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateCreditNoteRequest(
      originalInvoiceId: jsonSerialization['originalInvoiceId'] as int,
      issueDate: jsonSerialization['issueDate'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['issueDate']),
      reason: jsonSerialization['reason'] as String?,
    );
  }

  int originalInvoiceId;

  DateTime? issueDate;

  String? reason;

  /// Returns a shallow copy of this [CreateCreditNoteRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CreateCreditNoteRequest copyWith({
    int? originalInvoiceId,
    DateTime? issueDate,
    String? reason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateCreditNoteRequest',
      'originalInvoiceId': originalInvoiceId,
      if (issueDate != null) 'issueDate': issueDate?.toJson(),
      if (reason != null) 'reason': reason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CreateCreditNoteRequest',
      'originalInvoiceId': originalInvoiceId,
      if (issueDate != null) 'issueDate': issueDate?.toJson(),
      if (reason != null) 'reason': reason,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateCreditNoteRequestImpl extends CreateCreditNoteRequest {
  _CreateCreditNoteRequestImpl({
    required int originalInvoiceId,
    DateTime? issueDate,
    String? reason,
  }) : super._(
         originalInvoiceId: originalInvoiceId,
         issueDate: issueDate,
         reason: reason,
       );

  /// Returns a shallow copy of this [CreateCreditNoteRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CreateCreditNoteRequest copyWith({
    int? originalInvoiceId,
    Object? issueDate = _Undefined,
    Object? reason = _Undefined,
  }) {
    return CreateCreditNoteRequest(
      originalInvoiceId: originalInvoiceId ?? this.originalInvoiceId,
      issueDate: issueDate is DateTime? ? issueDate : this.issueDate,
      reason: reason is String? ? reason : this.reason,
    );
  }
}
