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
import '../../../modules/business/models/currency.dart' as _i80byysb;
import '../../../modules/business/models/locale.dart' as _ie5v8zdc;
import '../../../modules/invoicing/models/invoice_status.dart' as _ib459vd4;
import '../../../modules/invoicing/models/invoice_type.dart' as _i4s57tlu;
import '../../../modules/invoicing/models/recurrence_interval.dart'
    as _i2jlpxj3;

abstract class Invoice
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Invoice._({
    this.id,
    required this.businessId,
    required this.number,
    _i4s57tlu.InvoiceType? type,
    _ib459vd4.InvoiceStatus? status,
    this.customerId,
    required this.issueDate,
    this.dueDate,
    this.serviceDateFrom,
    this.serviceDateTo,
    _ie5v8zdc.Locale? locale,
    _i80byysb.Currency? currency,
    int? subtotalCents,
    int? vatTotalCents,
    int? totalCents,
    int? paymentTermsDays,
    int? dunningLevel,
    this.notes,
    this.templateId,
    this.pdfDocumentId,
    this.recurrenceInterval,
    this.nextRecurrenceDate,
    this.recurrenceEndDate,
    this.recurrenceMaxOccurrences,
    int? recurrenceOccurrencesCreated,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : type = type ?? _i4s57tlu.InvoiceType.invoice,
       status = status ?? _ib459vd4.InvoiceStatus.draft,
       locale = locale ?? _ie5v8zdc.Locale.de,
       currency = currency ?? _i80byysb.Currency.eur,
       subtotalCents = subtotalCents ?? 0,
       vatTotalCents = vatTotalCents ?? 0,
       totalCents = totalCents ?? 0,
       paymentTermsDays = paymentTermsDays ?? 14,
       dunningLevel = dunningLevel ?? 0,
       recurrenceOccurrencesCreated = recurrenceOccurrencesCreated ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Invoice({
    int? id,
    required int businessId,
    required String number,
    _i4s57tlu.InvoiceType? type,
    _ib459vd4.InvoiceStatus? status,
    int? customerId,
    required DateTime issueDate,
    DateTime? dueDate,
    DateTime? serviceDateFrom,
    DateTime? serviceDateTo,
    _ie5v8zdc.Locale? locale,
    _i80byysb.Currency? currency,
    int? subtotalCents,
    int? vatTotalCents,
    int? totalCents,
    int? paymentTermsDays,
    int? dunningLevel,
    String? notes,
    int? templateId,
    int? pdfDocumentId,
    _i2jlpxj3.RecurrenceInterval? recurrenceInterval,
    DateTime? nextRecurrenceDate,
    DateTime? recurrenceEndDate,
    int? recurrenceMaxOccurrences,
    int? recurrenceOccurrencesCreated,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _InvoiceImpl;

  factory Invoice.fromJson(Map<String, dynamic> jsonSerialization) {
    return Invoice(
      id: jsonSerialization['id'] as int?,
      businessId: jsonSerialization['businessId'] as int,
      number: jsonSerialization['number'] as String,
      type: jsonSerialization['type'] == null
          ? null
          : _i4s57tlu.InvoiceType.fromJson(
              (jsonSerialization['type'] as String),
            ),
      status: jsonSerialization['status'] == null
          ? null
          : _ib459vd4.InvoiceStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      customerId: jsonSerialization['customerId'] as int?,
      issueDate: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['issueDate'],
      ),
      dueDate: jsonSerialization['dueDate'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['dueDate']),
      serviceDateFrom: jsonSerialization['serviceDateFrom'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['serviceDateFrom'],
            ),
      serviceDateTo: jsonSerialization['serviceDateTo'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['serviceDateTo'],
            ),
      locale: jsonSerialization['locale'] == null
          ? null
          : _ie5v8zdc.Locale.fromJson((jsonSerialization['locale'] as String)),
      currency: jsonSerialization['currency'] == null
          ? null
          : _i80byysb.Currency.fromJson(
              (jsonSerialization['currency'] as String),
            ),
      subtotalCents: jsonSerialization['subtotalCents'] as int?,
      vatTotalCents: jsonSerialization['vatTotalCents'] as int?,
      totalCents: jsonSerialization['totalCents'] as int?,
      paymentTermsDays: jsonSerialization['paymentTermsDays'] as int?,
      dunningLevel: jsonSerialization['dunningLevel'] as int?,
      notes: jsonSerialization['notes'] as String?,
      templateId: jsonSerialization['templateId'] as int?,
      pdfDocumentId: jsonSerialization['pdfDocumentId'] as int?,
      recurrenceInterval: jsonSerialization['recurrenceInterval'] == null
          ? null
          : _i2jlpxj3.RecurrenceInterval.fromJson(
              (jsonSerialization['recurrenceInterval'] as String),
            ),
      nextRecurrenceDate: jsonSerialization['nextRecurrenceDate'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['nextRecurrenceDate'],
            ),
      recurrenceEndDate: jsonSerialization['recurrenceEndDate'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['recurrenceEndDate'],
            ),
      recurrenceMaxOccurrences:
          jsonSerialization['recurrenceMaxOccurrences'] as int?,
      recurrenceOccurrencesCreated:
          jsonSerialization['recurrenceOccurrencesCreated'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = InvoiceTable();

  static const db = InvoiceRepository._();

  @override
  int? id;

  int businessId;

  String number;

  _i4s57tlu.InvoiceType type;

  _ib459vd4.InvoiceStatus status;

  int? customerId;

  DateTime issueDate;

  DateTime? dueDate;

  DateTime? serviceDateFrom;

  DateTime? serviceDateTo;

  _ie5v8zdc.Locale locale;

  _i80byysb.Currency currency;

  int subtotalCents;

  int vatTotalCents;

  int totalCents;

  int paymentTermsDays;

  int dunningLevel;

  String? notes;

  int? templateId;

  int? pdfDocumentId;

  _i2jlpxj3.RecurrenceInterval? recurrenceInterval;

  DateTime? nextRecurrenceDate;

  DateTime? recurrenceEndDate;

  int? recurrenceMaxOccurrences;

  int recurrenceOccurrencesCreated;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Invoice]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Invoice copyWith({
    int? id,
    int? businessId,
    String? number,
    _i4s57tlu.InvoiceType? type,
    _ib459vd4.InvoiceStatus? status,
    int? customerId,
    DateTime? issueDate,
    DateTime? dueDate,
    DateTime? serviceDateFrom,
    DateTime? serviceDateTo,
    _ie5v8zdc.Locale? locale,
    _i80byysb.Currency? currency,
    int? subtotalCents,
    int? vatTotalCents,
    int? totalCents,
    int? paymentTermsDays,
    int? dunningLevel,
    String? notes,
    int? templateId,
    int? pdfDocumentId,
    _i2jlpxj3.RecurrenceInterval? recurrenceInterval,
    DateTime? nextRecurrenceDate,
    DateTime? recurrenceEndDate,
    int? recurrenceMaxOccurrences,
    int? recurrenceOccurrencesCreated,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Invoice',
      if (id != null) 'id': id,
      'businessId': businessId,
      'number': number,
      'type': type.toJson(),
      'status': status.toJson(),
      if (customerId != null) 'customerId': customerId,
      'issueDate': issueDate.toJson(),
      if (dueDate != null) 'dueDate': dueDate?.toJson(),
      if (serviceDateFrom != null) 'serviceDateFrom': serviceDateFrom?.toJson(),
      if (serviceDateTo != null) 'serviceDateTo': serviceDateTo?.toJson(),
      'locale': locale.toJson(),
      'currency': currency.toJson(),
      'subtotalCents': subtotalCents,
      'vatTotalCents': vatTotalCents,
      'totalCents': totalCents,
      'paymentTermsDays': paymentTermsDays,
      'dunningLevel': dunningLevel,
      if (notes != null) 'notes': notes,
      if (templateId != null) 'templateId': templateId,
      if (pdfDocumentId != null) 'pdfDocumentId': pdfDocumentId,
      if (recurrenceInterval != null)
        'recurrenceInterval': recurrenceInterval?.toJson(),
      if (nextRecurrenceDate != null)
        'nextRecurrenceDate': nextRecurrenceDate?.toJson(),
      if (recurrenceEndDate != null)
        'recurrenceEndDate': recurrenceEndDate?.toJson(),
      if (recurrenceMaxOccurrences != null)
        'recurrenceMaxOccurrences': recurrenceMaxOccurrences,
      'recurrenceOccurrencesCreated': recurrenceOccurrencesCreated,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Invoice',
      if (id != null) 'id': id,
      'businessId': businessId,
      'number': number,
      'type': type.toJson(),
      'status': status.toJson(),
      if (customerId != null) 'customerId': customerId,
      'issueDate': issueDate.toJson(),
      if (dueDate != null) 'dueDate': dueDate?.toJson(),
      if (serviceDateFrom != null) 'serviceDateFrom': serviceDateFrom?.toJson(),
      if (serviceDateTo != null) 'serviceDateTo': serviceDateTo?.toJson(),
      'locale': locale.toJson(),
      'currency': currency.toJson(),
      'subtotalCents': subtotalCents,
      'vatTotalCents': vatTotalCents,
      'totalCents': totalCents,
      'paymentTermsDays': paymentTermsDays,
      'dunningLevel': dunningLevel,
      if (notes != null) 'notes': notes,
      if (templateId != null) 'templateId': templateId,
      if (pdfDocumentId != null) 'pdfDocumentId': pdfDocumentId,
      if (recurrenceInterval != null)
        'recurrenceInterval': recurrenceInterval?.toJson(),
      if (nextRecurrenceDate != null)
        'nextRecurrenceDate': nextRecurrenceDate?.toJson(),
      if (recurrenceEndDate != null)
        'recurrenceEndDate': recurrenceEndDate?.toJson(),
      if (recurrenceMaxOccurrences != null)
        'recurrenceMaxOccurrences': recurrenceMaxOccurrences,
      'recurrenceOccurrencesCreated': recurrenceOccurrencesCreated,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static InvoiceInclude include() {
    return InvoiceInclude._();
  }

  static InvoiceIncludeList includeList({
    _is.WhereExpressionBuilder<InvoiceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InvoiceTable>? orderBy,
    _is.OrderByListBuilder<InvoiceTable>? orderByList,
    InvoiceInclude? include,
  }) {
    return InvoiceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Invoice.t),
      orderByList: orderByList?.call(Invoice.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InvoiceImpl extends Invoice {
  _InvoiceImpl({
    int? id,
    required int businessId,
    required String number,
    _i4s57tlu.InvoiceType? type,
    _ib459vd4.InvoiceStatus? status,
    int? customerId,
    required DateTime issueDate,
    DateTime? dueDate,
    DateTime? serviceDateFrom,
    DateTime? serviceDateTo,
    _ie5v8zdc.Locale? locale,
    _i80byysb.Currency? currency,
    int? subtotalCents,
    int? vatTotalCents,
    int? totalCents,
    int? paymentTermsDays,
    int? dunningLevel,
    String? notes,
    int? templateId,
    int? pdfDocumentId,
    _i2jlpxj3.RecurrenceInterval? recurrenceInterval,
    DateTime? nextRecurrenceDate,
    DateTime? recurrenceEndDate,
    int? recurrenceMaxOccurrences,
    int? recurrenceOccurrencesCreated,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         businessId: businessId,
         number: number,
         type: type,
         status: status,
         customerId: customerId,
         issueDate: issueDate,
         dueDate: dueDate,
         serviceDateFrom: serviceDateFrom,
         serviceDateTo: serviceDateTo,
         locale: locale,
         currency: currency,
         subtotalCents: subtotalCents,
         vatTotalCents: vatTotalCents,
         totalCents: totalCents,
         paymentTermsDays: paymentTermsDays,
         dunningLevel: dunningLevel,
         notes: notes,
         templateId: templateId,
         pdfDocumentId: pdfDocumentId,
         recurrenceInterval: recurrenceInterval,
         nextRecurrenceDate: nextRecurrenceDate,
         recurrenceEndDate: recurrenceEndDate,
         recurrenceMaxOccurrences: recurrenceMaxOccurrences,
         recurrenceOccurrencesCreated: recurrenceOccurrencesCreated,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Invoice]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Invoice copyWith({
    Object? id = _Undefined,
    int? businessId,
    String? number,
    _i4s57tlu.InvoiceType? type,
    _ib459vd4.InvoiceStatus? status,
    Object? customerId = _Undefined,
    DateTime? issueDate,
    Object? dueDate = _Undefined,
    Object? serviceDateFrom = _Undefined,
    Object? serviceDateTo = _Undefined,
    _ie5v8zdc.Locale? locale,
    _i80byysb.Currency? currency,
    int? subtotalCents,
    int? vatTotalCents,
    int? totalCents,
    int? paymentTermsDays,
    int? dunningLevel,
    Object? notes = _Undefined,
    Object? templateId = _Undefined,
    Object? pdfDocumentId = _Undefined,
    Object? recurrenceInterval = _Undefined,
    Object? nextRecurrenceDate = _Undefined,
    Object? recurrenceEndDate = _Undefined,
    Object? recurrenceMaxOccurrences = _Undefined,
    int? recurrenceOccurrencesCreated,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Invoice(
      id: id is int? ? id : this.id,
      businessId: businessId ?? this.businessId,
      number: number ?? this.number,
      type: type ?? this.type,
      status: status ?? this.status,
      customerId: customerId is int? ? customerId : this.customerId,
      issueDate: issueDate ?? this.issueDate,
      dueDate: dueDate is DateTime? ? dueDate : this.dueDate,
      serviceDateFrom: serviceDateFrom is DateTime?
          ? serviceDateFrom
          : this.serviceDateFrom,
      serviceDateTo: serviceDateTo is DateTime?
          ? serviceDateTo
          : this.serviceDateTo,
      locale: locale ?? this.locale,
      currency: currency ?? this.currency,
      subtotalCents: subtotalCents ?? this.subtotalCents,
      vatTotalCents: vatTotalCents ?? this.vatTotalCents,
      totalCents: totalCents ?? this.totalCents,
      paymentTermsDays: paymentTermsDays ?? this.paymentTermsDays,
      dunningLevel: dunningLevel ?? this.dunningLevel,
      notes: notes is String? ? notes : this.notes,
      templateId: templateId is int? ? templateId : this.templateId,
      pdfDocumentId: pdfDocumentId is int? ? pdfDocumentId : this.pdfDocumentId,
      recurrenceInterval: recurrenceInterval is _i2jlpxj3.RecurrenceInterval?
          ? recurrenceInterval
          : this.recurrenceInterval,
      nextRecurrenceDate: nextRecurrenceDate is DateTime?
          ? nextRecurrenceDate
          : this.nextRecurrenceDate,
      recurrenceEndDate: recurrenceEndDate is DateTime?
          ? recurrenceEndDate
          : this.recurrenceEndDate,
      recurrenceMaxOccurrences: recurrenceMaxOccurrences is int?
          ? recurrenceMaxOccurrences
          : this.recurrenceMaxOccurrences,
      recurrenceOccurrencesCreated:
          recurrenceOccurrencesCreated ?? this.recurrenceOccurrencesCreated,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class InvoiceUpdateTable extends _is.UpdateTable<InvoiceTable> {
  InvoiceUpdateTable(super.table);

  _is.ColumnValue<int, int> businessId(int value) => _is.ColumnValue(
    table.businessId,
    value,
  );

  _is.ColumnValue<String, String> number(String value) => _is.ColumnValue(
    table.number,
    value,
  );

  _is.ColumnValue<_i4s57tlu.InvoiceType, _i4s57tlu.InvoiceType> type(
    _i4s57tlu.InvoiceType value,
  ) => _is.ColumnValue(
    table.type,
    value,
  );

  _is.ColumnValue<_ib459vd4.InvoiceStatus, _ib459vd4.InvoiceStatus> status(
    _ib459vd4.InvoiceStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<int, int> customerId(int? value) => _is.ColumnValue(
    table.customerId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> issueDate(DateTime value) =>
      _is.ColumnValue(
        table.issueDate,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> dueDate(DateTime? value) =>
      _is.ColumnValue(
        table.dueDate,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> serviceDateFrom(DateTime? value) =>
      _is.ColumnValue(
        table.serviceDateFrom,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> serviceDateTo(DateTime? value) =>
      _is.ColumnValue(
        table.serviceDateTo,
        value,
      );

  _is.ColumnValue<_ie5v8zdc.Locale, _ie5v8zdc.Locale> locale(
    _ie5v8zdc.Locale value,
  ) => _is.ColumnValue(
    table.locale,
    value,
  );

  _is.ColumnValue<_i80byysb.Currency, _i80byysb.Currency> currency(
    _i80byysb.Currency value,
  ) => _is.ColumnValue(
    table.currency,
    value,
  );

  _is.ColumnValue<int, int> subtotalCents(int value) => _is.ColumnValue(
    table.subtotalCents,
    value,
  );

  _is.ColumnValue<int, int> vatTotalCents(int value) => _is.ColumnValue(
    table.vatTotalCents,
    value,
  );

  _is.ColumnValue<int, int> totalCents(int value) => _is.ColumnValue(
    table.totalCents,
    value,
  );

  _is.ColumnValue<int, int> paymentTermsDays(int value) => _is.ColumnValue(
    table.paymentTermsDays,
    value,
  );

  _is.ColumnValue<int, int> dunningLevel(int value) => _is.ColumnValue(
    table.dunningLevel,
    value,
  );

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(
    table.notes,
    value,
  );

  _is.ColumnValue<int, int> templateId(int? value) => _is.ColumnValue(
    table.templateId,
    value,
  );

  _is.ColumnValue<int, int> pdfDocumentId(int? value) => _is.ColumnValue(
    table.pdfDocumentId,
    value,
  );

  _is.ColumnValue<_i2jlpxj3.RecurrenceInterval, _i2jlpxj3.RecurrenceInterval>
  recurrenceInterval(_i2jlpxj3.RecurrenceInterval? value) => _is.ColumnValue(
    table.recurrenceInterval,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> nextRecurrenceDate(DateTime? value) =>
      _is.ColumnValue(
        table.nextRecurrenceDate,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> recurrenceEndDate(DateTime? value) =>
      _is.ColumnValue(
        table.recurrenceEndDate,
        value,
      );

  _is.ColumnValue<int, int> recurrenceMaxOccurrences(int? value) =>
      _is.ColumnValue(
        table.recurrenceMaxOccurrences,
        value,
      );

  _is.ColumnValue<int, int> recurrenceOccurrencesCreated(int value) =>
      _is.ColumnValue(
        table.recurrenceOccurrencesCreated,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class InvoiceTable extends _is.Table<int?> {
  InvoiceTable({super.tableRelation}) : super(tableName: 'invoice') {
    updateTable = InvoiceUpdateTable(this);
    businessId = _is.ColumnInt(
      'businessId',
      this,
    );
    number = _is.ColumnString(
      'number',
      this,
    );
    type = _is.ColumnEnum(
      'type',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    customerId = _is.ColumnInt(
      'customerId',
      this,
    );
    issueDate = _is.ColumnDateTime(
      'issueDate',
      this,
    );
    dueDate = _is.ColumnDateTime(
      'dueDate',
      this,
    );
    serviceDateFrom = _is.ColumnDateTime(
      'serviceDateFrom',
      this,
    );
    serviceDateTo = _is.ColumnDateTime(
      'serviceDateTo',
      this,
    );
    locale = _is.ColumnEnum(
      'locale',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    currency = _is.ColumnEnum(
      'currency',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    subtotalCents = _is.ColumnInt(
      'subtotalCents',
      this,
      hasDefault: true,
    );
    vatTotalCents = _is.ColumnInt(
      'vatTotalCents',
      this,
      hasDefault: true,
    );
    totalCents = _is.ColumnInt(
      'totalCents',
      this,
      hasDefault: true,
    );
    paymentTermsDays = _is.ColumnInt(
      'paymentTermsDays',
      this,
      hasDefault: true,
    );
    dunningLevel = _is.ColumnInt(
      'dunningLevel',
      this,
      hasDefault: true,
    );
    notes = _is.ColumnString(
      'notes',
      this,
    );
    templateId = _is.ColumnInt(
      'templateId',
      this,
    );
    pdfDocumentId = _is.ColumnInt(
      'pdfDocumentId',
      this,
    );
    recurrenceInterval = _is.ColumnEnum(
      'recurrenceInterval',
      this,
      _is.EnumSerialization.byName,
    );
    nextRecurrenceDate = _is.ColumnDateTime(
      'nextRecurrenceDate',
      this,
    );
    recurrenceEndDate = _is.ColumnDateTime(
      'recurrenceEndDate',
      this,
    );
    recurrenceMaxOccurrences = _is.ColumnInt(
      'recurrenceMaxOccurrences',
      this,
    );
    recurrenceOccurrencesCreated = _is.ColumnInt(
      'recurrenceOccurrencesCreated',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final InvoiceUpdateTable updateTable;

  late final _is.ColumnInt businessId;

  late final _is.ColumnString number;

  late final _is.ColumnEnum<_i4s57tlu.InvoiceType> type;

  late final _is.ColumnEnum<_ib459vd4.InvoiceStatus> status;

  late final _is.ColumnInt customerId;

  late final _is.ColumnDateTime issueDate;

  late final _is.ColumnDateTime dueDate;

  late final _is.ColumnDateTime serviceDateFrom;

  late final _is.ColumnDateTime serviceDateTo;

  late final _is.ColumnEnum<_ie5v8zdc.Locale> locale;

  late final _is.ColumnEnum<_i80byysb.Currency> currency;

  late final _is.ColumnInt subtotalCents;

  late final _is.ColumnInt vatTotalCents;

  late final _is.ColumnInt totalCents;

  late final _is.ColumnInt paymentTermsDays;

  late final _is.ColumnInt dunningLevel;

  late final _is.ColumnString notes;

  late final _is.ColumnInt templateId;

  late final _is.ColumnInt pdfDocumentId;

  late final _is.ColumnEnum<_i2jlpxj3.RecurrenceInterval> recurrenceInterval;

  late final _is.ColumnDateTime nextRecurrenceDate;

  late final _is.ColumnDateTime recurrenceEndDate;

  late final _is.ColumnInt recurrenceMaxOccurrences;

  late final _is.ColumnInt recurrenceOccurrencesCreated;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    businessId,
    number,
    type,
    status,
    customerId,
    issueDate,
    dueDate,
    serviceDateFrom,
    serviceDateTo,
    locale,
    currency,
    subtotalCents,
    vatTotalCents,
    totalCents,
    paymentTermsDays,
    dunningLevel,
    notes,
    templateId,
    pdfDocumentId,
    recurrenceInterval,
    nextRecurrenceDate,
    recurrenceEndDate,
    recurrenceMaxOccurrences,
    recurrenceOccurrencesCreated,
    createdAt,
    updatedAt,
  ];
}

class InvoiceInclude extends _is.IncludeObject {
  InvoiceInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Invoice.t;
}

class InvoiceIncludeList extends _is.IncludeList {
  InvoiceIncludeList._({
    _is.WhereExpressionBuilder<InvoiceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Invoice.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Invoice.t;
}

class InvoiceRepository {
  const InvoiceRepository._();

  /// Returns a list of [Invoice]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Invoice>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InvoiceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InvoiceTable>? orderBy,
    _is.OrderByListBuilder<InvoiceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Invoice>(
      where: where?.call(Invoice.t),
      orderBy: orderBy?.call(Invoice.t),
      orderByList: orderByList?.call(Invoice.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Invoice] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Invoice?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InvoiceTable>? where,
    int? offset,
    _is.OrderByBuilder<InvoiceTable>? orderBy,
    _is.OrderByListBuilder<InvoiceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Invoice>(
      where: where?.call(Invoice.t),
      orderBy: orderBy?.call(Invoice.t),
      orderByList: orderByList?.call(Invoice.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Invoice] by its [id] or null if no such row exists.
  Future<Invoice?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Invoice>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Invoice]s in the list and returns the inserted rows.
  ///
  /// The returned [Invoice]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Invoice>> insert(
    _is.DatabaseSession session,
    List<Invoice> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Invoice>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Invoice] and returns the inserted row.
  ///
  /// The returned [Invoice] will have its `id` field set.
  Future<Invoice> insertRow(
    _is.DatabaseSession session,
    Invoice row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Invoice>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Invoice]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Invoice]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Invoice>> upsert(
    _is.DatabaseSession session,
    List<Invoice> rows, {
    required _is.ColumnSelections<InvoiceTable> conflictColumns,
    _is.ColumnSelections<InvoiceTable>? updateColumns,
    _is.WhereExpressionBuilder<InvoiceTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Invoice>(
      rows,
      conflictColumns: conflictColumns(Invoice.t),
      updateColumns: updateColumns?.call(Invoice.t),
      updateWhere: updateWhere?.call(Invoice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Invoice] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Invoice] will have its `id` field set.
  Future<Invoice?> upsertRow(
    _is.DatabaseSession session,
    Invoice row, {
    required _is.ColumnSelections<InvoiceTable> conflictColumns,
    _is.ColumnSelections<InvoiceTable>? updateColumns,
    _is.WhereExpressionBuilder<InvoiceTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Invoice>(
      row,
      conflictColumns: conflictColumns(Invoice.t),
      updateColumns: updateColumns?.call(Invoice.t),
      updateWhere: updateWhere?.call(Invoice.t),
      transaction: transaction,
    );
  }

  /// Updates all [Invoice]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Invoice>> update(
    _is.DatabaseSession session,
    List<Invoice> rows, {
    _is.ColumnSelections<InvoiceTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Invoice>(
      rows,
      columns: columns?.call(Invoice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Invoice]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Invoice> updateRow(
    _is.DatabaseSession session,
    Invoice row, {
    _is.ColumnSelections<InvoiceTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Invoice>(
      row,
      columns: columns?.call(Invoice.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Invoice] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Invoice?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<InvoiceUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Invoice>(
      id,
      columnValues: columnValues(Invoice.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Invoice]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Invoice>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<InvoiceUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<InvoiceTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InvoiceTable>? orderBy,
    _is.OrderByListBuilder<InvoiceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Invoice>(
      columnValues: columnValues(Invoice.t.updateTable),
      where: where(Invoice.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Invoice.t),
      orderByList: orderByList?.call(Invoice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Invoice]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Invoice>> delete(
    _is.DatabaseSession session,
    List<Invoice> rows, {
    _is.OrderByBuilder<InvoiceTable>? orderBy,
    _is.OrderByListBuilder<InvoiceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Invoice>(
      rows,
      orderBy: orderBy?.call(Invoice.t),
      orderByList: orderByList?.call(Invoice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Invoice].
  Future<Invoice> deleteRow(
    _is.DatabaseSession session,
    Invoice row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Invoice>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Invoice>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InvoiceTable> where,
    _is.OrderByBuilder<InvoiceTable>? orderBy,
    _is.OrderByListBuilder<InvoiceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Invoice>(
      where: where(Invoice.t),
      orderBy: orderBy?.call(Invoice.t),
      orderByList: orderByList?.call(Invoice.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InvoiceTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Invoice>(
      where: where?.call(Invoice.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Invoice] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InvoiceTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Invoice>(
      where: where(Invoice.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
