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

import 'package:gewerber_backend_server/src/generated/protocol.dart'
    as _itzp2rm6;
import 'package:serverpod/serverpod.dart' as _is;
import '../../../modules/business/models/address.dart' as _iz28txwx;
import '../../../modules/invoicing/models/customer_status.dart' as _iq2eew5f;

abstract class Customer
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Customer._({
    this.id,
    required this.businessId,
    _iq2eew5f.CustomerStatus? status,
    required this.name,
    this.companyName,
    this.vatId,
    this.email,
    this.phone,
    this.address,
    this.notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : status = status ?? _iq2eew5f.CustomerStatus.active,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Customer({
    int? id,
    required int businessId,
    _iq2eew5f.CustomerStatus? status,
    required String name,
    String? companyName,
    String? vatId,
    String? email,
    String? phone,
    _iz28txwx.Address? address,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CustomerImpl;

  factory Customer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Customer(
      id: jsonSerialization['id'] as int?,
      businessId: jsonSerialization['businessId'] as int,
      status: jsonSerialization['status'] == null
          ? null
          : _iq2eew5f.CustomerStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      name: jsonSerialization['name'] as String,
      companyName: jsonSerialization['companyName'] as String?,
      vatId: jsonSerialization['vatId'] as String?,
      email: jsonSerialization['email'] as String?,
      phone: jsonSerialization['phone'] as String?,
      address: jsonSerialization['address'] == null
          ? null
          : _itzp2rm6.Protocol().deserialize<_iz28txwx.Address>(
              jsonSerialization['address'],
            ),
      notes: jsonSerialization['notes'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = CustomerTable();

  static const db = CustomerRepository._();

  @override
  int? id;

  int businessId;

  _iq2eew5f.CustomerStatus status;

  String name;

  String? companyName;

  String? vatId;

  String? email;

  String? phone;

  _iz28txwx.Address? address;

  String? notes;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Customer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Customer copyWith({
    int? id,
    int? businessId,
    _iq2eew5f.CustomerStatus? status,
    String? name,
    String? companyName,
    String? vatId,
    String? email,
    String? phone,
    _iz28txwx.Address? address,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Customer',
      if (id != null) 'id': id,
      'businessId': businessId,
      'status': status.toJson(),
      'name': name,
      if (companyName != null) 'companyName': companyName,
      if (vatId != null) 'vatId': vatId,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address?.toJson(),
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Customer',
      if (id != null) 'id': id,
      'businessId': businessId,
      'status': status.toJson(),
      'name': name,
      if (companyName != null) 'companyName': companyName,
      if (vatId != null) 'vatId': vatId,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address?.toJsonForProtocol(),
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static CustomerInclude include() {
    return CustomerInclude._();
  }

  static CustomerIncludeList includeList({
    _is.WhereExpressionBuilder<CustomerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CustomerTable>? orderBy,
    _is.OrderByListBuilder<CustomerTable>? orderByList,
    CustomerInclude? include,
  }) {
    return CustomerIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Customer.t),
      orderByList: orderByList?.call(Customer.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomerImpl extends Customer {
  _CustomerImpl({
    int? id,
    required int businessId,
    _iq2eew5f.CustomerStatus? status,
    required String name,
    String? companyName,
    String? vatId,
    String? email,
    String? phone,
    _iz28txwx.Address? address,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         businessId: businessId,
         status: status,
         name: name,
         companyName: companyName,
         vatId: vatId,
         email: email,
         phone: phone,
         address: address,
         notes: notes,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Customer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Customer copyWith({
    Object? id = _Undefined,
    int? businessId,
    _iq2eew5f.CustomerStatus? status,
    String? name,
    Object? companyName = _Undefined,
    Object? vatId = _Undefined,
    Object? email = _Undefined,
    Object? phone = _Undefined,
    Object? address = _Undefined,
    Object? notes = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Customer(
      id: id is int? ? id : this.id,
      businessId: businessId ?? this.businessId,
      status: status ?? this.status,
      name: name ?? this.name,
      companyName: companyName is String? ? companyName : this.companyName,
      vatId: vatId is String? ? vatId : this.vatId,
      email: email is String? ? email : this.email,
      phone: phone is String? ? phone : this.phone,
      address: address is _iz28txwx.Address?
          ? address
          : this.address?.copyWith(),
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class CustomerUpdateTable extends _is.UpdateTable<CustomerTable> {
  CustomerUpdateTable(super.table);

  _is.ColumnValue<int, int> businessId(int value) => _is.ColumnValue(
    table.businessId,
    value,
  );

  _is.ColumnValue<_iq2eew5f.CustomerStatus, _iq2eew5f.CustomerStatus> status(
    _iq2eew5f.CustomerStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> companyName(String? value) => _is.ColumnValue(
    table.companyName,
    value,
  );

  _is.ColumnValue<String, String> vatId(String? value) => _is.ColumnValue(
    table.vatId,
    value,
  );

  _is.ColumnValue<String, String> email(String? value) => _is.ColumnValue(
    table.email,
    value,
  );

  _is.ColumnValue<String, String> phone(String? value) => _is.ColumnValue(
    table.phone,
    value,
  );

  _is.ColumnValue<_iz28txwx.Address, _iz28txwx.Address> address(
    _iz28txwx.Address? value,
  ) => _is.ColumnValue(
    table.address,
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

class CustomerTable extends _is.Table<int?> {
  CustomerTable({super.tableRelation}) : super(tableName: 'customer') {
    updateTable = CustomerUpdateTable(this);
    businessId = _is.ColumnInt(
      'businessId',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    companyName = _is.ColumnString(
      'companyName',
      this,
    );
    vatId = _is.ColumnString(
      'vatId',
      this,
    );
    email = _is.ColumnString(
      'email',
      this,
    );
    phone = _is.ColumnString(
      'phone',
      this,
    );
    address = _is.ColumnSerializable<_iz28txwx.Address>(
      'address',
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

  late final CustomerUpdateTable updateTable;

  late final _is.ColumnInt businessId;

  late final _is.ColumnEnum<_iq2eew5f.CustomerStatus> status;

  late final _is.ColumnString name;

  late final _is.ColumnString companyName;

  late final _is.ColumnString vatId;

  late final _is.ColumnString email;

  late final _is.ColumnString phone;

  late final _is.ColumnSerializable<_iz28txwx.Address> address;

  late final _is.ColumnString notes;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
    id,
    businessId,
    status,
    name,
    companyName,
    vatId,
    email,
    phone,
    address,
    notes,
    createdAt,
    updatedAt,
  ];
}

class CustomerInclude extends _is.IncludeObject {
  CustomerInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Customer.t;
}

class CustomerIncludeList extends _is.IncludeList {
  CustomerIncludeList._({
    _is.WhereExpressionBuilder<CustomerTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Customer.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Customer.t;
}

class CustomerRepository {
  const CustomerRepository._();

  /// Returns a list of [Customer]s matching the given query parameters.
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
  Future<List<Customer>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CustomerTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CustomerTable>? orderBy,
    _is.OrderByListBuilder<CustomerTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Customer>(
      where: where?.call(Customer.t),
      orderBy: orderBy?.call(Customer.t),
      orderByList: orderByList?.call(Customer.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Customer] matching the given query parameters.
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
  Future<Customer?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CustomerTable>? where,
    int? offset,
    _is.OrderByBuilder<CustomerTable>? orderBy,
    _is.OrderByListBuilder<CustomerTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Customer>(
      where: where?.call(Customer.t),
      orderBy: orderBy?.call(Customer.t),
      orderByList: orderByList?.call(Customer.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Customer] by its [id] or null if no such row exists.
  Future<Customer?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Customer>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Customer]s in the list and returns the inserted rows.
  ///
  /// The returned [Customer]s will have their `id` fields set.
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
  Future<List<Customer>> insert(
    _is.DatabaseSession session,
    List<Customer> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Customer>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Customer] and returns the inserted row.
  ///
  /// The returned [Customer] will have its `id` field set.
  Future<Customer> insertRow(
    _is.DatabaseSession session,
    Customer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Customer>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Customer]s in the list and returns the resulting rows.
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
  /// The returned [Customer]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Customer>> upsert(
    _is.DatabaseSession session,
    List<Customer> rows, {
    required _is.ColumnSelections<CustomerTable> conflictColumns,
    _is.ColumnSelections<CustomerTable>? updateColumns,
    _is.WhereExpressionBuilder<CustomerTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Customer>(
      rows,
      conflictColumns: conflictColumns(Customer.t),
      updateColumns: updateColumns?.call(Customer.t),
      updateWhere: updateWhere?.call(Customer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Customer] and returns the resulting row.
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
  /// The returned [Customer] will have its `id` field set.
  Future<Customer?> upsertRow(
    _is.DatabaseSession session,
    Customer row, {
    required _is.ColumnSelections<CustomerTable> conflictColumns,
    _is.ColumnSelections<CustomerTable>? updateColumns,
    _is.WhereExpressionBuilder<CustomerTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Customer>(
      row,
      conflictColumns: conflictColumns(Customer.t),
      updateColumns: updateColumns?.call(Customer.t),
      updateWhere: updateWhere?.call(Customer.t),
      transaction: transaction,
    );
  }

  /// Updates all [Customer]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Customer>> update(
    _is.DatabaseSession session,
    List<Customer> rows, {
    _is.ColumnSelections<CustomerTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Customer>(
      rows,
      columns: columns?.call(Customer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Customer]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Customer> updateRow(
    _is.DatabaseSession session,
    Customer row, {
    _is.ColumnSelections<CustomerTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Customer>(
      row,
      columns: columns?.call(Customer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Customer] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Customer?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CustomerUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Customer>(
      id,
      columnValues: columnValues(Customer.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Customer]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Customer>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CustomerUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CustomerTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CustomerTable>? orderBy,
    _is.OrderByListBuilder<CustomerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Customer>(
      columnValues: columnValues(Customer.t.updateTable),
      where: where(Customer.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Customer.t),
      orderByList: orderByList?.call(Customer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Customer]s in the list and returns the deleted rows.
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
  Future<List<Customer>> delete(
    _is.DatabaseSession session,
    List<Customer> rows, {
    _is.OrderByBuilder<CustomerTable>? orderBy,
    _is.OrderByListBuilder<CustomerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Customer>(
      rows,
      orderBy: orderBy?.call(Customer.t),
      orderByList: orderByList?.call(Customer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Customer].
  Future<Customer> deleteRow(
    _is.DatabaseSession session,
    Customer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Customer>(
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
  Future<List<Customer>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CustomerTable> where,
    _is.OrderByBuilder<CustomerTable>? orderBy,
    _is.OrderByListBuilder<CustomerTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Customer>(
      where: where(Customer.t),
      orderBy: orderBy?.call(Customer.t),
      orderByList: orderByList?.call(Customer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CustomerTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Customer>(
      where: where?.call(Customer.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Customer] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CustomerTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Customer>(
      where: where(Customer.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
