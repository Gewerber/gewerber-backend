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
import '../../../modules/invoicing/models/invoice_type.dart' as _i2;
import '../../../modules/invoicing/models/invoice_status.dart' as _i3;
import '../../../modules/business/models/locale.dart' as _i4;
import '../../../modules/business/models/currency.dart' as _i5;
import '../../../modules/invoicing/models/recurrence_interval.dart' as _i6;

abstract class Invoice
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Invoice._({
    this.id,
    required this.businessId,
    required this.number,
    _i2.InvoiceType? type,
    _i3.InvoiceStatus? status,
    this.customerId,
    required this.issueDate,
    this.dueDate,
    this.serviceDateFrom,
    this.serviceDateTo,
    _i4.Locale? locale,
    _i5.Currency? currency,
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
  }) : type = type ?? _i2.InvoiceType.invoice,
       status = status ?? _i3.InvoiceStatus.draft,
       locale = locale ?? _i4.Locale.de,
       currency = currency ?? _i5.Currency.eur,
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
    _i2.InvoiceType? type,
    _i3.InvoiceStatus? status,
    int? customerId,
    required DateTime issueDate,
    DateTime? dueDate,
    DateTime? serviceDateFrom,
    DateTime? serviceDateTo,
    _i4.Locale? locale,
    _i5.Currency? currency,
    int? subtotalCents,
    int? vatTotalCents,
    int? totalCents,
    int? paymentTermsDays,
    int? dunningLevel,
    String? notes,
    int? templateId,
    int? pdfDocumentId,
    _i6.RecurrenceInterval? recurrenceInterval,
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
          : _i2.InvoiceType.fromJson((jsonSerialization['type'] as String)),
      status: jsonSerialization['status'] == null
          ? null
          : _i3.InvoiceStatus.fromJson((jsonSerialization['status'] as String)),
      customerId: jsonSerialization['customerId'] as int?,
      issueDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['issueDate'],
      ),
      dueDate: jsonSerialization['dueDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dueDate']),
      serviceDateFrom: jsonSerialization['serviceDateFrom'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['serviceDateFrom'],
            ),
      serviceDateTo: jsonSerialization['serviceDateTo'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['serviceDateTo'],
            ),
      locale: jsonSerialization['locale'] == null
          ? null
          : _i4.Locale.fromJson((jsonSerialization['locale'] as String)),
      currency: jsonSerialization['currency'] == null
          ? null
          : _i5.Currency.fromJson((jsonSerialization['currency'] as String)),
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
          : _i6.RecurrenceInterval.fromJson(
              (jsonSerialization['recurrenceInterval'] as String),
            ),
      nextRecurrenceDate: jsonSerialization['nextRecurrenceDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['nextRecurrenceDate'],
            ),
      recurrenceEndDate: jsonSerialization['recurrenceEndDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['recurrenceEndDate'],
            ),
      recurrenceMaxOccurrences:
          jsonSerialization['recurrenceMaxOccurrences'] as int?,
      recurrenceOccurrencesCreated:
          jsonSerialization['recurrenceOccurrencesCreated'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = InvoiceTable();

  static const db = InvoiceRepository._();

  @override
  int? id;

  int businessId;

  String number;

  _i2.InvoiceType type;

  _i3.InvoiceStatus status;

  int? customerId;

  DateTime issueDate;

  DateTime? dueDate;

  DateTime? serviceDateFrom;

  DateTime? serviceDateTo;

  _i4.Locale locale;

  _i5.Currency currency;

  int subtotalCents;

  int vatTotalCents;

  int totalCents;

  int paymentTermsDays;

  int dunningLevel;

  String? notes;

  int? templateId;

  int? pdfDocumentId;

  _i6.RecurrenceInterval? recurrenceInterval;

  DateTime? nextRecurrenceDate;

  DateTime? recurrenceEndDate;

  int? recurrenceMaxOccurrences;

  int recurrenceOccurrencesCreated;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Invoice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Invoice copyWith({
    int? id,
    int? businessId,
    String? number,
    _i2.InvoiceType? type,
    _i3.InvoiceStatus? status,
    int? customerId,
    DateTime? issueDate,
    DateTime? dueDate,
    DateTime? serviceDateFrom,
    DateTime? serviceDateTo,
    _i4.Locale? locale,
    _i5.Currency? currency,
    int? subtotalCents,
    int? vatTotalCents,
    int? totalCents,
    int? paymentTermsDays,
    int? dunningLevel,
    String? notes,
    int? templateId,
    int? pdfDocumentId,
    _i6.RecurrenceInterval? recurrenceInterval,
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
    _i1.WhereExpressionBuilder<InvoiceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InvoiceTable>? orderBy,
    _i1.OrderByListBuilder<InvoiceTable>? orderByList,
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
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InvoiceImpl extends Invoice {
  _InvoiceImpl({
    int? id,
    required int businessId,
    required String number,
    _i2.InvoiceType? type,
    _i3.InvoiceStatus? status,
    int? customerId,
    required DateTime issueDate,
    DateTime? dueDate,
    DateTime? serviceDateFrom,
    DateTime? serviceDateTo,
    _i4.Locale? locale,
    _i5.Currency? currency,
    int? subtotalCents,
    int? vatTotalCents,
    int? totalCents,
    int? paymentTermsDays,
    int? dunningLevel,
    String? notes,
    int? templateId,
    int? pdfDocumentId,
    _i6.RecurrenceInterval? recurrenceInterval,
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
  @_i1.useResult
  @override
  Invoice copyWith({
    Object? id = _Undefined,
    int? businessId,
    String? number,
    _i2.InvoiceType? type,
    _i3.InvoiceStatus? status,
    Object? customerId = _Undefined,
    DateTime? issueDate,
    Object? dueDate = _Undefined,
    Object? serviceDateFrom = _Undefined,
    Object? serviceDateTo = _Undefined,
    _i4.Locale? locale,
    _i5.Currency? currency,
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
      recurrenceInterval: recurrenceInterval is _i6.RecurrenceInterval?
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

class InvoiceUpdateTable extends _i1.UpdateTable<InvoiceTable> {
  InvoiceUpdateTable(super.table);

  _i1.ColumnValue<int, int> businessId(int value) => _i1.ColumnValue(
    table.businessId,
    value,
  );

  _i1.ColumnValue<String, String> number(String value) => _i1.ColumnValue(
    table.number,
    value,
  );

  _i1.ColumnValue<_i2.InvoiceType, _i2.InvoiceType> type(
    _i2.InvoiceType value,
  ) => _i1.ColumnValue(
    table.type,
    value,
  );

  _i1.ColumnValue<_i3.InvoiceStatus, _i3.InvoiceStatus> status(
    _i3.InvoiceStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> customerId(int? value) => _i1.ColumnValue(
    table.customerId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> issueDate(DateTime value) =>
      _i1.ColumnValue(
        table.issueDate,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> dueDate(DateTime? value) =>
      _i1.ColumnValue(
        table.dueDate,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> serviceDateFrom(DateTime? value) =>
      _i1.ColumnValue(
        table.serviceDateFrom,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> serviceDateTo(DateTime? value) =>
      _i1.ColumnValue(
        table.serviceDateTo,
        value,
      );

  _i1.ColumnValue<_i4.Locale, _i4.Locale> locale(_i4.Locale value) =>
      _i1.ColumnValue(
        table.locale,
        value,
      );

  _i1.ColumnValue<_i5.Currency, _i5.Currency> currency(_i5.Currency value) =>
      _i1.ColumnValue(
        table.currency,
        value,
      );

  _i1.ColumnValue<int, int> subtotalCents(int value) => _i1.ColumnValue(
    table.subtotalCents,
    value,
  );

  _i1.ColumnValue<int, int> vatTotalCents(int value) => _i1.ColumnValue(
    table.vatTotalCents,
    value,
  );

  _i1.ColumnValue<int, int> totalCents(int value) => _i1.ColumnValue(
    table.totalCents,
    value,
  );

  _i1.ColumnValue<int, int> paymentTermsDays(int value) => _i1.ColumnValue(
    table.paymentTermsDays,
    value,
  );

  _i1.ColumnValue<int, int> dunningLevel(int value) => _i1.ColumnValue(
    table.dunningLevel,
    value,
  );

  _i1.ColumnValue<String, String> notes(String? value) => _i1.ColumnValue(
    table.notes,
    value,
  );

  _i1.ColumnValue<int, int> templateId(int? value) => _i1.ColumnValue(
    table.templateId,
    value,
  );

  _i1.ColumnValue<int, int> pdfDocumentId(int? value) => _i1.ColumnValue(
    table.pdfDocumentId,
    value,
  );

  _i1.ColumnValue<_i6.RecurrenceInterval, _i6.RecurrenceInterval>
  recurrenceInterval(_i6.RecurrenceInterval? value) => _i1.ColumnValue(
    table.recurrenceInterval,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> nextRecurrenceDate(DateTime? value) =>
      _i1.ColumnValue(
        table.nextRecurrenceDate,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> recurrenceEndDate(DateTime? value) =>
      _i1.ColumnValue(
        table.recurrenceEndDate,
        value,
      );

  _i1.ColumnValue<int, int> recurrenceMaxOccurrences(int? value) =>
      _i1.ColumnValue(
        table.recurrenceMaxOccurrences,
        value,
      );

  _i1.ColumnValue<int, int> recurrenceOccurrencesCreated(int value) =>
      _i1.ColumnValue(
        table.recurrenceOccurrencesCreated,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class InvoiceTable extends _i1.Table<int?> {
  InvoiceTable({super.tableRelation}) : super(tableName: 'invoice') {
    updateTable = InvoiceUpdateTable(this);
    businessId = _i1.ColumnInt(
      'businessId',
      this,
    );
    number = _i1.ColumnString(
      'number',
      this,
    );
    type = _i1.ColumnEnum(
      'type',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    customerId = _i1.ColumnInt(
      'customerId',
      this,
    );
    issueDate = _i1.ColumnDateTime(
      'issueDate',
      this,
    );
    dueDate = _i1.ColumnDateTime(
      'dueDate',
      this,
    );
    serviceDateFrom = _i1.ColumnDateTime(
      'serviceDateFrom',
      this,
    );
    serviceDateTo = _i1.ColumnDateTime(
      'serviceDateTo',
      this,
    );
    locale = _i1.ColumnEnum(
      'locale',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    currency = _i1.ColumnEnum(
      'currency',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    subtotalCents = _i1.ColumnInt(
      'subtotalCents',
      this,
      hasDefault: true,
    );
    vatTotalCents = _i1.ColumnInt(
      'vatTotalCents',
      this,
      hasDefault: true,
    );
    totalCents = _i1.ColumnInt(
      'totalCents',
      this,
      hasDefault: true,
    );
    paymentTermsDays = _i1.ColumnInt(
      'paymentTermsDays',
      this,
      hasDefault: true,
    );
    dunningLevel = _i1.ColumnInt(
      'dunningLevel',
      this,
      hasDefault: true,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
    templateId = _i1.ColumnInt(
      'templateId',
      this,
    );
    pdfDocumentId = _i1.ColumnInt(
      'pdfDocumentId',
      this,
    );
    recurrenceInterval = _i1.ColumnEnum(
      'recurrenceInterval',
      this,
      _i1.EnumSerialization.byName,
    );
    nextRecurrenceDate = _i1.ColumnDateTime(
      'nextRecurrenceDate',
      this,
    );
    recurrenceEndDate = _i1.ColumnDateTime(
      'recurrenceEndDate',
      this,
    );
    recurrenceMaxOccurrences = _i1.ColumnInt(
      'recurrenceMaxOccurrences',
      this,
    );
    recurrenceOccurrencesCreated = _i1.ColumnInt(
      'recurrenceOccurrencesCreated',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final InvoiceUpdateTable updateTable;

  late final _i1.ColumnInt businessId;

  late final _i1.ColumnString number;

  late final _i1.ColumnEnum<_i2.InvoiceType> type;

  late final _i1.ColumnEnum<_i3.InvoiceStatus> status;

  late final _i1.ColumnInt customerId;

  late final _i1.ColumnDateTime issueDate;

  late final _i1.ColumnDateTime dueDate;

  late final _i1.ColumnDateTime serviceDateFrom;

  late final _i1.ColumnDateTime serviceDateTo;

  late final _i1.ColumnEnum<_i4.Locale> locale;

  late final _i1.ColumnEnum<_i5.Currency> currency;

  late final _i1.ColumnInt subtotalCents;

  late final _i1.ColumnInt vatTotalCents;

  late final _i1.ColumnInt totalCents;

  late final _i1.ColumnInt paymentTermsDays;

  late final _i1.ColumnInt dunningLevel;

  late final _i1.ColumnString notes;

  late final _i1.ColumnInt templateId;

  late final _i1.ColumnInt pdfDocumentId;

  late final _i1.ColumnEnum<_i6.RecurrenceInterval> recurrenceInterval;

  late final _i1.ColumnDateTime nextRecurrenceDate;

  late final _i1.ColumnDateTime recurrenceEndDate;

  late final _i1.ColumnInt recurrenceMaxOccurrences;

  late final _i1.ColumnInt recurrenceOccurrencesCreated;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
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

class InvoiceInclude extends _i1.IncludeObject {
  InvoiceInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Invoice.t;
}

class InvoiceIncludeList extends _i1.IncludeList {
  InvoiceIncludeList._({
    _i1.WhereExpressionBuilder<InvoiceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Invoice.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Invoice.t;
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<InvoiceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InvoiceTable>? orderBy,
    _i1.OrderByListBuilder<InvoiceTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<InvoiceTable>? where,
    int? offset,
    _i1.OrderByBuilder<InvoiceTable>? orderBy,
    _i1.OrderByListBuilder<InvoiceTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
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
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
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
    _i1.DatabaseSession session,
    List<Invoice> rows, {
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    Invoice row, {
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    List<Invoice> rows, {
    required _i1.ColumnSelections<InvoiceTable> conflictColumns,
    _i1.ColumnSelections<InvoiceTable>? updateColumns,
    _i1.WhereExpressionBuilder<InvoiceTable>? updateWhere,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    Invoice row, {
    required _i1.ColumnSelections<InvoiceTable> conflictColumns,
    _i1.ColumnSelections<InvoiceTable>? updateColumns,
    _i1.WhereExpressionBuilder<InvoiceTable>? updateWhere,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    List<Invoice> rows, {
    _i1.ColumnSelections<InvoiceTable>? columns,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    Invoice row, {
    _i1.ColumnSelections<InvoiceTable>? columns,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<InvoiceUpdateTable> columnValues,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<InvoiceUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<InvoiceTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InvoiceTable>? orderBy,
    _i1.OrderByListBuilder<InvoiceTable>? orderByList,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    List<Invoice> rows, {
    _i1.OrderByBuilder<InvoiceTable>? orderBy,
    _i1.OrderByListBuilder<InvoiceTable>? orderByList,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session,
    Invoice row, {
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<InvoiceTable> where,
    _i1.OrderByBuilder<InvoiceTable>? orderBy,
    _i1.OrderByListBuilder<InvoiceTable>? orderByList,
    _i1.Transaction? transaction,
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
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<InvoiceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Invoice>(
      where: where?.call(Invoice.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Invoice] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<InvoiceTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Invoice>(
      where: where(Invoice.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
