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
import '../../../modules/business/models/rounding_mode.dart' as _i2;

abstract class BusinessSettings
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  BusinessSettings._({
    this.id,
    required this.businessId,
    int? paymentTermsDays,
    this.invoiceNumberPrefix,
    bool? invoiceNumberIncludeYear,
    int? invoiceNumberMinDigits,
    _i2.RoundingMode? roundingMode,
    int? roundingGranularityMinutes,
    DateTime? updatedAt,
  }) : paymentTermsDays = paymentTermsDays ?? 14,
       invoiceNumberIncludeYear = invoiceNumberIncludeYear ?? true,
       invoiceNumberMinDigits = invoiceNumberMinDigits ?? 4,
       roundingMode = roundingMode ?? _i2.RoundingMode.none,
       roundingGranularityMinutes = roundingGranularityMinutes ?? 1,
       updatedAt = updatedAt ?? DateTime.now();

  factory BusinessSettings({
    int? id,
    required int businessId,
    int? paymentTermsDays,
    String? invoiceNumberPrefix,
    bool? invoiceNumberIncludeYear,
    int? invoiceNumberMinDigits,
    _i2.RoundingMode? roundingMode,
    int? roundingGranularityMinutes,
    DateTime? updatedAt,
  }) = _BusinessSettingsImpl;

  factory BusinessSettings.fromJson(Map<String, dynamic> jsonSerialization) {
    return BusinessSettings(
      id: jsonSerialization['id'] as int?,
      businessId: jsonSerialization['businessId'] as int,
      paymentTermsDays: jsonSerialization['paymentTermsDays'] as int?,
      invoiceNumberPrefix: jsonSerialization['invoiceNumberPrefix'] as String?,
      invoiceNumberIncludeYear:
          jsonSerialization['invoiceNumberIncludeYear'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['invoiceNumberIncludeYear'],
            ),
      invoiceNumberMinDigits:
          jsonSerialization['invoiceNumberMinDigits'] as int?,
      roundingMode: jsonSerialization['roundingMode'] == null
          ? null
          : _i2.RoundingMode.fromJson(
              (jsonSerialization['roundingMode'] as String),
            ),
      roundingGranularityMinutes:
          jsonSerialization['roundingGranularityMinutes'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = BusinessSettingsTable();

  static const db = BusinessSettingsRepository._();

  @override
  int? id;

  int businessId;

  int paymentTermsDays;

  String? invoiceNumberPrefix;

  bool invoiceNumberIncludeYear;

  int invoiceNumberMinDigits;

  _i2.RoundingMode roundingMode;

  int roundingGranularityMinutes;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [BusinessSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BusinessSettings copyWith({
    int? id,
    int? businessId,
    int? paymentTermsDays,
    String? invoiceNumberPrefix,
    bool? invoiceNumberIncludeYear,
    int? invoiceNumberMinDigits,
    _i2.RoundingMode? roundingMode,
    int? roundingGranularityMinutes,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BusinessSettings',
      if (id != null) 'id': id,
      'businessId': businessId,
      'paymentTermsDays': paymentTermsDays,
      if (invoiceNumberPrefix != null)
        'invoiceNumberPrefix': invoiceNumberPrefix,
      'invoiceNumberIncludeYear': invoiceNumberIncludeYear,
      'invoiceNumberMinDigits': invoiceNumberMinDigits,
      'roundingMode': roundingMode.toJson(),
      'roundingGranularityMinutes': roundingGranularityMinutes,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BusinessSettings',
      if (id != null) 'id': id,
      'businessId': businessId,
      'paymentTermsDays': paymentTermsDays,
      if (invoiceNumberPrefix != null)
        'invoiceNumberPrefix': invoiceNumberPrefix,
      'invoiceNumberIncludeYear': invoiceNumberIncludeYear,
      'invoiceNumberMinDigits': invoiceNumberMinDigits,
      'roundingMode': roundingMode.toJson(),
      'roundingGranularityMinutes': roundingGranularityMinutes,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static BusinessSettingsInclude include() {
    return BusinessSettingsInclude._();
  }

  static BusinessSettingsIncludeList includeList({
    _i1.WhereExpressionBuilder<BusinessSettingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BusinessSettingsTable>? orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.OrderByListBuilder<BusinessSettingsTable>? orderByList,
    BusinessSettingsInclude? include,
  }) {
    return BusinessSettingsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BusinessSettings.t),
      orderDescending: // ignore: deprecated_member_use_from_same_package
          orderDescending,
      orderByList: orderByList?.call(BusinessSettings.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BusinessSettingsImpl extends BusinessSettings {
  _BusinessSettingsImpl({
    int? id,
    required int businessId,
    int? paymentTermsDays,
    String? invoiceNumberPrefix,
    bool? invoiceNumberIncludeYear,
    int? invoiceNumberMinDigits,
    _i2.RoundingMode? roundingMode,
    int? roundingGranularityMinutes,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         businessId: businessId,
         paymentTermsDays: paymentTermsDays,
         invoiceNumberPrefix: invoiceNumberPrefix,
         invoiceNumberIncludeYear: invoiceNumberIncludeYear,
         invoiceNumberMinDigits: invoiceNumberMinDigits,
         roundingMode: roundingMode,
         roundingGranularityMinutes: roundingGranularityMinutes,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [BusinessSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BusinessSettings copyWith({
    Object? id = _Undefined,
    int? businessId,
    int? paymentTermsDays,
    Object? invoiceNumberPrefix = _Undefined,
    bool? invoiceNumberIncludeYear,
    int? invoiceNumberMinDigits,
    _i2.RoundingMode? roundingMode,
    int? roundingGranularityMinutes,
    DateTime? updatedAt,
  }) {
    return BusinessSettings(
      id: id is int? ? id : this.id,
      businessId: businessId ?? this.businessId,
      paymentTermsDays: paymentTermsDays ?? this.paymentTermsDays,
      invoiceNumberPrefix: invoiceNumberPrefix is String?
          ? invoiceNumberPrefix
          : this.invoiceNumberPrefix,
      invoiceNumberIncludeYear:
          invoiceNumberIncludeYear ?? this.invoiceNumberIncludeYear,
      invoiceNumberMinDigits:
          invoiceNumberMinDigits ?? this.invoiceNumberMinDigits,
      roundingMode: roundingMode ?? this.roundingMode,
      roundingGranularityMinutes:
          roundingGranularityMinutes ?? this.roundingGranularityMinutes,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class BusinessSettingsUpdateTable
    extends _i1.UpdateTable<BusinessSettingsTable> {
  BusinessSettingsUpdateTable(super.table);

  _i1.ColumnValue<int, int> businessId(int value) => _i1.ColumnValue(
    table.businessId,
    value,
  );

  _i1.ColumnValue<int, int> paymentTermsDays(int value) => _i1.ColumnValue(
    table.paymentTermsDays,
    value,
  );

  _i1.ColumnValue<String, String> invoiceNumberPrefix(String? value) =>
      _i1.ColumnValue(
        table.invoiceNumberPrefix,
        value,
      );

  _i1.ColumnValue<bool, bool> invoiceNumberIncludeYear(bool value) =>
      _i1.ColumnValue(
        table.invoiceNumberIncludeYear,
        value,
      );

  _i1.ColumnValue<int, int> invoiceNumberMinDigits(int value) =>
      _i1.ColumnValue(
        table.invoiceNumberMinDigits,
        value,
      );

  _i1.ColumnValue<_i2.RoundingMode, _i2.RoundingMode> roundingMode(
    _i2.RoundingMode value,
  ) => _i1.ColumnValue(
    table.roundingMode,
    value,
  );

  _i1.ColumnValue<int, int> roundingGranularityMinutes(int value) =>
      _i1.ColumnValue(
        table.roundingGranularityMinutes,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class BusinessSettingsTable extends _i1.Table<int?> {
  BusinessSettingsTable({super.tableRelation})
    : super(tableName: 'business_settings') {
    updateTable = BusinessSettingsUpdateTable(this);
    businessId = _i1.ColumnInt(
      'businessId',
      this,
    );
    paymentTermsDays = _i1.ColumnInt(
      'paymentTermsDays',
      this,
      hasDefault: true,
    );
    invoiceNumberPrefix = _i1.ColumnString(
      'invoiceNumberPrefix',
      this,
    );
    invoiceNumberIncludeYear = _i1.ColumnBool(
      'invoiceNumberIncludeYear',
      this,
      hasDefault: true,
    );
    invoiceNumberMinDigits = _i1.ColumnInt(
      'invoiceNumberMinDigits',
      this,
      hasDefault: true,
    );
    roundingMode = _i1.ColumnEnum(
      'roundingMode',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    roundingGranularityMinutes = _i1.ColumnInt(
      'roundingGranularityMinutes',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final BusinessSettingsUpdateTable updateTable;

  late final _i1.ColumnInt businessId;

  late final _i1.ColumnInt paymentTermsDays;

  late final _i1.ColumnString invoiceNumberPrefix;

  late final _i1.ColumnBool invoiceNumberIncludeYear;

  late final _i1.ColumnInt invoiceNumberMinDigits;

  late final _i1.ColumnEnum<_i2.RoundingMode> roundingMode;

  late final _i1.ColumnInt roundingGranularityMinutes;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    businessId,
    paymentTermsDays,
    invoiceNumberPrefix,
    invoiceNumberIncludeYear,
    invoiceNumberMinDigits,
    roundingMode,
    roundingGranularityMinutes,
    updatedAt,
  ];
}

class BusinessSettingsInclude extends _i1.IncludeObject {
  BusinessSettingsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => BusinessSettings.t;
}

class BusinessSettingsIncludeList extends _i1.IncludeList {
  BusinessSettingsIncludeList._({
    _i1.WhereExpressionBuilder<BusinessSettingsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BusinessSettings.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => BusinessSettings.t;
}

class BusinessSettingsRepository {
  const BusinessSettingsRepository._();

  /// Returns a list of [BusinessSettings]s matching the given query parameters.
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
  Future<List<BusinessSettings>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BusinessSettingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BusinessSettingsTable>? orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.OrderByListBuilder<BusinessSettingsTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BusinessSettings>(
      where: where?.call(BusinessSettings.t),
      orderBy: orderBy?.call(BusinessSettings.t),
      orderByList: orderByList?.call(BusinessSettings.t),
      orderDescending: // ignore: deprecated_member_use
          orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BusinessSettings] matching the given query parameters.
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
  Future<BusinessSettings?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BusinessSettingsTable>? where,
    int? offset,
    _i1.OrderByBuilder<BusinessSettingsTable>? orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.OrderByListBuilder<BusinessSettingsTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BusinessSettings>(
      where: where?.call(BusinessSettings.t),
      orderBy: orderBy?.call(BusinessSettings.t),
      orderByList: orderByList?.call(BusinessSettings.t),
      orderDescending: // ignore: deprecated_member_use
          orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BusinessSettings] by its [id] or null if no such row exists.
  Future<BusinessSettings?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BusinessSettings>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BusinessSettings]s in the list and returns the inserted rows.
  ///
  /// The returned [BusinessSettings]s will have their `id` fields set.
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
  Future<List<BusinessSettings>> insert(
    _i1.DatabaseSession session,
    List<BusinessSettings> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<BusinessSettings>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [BusinessSettings] and returns the inserted row.
  ///
  /// The returned [BusinessSettings] will have its `id` field set.
  Future<BusinessSettings> insertRow(
    _i1.DatabaseSession session,
    BusinessSettings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BusinessSettings>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [BusinessSettings]s in the list and returns the resulting rows.
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
  /// The returned [BusinessSettings]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BusinessSettings>> upsert(
    _i1.DatabaseSession session,
    List<BusinessSettings> rows, {
    required _i1.ColumnSelections<BusinessSettingsTable> conflictColumns,
    _i1.ColumnSelections<BusinessSettingsTable>? updateColumns,
    _i1.WhereExpressionBuilder<BusinessSettingsTable>? updateWhere,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<BusinessSettings>(
      rows,
      conflictColumns: conflictColumns(BusinessSettings.t),
      updateColumns: updateColumns?.call(BusinessSettings.t),
      updateWhere: updateWhere?.call(BusinessSettings.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [BusinessSettings] and returns the resulting row.
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
  /// The returned [BusinessSettings] will have its `id` field set.
  Future<BusinessSettings?> upsertRow(
    _i1.DatabaseSession session,
    BusinessSettings row, {
    required _i1.ColumnSelections<BusinessSettingsTable> conflictColumns,
    _i1.ColumnSelections<BusinessSettingsTable>? updateColumns,
    _i1.WhereExpressionBuilder<BusinessSettingsTable>? updateWhere,
    _i1.Transaction? transaction,
  }) async {
    return session.db.upsertRow<BusinessSettings>(
      row,
      conflictColumns: conflictColumns(BusinessSettings.t),
      updateColumns: updateColumns?.call(BusinessSettings.t),
      updateWhere: updateWhere?.call(BusinessSettings.t),
      transaction: transaction,
    );
  }

  /// Updates all [BusinessSettings]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BusinessSettings>> update(
    _i1.DatabaseSession session,
    List<BusinessSettings> rows, {
    _i1.ColumnSelections<BusinessSettingsTable>? columns,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<BusinessSettings>(
      rows,
      columns: columns?.call(BusinessSettings.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [BusinessSettings]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BusinessSettings> updateRow(
    _i1.DatabaseSession session,
    BusinessSettings row, {
    _i1.ColumnSelections<BusinessSettingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BusinessSettings>(
      row,
      columns: columns?.call(BusinessSettings.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BusinessSettings] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BusinessSettings?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<BusinessSettingsUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<BusinessSettings>(
      id,
      columnValues: columnValues(BusinessSettings.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BusinessSettings]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BusinessSettings>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<BusinessSettingsUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<BusinessSettingsTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BusinessSettingsTable>? orderBy,
    _i1.OrderByListBuilder<BusinessSettingsTable>? orderByList,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<BusinessSettings>(
      columnValues: columnValues(BusinessSettings.t.updateTable),
      where: where(BusinessSettings.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BusinessSettings.t),
      orderByList: orderByList?.call(BusinessSettings.t),
      orderDescending: // ignore: deprecated_member_use
          orderDescending,
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [BusinessSettings]s in the list and returns the deleted rows.
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
  Future<List<BusinessSettings>> delete(
    _i1.DatabaseSession session,
    List<BusinessSettings> rows, {
    _i1.OrderByBuilder<BusinessSettingsTable>? orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.OrderByListBuilder<BusinessSettingsTable>? orderByList,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<BusinessSettings>(
      rows,
      orderBy: orderBy?.call(BusinessSettings.t),
      orderByList: orderByList?.call(BusinessSettings.t),
      orderDescending: // ignore: deprecated_member_use
          orderDescending,
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [BusinessSettings].
  Future<BusinessSettings> deleteRow(
    _i1.DatabaseSession session,
    BusinessSettings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BusinessSettings>(
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
  Future<List<BusinessSettings>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BusinessSettingsTable> where,
    _i1.OrderByBuilder<BusinessSettingsTable>? orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.OrderByListBuilder<BusinessSettingsTable>? orderByList,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<BusinessSettings>(
      where: where(BusinessSettings.t),
      orderBy: orderBy?.call(BusinessSettings.t),
      orderByList: orderByList?.call(BusinessSettings.t),
      orderDescending: // ignore: deprecated_member_use
          orderDescending,
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BusinessSettingsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BusinessSettings>(
      where: where?.call(BusinessSettings.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BusinessSettings] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BusinessSettingsTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BusinessSettings>(
      where: where(BusinessSettings.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
