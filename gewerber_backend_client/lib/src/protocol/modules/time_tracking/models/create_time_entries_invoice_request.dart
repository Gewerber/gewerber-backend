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

abstract class CreateTimeEntriesInvoiceRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CreateTimeEntriesInvoiceRequest._({
    required this.projectId,
    this.from,
    this.to,
    this.customerId,
    this.issueDate,
  });

  factory CreateTimeEntriesInvoiceRequest({
    required int projectId,
    DateTime? from,
    DateTime? to,
    int? customerId,
    DateTime? issueDate,
  }) = _CreateTimeEntriesInvoiceRequestImpl;

  factory CreateTimeEntriesInvoiceRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateTimeEntriesInvoiceRequest(
      projectId: jsonSerialization['projectId'] as int,
      from: jsonSerialization['from'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['from']),
      to: jsonSerialization['to'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['to']),
      customerId: jsonSerialization['customerId'] as int?,
      issueDate: jsonSerialization['issueDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['issueDate']),
    );
  }

  int projectId;

  DateTime? from;

  DateTime? to;

  int? customerId;

  DateTime? issueDate;

  /// Returns a shallow copy of this [CreateTimeEntriesInvoiceRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreateTimeEntriesInvoiceRequest copyWith({
    int? projectId,
    DateTime? from,
    DateTime? to,
    int? customerId,
    DateTime? issueDate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateTimeEntriesInvoiceRequest',
      'projectId': projectId,
      if (from != null) 'from': from?.toJson(),
      if (to != null) 'to': to?.toJson(),
      if (customerId != null) 'customerId': customerId,
      if (issueDate != null) 'issueDate': issueDate?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CreateTimeEntriesInvoiceRequest',
      'projectId': projectId,
      if (from != null) 'from': from?.toJson(),
      if (to != null) 'to': to?.toJson(),
      if (customerId != null) 'customerId': customerId,
      if (issueDate != null) 'issueDate': issueDate?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateTimeEntriesInvoiceRequestImpl
    extends CreateTimeEntriesInvoiceRequest {
  _CreateTimeEntriesInvoiceRequestImpl({
    required int projectId,
    DateTime? from,
    DateTime? to,
    int? customerId,
    DateTime? issueDate,
  }) : super._(
         projectId: projectId,
         from: from,
         to: to,
         customerId: customerId,
         issueDate: issueDate,
       );

  /// Returns a shallow copy of this [CreateTimeEntriesInvoiceRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreateTimeEntriesInvoiceRequest copyWith({
    int? projectId,
    Object? from = _Undefined,
    Object? to = _Undefined,
    Object? customerId = _Undefined,
    Object? issueDate = _Undefined,
  }) {
    return CreateTimeEntriesInvoiceRequest(
      projectId: projectId ?? this.projectId,
      from: from is DateTime? ? from : this.from,
      to: to is DateTime? ? to : this.to,
      customerId: customerId is int? ? customerId : this.customerId,
      issueDate: issueDate is DateTime? ? issueDate : this.issueDate,
    );
  }
}
