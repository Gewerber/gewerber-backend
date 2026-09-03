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
import '../../../modules/dashboard/models/debtor_summary.dart' as _iu6gdls1;
import '../../../modules/invoicing/models/invoice.dart' as _i2lykh97;

abstract class ReceivablesSummary
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ReceivablesSummary._({
    required this.openInvoicesCount,
    required this.openTotalCents,
    required this.overdueCount,
    required this.overdueTotalCents,
    required this.debtors,
    required this.overdueInvoices,
  });

  factory ReceivablesSummary({
    required int openInvoicesCount,
    required int openTotalCents,
    required int overdueCount,
    required int overdueTotalCents,
    required List<_iu6gdls1.DebtorSummary> debtors,
    required List<_i2lykh97.Invoice> overdueInvoices,
  }) = _ReceivablesSummaryImpl;

  factory ReceivablesSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReceivablesSummary(
      openInvoicesCount: jsonSerialization['openInvoicesCount'] as int,
      openTotalCents: jsonSerialization['openTotalCents'] as int,
      overdueCount: jsonSerialization['overdueCount'] as int,
      overdueTotalCents: jsonSerialization['overdueTotalCents'] as int,
      debtors: _iipbhyvd.Protocol().deserialize<List<_iu6gdls1.DebtorSummary>>(
        jsonSerialization['debtors'],
      ),
      overdueInvoices: _iipbhyvd.Protocol()
          .deserialize<List<_i2lykh97.Invoice>>(
            jsonSerialization['overdueInvoices'],
          ),
    );
  }

  int openInvoicesCount;

  int openTotalCents;

  int overdueCount;

  int overdueTotalCents;

  List<_iu6gdls1.DebtorSummary> debtors;

  List<_i2lykh97.Invoice> overdueInvoices;

  /// Returns a shallow copy of this [ReceivablesSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ReceivablesSummary copyWith({
    int? openInvoicesCount,
    int? openTotalCents,
    int? overdueCount,
    int? overdueTotalCents,
    List<_iu6gdls1.DebtorSummary>? debtors,
    List<_i2lykh97.Invoice>? overdueInvoices,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReceivablesSummary',
      'openInvoicesCount': openInvoicesCount,
      'openTotalCents': openTotalCents,
      'overdueCount': overdueCount,
      'overdueTotalCents': overdueTotalCents,
      'debtors': debtors.toJson(valueToJson: (v) => v.toJson()),
      'overdueInvoices': overdueInvoices.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReceivablesSummary',
      'openInvoicesCount': openInvoicesCount,
      'openTotalCents': openTotalCents,
      'overdueCount': overdueCount,
      'overdueTotalCents': overdueTotalCents,
      'debtors': debtors.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'overdueInvoices': overdueInvoices.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ReceivablesSummaryImpl extends ReceivablesSummary {
  _ReceivablesSummaryImpl({
    required int openInvoicesCount,
    required int openTotalCents,
    required int overdueCount,
    required int overdueTotalCents,
    required List<_iu6gdls1.DebtorSummary> debtors,
    required List<_i2lykh97.Invoice> overdueInvoices,
  }) : super._(
         openInvoicesCount: openInvoicesCount,
         openTotalCents: openTotalCents,
         overdueCount: overdueCount,
         overdueTotalCents: overdueTotalCents,
         debtors: debtors,
         overdueInvoices: overdueInvoices,
       );

  /// Returns a shallow copy of this [ReceivablesSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ReceivablesSummary copyWith({
    int? openInvoicesCount,
    int? openTotalCents,
    int? overdueCount,
    int? overdueTotalCents,
    List<_iu6gdls1.DebtorSummary>? debtors,
    List<_i2lykh97.Invoice>? overdueInvoices,
  }) {
    return ReceivablesSummary(
      openInvoicesCount: openInvoicesCount ?? this.openInvoicesCount,
      openTotalCents: openTotalCents ?? this.openTotalCents,
      overdueCount: overdueCount ?? this.overdueCount,
      overdueTotalCents: overdueTotalCents ?? this.overdueTotalCents,
      debtors: debtors ?? this.debtors.map((e0) => e0.copyWith()).toList(),
      overdueInvoices:
          overdueInvoices ??
          this.overdueInvoices.map((e0) => e0.copyWith()).toList(),
    );
  }
}
