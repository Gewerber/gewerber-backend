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
import '../../../modules/time_tracking/models/project_status.dart' as _i1ujg7mu;

abstract class Project
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Project._({
    this.id,
    required this.businessId,
    required this.name,
    _i1ujg7mu.ProjectStatus? status,
    this.customerId,
    this.hourlyRateCents,
    this.notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : status = status ?? _i1ujg7mu.ProjectStatus.active,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Project({
    int? id,
    required int businessId,
    required String name,
    _i1ujg7mu.ProjectStatus? status,
    int? customerId,
    int? hourlyRateCents,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProjectImpl;

  factory Project.fromJson(Map<String, dynamic> jsonSerialization) {
    return Project(
      id: jsonSerialization['id'] as int?,
      businessId: jsonSerialization['businessId'] as int,
      name: jsonSerialization['name'] as String,
      status: jsonSerialization['status'] == null
          ? null
          : _i1ujg7mu.ProjectStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      customerId: jsonSerialization['customerId'] as int?,
      hourlyRateCents: jsonSerialization['hourlyRateCents'] as int?,
      notes: jsonSerialization['notes'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ProjectTable();

  static const db = ProjectRepository._();

  @override
  int? id;

  int businessId;

  String name;

  _i1ujg7mu.ProjectStatus status;

  int? customerId;

  int? hourlyRateCents;

  String? notes;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Project]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Project copyWith({
    int? id,
    int? businessId,
    String? name,
    _i1ujg7mu.ProjectStatus? status,
    int? customerId,
    int? hourlyRateCents,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Project',
      if (id != null) 'id': id,
      'businessId': businessId,
      'name': name,
      'status': status.toJson(),
      if (customerId != null) 'customerId': customerId,
      if (hourlyRateCents != null) 'hourlyRateCents': hourlyRateCents,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Project',
      if (id != null) 'id': id,
      'businessId': businessId,
      'name': name,
      'status': status.toJson(),
      if (customerId != null) 'customerId': customerId,
      if (hourlyRateCents != null) 'hourlyRateCents': hourlyRateCents,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ProjectInclude include() {
    return ProjectInclude._();
  }

  static ProjectIncludeList includeList({
    _is.WhereExpressionBuilder<ProjectTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProjectTable>? orderBy,
    _is.OrderByListBuilder<ProjectTable>? orderByList,
    ProjectInclude? include,
  }) {
    return ProjectIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Project.t),
      orderByList: orderByList?.call(Project.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProjectImpl extends Project {
  _ProjectImpl({
    int? id,
    required int businessId,
    required String name,
    _i1ujg7mu.ProjectStatus? status,
    int? customerId,
    int? hourlyRateCents,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         businessId: businessId,
         name: name,
         status: status,
         customerId: customerId,
         hourlyRateCents: hourlyRateCents,
         notes: notes,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Project]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Project copyWith({
    Object? id = _Undefined,
    int? businessId,
    String? name,
    _i1ujg7mu.ProjectStatus? status,
    Object? customerId = _Undefined,
    Object? hourlyRateCents = _Undefined,
    Object? notes = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Project(
      id: id is int? ? id : this.id,
      businessId: businessId ?? this.businessId,
      name: name ?? this.name,
      status: status ?? this.status,
      customerId: customerId is int? ? customerId : this.customerId,
      hourlyRateCents: hourlyRateCents is int?
          ? hourlyRateCents
          : this.hourlyRateCents,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ProjectUpdateTable extends _is.UpdateTable<ProjectTable> {
  ProjectUpdateTable(super.table);

  _is.ColumnValue<int, int> businessId(int value) => _is.ColumnValue(
    table.businessId,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<_i1ujg7mu.ProjectStatus, _i1ujg7mu.ProjectStatus> status(
    _i1ujg7mu.ProjectStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<int, int> customerId(int? value) => _is.ColumnValue(
    table.customerId,
    value,
  );

  _is.ColumnValue<int, int> hourlyRateCents(int? value) => _is.ColumnValue(
    table.hourlyRateCents,
    value,
  );

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(
    table.notes,
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

class ProjectTable extends _is.Table<int?> {
  ProjectTable({super.tableRelation}) : super(tableName: 'project') {
    updateTable = ProjectUpdateTable(this);
    businessId = _is.ColumnInt(
      'businessId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
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
    hourlyRateCents = _is.ColumnInt(
      'hourlyRateCents',
      this,
    );
    notes = _is.ColumnString(
      'notes',
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

  late final ProjectUpdateTable updateTable;

  late final _is.ColumnInt businessId;

  late final _is.ColumnString name;

  late final _is.ColumnEnum<_i1ujg7mu.ProjectStatus> status;

  late final _is.ColumnInt customerId;

  late final _is.ColumnInt hourlyRateCents;

  late final _is.ColumnString notes;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    businessId,
    name,
    status,
    customerId,
    hourlyRateCents,
    notes,
    createdAt,
    updatedAt,
  ];
}

class ProjectInclude extends _is.IncludeObject {
  ProjectInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Project.t;
}

class ProjectIncludeList extends _is.IncludeList {
  ProjectIncludeList._({
    _is.WhereExpressionBuilder<ProjectTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Project.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Project.t;
}

class ProjectRepository {
  const ProjectRepository._();

  /// Returns a list of [Project]s matching the given query parameters.
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
  Future<List<Project>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProjectTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProjectTable>? orderBy,
    _is.OrderByListBuilder<ProjectTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Project>(
      where: where?.call(Project.t),
      orderBy: orderBy?.call(Project.t),
      orderByList: orderByList?.call(Project.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Project] matching the given query parameters.
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
  Future<Project?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProjectTable>? where,
    int? offset,
    _is.OrderByBuilder<ProjectTable>? orderBy,
    _is.OrderByListBuilder<ProjectTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Project>(
      where: where?.call(Project.t),
      orderBy: orderBy?.call(Project.t),
      orderByList: orderByList?.call(Project.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Project] by its [id] or null if no such row exists.
  Future<Project?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Project>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Project]s in the list and returns the inserted rows.
  ///
  /// The returned [Project]s will have their `id` fields set.
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
  Future<List<Project>> insert(
    _is.DatabaseSession session,
    List<Project> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Project>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Project] and returns the inserted row.
  ///
  /// The returned [Project] will have its `id` field set.
  Future<Project> insertRow(
    _is.DatabaseSession session,
    Project row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Project>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Project]s in the list and returns the resulting rows.
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
  /// The returned [Project]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Project>> upsert(
    _is.DatabaseSession session,
    List<Project> rows, {
    required _is.ColumnSelections<ProjectTable> conflictColumns,
    _is.ColumnSelections<ProjectTable>? updateColumns,
    _is.WhereExpressionBuilder<ProjectTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Project>(
      rows,
      conflictColumns: conflictColumns(Project.t),
      updateColumns: updateColumns?.call(Project.t),
      updateWhere: updateWhere?.call(Project.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Project] and returns the resulting row.
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
  /// The returned [Project] will have its `id` field set.
  Future<Project?> upsertRow(
    _is.DatabaseSession session,
    Project row, {
    required _is.ColumnSelections<ProjectTable> conflictColumns,
    _is.ColumnSelections<ProjectTable>? updateColumns,
    _is.WhereExpressionBuilder<ProjectTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Project>(
      row,
      conflictColumns: conflictColumns(Project.t),
      updateColumns: updateColumns?.call(Project.t),
      updateWhere: updateWhere?.call(Project.t),
      transaction: transaction,
    );
  }

  /// Updates all [Project]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Project>> update(
    _is.DatabaseSession session,
    List<Project> rows, {
    _is.ColumnSelections<ProjectTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Project>(
      rows,
      columns: columns?.call(Project.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Project]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Project> updateRow(
    _is.DatabaseSession session,
    Project row, {
    _is.ColumnSelections<ProjectTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Project>(
      row,
      columns: columns?.call(Project.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Project] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Project?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ProjectUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Project>(
      id,
      columnValues: columnValues(Project.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Project]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Project>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ProjectUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ProjectTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ProjectTable>? orderBy,
    _is.OrderByListBuilder<ProjectTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Project>(
      columnValues: columnValues(Project.t.updateTable),
      where: where(Project.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Project.t),
      orderByList: orderByList?.call(Project.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Project]s in the list and returns the deleted rows.
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
  Future<List<Project>> delete(
    _is.DatabaseSession session,
    List<Project> rows, {
    _is.OrderByBuilder<ProjectTable>? orderBy,
    _is.OrderByListBuilder<ProjectTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Project>(
      rows,
      orderBy: orderBy?.call(Project.t),
      orderByList: orderByList?.call(Project.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Project].
  Future<Project> deleteRow(
    _is.DatabaseSession session,
    Project row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Project>(
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
  Future<List<Project>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProjectTable> where,
    _is.OrderByBuilder<ProjectTable>? orderBy,
    _is.OrderByListBuilder<ProjectTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Project>(
      where: where(Project.t),
      orderBy: orderBy?.call(Project.t),
      orderByList: orderByList?.call(Project.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ProjectTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Project>(
      where: where?.call(Project.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Project] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ProjectTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Project>(
      where: where(Project.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
