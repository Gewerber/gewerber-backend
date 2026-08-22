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
import '../../../modules/accounting/models/transaction_type.dart' as _i2;
import '../../../modules/accounting/models/transaction_category.dart' as _i3;

abstract class AccountingTransaction
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AccountingTransaction._({
    this.id,
    required this.businessId,
    required this.type,
    required this.category,
    this.description,
    required this.occurredAt,
    required this.amountCents,
    this.receiptDocumentId,
    this.relatedInvoiceId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory AccountingTransaction({
    int? id,
    required int businessId,
    required _i2.TransactionType type,
    required _i3.TransactionCategory category,
    String? description,
    required DateTime occurredAt,
    required int amountCents,
    int? receiptDocumentId,
    int? relatedInvoiceId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AccountingTransactionImpl;

  factory AccountingTransaction.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AccountingTransaction(
      id: jsonSerialization['id'] as int?,
      businessId: jsonSerialization['businessId'] as int,
      type: _i2.TransactionType.fromJson((jsonSerialization['type'] as String)),
      category: _i3.TransactionCategory.fromJson(
        (jsonSerialization['category'] as String),
      ),
      description: jsonSerialization['description'] as String?,
      occurredAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredAt'],
      ),
      amountCents: jsonSerialization['amountCents'] as int,
      receiptDocumentId: jsonSerialization['receiptDocumentId'] as int?,
      relatedInvoiceId: jsonSerialization['relatedInvoiceId'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = AccountingTransactionTable();

  static const db = AccountingTransactionRepository._();

  @override
  int? id;

  int businessId;

  _i2.TransactionType type;

  _i3.TransactionCategory category;

  String? description;

  DateTime occurredAt;

  int amountCents;

  int? receiptDocumentId;

  int? relatedInvoiceId;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AccountingTransaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AccountingTransaction copyWith({
    int? id,
    int? businessId,
    _i2.TransactionType? type,
    _i3.TransactionCategory? category,
    String? description,
    DateTime? occurredAt,
    int? amountCents,
    int? receiptDocumentId,
    int? relatedInvoiceId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AccountingTransaction',
      if (id != null) 'id': id,
      'businessId': businessId,
      'type': type.toJson(),
      'category': category.toJson(),
      if (description != null) 'description': description,
      'occurredAt': occurredAt.toJson(),
      'amountCents': amountCents,
      if (receiptDocumentId != null) 'receiptDocumentId': receiptDocumentId,
      if (relatedInvoiceId != null) 'relatedInvoiceId': relatedInvoiceId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AccountingTransaction',
      if (id != null) 'id': id,
      'businessId': businessId,
      'type': type.toJson(),
      'category': category.toJson(),
      if (description != null) 'description': description,
      'occurredAt': occurredAt.toJson(),
      'amountCents': amountCents,
      if (receiptDocumentId != null) 'receiptDocumentId': receiptDocumentId,
      if (relatedInvoiceId != null) 'relatedInvoiceId': relatedInvoiceId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static AccountingTransactionInclude include() {
    return AccountingTransactionInclude._();
  }

  static AccountingTransactionIncludeList includeList({
    _i1.WhereExpressionBuilder<AccountingTransactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccountingTransactionTable>? orderBy,
    _i1.OrderByListBuilder<AccountingTransactionTable>? orderByList,
    AccountingTransactionInclude? include,
  }) {
    return AccountingTransactionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AccountingTransaction.t),
      orderByList: orderByList?.call(AccountingTransaction.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AccountingTransactionImpl extends AccountingTransaction {
  _AccountingTransactionImpl({
    int? id,
    required int businessId,
    required _i2.TransactionType type,
    required _i3.TransactionCategory category,
    String? description,
    required DateTime occurredAt,
    required int amountCents,
    int? receiptDocumentId,
    int? relatedInvoiceId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         businessId: businessId,
         type: type,
         category: category,
         description: description,
         occurredAt: occurredAt,
         amountCents: amountCents,
         receiptDocumentId: receiptDocumentId,
         relatedInvoiceId: relatedInvoiceId,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [AccountingTransaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AccountingTransaction copyWith({
    Object? id = _Undefined,
    int? businessId,
    _i2.TransactionType? type,
    _i3.TransactionCategory? category,
    Object? description = _Undefined,
    DateTime? occurredAt,
    int? amountCents,
    Object? receiptDocumentId = _Undefined,
    Object? relatedInvoiceId = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AccountingTransaction(
      id: id is int? ? id : this.id,
      businessId: businessId ?? this.businessId,
      type: type ?? this.type,
      category: category ?? this.category,
      description: description is String? ? description : this.description,
      occurredAt: occurredAt ?? this.occurredAt,
      amountCents: amountCents ?? this.amountCents,
      receiptDocumentId: receiptDocumentId is int?
          ? receiptDocumentId
          : this.receiptDocumentId,
      relatedInvoiceId: relatedInvoiceId is int?
          ? relatedInvoiceId
          : this.relatedInvoiceId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class AccountingTransactionUpdateTable
    extends _i1.UpdateTable<AccountingTransactionTable> {
  AccountingTransactionUpdateTable(super.table);

  _i1.ColumnValue<int, int> businessId(int value) => _i1.ColumnValue(
    table.businessId,
    value,
  );

  _i1.ColumnValue<_i2.TransactionType, _i2.TransactionType> type(
    _i2.TransactionType value,
  ) => _i1.ColumnValue(
    table.type,
    value,
  );

  _i1.ColumnValue<_i3.TransactionCategory, _i3.TransactionCategory> category(
    _i3.TransactionCategory value,
  ) => _i1.ColumnValue(
    table.category,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> occurredAt(DateTime value) =>
      _i1.ColumnValue(
        table.occurredAt,
        value,
      );

  _i1.ColumnValue<int, int> amountCents(int value) => _i1.ColumnValue(
    table.amountCents,
    value,
  );

  _i1.ColumnValue<int, int> receiptDocumentId(int? value) => _i1.ColumnValue(
    table.receiptDocumentId,
    value,
  );

  _i1.ColumnValue<int, int> relatedInvoiceId(int? value) => _i1.ColumnValue(
    table.relatedInvoiceId,
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

class AccountingTransactionTable extends _i1.Table<int?> {
  AccountingTransactionTable({super.tableRelation})
    : super(tableName: 'accounting_transaction') {
    updateTable = AccountingTransactionUpdateTable(this);
    businessId = _i1.ColumnInt(
      'businessId',
      this,
    );
    type = _i1.ColumnEnum(
      'type',
      this,
      _i1.EnumSerialization.byName,
    );
    category = _i1.ColumnEnum(
      'category',
      this,
      _i1.EnumSerialization.byName,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    occurredAt = _i1.ColumnDateTime(
      'occurredAt',
      this,
    );
    amountCents = _i1.ColumnInt(
      'amountCents',
      this,
    );
    receiptDocumentId = _i1.ColumnInt(
      'receiptDocumentId',
      this,
    );
    relatedInvoiceId = _i1.ColumnInt(
      'relatedInvoiceId',
      this,
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

  late final AccountingTransactionUpdateTable updateTable;

  late final _i1.ColumnInt businessId;

  late final _i1.ColumnEnum<_i2.TransactionType> type;

  late final _i1.ColumnEnum<_i3.TransactionCategory> category;

  late final _i1.ColumnString description;

  late final _i1.ColumnDateTime occurredAt;

  late final _i1.ColumnInt amountCents;

  late final _i1.ColumnInt receiptDocumentId;

  late final _i1.ColumnInt relatedInvoiceId;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    businessId,
    type,
    category,
    description,
    occurredAt,
    amountCents,
    receiptDocumentId,
    relatedInvoiceId,
    createdAt,
    updatedAt,
  ];
}

class AccountingTransactionInclude extends _i1.IncludeObject {
  AccountingTransactionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AccountingTransaction.t;
}

class AccountingTransactionIncludeList extends _i1.IncludeList {
  AccountingTransactionIncludeList._({
    _i1.WhereExpressionBuilder<AccountingTransactionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AccountingTransaction.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AccountingTransaction.t;
}

class AccountingTransactionRepository {
  const AccountingTransactionRepository._();

  /// Returns a list of [AccountingTransaction]s matching the given query parameters.
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
  Future<List<AccountingTransaction>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AccountingTransactionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccountingTransactionTable>? orderBy,
    _i1.OrderByListBuilder<AccountingTransactionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AccountingTransaction>(
      where: where?.call(AccountingTransaction.t),
      orderBy: orderBy?.call(AccountingTransaction.t),
      orderByList: orderByList?.call(AccountingTransaction.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AccountingTransaction] matching the given query parameters.
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
  Future<AccountingTransaction?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AccountingTransactionTable>? where,
    int? offset,
    _i1.OrderByBuilder<AccountingTransactionTable>? orderBy,
    _i1.OrderByListBuilder<AccountingTransactionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AccountingTransaction>(
      where: where?.call(AccountingTransaction.t),
      orderBy: orderBy?.call(AccountingTransaction.t),
      orderByList: orderByList?.call(AccountingTransaction.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AccountingTransaction] by its [id] or null if no such row exists.
  Future<AccountingTransaction?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AccountingTransaction>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AccountingTransaction]s in the list and returns the inserted rows.
  ///
  /// The returned [AccountingTransaction]s will have their `id` fields set.
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
  Future<List<AccountingTransaction>> insert(
    _i1.DatabaseSession session,
    List<AccountingTransaction> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AccountingTransaction>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AccountingTransaction] and returns the inserted row.
  ///
  /// The returned [AccountingTransaction] will have its `id` field set.
  Future<AccountingTransaction> insertRow(
    _i1.DatabaseSession session,
    AccountingTransaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AccountingTransaction>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [AccountingTransaction]s in the list and returns the resulting rows.
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
  /// The returned [AccountingTransaction]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AccountingTransaction>> upsert(
    _i1.DatabaseSession session,
    List<AccountingTransaction> rows, {
    required _i1.ColumnSelections<AccountingTransactionTable> conflictColumns,
    _i1.ColumnSelections<AccountingTransactionTable>? updateColumns,
    _i1.WhereExpressionBuilder<AccountingTransactionTable>? updateWhere,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AccountingTransaction>(
      rows,
      conflictColumns: conflictColumns(AccountingTransaction.t),
      updateColumns: updateColumns?.call(AccountingTransaction.t),
      updateWhere: updateWhere?.call(AccountingTransaction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AccountingTransaction] and returns the resulting row.
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
  /// The returned [AccountingTransaction] will have its `id` field set.
  Future<AccountingTransaction?> upsertRow(
    _i1.DatabaseSession session,
    AccountingTransaction row, {
    required _i1.ColumnSelections<AccountingTransactionTable> conflictColumns,
    _i1.ColumnSelections<AccountingTransactionTable>? updateColumns,
    _i1.WhereExpressionBuilder<AccountingTransactionTable>? updateWhere,
    _i1.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AccountingTransaction>(
      row,
      conflictColumns: conflictColumns(AccountingTransaction.t),
      updateColumns: updateColumns?.call(AccountingTransaction.t),
      updateWhere: updateWhere?.call(AccountingTransaction.t),
      transaction: transaction,
    );
  }

  /// Updates all [AccountingTransaction]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AccountingTransaction>> update(
    _i1.DatabaseSession session,
    List<AccountingTransaction> rows, {
    _i1.ColumnSelections<AccountingTransactionTable>? columns,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AccountingTransaction>(
      rows,
      columns: columns?.call(AccountingTransaction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AccountingTransaction]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AccountingTransaction> updateRow(
    _i1.DatabaseSession session,
    AccountingTransaction row, {
    _i1.ColumnSelections<AccountingTransactionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AccountingTransaction>(
      row,
      columns: columns?.call(AccountingTransaction.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AccountingTransaction] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AccountingTransaction?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AccountingTransactionUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AccountingTransaction>(
      id,
      columnValues: columnValues(AccountingTransaction.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AccountingTransaction]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AccountingTransaction>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AccountingTransactionUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<AccountingTransactionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AccountingTransactionTable>? orderBy,
    _i1.OrderByListBuilder<AccountingTransactionTable>? orderByList,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AccountingTransaction>(
      columnValues: columnValues(AccountingTransaction.t.updateTable),
      where: where(AccountingTransaction.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AccountingTransaction.t),
      orderByList: orderByList?.call(AccountingTransaction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AccountingTransaction]s in the list and returns the deleted rows.
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
  Future<List<AccountingTransaction>> delete(
    _i1.DatabaseSession session,
    List<AccountingTransaction> rows, {
    _i1.OrderByBuilder<AccountingTransactionTable>? orderBy,
    _i1.OrderByListBuilder<AccountingTransactionTable>? orderByList,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AccountingTransaction>(
      rows,
      orderBy: orderBy?.call(AccountingTransaction.t),
      orderByList: orderByList?.call(AccountingTransaction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AccountingTransaction].
  Future<AccountingTransaction> deleteRow(
    _i1.DatabaseSession session,
    AccountingTransaction row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AccountingTransaction>(
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
  Future<List<AccountingTransaction>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AccountingTransactionTable> where,
    _i1.OrderByBuilder<AccountingTransactionTable>? orderBy,
    _i1.OrderByListBuilder<AccountingTransactionTable>? orderByList,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AccountingTransaction>(
      where: where(AccountingTransaction.t),
      orderBy: orderBy?.call(AccountingTransaction.t),
      orderByList: orderByList?.call(AccountingTransaction.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AccountingTransactionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AccountingTransaction>(
      where: where?.call(AccountingTransaction.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AccountingTransaction] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AccountingTransactionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AccountingTransaction>(
      where: where(AccountingTransaction.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
