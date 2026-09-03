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

abstract class TimeEntry
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  TimeEntry._({
    this.id,
    required this.businessId,
    this.projectId,
    this.taskId,
    this.description,
    required this.startedAt,
    this.stoppedAt,
    this.durationMinutes,
    bool? billable,
    this.invoicedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : billable = billable ?? true,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory TimeEntry({
    int? id,
    required int businessId,
    int? projectId,
    int? taskId,
    String? description,
    required DateTime startedAt,
    DateTime? stoppedAt,
    int? durationMinutes,
    bool? billable,
    DateTime? invoicedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TimeEntryImpl;

  factory TimeEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return TimeEntry(
      id: jsonSerialization['id'] as int?,
      businessId: jsonSerialization['businessId'] as int,
      projectId: jsonSerialization['projectId'] as int?,
      taskId: jsonSerialization['taskId'] as int?,
      description: jsonSerialization['description'] as String?,
      startedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      stoppedAt: jsonSerialization['stoppedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['stoppedAt']),
      durationMinutes: jsonSerialization['durationMinutes'] as int?,
      billable: jsonSerialization['billable'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['billable']),
      invoicedAt: jsonSerialization['invoicedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['invoicedAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = TimeEntryTable();

  static const db = TimeEntryRepository._();

  @override
  int? id;

  int businessId;

  int? projectId;

  int? taskId;

  String? description;

  DateTime startedAt;

  DateTime? stoppedAt;

  int? durationMinutes;

  bool billable;

  DateTime? invoicedAt;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [TimeEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TimeEntry copyWith({
    int? id,
    int? businessId,
    int? projectId,
    int? taskId,
    String? description,
    DateTime? startedAt,
    DateTime? stoppedAt,
    int? durationMinutes,
    bool? billable,
    DateTime? invoicedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TimeEntry',
      if (id != null) 'id': id,
      'businessId': businessId,
      if (projectId != null) 'projectId': projectId,
      if (taskId != null) 'taskId': taskId,
      if (description != null) 'description': description,
      'startedAt': startedAt.toJson(),
      if (stoppedAt != null) 'stoppedAt': stoppedAt?.toJson(),
      if (durationMinutes != null) 'durationMinutes': durationMinutes,
      'billable': billable,
      if (invoicedAt != null) 'invoicedAt': invoicedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TimeEntry',
      if (id != null) 'id': id,
      'businessId': businessId,
      if (projectId != null) 'projectId': projectId,
      if (taskId != null) 'taskId': taskId,
      if (description != null) 'description': description,
      'startedAt': startedAt.toJson(),
      if (stoppedAt != null) 'stoppedAt': stoppedAt?.toJson(),
      if (durationMinutes != null) 'durationMinutes': durationMinutes,
      'billable': billable,
      if (invoicedAt != null) 'invoicedAt': invoicedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static TimeEntryInclude include() {
    return TimeEntryInclude._();
  }

  static TimeEntryIncludeList includeList({
    _is.WhereExpressionBuilder<TimeEntryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TimeEntryTable>? orderBy,
    _is.OrderByListBuilder<TimeEntryTable>? orderByList,
    TimeEntryInclude? include,
  }) {
    return TimeEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TimeEntry.t),
      orderByList: orderByList?.call(TimeEntry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TimeEntryImpl extends TimeEntry {
  _TimeEntryImpl({
    int? id,
    required int businessId,
    int? projectId,
    int? taskId,
    String? description,
    required DateTime startedAt,
    DateTime? stoppedAt,
    int? durationMinutes,
    bool? billable,
    DateTime? invoicedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         businessId: businessId,
         projectId: projectId,
         taskId: taskId,
         description: description,
         startedAt: startedAt,
         stoppedAt: stoppedAt,
         durationMinutes: durationMinutes,
         billable: billable,
         invoicedAt: invoicedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [TimeEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TimeEntry copyWith({
    Object? id = _Undefined,
    int? businessId,
    Object? projectId = _Undefined,
    Object? taskId = _Undefined,
    Object? description = _Undefined,
    DateTime? startedAt,
    Object? stoppedAt = _Undefined,
    Object? durationMinutes = _Undefined,
    bool? billable,
    Object? invoicedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TimeEntry(
      id: id is int? ? id : this.id,
      businessId: businessId ?? this.businessId,
      projectId: projectId is int? ? projectId : this.projectId,
      taskId: taskId is int? ? taskId : this.taskId,
      description: description is String? ? description : this.description,
      startedAt: startedAt ?? this.startedAt,
      stoppedAt: stoppedAt is DateTime? ? stoppedAt : this.stoppedAt,
      durationMinutes: durationMinutes is int?
          ? durationMinutes
          : this.durationMinutes,
      billable: billable ?? this.billable,
      invoicedAt: invoicedAt is DateTime? ? invoicedAt : this.invoicedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class TimeEntryUpdateTable extends _is.UpdateTable<TimeEntryTable> {
  TimeEntryUpdateTable(super.table);

  _is.ColumnValue<int, int> businessId(int value) => _is.ColumnValue(
    table.businessId,
    value,
  );

  _is.ColumnValue<int, int> projectId(int? value) => _is.ColumnValue(
    table.projectId,
    value,
  );

  _is.ColumnValue<int, int> taskId(int? value) => _is.ColumnValue(
    table.taskId,
    value,
  );

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> startedAt(DateTime value) =>
      _is.ColumnValue(
        table.startedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> stoppedAt(DateTime? value) =>
      _is.ColumnValue(
        table.stoppedAt,
        value,
      );

  _is.ColumnValue<int, int> durationMinutes(int? value) => _is.ColumnValue(
    table.durationMinutes,
    value,
  );

  _is.ColumnValue<bool, bool> billable(bool value) => _is.ColumnValue(
    table.billable,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> invoicedAt(DateTime? value) =>
      _is.ColumnValue(
        table.invoicedAt,
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

class TimeEntryTable extends _is.Table<int?> {
  TimeEntryTable({super.tableRelation}) : super(tableName: 'time_entry') {
    updateTable = TimeEntryUpdateTable(this);
    businessId = _is.ColumnInt(
      'businessId',
      this,
    );
    projectId = _is.ColumnInt(
      'projectId',
      this,
    );
    taskId = _is.ColumnInt(
      'taskId',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    startedAt = _is.ColumnDateTime(
      'startedAt',
      this,
    );
    stoppedAt = _is.ColumnDateTime(
      'stoppedAt',
      this,
    );
    durationMinutes = _is.ColumnInt(
      'durationMinutes',
      this,
    );
    billable = _is.ColumnBool(
      'billable',
      this,
      hasDefault: true,
    );
    invoicedAt = _is.ColumnDateTime(
      'invoicedAt',
      this,
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

  late final TimeEntryUpdateTable updateTable;

  late final _is.ColumnInt businessId;

  late final _is.ColumnInt projectId;

  late final _is.ColumnInt taskId;

  late final _is.ColumnString description;

  late final _is.ColumnDateTime startedAt;

  late final _is.ColumnDateTime stoppedAt;

  late final _is.ColumnInt durationMinutes;

  late final _is.ColumnBool billable;

  late final _is.ColumnDateTime invoicedAt;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    businessId,
    projectId,
    taskId,
    description,
    startedAt,
    stoppedAt,
    durationMinutes,
    billable,
    invoicedAt,
    createdAt,
    updatedAt,
  ];
}

class TimeEntryInclude extends _is.IncludeObject {
  TimeEntryInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => TimeEntry.t;
}

class TimeEntryIncludeList extends _is.IncludeList {
  TimeEntryIncludeList._({
    _is.WhereExpressionBuilder<TimeEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TimeEntry.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => TimeEntry.t;
}

class TimeEntryRepository {
  const TimeEntryRepository._();

  /// Returns a list of [TimeEntry]s matching the given query parameters.
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
  Future<List<TimeEntry>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TimeEntryTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TimeEntryTable>? orderBy,
    _is.OrderByListBuilder<TimeEntryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TimeEntry>(
      where: where?.call(TimeEntry.t),
      orderBy: orderBy?.call(TimeEntry.t),
      orderByList: orderByList?.call(TimeEntry.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TimeEntry] matching the given query parameters.
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
  Future<TimeEntry?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TimeEntryTable>? where,
    int? offset,
    _is.OrderByBuilder<TimeEntryTable>? orderBy,
    _is.OrderByListBuilder<TimeEntryTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TimeEntry>(
      where: where?.call(TimeEntry.t),
      orderBy: orderBy?.call(TimeEntry.t),
      orderByList: orderByList?.call(TimeEntry.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TimeEntry] by its [id] or null if no such row exists.
  Future<TimeEntry?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TimeEntry>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TimeEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [TimeEntry]s will have their `id` fields set.
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
  Future<List<TimeEntry>> insert(
    _is.DatabaseSession session,
    List<TimeEntry> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<TimeEntry>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [TimeEntry] and returns the inserted row.
  ///
  /// The returned [TimeEntry] will have its `id` field set.
  Future<TimeEntry> insertRow(
    _is.DatabaseSession session,
    TimeEntry row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<TimeEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [TimeEntry]s in the list and returns the resulting rows.
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
  /// The returned [TimeEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TimeEntry>> upsert(
    _is.DatabaseSession session,
    List<TimeEntry> rows, {
    required _is.ColumnSelections<TimeEntryTable> conflictColumns,
    _is.ColumnSelections<TimeEntryTable>? updateColumns,
    _is.WhereExpressionBuilder<TimeEntryTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<TimeEntry>(
      rows,
      conflictColumns: conflictColumns(TimeEntry.t),
      updateColumns: updateColumns?.call(TimeEntry.t),
      updateWhere: updateWhere?.call(TimeEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [TimeEntry] and returns the resulting row.
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
  /// The returned [TimeEntry] will have its `id` field set.
  Future<TimeEntry?> upsertRow(
    _is.DatabaseSession session,
    TimeEntry row, {
    required _is.ColumnSelections<TimeEntryTable> conflictColumns,
    _is.ColumnSelections<TimeEntryTable>? updateColumns,
    _is.WhereExpressionBuilder<TimeEntryTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<TimeEntry>(
      row,
      conflictColumns: conflictColumns(TimeEntry.t),
      updateColumns: updateColumns?.call(TimeEntry.t),
      updateWhere: updateWhere?.call(TimeEntry.t),
      transaction: transaction,
    );
  }

  /// Updates all [TimeEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TimeEntry>> update(
    _is.DatabaseSession session,
    List<TimeEntry> rows, {
    _is.ColumnSelections<TimeEntryTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<TimeEntry>(
      rows,
      columns: columns?.call(TimeEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [TimeEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TimeEntry> updateRow(
    _is.DatabaseSession session,
    TimeEntry row, {
    _is.ColumnSelections<TimeEntryTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<TimeEntry>(
      row,
      columns: columns?.call(TimeEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TimeEntry] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TimeEntry?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<TimeEntryUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<TimeEntry>(
      id,
      columnValues: columnValues(TimeEntry.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TimeEntry]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<TimeEntry>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<TimeEntryUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<TimeEntryTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<TimeEntryTable>? orderBy,
    _is.OrderByListBuilder<TimeEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<TimeEntry>(
      columnValues: columnValues(TimeEntry.t.updateTable),
      where: where(TimeEntry.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TimeEntry.t),
      orderByList: orderByList?.call(TimeEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [TimeEntry]s in the list and returns the deleted rows.
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
  Future<List<TimeEntry>> delete(
    _is.DatabaseSession session,
    List<TimeEntry> rows, {
    _is.OrderByBuilder<TimeEntryTable>? orderBy,
    _is.OrderByListBuilder<TimeEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<TimeEntry>(
      rows,
      orderBy: orderBy?.call(TimeEntry.t),
      orderByList: orderByList?.call(TimeEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [TimeEntry].
  Future<TimeEntry> deleteRow(
    _is.DatabaseSession session,
    TimeEntry row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TimeEntry>(
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
  Future<List<TimeEntry>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TimeEntryTable> where,
    _is.OrderByBuilder<TimeEntryTable>? orderBy,
    _is.OrderByListBuilder<TimeEntryTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<TimeEntry>(
      where: where(TimeEntry.t),
      orderBy: orderBy?.call(TimeEntry.t),
      orderByList: orderByList?.call(TimeEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<TimeEntryTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<TimeEntry>(
      where: where?.call(TimeEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TimeEntry] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<TimeEntryTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TimeEntry>(
      where: where(TimeEntry.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
