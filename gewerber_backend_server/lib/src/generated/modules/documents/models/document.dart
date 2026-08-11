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
import '../../../modules/documents/models/document_kind.dart' as _i2;
import '../../../modules/documents/models/storage_location.dart' as _i3;

abstract class Document
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Document._({
    this.id,
    required this.businessId,
    _i2.DocumentKind? kind,
    required this.fileName,
    this.mimeType,
    this.sizeBytes,
    _i3.StorageLocation? storageLocation,
    required this.storagePath,
    this.relatedEntityType,
    this.relatedEntityId,
    this.uploadedById,
    DateTime? createdAt,
  }) : kind = kind ?? _i2.DocumentKind.attachment,
       storageLocation = storageLocation ?? _i3.StorageLocation.private,
       createdAt = createdAt ?? DateTime.now();

  factory Document({
    int? id,
    required int businessId,
    _i2.DocumentKind? kind,
    required String fileName,
    String? mimeType,
    int? sizeBytes,
    _i3.StorageLocation? storageLocation,
    required String storagePath,
    String? relatedEntityType,
    String? relatedEntityId,
    _i1.UuidValue? uploadedById,
    DateTime? createdAt,
  }) = _DocumentImpl;

  factory Document.fromJson(Map<String, dynamic> jsonSerialization) {
    return Document(
      id: jsonSerialization['id'] as int?,
      businessId: jsonSerialization['businessId'] as int,
      kind: jsonSerialization['kind'] == null
          ? null
          : _i2.DocumentKind.fromJson((jsonSerialization['kind'] as String)),
      fileName: jsonSerialization['fileName'] as String,
      mimeType: jsonSerialization['mimeType'] as String?,
      sizeBytes: jsonSerialization['sizeBytes'] as int?,
      storageLocation: jsonSerialization['storageLocation'] == null
          ? null
          : _i3.StorageLocation.fromJson(
              (jsonSerialization['storageLocation'] as String),
            ),
      storagePath: jsonSerialization['storagePath'] as String,
      relatedEntityType: jsonSerialization['relatedEntityType'] as String?,
      relatedEntityId: jsonSerialization['relatedEntityId'] as String?,
      uploadedById: jsonSerialization['uploadedById'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['uploadedById'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = DocumentTable();

  static const db = DocumentRepository._();

  @override
  int? id;

  int businessId;

  _i2.DocumentKind kind;

  String fileName;

  String? mimeType;

  int? sizeBytes;

  _i3.StorageLocation storageLocation;

  String storagePath;

  String? relatedEntityType;

  String? relatedEntityId;

  _i1.UuidValue? uploadedById;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Document]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Document copyWith({
    int? id,
    int? businessId,
    _i2.DocumentKind? kind,
    String? fileName,
    String? mimeType,
    int? sizeBytes,
    _i3.StorageLocation? storageLocation,
    String? storagePath,
    String? relatedEntityType,
    String? relatedEntityId,
    _i1.UuidValue? uploadedById,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Document',
      if (id != null) 'id': id,
      'businessId': businessId,
      'kind': kind.toJson(),
      'fileName': fileName,
      if (mimeType != null) 'mimeType': mimeType,
      if (sizeBytes != null) 'sizeBytes': sizeBytes,
      'storageLocation': storageLocation.toJson(),
      'storagePath': storagePath,
      if (relatedEntityType != null) 'relatedEntityType': relatedEntityType,
      if (relatedEntityId != null) 'relatedEntityId': relatedEntityId,
      if (uploadedById != null) 'uploadedById': uploadedById?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Document',
      if (id != null) 'id': id,
      'businessId': businessId,
      'kind': kind.toJson(),
      'fileName': fileName,
      if (mimeType != null) 'mimeType': mimeType,
      if (sizeBytes != null) 'sizeBytes': sizeBytes,
      'storageLocation': storageLocation.toJson(),
      'storagePath': storagePath,
      if (relatedEntityType != null) 'relatedEntityType': relatedEntityType,
      if (relatedEntityId != null) 'relatedEntityId': relatedEntityId,
      if (uploadedById != null) 'uploadedById': uploadedById?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static DocumentInclude include() {
    return DocumentInclude._();
  }

  static DocumentIncludeList includeList({
    _i1.WhereExpressionBuilder<DocumentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DocumentTable>? orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocumentTable>? orderByList,
    DocumentInclude? include,
  }) {
    return DocumentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Document.t),
      orderDescending: // ignore: deprecated_member_use_from_same_package
          orderDescending,
      orderByList: orderByList?.call(Document.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DocumentImpl extends Document {
  _DocumentImpl({
    int? id,
    required int businessId,
    _i2.DocumentKind? kind,
    required String fileName,
    String? mimeType,
    int? sizeBytes,
    _i3.StorageLocation? storageLocation,
    required String storagePath,
    String? relatedEntityType,
    String? relatedEntityId,
    _i1.UuidValue? uploadedById,
    DateTime? createdAt,
  }) : super._(
         id: id,
         businessId: businessId,
         kind: kind,
         fileName: fileName,
         mimeType: mimeType,
         sizeBytes: sizeBytes,
         storageLocation: storageLocation,
         storagePath: storagePath,
         relatedEntityType: relatedEntityType,
         relatedEntityId: relatedEntityId,
         uploadedById: uploadedById,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Document]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Document copyWith({
    Object? id = _Undefined,
    int? businessId,
    _i2.DocumentKind? kind,
    String? fileName,
    Object? mimeType = _Undefined,
    Object? sizeBytes = _Undefined,
    _i3.StorageLocation? storageLocation,
    String? storagePath,
    Object? relatedEntityType = _Undefined,
    Object? relatedEntityId = _Undefined,
    Object? uploadedById = _Undefined,
    DateTime? createdAt,
  }) {
    return Document(
      id: id is int? ? id : this.id,
      businessId: businessId ?? this.businessId,
      kind: kind ?? this.kind,
      fileName: fileName ?? this.fileName,
      mimeType: mimeType is String? ? mimeType : this.mimeType,
      sizeBytes: sizeBytes is int? ? sizeBytes : this.sizeBytes,
      storageLocation: storageLocation ?? this.storageLocation,
      storagePath: storagePath ?? this.storagePath,
      relatedEntityType: relatedEntityType is String?
          ? relatedEntityType
          : this.relatedEntityType,
      relatedEntityId: relatedEntityId is String?
          ? relatedEntityId
          : this.relatedEntityId,
      uploadedById: uploadedById is _i1.UuidValue?
          ? uploadedById
          : this.uploadedById,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class DocumentUpdateTable extends _i1.UpdateTable<DocumentTable> {
  DocumentUpdateTable(super.table);

  _i1.ColumnValue<int, int> businessId(int value) => _i1.ColumnValue(
    table.businessId,
    value,
  );

  _i1.ColumnValue<_i2.DocumentKind, _i2.DocumentKind> kind(
    _i2.DocumentKind value,
  ) => _i1.ColumnValue(
    table.kind,
    value,
  );

  _i1.ColumnValue<String, String> fileName(String value) => _i1.ColumnValue(
    table.fileName,
    value,
  );

  _i1.ColumnValue<String, String> mimeType(String? value) => _i1.ColumnValue(
    table.mimeType,
    value,
  );

  _i1.ColumnValue<int, int> sizeBytes(int? value) => _i1.ColumnValue(
    table.sizeBytes,
    value,
  );

  _i1.ColumnValue<_i3.StorageLocation, _i3.StorageLocation> storageLocation(
    _i3.StorageLocation value,
  ) => _i1.ColumnValue(
    table.storageLocation,
    value,
  );

  _i1.ColumnValue<String, String> storagePath(String value) => _i1.ColumnValue(
    table.storagePath,
    value,
  );

  _i1.ColumnValue<String, String> relatedEntityType(String? value) =>
      _i1.ColumnValue(
        table.relatedEntityType,
        value,
      );

  _i1.ColumnValue<String, String> relatedEntityId(String? value) =>
      _i1.ColumnValue(
        table.relatedEntityId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> uploadedById(
    _i1.UuidValue? value,
  ) => _i1.ColumnValue(
    table.uploadedById,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class DocumentTable extends _i1.Table<int?> {
  DocumentTable({super.tableRelation}) : super(tableName: 'document') {
    updateTable = DocumentUpdateTable(this);
    businessId = _i1.ColumnInt(
      'businessId',
      this,
    );
    kind = _i1.ColumnEnum(
      'kind',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    fileName = _i1.ColumnString(
      'fileName',
      this,
    );
    mimeType = _i1.ColumnString(
      'mimeType',
      this,
    );
    sizeBytes = _i1.ColumnInt(
      'sizeBytes',
      this,
    );
    storageLocation = _i1.ColumnEnum(
      'storageLocation',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    storagePath = _i1.ColumnString(
      'storagePath',
      this,
    );
    relatedEntityType = _i1.ColumnString(
      'relatedEntityType',
      this,
    );
    relatedEntityId = _i1.ColumnString(
      'relatedEntityId',
      this,
    );
    uploadedById = _i1.ColumnUuid(
      'uploadedById',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final DocumentUpdateTable updateTable;

  late final _i1.ColumnInt businessId;

  late final _i1.ColumnEnum<_i2.DocumentKind> kind;

  late final _i1.ColumnString fileName;

  late final _i1.ColumnString mimeType;

  late final _i1.ColumnInt sizeBytes;

  late final _i1.ColumnEnum<_i3.StorageLocation> storageLocation;

  late final _i1.ColumnString storagePath;

  late final _i1.ColumnString relatedEntityType;

  late final _i1.ColumnString relatedEntityId;

  late final _i1.ColumnUuid uploadedById;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    businessId,
    kind,
    fileName,
    mimeType,
    sizeBytes,
    storageLocation,
    storagePath,
    relatedEntityType,
    relatedEntityId,
    uploadedById,
    createdAt,
  ];
}

class DocumentInclude extends _i1.IncludeObject {
  DocumentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Document.t;
}

class DocumentIncludeList extends _i1.IncludeList {
  DocumentIncludeList._({
    _i1.WhereExpressionBuilder<DocumentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Document.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Document.t;
}

class DocumentRepository {
  const DocumentRepository._();

  /// Returns a list of [Document]s matching the given query parameters.
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
  Future<List<Document>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DocumentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DocumentTable>? orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocumentTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Document>(
      where: where?.call(Document.t),
      orderBy: orderBy?.call(Document.t),
      orderByList: orderByList?.call(Document.t),
      orderDescending: // ignore: deprecated_member_use
          orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Document] matching the given query parameters.
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
  Future<Document?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DocumentTable>? where,
    int? offset,
    _i1.OrderByBuilder<DocumentTable>? orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocumentTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Document>(
      where: where?.call(Document.t),
      orderBy: orderBy?.call(Document.t),
      orderByList: orderByList?.call(Document.t),
      orderDescending: // ignore: deprecated_member_use
          orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Document] by its [id] or null if no such row exists.
  Future<Document?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Document>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Document]s in the list and returns the inserted rows.
  ///
  /// The returned [Document]s will have their `id` fields set.
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
  Future<List<Document>> insert(
    _i1.DatabaseSession session,
    List<Document> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Document>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Document] and returns the inserted row.
  ///
  /// The returned [Document] will have its `id` field set.
  Future<Document> insertRow(
    _i1.DatabaseSession session,
    Document row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Document>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Document]s in the list and returns the resulting rows.
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
  /// The returned [Document]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Document>> upsert(
    _i1.DatabaseSession session,
    List<Document> rows, {
    required _i1.ColumnSelections<DocumentTable> conflictColumns,
    _i1.ColumnSelections<DocumentTable>? updateColumns,
    _i1.WhereExpressionBuilder<DocumentTable>? updateWhere,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Document>(
      rows,
      conflictColumns: conflictColumns(Document.t),
      updateColumns: updateColumns?.call(Document.t),
      updateWhere: updateWhere?.call(Document.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Document] and returns the resulting row.
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
  /// The returned [Document] will have its `id` field set.
  Future<Document?> upsertRow(
    _i1.DatabaseSession session,
    Document row, {
    required _i1.ColumnSelections<DocumentTable> conflictColumns,
    _i1.ColumnSelections<DocumentTable>? updateColumns,
    _i1.WhereExpressionBuilder<DocumentTable>? updateWhere,
    _i1.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Document>(
      row,
      conflictColumns: conflictColumns(Document.t),
      updateColumns: updateColumns?.call(Document.t),
      updateWhere: updateWhere?.call(Document.t),
      transaction: transaction,
    );
  }

  /// Updates all [Document]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Document>> update(
    _i1.DatabaseSession session,
    List<Document> rows, {
    _i1.ColumnSelections<DocumentTable>? columns,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Document>(
      rows,
      columns: columns?.call(Document.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Document]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Document> updateRow(
    _i1.DatabaseSession session,
    Document row, {
    _i1.ColumnSelections<DocumentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Document>(
      row,
      columns: columns?.call(Document.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Document] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Document?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<DocumentUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Document>(
      id,
      columnValues: columnValues(Document.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Document]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Document>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DocumentUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DocumentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DocumentTable>? orderBy,
    _i1.OrderByListBuilder<DocumentTable>? orderByList,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Document>(
      columnValues: columnValues(Document.t.updateTable),
      where: where(Document.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Document.t),
      orderByList: orderByList?.call(Document.t),
      orderDescending: // ignore: deprecated_member_use
          orderDescending,
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Document]s in the list and returns the deleted rows.
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
  Future<List<Document>> delete(
    _i1.DatabaseSession session,
    List<Document> rows, {
    _i1.OrderByBuilder<DocumentTable>? orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocumentTable>? orderByList,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Document>(
      rows,
      orderBy: orderBy?.call(Document.t),
      orderByList: orderByList?.call(Document.t),
      orderDescending: // ignore: deprecated_member_use
          orderDescending,
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Document].
  Future<Document> deleteRow(
    _i1.DatabaseSession session,
    Document row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Document>(
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
  Future<List<Document>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DocumentTable> where,
    _i1.OrderByBuilder<DocumentTable>? orderBy,
    @Deprecated('Use desc() on the orderBy column instead.')
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocumentTable>? orderByList,
    _i1.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Document>(
      where: where(Document.t),
      orderBy: orderBy?.call(Document.t),
      orderByList: orderByList?.call(Document.t),
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
    _i1.WhereExpressionBuilder<DocumentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Document>(
      where: where?.call(Document.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Document] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DocumentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Document>(
      where: where(Document.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
