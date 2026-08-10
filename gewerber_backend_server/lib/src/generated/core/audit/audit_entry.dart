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
import 'package:gewerber_backend_server/src/generated/protocol.dart' as _i2;

abstract class AuditEntry
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AuditEntry._({
    this.id,
    this.businessId,
    this.userId,
    required this.action,
    required this.entityType,
    this.entityId,
    this.changes,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory AuditEntry({
    int? id,
    int? businessId,
    _i1.UuidValue? userId,
    required String action,
    required String entityType,
    String? entityId,
    Map<String, String>? changes,
    DateTime? createdAt,
  }) = _AuditEntryImpl;

  factory AuditEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuditEntry(
      id: jsonSerialization['id'] as int?,
      businessId: jsonSerialization['businessId'] as int?,
      userId: jsonSerialization['userId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      action: jsonSerialization['action'] as String,
      entityType: jsonSerialization['entityType'] as String,
      entityId: jsonSerialization['entityId'] as String?,
      changes: jsonSerialization['changes'] == null
          ? null
          : _i2.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['changes'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = AuditEntryTable();

  static const db = AuditEntryRepository._();

  @override
  int? id;

  int? businessId;

  _i1.UuidValue? userId;

  String action;

  String entityType;

  String? entityId;

  Map<String, String>? changes;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AuditEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuditEntry copyWith({
    int? id,
    int? businessId,
    _i1.UuidValue? userId,
    String? action,
    String? entityType,
    String? entityId,
    Map<String, String>? changes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuditEntry',
      if (id != null) 'id': id,
      if (businessId != null) 'businessId': businessId,
      if (userId != null) 'userId': userId?.toJson(),
      'action': action,
      'entityType': entityType,
      if (entityId != null) 'entityId': entityId,
      if (changes != null) 'changes': changes?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static AuditEntryInclude include() {
    return AuditEntryInclude._();
  }

  static AuditEntryIncludeList includeList({
    _i1.WhereExpressionBuilder<AuditEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AuditEntryTable>? orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.OrderByListBuilder<AuditEntryTable>? orderByList,
    AuditEntryInclude? include,
  }) {
    return AuditEntryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AuditEntry.t),
      orderDescending: // ignore: deprecated_member_use_from_same_package
          orderDescending,
      orderByList: orderByList?.call(AuditEntry.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuditEntryImpl extends AuditEntry {
  _AuditEntryImpl({
    int? id,
    int? businessId,
    _i1.UuidValue? userId,
    required String action,
    required String entityType,
    String? entityId,
    Map<String, String>? changes,
    DateTime? createdAt,
  }) : super._(
         id: id,
         businessId: businessId,
         userId: userId,
         action: action,
         entityType: entityType,
         entityId: entityId,
         changes: changes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AuditEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuditEntry copyWith({
    Object? id = _Undefined,
    Object? businessId = _Undefined,
    Object? userId = _Undefined,
    String? action,
    String? entityType,
    Object? entityId = _Undefined,
    Object? changes = _Undefined,
    DateTime? createdAt,
  }) {
    return AuditEntry(
      id: id is int? ? id : this.id,
      businessId: businessId is int? ? businessId : this.businessId,
      userId: userId is _i1.UuidValue? ? userId : this.userId,
      action: action ?? this.action,
      entityType: entityType ?? this.entityType,
      entityId: entityId is String? ? entityId : this.entityId,
      changes: changes is Map<String, String>?
          ? changes
          : this.changes?.map(
              (
                key0,
                value0,
              ) => MapEntry(
                key0,
                value0,
              ),
            ),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AuditEntryUpdateTable extends _i1.UpdateTable<AuditEntryTable> {
  AuditEntryUpdateTable(super.table);

  _i1.ColumnValue<int, int> businessId(int? value) => _i1.ColumnValue(
    table.businessId,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue? value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<String, String> action(String value) => _i1.ColumnValue(
    table.action,
    value,
  );

  _i1.ColumnValue<String, String> entityType(String value) => _i1.ColumnValue(
    table.entityType,
    value,
  );

  _i1.ColumnValue<String, String> entityId(String? value) => _i1.ColumnValue(
    table.entityId,
    value,
  );

  _i1.ColumnValue<Map<String, String>, Map<String, String>> changes(
    Map<String, String>? value,
  ) => _i1.ColumnValue(
    table.changes,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class AuditEntryTable extends _i1.Table<int?> {
  AuditEntryTable({super.tableRelation}) : super(tableName: 'audit_entry') {
    updateTable = AuditEntryUpdateTable(this);
    businessId = _i1.ColumnInt(
      'businessId',
      this,
    );
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    action = _i1.ColumnString(
      'action',
      this,
    );
    entityType = _i1.ColumnString(
      'entityType',
      this,
    );
    entityId = _i1.ColumnString(
      'entityId',
      this,
    );
    changes = _i1.ColumnSerializable<Map<String, String>>(
      'changes',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final AuditEntryUpdateTable updateTable;

  late final _i1.ColumnInt businessId;

  late final _i1.ColumnUuid userId;

  late final _i1.ColumnString action;

  late final _i1.ColumnString entityType;

  late final _i1.ColumnString entityId;

  late final _i1.ColumnSerializable<Map<String, String>> changes;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    businessId,
    userId,
    action,
    entityType,
    entityId,
    changes,
    createdAt,
  ];
}

class AuditEntryInclude extends _i1.IncludeObject {
  AuditEntryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AuditEntry.t;
}

class AuditEntryIncludeList extends _i1.IncludeList {
  AuditEntryIncludeList._({
    _i1.WhereExpressionBuilder<AuditEntryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AuditEntry.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AuditEntry.t;
}

class AuditEntryRepository {
  const AuditEntryRepository._();

  /// Returns a list of [AuditEntry]s matching the given query parameters.
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
  Future<List<AuditEntry>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AuditEntryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AuditEntryTable>? orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.OrderByListBuilder<AuditEntryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AuditEntry>(
      where: where?.call(AuditEntry.t),
      orderBy: orderBy?.call(AuditEntry.t),
      orderByList: orderByList?.call(AuditEntry.t),
      orderDescending: // ignore: deprecated_member_use
          orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AuditEntry] matching the given query parameters.
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
  Future<AuditEntry?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AuditEntryTable>? where,
    int? offset,
    _i1.OrderByBuilder<AuditEntryTable>? orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.OrderByListBuilder<AuditEntryTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AuditEntry>(
      where: where?.call(AuditEntry.t),
      orderBy: orderBy?.call(AuditEntry.t),
      orderByList: orderByList?.call(AuditEntry.t),
      orderDescending: // ignore: deprecated_member_use
          orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AuditEntry] by its [id] or null if no such row exists.
  Future<AuditEntry?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AuditEntry>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AuditEntry]s in the list and returns the inserted rows.
  ///
  /// The returned [AuditEntry]s will have their `id` fields set.
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
  Future<List<AuditEntry>> insert(
    _i1.DatabaseSession session,
    List<AuditEntry> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AuditEntry>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AuditEntry] and returns the inserted row.
  ///
  /// The returned [AuditEntry] will have its `id` field set.
  Future<AuditEntry> insertRow(
    _i1.DatabaseSession session,
    AuditEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AuditEntry>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AuditEntry]s in the list and returns the resulting rows.
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
  /// The returned [AuditEntry]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AuditEntry>> upsert(
    _i1.DatabaseSession session,
    List<AuditEntry> rows, {
    required _i1.ColumnSelections<AuditEntryTable> conflictColumns,
    _i1.ColumnSelections<AuditEntryTable>? updateColumns,
    _i1.WhereExpressionBuilder<AuditEntryTable>? updateWhere,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AuditEntry>(
      rows,
      conflictColumns: conflictColumns(AuditEntry.t),
      updateColumns: updateColumns?.call(AuditEntry.t),
      updateWhere: updateWhere?.call(AuditEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AuditEntry] and returns the resulting row.
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
  /// The returned [AuditEntry] will have its `id` field set.
  Future<AuditEntry?> upsertRow(
    _i1.DatabaseSession session,
    AuditEntry row, {
    required _i1.ColumnSelections<AuditEntryTable> conflictColumns,
    _i1.ColumnSelections<AuditEntryTable>? updateColumns,
    _i1.WhereExpressionBuilder<AuditEntryTable>? updateWhere,
    _i1.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AuditEntry>(
      row,
      conflictColumns: conflictColumns(AuditEntry.t),
      updateColumns: updateColumns?.call(AuditEntry.t),
      updateWhere: updateWhere?.call(AuditEntry.t),
      transaction: transaction,
    );
  }

  /// Updates all [AuditEntry]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AuditEntry>> update(
    _i1.DatabaseSession session,
    List<AuditEntry> rows, {
    _i1.ColumnSelections<AuditEntryTable>? columns,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AuditEntry>(
      rows,
      columns: columns?.call(AuditEntry.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AuditEntry]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AuditEntry> updateRow(
    _i1.DatabaseSession session,
    AuditEntry row, {
    _i1.ColumnSelections<AuditEntryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AuditEntry>(
      row,
      columns: columns?.call(AuditEntry.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AuditEntry] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AuditEntry?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AuditEntryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AuditEntry>(
      id,
      columnValues: columnValues(AuditEntry.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AuditEntry]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AuditEntry>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AuditEntryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AuditEntryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AuditEntryTable>? orderBy,
    _i1.OrderByListBuilder<AuditEntryTable>? orderByList,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AuditEntry>(
      columnValues: columnValues(AuditEntry.t.updateTable),
      where: where(AuditEntry.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AuditEntry.t),
      orderByList: orderByList?.call(AuditEntry.t),
      orderDescending: // ignore: deprecated_member_use
          orderDescending,
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AuditEntry]s in the list and returns the deleted rows.
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
  Future<List<AuditEntry>> delete(
    _i1.DatabaseSession session,
    List<AuditEntry> rows, {
    _i1.OrderByBuilder<AuditEntryTable>? orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.OrderByListBuilder<AuditEntryTable>? orderByList,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AuditEntry>(
      rows,
      orderBy: orderBy?.call(AuditEntry.t),
      orderByList: orderByList?.call(AuditEntry.t),
      orderDescending: // ignore: deprecated_member_use
          orderDescending,
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AuditEntry].
  Future<AuditEntry> deleteRow(
    _i1.DatabaseSession session,
    AuditEntry row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AuditEntry>(
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
  Future<List<AuditEntry>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AuditEntryTable> where,
    _i1.OrderByBuilder<AuditEntryTable>? orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.OrderByListBuilder<AuditEntryTable>? orderByList,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AuditEntry>(
      where: where(AuditEntry.t),
      orderBy: orderBy?.call(AuditEntry.t),
      orderByList: orderByList?.call(AuditEntry.t),
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
    _i1.WhereExpressionBuilder<AuditEntryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AuditEntry>(
      where: where?.call(AuditEntry.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AuditEntry] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AuditEntryTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AuditEntry>(
      where: where(AuditEntry.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
