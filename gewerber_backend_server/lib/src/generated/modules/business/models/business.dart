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
import '../../../modules/business/models/legal_form.dart' as _i2;
import '../../../modules/business/models/locale.dart' as _i3;
import '../../../modules/business/models/currency.dart' as _i4;
import '../../../modules/business/models/address.dart' as _i5;
import 'package:gewerber_backend_server/src/generated/protocol.dart' as _i6;

abstract class Business
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Business._({
    this.id,
    required this.name,
    _i2.LegalForm? legalForm,
    bool? isKleinunternehmer,
    this.vatId,
    this.taxNumber,
    this.email,
    this.phone,
    this.address,
    _i3.Locale? locale,
    _i4.Currency? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : legalForm = legalForm ?? _i2.LegalForm.einzelunternehmen,
       isKleinunternehmer = isKleinunternehmer ?? false,
       locale = locale ?? _i3.Locale.de,
       currency = currency ?? _i4.Currency.eur,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Business({
    int? id,
    required String name,
    _i2.LegalForm? legalForm,
    bool? isKleinunternehmer,
    String? vatId,
    String? taxNumber,
    String? email,
    String? phone,
    _i5.Address? address,
    _i3.Locale? locale,
    _i4.Currency? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _BusinessImpl;

  factory Business.fromJson(Map<String, dynamic> jsonSerialization) {
    return Business(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      legalForm: jsonSerialization['legalForm'] == null
          ? null
          : _i2.LegalForm.fromJson((jsonSerialization['legalForm'] as String)),
      isKleinunternehmer: jsonSerialization['isKleinunternehmer'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['isKleinunternehmer'],
            ),
      vatId: jsonSerialization['vatId'] as String?,
      taxNumber: jsonSerialization['taxNumber'] as String?,
      email: jsonSerialization['email'] as String?,
      phone: jsonSerialization['phone'] as String?,
      address: jsonSerialization['address'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.Address>(
              jsonSerialization['address'],
            ),
      locale: jsonSerialization['locale'] == null
          ? null
          : _i3.Locale.fromJson((jsonSerialization['locale'] as String)),
      currency: jsonSerialization['currency'] == null
          ? null
          : _i4.Currency.fromJson((jsonSerialization['currency'] as String)),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = BusinessTable();

  static const db = BusinessRepository._();

  @override
  int? id;

  String name;

  _i2.LegalForm legalForm;

  bool isKleinunternehmer;

  String? vatId;

  String? taxNumber;

  String? email;

  String? phone;

  _i5.Address? address;

  _i3.Locale locale;

  _i4.Currency currency;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Business]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Business copyWith({
    int? id,
    String? name,
    _i2.LegalForm? legalForm,
    bool? isKleinunternehmer,
    String? vatId,
    String? taxNumber,
    String? email,
    String? phone,
    _i5.Address? address,
    _i3.Locale? locale,
    _i4.Currency? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Business',
      if (id != null) 'id': id,
      'name': name,
      'legalForm': legalForm.toJson(),
      'isKleinunternehmer': isKleinunternehmer,
      if (vatId != null) 'vatId': vatId,
      if (taxNumber != null) 'taxNumber': taxNumber,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address?.toJson(),
      'locale': locale.toJson(),
      'currency': currency.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Business',
      if (id != null) 'id': id,
      'name': name,
      'legalForm': legalForm.toJson(),
      'isKleinunternehmer': isKleinunternehmer,
      if (vatId != null) 'vatId': vatId,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address?.toJsonForProtocol(),
      'locale': locale.toJson(),
      'currency': currency.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static BusinessInclude include() {
    return BusinessInclude._();
  }

  static BusinessIncludeList includeList({
    _i1.WhereExpressionBuilder<BusinessTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BusinessTable>? orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.OrderByListBuilder<BusinessTable>? orderByList,
    BusinessInclude? include,
  }) {
    return BusinessIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Business.t),
      orderDescending: // ignore: deprecated_member_use_from_same_package
          orderDescending,
      orderByList: orderByList?.call(Business.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BusinessImpl extends Business {
  _BusinessImpl({
    int? id,
    required String name,
    _i2.LegalForm? legalForm,
    bool? isKleinunternehmer,
    String? vatId,
    String? taxNumber,
    String? email,
    String? phone,
    _i5.Address? address,
    _i3.Locale? locale,
    _i4.Currency? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         legalForm: legalForm,
         isKleinunternehmer: isKleinunternehmer,
         vatId: vatId,
         taxNumber: taxNumber,
         email: email,
         phone: phone,
         address: address,
         locale: locale,
         currency: currency,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Business]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Business copyWith({
    Object? id = _Undefined,
    String? name,
    _i2.LegalForm? legalForm,
    bool? isKleinunternehmer,
    Object? vatId = _Undefined,
    Object? taxNumber = _Undefined,
    Object? email = _Undefined,
    Object? phone = _Undefined,
    Object? address = _Undefined,
    _i3.Locale? locale,
    _i4.Currency? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Business(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      legalForm: legalForm ?? this.legalForm,
      isKleinunternehmer: isKleinunternehmer ?? this.isKleinunternehmer,
      vatId: vatId is String? ? vatId : this.vatId,
      taxNumber: taxNumber is String? ? taxNumber : this.taxNumber,
      email: email is String? ? email : this.email,
      phone: phone is String? ? phone : this.phone,
      address: address is _i5.Address? ? address : this.address?.copyWith(),
      locale: locale ?? this.locale,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class BusinessUpdateTable extends _i1.UpdateTable<BusinessTable> {
  BusinessUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<_i2.LegalForm, _i2.LegalForm> legalForm(
    _i2.LegalForm value,
  ) => _i1.ColumnValue(
    table.legalForm,
    value,
  );

  _i1.ColumnValue<bool, bool> isKleinunternehmer(bool value) => _i1.ColumnValue(
    table.isKleinunternehmer,
    value,
  );

  _i1.ColumnValue<String, String> vatId(String? value) => _i1.ColumnValue(
    table.vatId,
    value,
  );

  _i1.ColumnValue<String, String> taxNumber(String? value) => _i1.ColumnValue(
    table.taxNumber,
    value,
  );

  _i1.ColumnValue<String, String> email(String? value) => _i1.ColumnValue(
    table.email,
    value,
  );

  _i1.ColumnValue<String, String> phone(String? value) => _i1.ColumnValue(
    table.phone,
    value,
  );

  _i1.ColumnValue<_i5.Address, _i5.Address> address(_i5.Address? value) =>
      _i1.ColumnValue(
        table.address,
        value,
      );

  _i1.ColumnValue<_i3.Locale, _i3.Locale> locale(_i3.Locale value) =>
      _i1.ColumnValue(
        table.locale,
        value,
      );

  _i1.ColumnValue<_i4.Currency, _i4.Currency> currency(_i4.Currency value) =>
      _i1.ColumnValue(
        table.currency,
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

class BusinessTable extends _i1.Table<int?> {
  BusinessTable({super.tableRelation}) : super(tableName: 'business') {
    updateTable = BusinessUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    legalForm = _i1.ColumnEnum(
      'legalForm',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    isKleinunternehmer = _i1.ColumnBool(
      'isKleinunternehmer',
      this,
      hasDefault: true,
    );
    vatId = _i1.ColumnString(
      'vatId',
      this,
    );
    taxNumber = _i1.ColumnString(
      'taxNumber',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
    );
    address = _i1.ColumnSerializable<_i5.Address>(
      'address',
      this,
    );
    locale = _i1.ColumnEnum(
      'locale',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    currency = _i1.ColumnEnum(
      'currency',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
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

  late final BusinessUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnEnum<_i2.LegalForm> legalForm;

  late final _i1.ColumnBool isKleinunternehmer;

  late final _i1.ColumnString vatId;

  late final _i1.ColumnString taxNumber;

  late final _i1.ColumnString email;

  late final _i1.ColumnString phone;

  late final _i1.ColumnSerializable<_i5.Address> address;

  late final _i1.ColumnEnum<_i3.Locale> locale;

  late final _i1.ColumnEnum<_i4.Currency> currency;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    legalForm,
    isKleinunternehmer,
    vatId,
    taxNumber,
    email,
    phone,
    address,
    locale,
    currency,
    createdAt,
    updatedAt,
  ];
}

class BusinessInclude extends _i1.IncludeObject {
  BusinessInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Business.t;
}

class BusinessIncludeList extends _i1.IncludeList {
  BusinessIncludeList._({
    _i1.WhereExpressionBuilder<BusinessTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Business.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Business.t;
}

class BusinessRepository {
  const BusinessRepository._();

  /// Returns a list of [Business]s matching the given query parameters.
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
  Future<List<Business>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BusinessTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BusinessTable>? orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.OrderByListBuilder<BusinessTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Business>(
      where: where?.call(Business.t),
      orderBy: orderBy?.call(Business.t),
      orderByList: orderByList?.call(Business.t),
      orderDescending: // ignore: deprecated_member_use
          orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Business] matching the given query parameters.
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
  Future<Business?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BusinessTable>? where,
    int? offset,
    _i1.OrderByBuilder<BusinessTable>? orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.OrderByListBuilder<BusinessTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Business>(
      where: where?.call(Business.t),
      orderBy: orderBy?.call(Business.t),
      orderByList: orderByList?.call(Business.t),
      orderDescending: // ignore: deprecated_member_use
          orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Business] by its [id] or null if no such row exists.
  Future<Business?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Business>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Business]s in the list and returns the inserted rows.
  ///
  /// The returned [Business]s will have their `id` fields set.
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
  Future<List<Business>> insert(
    _i1.DatabaseSession session,
    List<Business> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Business>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Business] and returns the inserted row.
  ///
  /// The returned [Business] will have its `id` field set.
  Future<Business> insertRow(
    _i1.DatabaseSession session,
    Business row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Business>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Business]s in the list and returns the resulting rows.
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
  /// The returned [Business]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Business>> upsert(
    _i1.DatabaseSession session,
    List<Business> rows, {
    required _i1.ColumnSelections<BusinessTable> conflictColumns,
    _i1.ColumnSelections<BusinessTable>? updateColumns,
    _i1.WhereExpressionBuilder<BusinessTable>? updateWhere,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Business>(
      rows,
      conflictColumns: conflictColumns(Business.t),
      updateColumns: updateColumns?.call(Business.t),
      updateWhere: updateWhere?.call(Business.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Business] and returns the resulting row.
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
  /// The returned [Business] will have its `id` field set.
  Future<Business?> upsertRow(
    _i1.DatabaseSession session,
    Business row, {
    required _i1.ColumnSelections<BusinessTable> conflictColumns,
    _i1.ColumnSelections<BusinessTable>? updateColumns,
    _i1.WhereExpressionBuilder<BusinessTable>? updateWhere,
    _i1.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Business>(
      row,
      conflictColumns: conflictColumns(Business.t),
      updateColumns: updateColumns?.call(Business.t),
      updateWhere: updateWhere?.call(Business.t),
      transaction: transaction,
    );
  }

  /// Updates all [Business]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Business>> update(
    _i1.DatabaseSession session,
    List<Business> rows, {
    _i1.ColumnSelections<BusinessTable>? columns,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Business>(
      rows,
      columns: columns?.call(Business.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Business]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Business> updateRow(
    _i1.DatabaseSession session,
    Business row, {
    _i1.ColumnSelections<BusinessTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Business>(
      row,
      columns: columns?.call(Business.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Business] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Business?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<BusinessUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Business>(
      id,
      columnValues: columnValues(Business.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Business]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Business>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<BusinessUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<BusinessTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BusinessTable>? orderBy,
    _i1.OrderByListBuilder<BusinessTable>? orderByList,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Business>(
      columnValues: columnValues(Business.t.updateTable),
      where: where(Business.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Business.t),
      orderByList: orderByList?.call(Business.t),
      orderDescending: // ignore: deprecated_member_use
          orderDescending,
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Business]s in the list and returns the deleted rows.
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
  Future<List<Business>> delete(
    _i1.DatabaseSession session,
    List<Business> rows, {
    _i1.OrderByBuilder<BusinessTable>? orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.OrderByListBuilder<BusinessTable>? orderByList,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Business>(
      rows,
      orderBy: orderBy?.call(Business.t),
      orderByList: orderByList?.call(Business.t),
      orderDescending: // ignore: deprecated_member_use
          orderDescending,
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Business].
  Future<Business> deleteRow(
    _i1.DatabaseSession session,
    Business row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Business>(
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
  Future<List<Business>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BusinessTable> where,
    _i1.OrderByBuilder<BusinessTable>? orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.OrderByListBuilder<BusinessTable>? orderByList,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Business>(
      where: where(Business.t),
      orderBy: orderBy?.call(Business.t),
      orderByList: orderByList?.call(Business.t),
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
    _i1.WhereExpressionBuilder<BusinessTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Business>(
      where: where?.call(Business.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Business] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BusinessTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Business>(
      where: where(Business.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
