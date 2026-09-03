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

abstract class UserGuidanceProgress
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  UserGuidanceProgress._({
    this.id,
    this.userId,
    required this.itemKey,
    this.completedAt,
    this.dismissedAt,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  factory UserGuidanceProgress({
    int? id,
    _is.UuidValue? userId,
    required String itemKey,
    DateTime? completedAt,
    DateTime? dismissedAt,
    DateTime? updatedAt,
  }) = _UserGuidanceProgressImpl;

  factory UserGuidanceProgress.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UserGuidanceProgress(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      itemKey: jsonSerialization['itemKey'] as String,
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      dismissedAt: jsonSerialization['dismissedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['dismissedAt'],
            ),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = UserGuidanceProgressTable();

  static const db = UserGuidanceProgressRepository._();

  @override
  int? id;

  /// Nullable: set to null when the account is deleted (GDPR Art. 17).
  _is.UuidValue? userId;

  String itemKey;

  DateTime? completedAt;

  DateTime? dismissedAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserGuidanceProgress]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  UserGuidanceProgress copyWith({
    int? id,
    _is.UuidValue? userId,
    String? itemKey,
    DateTime? completedAt,
    DateTime? dismissedAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserGuidanceProgress',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId?.toJson(),
      'itemKey': itemKey,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (dismissedAt != null) 'dismissedAt': dismissedAt?.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserGuidanceProgress',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId?.toJson(),
      'itemKey': itemKey,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (dismissedAt != null) 'dismissedAt': dismissedAt?.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static UserGuidanceProgressInclude include() {
    return UserGuidanceProgressInclude._();
  }

  static UserGuidanceProgressIncludeList includeList({
    _is.WhereExpressionBuilder<UserGuidanceProgressTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserGuidanceProgressTable>? orderBy,
    _is.OrderByListBuilder<UserGuidanceProgressTable>? orderByList,
    UserGuidanceProgressInclude? include,
  }) {
    return UserGuidanceProgressIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserGuidanceProgress.t),
      orderByList: orderByList?.call(UserGuidanceProgress.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserGuidanceProgressImpl extends UserGuidanceProgress {
  _UserGuidanceProgressImpl({
    int? id,
    _is.UuidValue? userId,
    required String itemKey,
    DateTime? completedAt,
    DateTime? dismissedAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         itemKey: itemKey,
         completedAt: completedAt,
         dismissedAt: dismissedAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [UserGuidanceProgress]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  UserGuidanceProgress copyWith({
    Object? id = _Undefined,
    Object? userId = _Undefined,
    String? itemKey,
    Object? completedAt = _Undefined,
    Object? dismissedAt = _Undefined,
    DateTime? updatedAt,
  }) {
    return UserGuidanceProgress(
      id: id is int? ? id : this.id,
      userId: userId is _is.UuidValue? ? userId : this.userId,
      itemKey: itemKey ?? this.itemKey,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      dismissedAt: dismissedAt is DateTime? ? dismissedAt : this.dismissedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class UserGuidanceProgressUpdateTable
    extends _is.UpdateTable<UserGuidanceProgressTable> {
  UserGuidanceProgressUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> userId(_is.UuidValue? value) =>
      _is.ColumnValue(
        table.userId,
        value,
      );

  _is.ColumnValue<String, String> itemKey(String value) => _is.ColumnValue(
    table.itemKey,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _is.ColumnValue(
        table.completedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> dismissedAt(DateTime? value) =>
      _is.ColumnValue(
        table.dismissedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class UserGuidanceProgressTable extends _is.Table<int?> {
  UserGuidanceProgressTable({super.tableRelation})
    : super(tableName: 'user_guidance_progress') {
    updateTable = UserGuidanceProgressUpdateTable(this);
    userId = _is.ColumnUuid(
      'userId',
      this,
    );
    itemKey = _is.ColumnString(
      'itemKey',
      this,
    );
    completedAt = _is.ColumnDateTime(
      'completedAt',
      this,
    );
    dismissedAt = _is.ColumnDateTime(
      'dismissedAt',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final UserGuidanceProgressUpdateTable updateTable;

  /// Nullable: set to null when the account is deleted (GDPR Art. 17).
  late final _is.ColumnUuid userId;

  late final _is.ColumnString itemKey;

  late final _is.ColumnDateTime completedAt;

  late final _is.ColumnDateTime dismissedAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    itemKey,
    completedAt,
    dismissedAt,
    updatedAt,
  ];
}

class UserGuidanceProgressInclude extends _is.IncludeObject {
  UserGuidanceProgressInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => UserGuidanceProgress.t;
}

class UserGuidanceProgressIncludeList extends _is.IncludeList {
  UserGuidanceProgressIncludeList._({
    _is.WhereExpressionBuilder<UserGuidanceProgressTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserGuidanceProgress.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => UserGuidanceProgress.t;
}

class UserGuidanceProgressRepository {
  const UserGuidanceProgressRepository._();

  /// Returns a list of [UserGuidanceProgress]s matching the given query parameters.
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
  Future<List<UserGuidanceProgress>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserGuidanceProgressTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserGuidanceProgressTable>? orderBy,
    _is.OrderByListBuilder<UserGuidanceProgressTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserGuidanceProgress>(
      where: where?.call(UserGuidanceProgress.t),
      orderBy: orderBy?.call(UserGuidanceProgress.t),
      orderByList: orderByList?.call(UserGuidanceProgress.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserGuidanceProgress] matching the given query parameters.
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
  Future<UserGuidanceProgress?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserGuidanceProgressTable>? where,
    int? offset,
    _is.OrderByBuilder<UserGuidanceProgressTable>? orderBy,
    _is.OrderByListBuilder<UserGuidanceProgressTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserGuidanceProgress>(
      where: where?.call(UserGuidanceProgress.t),
      orderBy: orderBy?.call(UserGuidanceProgress.t),
      orderByList: orderByList?.call(UserGuidanceProgress.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserGuidanceProgress] by its [id] or null if no such row exists.
  Future<UserGuidanceProgress?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserGuidanceProgress>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserGuidanceProgress]s in the list and returns the inserted rows.
  ///
  /// The returned [UserGuidanceProgress]s will have their `id` fields set.
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
  Future<List<UserGuidanceProgress>> insert(
    _is.DatabaseSession session,
    List<UserGuidanceProgress> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<UserGuidanceProgress>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [UserGuidanceProgress] and returns the inserted row.
  ///
  /// The returned [UserGuidanceProgress] will have its `id` field set.
  Future<UserGuidanceProgress> insertRow(
    _is.DatabaseSession session,
    UserGuidanceProgress row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserGuidanceProgress>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [UserGuidanceProgress]s in the list and returns the resulting rows.
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
  /// The returned [UserGuidanceProgress]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserGuidanceProgress>> upsert(
    _is.DatabaseSession session,
    List<UserGuidanceProgress> rows, {
    required _is.ColumnSelections<UserGuidanceProgressTable> conflictColumns,
    _is.ColumnSelections<UserGuidanceProgressTable>? updateColumns,
    _is.WhereExpressionBuilder<UserGuidanceProgressTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<UserGuidanceProgress>(
      rows,
      conflictColumns: conflictColumns(UserGuidanceProgress.t),
      updateColumns: updateColumns?.call(UserGuidanceProgress.t),
      updateWhere: updateWhere?.call(UserGuidanceProgress.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [UserGuidanceProgress] and returns the resulting row.
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
  /// The returned [UserGuidanceProgress] will have its `id` field set.
  Future<UserGuidanceProgress?> upsertRow(
    _is.DatabaseSession session,
    UserGuidanceProgress row, {
    required _is.ColumnSelections<UserGuidanceProgressTable> conflictColumns,
    _is.ColumnSelections<UserGuidanceProgressTable>? updateColumns,
    _is.WhereExpressionBuilder<UserGuidanceProgressTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<UserGuidanceProgress>(
      row,
      conflictColumns: conflictColumns(UserGuidanceProgress.t),
      updateColumns: updateColumns?.call(UserGuidanceProgress.t),
      updateWhere: updateWhere?.call(UserGuidanceProgress.t),
      transaction: transaction,
    );
  }

  /// Updates all [UserGuidanceProgress]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserGuidanceProgress>> update(
    _is.DatabaseSession session,
    List<UserGuidanceProgress> rows, {
    _is.ColumnSelections<UserGuidanceProgressTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<UserGuidanceProgress>(
      rows,
      columns: columns?.call(UserGuidanceProgress.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [UserGuidanceProgress]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserGuidanceProgress> updateRow(
    _is.DatabaseSession session,
    UserGuidanceProgress row, {
    _is.ColumnSelections<UserGuidanceProgressTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserGuidanceProgress>(
      row,
      columns: columns?.call(UserGuidanceProgress.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserGuidanceProgress] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserGuidanceProgress?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<UserGuidanceProgressUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<UserGuidanceProgress>(
      id,
      columnValues: columnValues(UserGuidanceProgress.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserGuidanceProgress]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UserGuidanceProgress>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<UserGuidanceProgressUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<UserGuidanceProgressTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UserGuidanceProgressTable>? orderBy,
    _is.OrderByListBuilder<UserGuidanceProgressTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<UserGuidanceProgress>(
      columnValues: columnValues(UserGuidanceProgress.t.updateTable),
      where: where(UserGuidanceProgress.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserGuidanceProgress.t),
      orderByList: orderByList?.call(UserGuidanceProgress.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [UserGuidanceProgress]s in the list and returns the deleted rows.
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
  Future<List<UserGuidanceProgress>> delete(
    _is.DatabaseSession session,
    List<UserGuidanceProgress> rows, {
    _is.OrderByBuilder<UserGuidanceProgressTable>? orderBy,
    _is.OrderByListBuilder<UserGuidanceProgressTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<UserGuidanceProgress>(
      rows,
      orderBy: orderBy?.call(UserGuidanceProgress.t),
      orderByList: orderByList?.call(UserGuidanceProgress.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [UserGuidanceProgress].
  Future<UserGuidanceProgress> deleteRow(
    _is.DatabaseSession session,
    UserGuidanceProgress row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserGuidanceProgress>(
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
  Future<List<UserGuidanceProgress>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserGuidanceProgressTable> where,
    _is.OrderByBuilder<UserGuidanceProgressTable>? orderBy,
    _is.OrderByListBuilder<UserGuidanceProgressTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<UserGuidanceProgress>(
      where: where(UserGuidanceProgress.t),
      orderBy: orderBy?.call(UserGuidanceProgress.t),
      orderByList: orderByList?.call(UserGuidanceProgress.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UserGuidanceProgressTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<UserGuidanceProgress>(
      where: where?.call(UserGuidanceProgress.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserGuidanceProgress] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UserGuidanceProgressTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserGuidanceProgress>(
      where: where(UserGuidanceProgress.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
