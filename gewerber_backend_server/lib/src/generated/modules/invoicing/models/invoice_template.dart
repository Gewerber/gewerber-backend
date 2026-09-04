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

abstract class InvoiceTemplate
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  InvoiceTemplate._({
    this.id,
    required this.businessId,
    required this.name,
    bool? isDefault,
    this.headerText,
    this.footerText,
    this.logoDocumentId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isDefault = isDefault ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory InvoiceTemplate({
    int? id,
    required int businessId,
    required String name,
    bool? isDefault,
    String? headerText,
    String? footerText,
    int? logoDocumentId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _InvoiceTemplateImpl;

  factory InvoiceTemplate.fromJson(Map<String, dynamic> jsonSerialization) {
    return InvoiceTemplate(
      id: jsonSerialization['id'] as int?,
      businessId: jsonSerialization['businessId'] as int,
      name: jsonSerialization['name'] as String,
      isDefault: jsonSerialization['isDefault'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isDefault']),
      headerText: jsonSerialization['headerText'] as String?,
      footerText: jsonSerialization['footerText'] as String?,
      logoDocumentId: jsonSerialization['logoDocumentId'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = InvoiceTemplateTable();

  static const db = InvoiceTemplateRepository._();

  @override
  int? id;

  int businessId;

  String name;

  bool isDefault;

  String? headerText;

  String? footerText;

  int? logoDocumentId;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [InvoiceTemplate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  InvoiceTemplate copyWith({
    int? id,
    int? businessId,
    String? name,
    bool? isDefault,
    String? headerText,
    String? footerText,
    int? logoDocumentId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InvoiceTemplate',
      if (id != null) 'id': id,
      'businessId': businessId,
      'name': name,
      'isDefault': isDefault,
      if (headerText != null) 'headerText': headerText,
      if (footerText != null) 'footerText': footerText,
      if (logoDocumentId != null) 'logoDocumentId': logoDocumentId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InvoiceTemplate',
      if (id != null) 'id': id,
      'businessId': businessId,
      'name': name,
      'isDefault': isDefault,
      if (headerText != null) 'headerText': headerText,
      if (footerText != null) 'footerText': footerText,
      if (logoDocumentId != null) 'logoDocumentId': logoDocumentId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static InvoiceTemplateInclude include() {
    return InvoiceTemplateInclude._();
  }

  static InvoiceTemplateIncludeList includeList({
    _is.WhereExpressionBuilder<InvoiceTemplateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InvoiceTemplateTable>? orderBy,
    _is.OrderByListBuilder<InvoiceTemplateTable>? orderByList,
    InvoiceTemplateInclude? include,
  }) {
    return InvoiceTemplateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InvoiceTemplate.t),
      orderByList: orderByList?.call(InvoiceTemplate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InvoiceTemplateImpl extends InvoiceTemplate {
  _InvoiceTemplateImpl({
    int? id,
    required int businessId,
    required String name,
    bool? isDefault,
    String? headerText,
    String? footerText,
    int? logoDocumentId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         businessId: businessId,
         name: name,
         isDefault: isDefault,
         headerText: headerText,
         footerText: footerText,
         logoDocumentId: logoDocumentId,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [InvoiceTemplate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  InvoiceTemplate copyWith({
    Object? id = _Undefined,
    int? businessId,
    String? name,
    bool? isDefault,
    Object? headerText = _Undefined,
    Object? footerText = _Undefined,
    Object? logoDocumentId = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return InvoiceTemplate(
      id: id is int? ? id : this.id,
      businessId: businessId ?? this.businessId,
      name: name ?? this.name,
      isDefault: isDefault ?? this.isDefault,
      headerText: headerText is String? ? headerText : this.headerText,
      footerText: footerText is String? ? footerText : this.footerText,
      logoDocumentId: logoDocumentId is int?
          ? logoDocumentId
          : this.logoDocumentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class InvoiceTemplateUpdateTable extends _is.UpdateTable<InvoiceTemplateTable> {
  InvoiceTemplateUpdateTable(super.table);

  _is.ColumnValue<int, int> businessId(int value) => _is.ColumnValue(
    table.businessId,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<bool, bool> isDefault(bool value) => _is.ColumnValue(
    table.isDefault,
    value,
  );

  _is.ColumnValue<String, String> headerText(String? value) => _is.ColumnValue(
    table.headerText,
    value,
  );

  _is.ColumnValue<String, String> footerText(String? value) => _is.ColumnValue(
    table.footerText,
    value,
  );

  _is.ColumnValue<int, int> logoDocumentId(int? value) => _is.ColumnValue(
    table.logoDocumentId,
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

class InvoiceTemplateTable extends _is.Table<int?> {
  InvoiceTemplateTable({super.tableRelation})
    : super(tableName: 'invoice_template') {
    updateTable = InvoiceTemplateUpdateTable(this);
    businessId = _is.ColumnInt(
      'businessId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    isDefault = _is.ColumnBool(
      'isDefault',
      this,
      hasDefault: true,
    );
    headerText = _is.ColumnString(
      'headerText',
      this,
    );
    footerText = _is.ColumnString(
      'footerText',
      this,
    );
    logoDocumentId = _is.ColumnInt(
      'logoDocumentId',
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

  late final InvoiceTemplateUpdateTable updateTable;

  late final _is.ColumnInt businessId;

  late final _is.ColumnString name;

  late final _is.ColumnBool isDefault;

  late final _is.ColumnString headerText;

  late final _is.ColumnString footerText;

  late final _is.ColumnInt logoDocumentId;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    businessId,
    name,
    isDefault,
    headerText,
    footerText,
    logoDocumentId,
    createdAt,
    updatedAt,
  ];
}

class InvoiceTemplateInclude extends _is.IncludeObject {
  InvoiceTemplateInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => InvoiceTemplate.t;
}

class InvoiceTemplateIncludeList extends _is.IncludeList {
  InvoiceTemplateIncludeList._({
    _is.WhereExpressionBuilder<InvoiceTemplateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InvoiceTemplate.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => InvoiceTemplate.t;
}

class InvoiceTemplateRepository {
  const InvoiceTemplateRepository._();

  /// Returns a list of [InvoiceTemplate]s matching the given query parameters.
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
  Future<List<InvoiceTemplate>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InvoiceTemplateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InvoiceTemplateTable>? orderBy,
    _is.OrderByListBuilder<InvoiceTemplateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<InvoiceTemplate>(
      where: where?.call(InvoiceTemplate.t),
      orderBy: orderBy?.call(InvoiceTemplate.t),
      orderByList: orderByList?.call(InvoiceTemplate.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [InvoiceTemplate] matching the given query parameters.
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
  Future<InvoiceTemplate?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InvoiceTemplateTable>? where,
    int? offset,
    _is.OrderByBuilder<InvoiceTemplateTable>? orderBy,
    _is.OrderByListBuilder<InvoiceTemplateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<InvoiceTemplate>(
      where: where?.call(InvoiceTemplate.t),
      orderBy: orderBy?.call(InvoiceTemplate.t),
      orderByList: orderByList?.call(InvoiceTemplate.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [InvoiceTemplate] by its [id] or null if no such row exists.
  Future<InvoiceTemplate?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<InvoiceTemplate>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [InvoiceTemplate]s in the list and returns the inserted rows.
  ///
  /// The returned [InvoiceTemplate]s will have their `id` fields set.
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
  Future<List<InvoiceTemplate>> insert(
    _is.DatabaseSession session,
    List<InvoiceTemplate> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<InvoiceTemplate>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [InvoiceTemplate] and returns the inserted row.
  ///
  /// The returned [InvoiceTemplate] will have its `id` field set.
  Future<InvoiceTemplate> insertRow(
    _is.DatabaseSession session,
    InvoiceTemplate row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<InvoiceTemplate>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [InvoiceTemplate]s in the list and returns the resulting rows.
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
  /// The returned [InvoiceTemplate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InvoiceTemplate>> upsert(
    _is.DatabaseSession session,
    List<InvoiceTemplate> rows, {
    required _is.ColumnSelections<InvoiceTemplateTable> conflictColumns,
    _is.ColumnSelections<InvoiceTemplateTable>? updateColumns,
    _is.WhereExpressionBuilder<InvoiceTemplateTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<InvoiceTemplate>(
      rows,
      conflictColumns: conflictColumns(InvoiceTemplate.t),
      updateColumns: updateColumns?.call(InvoiceTemplate.t),
      updateWhere: updateWhere?.call(InvoiceTemplate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [InvoiceTemplate] and returns the resulting row.
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
  /// The returned [InvoiceTemplate] will have its `id` field set.
  Future<InvoiceTemplate?> upsertRow(
    _is.DatabaseSession session,
    InvoiceTemplate row, {
    required _is.ColumnSelections<InvoiceTemplateTable> conflictColumns,
    _is.ColumnSelections<InvoiceTemplateTable>? updateColumns,
    _is.WhereExpressionBuilder<InvoiceTemplateTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<InvoiceTemplate>(
      row,
      conflictColumns: conflictColumns(InvoiceTemplate.t),
      updateColumns: updateColumns?.call(InvoiceTemplate.t),
      updateWhere: updateWhere?.call(InvoiceTemplate.t),
      transaction: transaction,
    );
  }

  /// Updates all [InvoiceTemplate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InvoiceTemplate>> update(
    _is.DatabaseSession session,
    List<InvoiceTemplate> rows, {
    _is.ColumnSelections<InvoiceTemplateTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<InvoiceTemplate>(
      rows,
      columns: columns?.call(InvoiceTemplate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [InvoiceTemplate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InvoiceTemplate> updateRow(
    _is.DatabaseSession session,
    InvoiceTemplate row, {
    _is.ColumnSelections<InvoiceTemplateTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<InvoiceTemplate>(
      row,
      columns: columns?.call(InvoiceTemplate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InvoiceTemplate] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<InvoiceTemplate?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<InvoiceTemplateUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<InvoiceTemplate>(
      id,
      columnValues: columnValues(InvoiceTemplate.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [InvoiceTemplate]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InvoiceTemplate>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<InvoiceTemplateUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<InvoiceTemplateTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InvoiceTemplateTable>? orderBy,
    _is.OrderByListBuilder<InvoiceTemplateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<InvoiceTemplate>(
      columnValues: columnValues(InvoiceTemplate.t.updateTable),
      where: where(InvoiceTemplate.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InvoiceTemplate.t),
      orderByList: orderByList?.call(InvoiceTemplate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [InvoiceTemplate]s in the list and returns the deleted rows.
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
  Future<List<InvoiceTemplate>> delete(
    _is.DatabaseSession session,
    List<InvoiceTemplate> rows, {
    _is.OrderByBuilder<InvoiceTemplateTable>? orderBy,
    _is.OrderByListBuilder<InvoiceTemplateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<InvoiceTemplate>(
      rows,
      orderBy: orderBy?.call(InvoiceTemplate.t),
      orderByList: orderByList?.call(InvoiceTemplate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [InvoiceTemplate].
  Future<InvoiceTemplate> deleteRow(
    _is.DatabaseSession session,
    InvoiceTemplate row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InvoiceTemplate>(
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
  Future<List<InvoiceTemplate>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InvoiceTemplateTable> where,
    _is.OrderByBuilder<InvoiceTemplateTable>? orderBy,
    _is.OrderByListBuilder<InvoiceTemplateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<InvoiceTemplate>(
      where: where(InvoiceTemplate.t),
      orderBy: orderBy?.call(InvoiceTemplate.t),
      orderByList: orderByList?.call(InvoiceTemplate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InvoiceTemplateTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<InvoiceTemplate>(
      where: where?.call(InvoiceTemplate.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [InvoiceTemplate] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InvoiceTemplateTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<InvoiceTemplate>(
      where: where(InvoiceTemplate.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
