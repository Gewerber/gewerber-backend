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
import '../../../modules/time_tracking/models/time_report_line.dart'
    as _iudwqilh;

abstract class TimeReport
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  TimeReport._({
    required this.from,
    required this.to,
    required this.totalMinutes,
    required this.billableMinutes,
    required this.roundedMinutes,
    required this.lines,
  });

  factory TimeReport({
    required DateTime from,
    required DateTime to,
    required int totalMinutes,
    required int billableMinutes,
    required int roundedMinutes,
    required List<_iudwqilh.TimeReportLine> lines,
  }) = _TimeReportImpl;

  factory TimeReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return TimeReport(
      from: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['from']),
      to: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['to']),
      totalMinutes: jsonSerialization['totalMinutes'] as int,
      billableMinutes: jsonSerialization['billableMinutes'] as int,
      roundedMinutes: jsonSerialization['roundedMinutes'] as int,
      lines: _iipbhyvd.Protocol().deserialize<List<_iudwqilh.TimeReportLine>>(
        jsonSerialization['lines'],
      ),
    );
  }

  DateTime from;

  DateTime to;

  int totalMinutes;

  int billableMinutes;

  int roundedMinutes;

  List<_iudwqilh.TimeReportLine> lines;

  /// Returns a shallow copy of this [TimeReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  TimeReport copyWith({
    DateTime? from,
    DateTime? to,
    int? totalMinutes,
    int? billableMinutes,
    int? roundedMinutes,
    List<_iudwqilh.TimeReportLine>? lines,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TimeReport',
      'from': from.toJson(),
      'to': to.toJson(),
      'totalMinutes': totalMinutes,
      'billableMinutes': billableMinutes,
      'roundedMinutes': roundedMinutes,
      'lines': lines.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TimeReport',
      'from': from.toJson(),
      'to': to.toJson(),
      'totalMinutes': totalMinutes,
      'billableMinutes': billableMinutes,
      'roundedMinutes': roundedMinutes,
      'lines': lines.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _TimeReportImpl extends TimeReport {
  _TimeReportImpl({
    required DateTime from,
    required DateTime to,
    required int totalMinutes,
    required int billableMinutes,
    required int roundedMinutes,
    required List<_iudwqilh.TimeReportLine> lines,
  }) : super._(
         from: from,
         to: to,
         totalMinutes: totalMinutes,
         billableMinutes: billableMinutes,
         roundedMinutes: roundedMinutes,
         lines: lines,
       );

  /// Returns a shallow copy of this [TimeReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  TimeReport copyWith({
    DateTime? from,
    DateTime? to,
    int? totalMinutes,
    int? billableMinutes,
    int? roundedMinutes,
    List<_iudwqilh.TimeReportLine>? lines,
  }) {
    return TimeReport(
      from: from ?? this.from,
      to: to ?? this.to,
      totalMinutes: totalMinutes ?? this.totalMinutes,
      billableMinutes: billableMinutes ?? this.billableMinutes,
      roundedMinutes: roundedMinutes ?? this.roundedMinutes,
      lines: lines ?? this.lines.map((e0) => e0.copyWith()).toList(),
    );
  }
}
