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

/// Admin-managed override of a curated in-code [GuidanceTip]. Keyed by
/// `topic`: when present it replaces the built-in tip with the same topic
/// (in `guidance.tips` and in the admin listing). Topics without a built-in
/// tip are appended as new tips.
abstract class GuidanceTipOverride
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  GuidanceTipOverride._({
    this.id,
    required this.topic,
    required this.title,
    required this.body,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  factory GuidanceTipOverride({
    int? id,
    required String topic,
    required String title,
    required String body,
    DateTime? updatedAt,
  }) = _GuidanceTipOverrideImpl;

  factory GuidanceTipOverride.fromJson(Map<String, dynamic> jsonSerialization) {
    return GuidanceTipOverride(
      id: jsonSerialization['id'] as int?,
      topic: jsonSerialization['topic'] as String,
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = GuidanceTipOverrideTable();

  static const db = GuidanceTipOverrideRepository._();

  @override
  int? id;

  String topic;

  String title;

  String body;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [GuidanceTipOverride]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GuidanceTipOverride copyWith({
    int? id,
    String? topic,
    String? title,
    String? body,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GuidanceTipOverride',
      if (id != null) 'id': id,
      'topic': topic,
      'title': title,
      'body': body,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static GuidanceTipOverrideInclude include() {
    return GuidanceTipOverrideInclude._();
  }

  static GuidanceTipOverrideIncludeList includeList({
    _i1.WhereExpressionBuilder<GuidanceTipOverrideTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GuidanceTipOverrideTable>? orderBy,
    _i1.OrderByListBuilder<GuidanceTipOverrideTable>? orderByList,
    GuidanceTipOverrideInclude? include,
  }) {
    return GuidanceTipOverrideIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GuidanceTipOverride.t),
      orderByList: orderByList?.call(GuidanceTipOverride.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GuidanceTipOverrideImpl extends GuidanceTipOverride {
  _GuidanceTipOverrideImpl({
    int? id,
    required String topic,
    required String title,
    required String body,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         topic: topic,
         title: title,
         body: body,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [GuidanceTipOverride]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GuidanceTipOverride copyWith({
    Object? id = _Undefined,
    String? topic,
    String? title,
    String? body,
    DateTime? updatedAt,
  }) {
    return GuidanceTipOverride(
      id: id is int? ? id : this.id,
      topic: topic ?? this.topic,
      title: title ?? this.title,
      body: body ?? this.body,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class GuidanceTipOverrideUpdateTable
    extends _i1.UpdateTable<GuidanceTipOverrideTable> {
  GuidanceTipOverrideUpdateTable(super.table);

  _i1.ColumnValue<String, String> topic(String value) => _i1.ColumnValue(
    table.topic,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> body(String value) => _i1.ColumnValue(
    table.body,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class GuidanceTipOverrideTable extends _i1.Table<int?> {
  GuidanceTipOverrideTable({super.tableRelation})
    : super(tableName: 'guidance_tip_override') {
    updateTable = GuidanceTipOverrideUpdateTable(this);
    topic = _i1.ColumnString(
      'topic',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    body = _i1.ColumnString(
      'body',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final GuidanceTipOverrideUpdateTable updateTable;

  late final _i1.ColumnString topic;

  late final _i1.ColumnString title;

  late final _i1.ColumnString body;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    topic,
    title,
    body,
    updatedAt,
  ];
}

class GuidanceTipOverrideInclude extends _i1.IncludeObject {
  GuidanceTipOverrideInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => GuidanceTipOverride.t;
}

class GuidanceTipOverrideIncludeList extends _i1.IncludeList {
  GuidanceTipOverrideIncludeList._({
    _i1.WhereExpressionBuilder<GuidanceTipOverrideTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(GuidanceTipOverride.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => GuidanceTipOverride.t;
}

class GuidanceTipOverrideRepository {
  const GuidanceTipOverrideRepository._();

  /// Returns a list of [GuidanceTipOverride]s matching the given query parameters.
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
  Future<List<GuidanceTipOverride>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<GuidanceTipOverrideTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GuidanceTipOverrideTable>? orderBy,
    _i1.OrderByListBuilder<GuidanceTipOverrideTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<GuidanceTipOverride>(
      where: where?.call(GuidanceTipOverride.t),
      orderBy: orderBy?.call(GuidanceTipOverride.t),
      orderByList: orderByList?.call(GuidanceTipOverride.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [GuidanceTipOverride] matching the given query parameters.
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
  Future<GuidanceTipOverride?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<GuidanceTipOverrideTable>? where,
    int? offset,
    _i1.OrderByBuilder<GuidanceTipOverrideTable>? orderBy,
    _i1.OrderByListBuilder<GuidanceTipOverrideTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<GuidanceTipOverride>(
      where: where?.call(GuidanceTipOverride.t),
      orderBy: orderBy?.call(GuidanceTipOverride.t),
      orderByList: orderByList?.call(GuidanceTipOverride.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [GuidanceTipOverride] by its [id] or null if no such row exists.
  Future<GuidanceTipOverride?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<GuidanceTipOverride>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [GuidanceTipOverride]s in the list and returns the inserted rows.
  ///
  /// The returned [GuidanceTipOverride]s will have their `id` fields set.
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
  Future<List<GuidanceTipOverride>> insert(
    _i1.DatabaseSession session,
    List<GuidanceTipOverride> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<GuidanceTipOverride>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [GuidanceTipOverride] and returns the inserted row.
  ///
  /// The returned [GuidanceTipOverride] will have its `id` field set.
  Future<GuidanceTipOverride> insertRow(
    _i1.DatabaseSession session,
    GuidanceTipOverride row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<GuidanceTipOverride>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [GuidanceTipOverride]s in the list and returns the resulting rows.
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
  /// The returned [GuidanceTipOverride]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<GuidanceTipOverride>> upsert(
    _i1.DatabaseSession session,
    List<GuidanceTipOverride> rows, {
    required _i1.ColumnSelections<GuidanceTipOverrideTable> conflictColumns,
    _i1.ColumnSelections<GuidanceTipOverrideTable>? updateColumns,
    _i1.WhereExpressionBuilder<GuidanceTipOverrideTable>? updateWhere,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<GuidanceTipOverride>(
      rows,
      conflictColumns: conflictColumns(GuidanceTipOverride.t),
      updateColumns: updateColumns?.call(GuidanceTipOverride.t),
      updateWhere: updateWhere?.call(GuidanceTipOverride.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [GuidanceTipOverride] and returns the resulting row.
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
  /// The returned [GuidanceTipOverride] will have its `id` field set.
  Future<GuidanceTipOverride?> upsertRow(
    _i1.DatabaseSession session,
    GuidanceTipOverride row, {
    required _i1.ColumnSelections<GuidanceTipOverrideTable> conflictColumns,
    _i1.ColumnSelections<GuidanceTipOverrideTable>? updateColumns,
    _i1.WhereExpressionBuilder<GuidanceTipOverrideTable>? updateWhere,
    _i1.Transaction? transaction,
  }) async {
    return session.db.upsertRow<GuidanceTipOverride>(
      row,
      conflictColumns: conflictColumns(GuidanceTipOverride.t),
      updateColumns: updateColumns?.call(GuidanceTipOverride.t),
      updateWhere: updateWhere?.call(GuidanceTipOverride.t),
      transaction: transaction,
    );
  }

  /// Updates all [GuidanceTipOverride]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<GuidanceTipOverride>> update(
    _i1.DatabaseSession session,
    List<GuidanceTipOverride> rows, {
    _i1.ColumnSelections<GuidanceTipOverrideTable>? columns,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<GuidanceTipOverride>(
      rows,
      columns: columns?.call(GuidanceTipOverride.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [GuidanceTipOverride]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<GuidanceTipOverride> updateRow(
    _i1.DatabaseSession session,
    GuidanceTipOverride row, {
    _i1.ColumnSelections<GuidanceTipOverrideTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<GuidanceTipOverride>(
      row,
      columns: columns?.call(GuidanceTipOverride.t),
      transaction: transaction,
    );
  }

  /// Updates a single [GuidanceTipOverride] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<GuidanceTipOverride?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<GuidanceTipOverrideUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<GuidanceTipOverride>(
      id,
      columnValues: columnValues(GuidanceTipOverride.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [GuidanceTipOverride]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<GuidanceTipOverride>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<GuidanceTipOverrideUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<GuidanceTipOverrideTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GuidanceTipOverrideTable>? orderBy,
    _i1.OrderByListBuilder<GuidanceTipOverrideTable>? orderByList,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<GuidanceTipOverride>(
      columnValues: columnValues(GuidanceTipOverride.t.updateTable),
      where: where(GuidanceTipOverride.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GuidanceTipOverride.t),
      orderByList: orderByList?.call(GuidanceTipOverride.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [GuidanceTipOverride]s in the list and returns the deleted rows.
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
  Future<List<GuidanceTipOverride>> delete(
    _i1.DatabaseSession session,
    List<GuidanceTipOverride> rows, {
    _i1.OrderByBuilder<GuidanceTipOverrideTable>? orderBy,
    _i1.OrderByListBuilder<GuidanceTipOverrideTable>? orderByList,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<GuidanceTipOverride>(
      rows,
      orderBy: orderBy?.call(GuidanceTipOverride.t),
      orderByList: orderByList?.call(GuidanceTipOverride.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [GuidanceTipOverride].
  Future<GuidanceTipOverride> deleteRow(
    _i1.DatabaseSession session,
    GuidanceTipOverride row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<GuidanceTipOverride>(
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
  Future<List<GuidanceTipOverride>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<GuidanceTipOverrideTable> where,
    _i1.OrderByBuilder<GuidanceTipOverrideTable>? orderBy,
    _i1.OrderByListBuilder<GuidanceTipOverrideTable>? orderByList,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<GuidanceTipOverride>(
      where: where(GuidanceTipOverride.t),
      orderBy: orderBy?.call(GuidanceTipOverride.t),
      orderByList: orderByList?.call(GuidanceTipOverride.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<GuidanceTipOverrideTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<GuidanceTipOverride>(
      where: where?.call(GuidanceTipOverride.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [GuidanceTipOverride] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<GuidanceTipOverrideTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<GuidanceTipOverride>(
      where: where(GuidanceTipOverride.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
