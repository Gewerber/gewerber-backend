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

abstract class Sequence
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Sequence._({
    this.id,
    required this.businessId,
    required this.key,
    required this.year,
    int? lastValue,
    DateTime? updatedAt,
  }) : lastValue = lastValue ?? 0,
       updatedAt = updatedAt ?? DateTime.now();

  factory Sequence({
    int? id,
    required int businessId,
    required String key,
    required int year,
    int? lastValue,
    DateTime? updatedAt,
  }) = _SequenceImpl;

  factory Sequence.fromJson(Map<String, dynamic> jsonSerialization) {
    return Sequence(
      id: jsonSerialization['id'] as int?,
      businessId: jsonSerialization['businessId'] as int,
      key: jsonSerialization['key'] as String,
      year: jsonSerialization['year'] as int,
      lastValue: jsonSerialization['lastValue'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = SequenceTable();

  static const db = SequenceRepository._();

  @override
  int? id;

  int businessId;

  String key;

  int year;

  int lastValue;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Sequence]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Sequence copyWith({
    int? id,
    int? businessId,
    String? key,
    int? year,
    int? lastValue,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Sequence',
      if (id != null) 'id': id,
      'businessId': businessId,
      'key': key,
      'year': year,
      'lastValue': lastValue,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static SequenceInclude include() {
    return SequenceInclude._();
  }

  static SequenceIncludeList includeList({
    _is.WhereExpressionBuilder<SequenceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SequenceTable>? orderBy,
    _is.OrderByListBuilder<SequenceTable>? orderByList,
    SequenceInclude? include,
  }) {
    return SequenceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Sequence.t),
      orderByList: orderByList?.call(Sequence.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SequenceImpl extends Sequence {
  _SequenceImpl({
    int? id,
    required int businessId,
    required String key,
    required int year,
    int? lastValue,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         businessId: businessId,
         key: key,
         year: year,
         lastValue: lastValue,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Sequence]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Sequence copyWith({
    Object? id = _Undefined,
    int? businessId,
    String? key,
    int? year,
    int? lastValue,
    DateTime? updatedAt,
  }) {
    return Sequence(
      id: id is int? ? id : this.id,
      businessId: businessId ?? this.businessId,
      key: key ?? this.key,
      year: year ?? this.year,
      lastValue: lastValue ?? this.lastValue,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SequenceUpdateTable extends _is.UpdateTable<SequenceTable> {
  SequenceUpdateTable(super.table);

  _is.ColumnValue<int, int> businessId(int value) => _is.ColumnValue(
    table.businessId,
    value,
  );

  _is.ColumnValue<String, String> key(String value) => _is.ColumnValue(
    table.key,
    value,
  );

  _is.ColumnValue<int, int> year(int value) => _is.ColumnValue(
    table.year,
    value,
  );

  _is.ColumnValue<int, int> lastValue(int value) => _is.ColumnValue(
    table.lastValue,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class SequenceTable extends _is.Table<int?> {
  SequenceTable({super.tableRelation}) : super(tableName: 'number_sequence') {
    updateTable = SequenceUpdateTable(this);
    businessId = _is.ColumnInt(
      'businessId',
      this,
    );
    key = _is.ColumnString(
      'key',
      this,
    );
    year = _is.ColumnInt(
      'year',
      this,
    );
    lastValue = _is.ColumnInt(
      'lastValue',
      this,
      hasDefault: true,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final SequenceUpdateTable updateTable;

  late final _is.ColumnInt businessId;

  late final _is.ColumnString key;

  late final _is.ColumnInt year;

  late final _is.ColumnInt lastValue;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    businessId,
    key,
    year,
    lastValue,
    updatedAt,
  ];
}

class SequenceInclude extends _is.IncludeObject {
  SequenceInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Sequence.t;
}

class SequenceIncludeList extends _is.IncludeList {
  SequenceIncludeList._({
    _is.WhereExpressionBuilder<SequenceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Sequence.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Sequence.t;
}

class SequenceRepository {
  const SequenceRepository._();

  /// Returns a list of [Sequence]s matching the given query parameters.
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
  Future<List<Sequence>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SequenceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SequenceTable>? orderBy,
    _is.OrderByListBuilder<SequenceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Sequence>(
      where: where?.call(Sequence.t),
      orderBy: orderBy?.call(Sequence.t),
      orderByList: orderByList?.call(Sequence.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Sequence] matching the given query parameters.
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
  Future<Sequence?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SequenceTable>? where,
    int? offset,
    _is.OrderByBuilder<SequenceTable>? orderBy,
    _is.OrderByListBuilder<SequenceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Sequence>(
      where: where?.call(Sequence.t),
      orderBy: orderBy?.call(Sequence.t),
      orderByList: orderByList?.call(Sequence.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Sequence] by its [id] or null if no such row exists.
  Future<Sequence?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Sequence>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Sequence]s in the list and returns the inserted rows.
  ///
  /// The returned [Sequence]s will have their `id` fields set.
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
  Future<List<Sequence>> insert(
    _is.DatabaseSession session,
    List<Sequence> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Sequence>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Sequence] and returns the inserted row.
  ///
  /// The returned [Sequence] will have its `id` field set.
  Future<Sequence> insertRow(
    _is.DatabaseSession session,
    Sequence row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Sequence>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Sequence]s in the list and returns the resulting rows.
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
  /// The returned [Sequence]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Sequence>> upsert(
    _is.DatabaseSession session,
    List<Sequence> rows, {
    required _is.ColumnSelections<SequenceTable> conflictColumns,
    _is.ColumnSelections<SequenceTable>? updateColumns,
    _is.WhereExpressionBuilder<SequenceTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Sequence>(
      rows,
      conflictColumns: conflictColumns(Sequence.t),
      updateColumns: updateColumns?.call(Sequence.t),
      updateWhere: updateWhere?.call(Sequence.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Sequence] and returns the resulting row.
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
  /// The returned [Sequence] will have its `id` field set.
  Future<Sequence?> upsertRow(
    _is.DatabaseSession session,
    Sequence row, {
    required _is.ColumnSelections<SequenceTable> conflictColumns,
    _is.ColumnSelections<SequenceTable>? updateColumns,
    _is.WhereExpressionBuilder<SequenceTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Sequence>(
      row,
      conflictColumns: conflictColumns(Sequence.t),
      updateColumns: updateColumns?.call(Sequence.t),
      updateWhere: updateWhere?.call(Sequence.t),
      transaction: transaction,
    );
  }

  /// Updates all [Sequence]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Sequence>> update(
    _is.DatabaseSession session,
    List<Sequence> rows, {
    _is.ColumnSelections<SequenceTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Sequence>(
      rows,
      columns: columns?.call(Sequence.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Sequence]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Sequence> updateRow(
    _is.DatabaseSession session,
    Sequence row, {
    _is.ColumnSelections<SequenceTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Sequence>(
      row,
      columns: columns?.call(Sequence.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Sequence] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Sequence?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SequenceUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Sequence>(
      id,
      columnValues: columnValues(Sequence.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Sequence]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Sequence>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SequenceUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SequenceTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SequenceTable>? orderBy,
    _is.OrderByListBuilder<SequenceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Sequence>(
      columnValues: columnValues(Sequence.t.updateTable),
      where: where(Sequence.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Sequence.t),
      orderByList: orderByList?.call(Sequence.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Sequence]s in the list and returns the deleted rows.
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
  Future<List<Sequence>> delete(
    _is.DatabaseSession session,
    List<Sequence> rows, {
    _is.OrderByBuilder<SequenceTable>? orderBy,
    _is.OrderByListBuilder<SequenceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Sequence>(
      rows,
      orderBy: orderBy?.call(Sequence.t),
      orderByList: orderByList?.call(Sequence.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Sequence].
  Future<Sequence> deleteRow(
    _is.DatabaseSession session,
    Sequence row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Sequence>(
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
  Future<List<Sequence>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SequenceTable> where,
    _is.OrderByBuilder<SequenceTable>? orderBy,
    _is.OrderByListBuilder<SequenceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Sequence>(
      where: where(Sequence.t),
      orderBy: orderBy?.call(Sequence.t),
      orderByList: orderByList?.call(Sequence.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SequenceTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Sequence>(
      where: where?.call(Sequence.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Sequence] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SequenceTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Sequence>(
      where: where(Sequence.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
