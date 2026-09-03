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

abstract class CreateTimeEntriesInvoiceRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CreateTimeEntriesInvoiceRequest._({
    required this.projectId,
    this.from,
    this.to,
    this.customerId,
    this.issueDate,
    this.timeEntryIds,
  });

  factory CreateTimeEntriesInvoiceRequest({
    required int projectId,
    DateTime? from,
    DateTime? to,
    int? customerId,
    DateTime? issueDate,
    List<int>? timeEntryIds,
  }) = _CreateTimeEntriesInvoiceRequestImpl;

  factory CreateTimeEntriesInvoiceRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateTimeEntriesInvoiceRequest(
      projectId: jsonSerialization['projectId'] as int,
      from: jsonSerialization['from'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['from']),
      to: jsonSerialization['to'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['to']),
      customerId: jsonSerialization['customerId'] as int?,
      issueDate: jsonSerialization['issueDate'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['issueDate']),
      timeEntryIds: jsonSerialization['timeEntryIds'] == null
          ? null
          : _iipbhyvd.Protocol().deserialize<List<int>>(
              jsonSerialization['timeEntryIds'],
            ),
    );
  }

  int projectId;

  DateTime? from;

  DateTime? to;

  int? customerId;

  DateTime? issueDate;

  List<int>? timeEntryIds;

  /// Returns a shallow copy of this [CreateTimeEntriesInvoiceRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CreateTimeEntriesInvoiceRequest copyWith({
    int? projectId,
    DateTime? from,
    DateTime? to,
    int? customerId,
    DateTime? issueDate,
    List<int>? timeEntryIds,
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
      if (timeEntryIds != null) 'timeEntryIds': timeEntryIds?.toJson(),
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
      if (timeEntryIds != null) 'timeEntryIds': timeEntryIds?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
    List<int>? timeEntryIds,
  }) : super._(
         projectId: projectId,
         from: from,
         to: to,
         customerId: customerId,
         issueDate: issueDate,
         timeEntryIds: timeEntryIds,
       );

  /// Returns a shallow copy of this [CreateTimeEntriesInvoiceRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CreateTimeEntriesInvoiceRequest copyWith({
    int? projectId,
    Object? from = _Undefined,
    Object? to = _Undefined,
    Object? customerId = _Undefined,
    Object? issueDate = _Undefined,
    Object? timeEntryIds = _Undefined,
  }) {
    return CreateTimeEntriesInvoiceRequest(
      projectId: projectId ?? this.projectId,
      from: from is DateTime? ? from : this.from,
      to: to is DateTime? ? to : this.to,
      customerId: customerId is int? ? customerId : this.customerId,
      issueDate: issueDate is DateTime? ? issueDate : this.issueDate,
      timeEntryIds: timeEntryIds is List<int>?
          ? timeEntryIds
          : this.timeEntryIds?.map((e0) => e0).toList(),
    );
  }
}
