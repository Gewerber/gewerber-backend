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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'core/audit/audit_entry.dart' as _i5;
import 'core/errors/conflict_exception.dart' as _i6;
import 'core/errors/forbidden_exception.dart' as _i7;
import 'core/errors/not_found_exception.dart' as _i8;
import 'core/errors/validation_exception.dart' as _i9;
import 'modules/business/models/address.dart' as _i10;
import 'modules/business/models/business.dart' as _i11;
import 'modules/business/models/create_business_request.dart' as _i12;
import 'modules/business/models/legal_form.dart' as _i13;
import 'modules/business/models/membership.dart' as _i14;
import 'modules/business/models/membership_role.dart' as _i15;
import 'modules/business/models/update_business_request.dart' as _i16;
import 'package:gewerber_backend_server/src/generated/modules/business/models/business.dart'
    as _i17;
export 'core/audit/audit_entry.dart';
export 'core/errors/conflict_exception.dart';
export 'core/errors/forbidden_exception.dart';
export 'core/errors/not_found_exception.dart';
export 'core/errors/validation_exception.dart';
export 'modules/business/models/address.dart';
export 'modules/business/models/business.dart';
export 'modules/business/models/create_business_request.dart';
export 'modules/business/models/legal_form.dart';
export 'modules/business/models/membership.dart';
export 'modules/business/models/membership_role.dart';
export 'modules/business/models/update_business_request.dart';

class Protocol extends _i1.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'audit_entry',
      dartName: 'AuditEntry',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _i2.ColumnDefinition(
          name: 'businessId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _i2.ColumnDefinition(
          name: 'action',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'entityType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'entityId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'changes',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,String>?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'audit_entry_business_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'business',
      dartName: 'Business',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'legalForm',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:LegalForm',
          columnDefault: '\'einzelunternehmen\'',
        ),
        _i2.ColumnDefinition(
          name: 'isKleinunternehmer',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'vatId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'taxNumber',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'phone',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'address',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:Address?',
        ),
        _i2.ColumnDefinition(
          name: 'locale',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'de\'',
        ),
        _i2.ColumnDefinition(
          name: 'currency',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'EUR\'',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'membership',
      dartName: 'Membership',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'businessId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'role',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MembershipRole',
          columnDefault: '\'member\'',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'membership_fk_0',
          columns: ['businessId'],
          referenceTable: 'business',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'membership_user_business_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'membership_business_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i5.AuditEntry) {
      return _i5.AuditEntry.fromJson(data) as T;
    }
    if (t == _i6.ConflictException) {
      return _i6.ConflictException.fromJson(data) as T;
    }
    if (t == _i7.ForbiddenException) {
      return _i7.ForbiddenException.fromJson(data) as T;
    }
    if (t == _i8.NotFoundException) {
      return _i8.NotFoundException.fromJson(data) as T;
    }
    if (t == _i9.ValidationException) {
      return _i9.ValidationException.fromJson(data) as T;
    }
    if (t == _i10.Address) {
      return _i10.Address.fromJson(data) as T;
    }
    if (t == _i11.Business) {
      return _i11.Business.fromJson(data) as T;
    }
    if (t == _i12.CreateBusinessRequest) {
      return _i12.CreateBusinessRequest.fromJson(data) as T;
    }
    if (t == _i13.LegalForm) {
      return _i13.LegalForm.fromJson(data) as T;
    }
    if (t == _i14.Membership) {
      return _i14.Membership.fromJson(data) as T;
    }
    if (t == _i15.MembershipRole) {
      return _i15.MembershipRole.fromJson(data) as T;
    }
    if (t == _i16.UpdateBusinessRequest) {
      return _i16.UpdateBusinessRequest.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.AuditEntry?>()) {
      return (data != null ? _i5.AuditEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ConflictException?>()) {
      return (data != null ? _i6.ConflictException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.ForbiddenException?>()) {
      return (data != null ? _i7.ForbiddenException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.NotFoundException?>()) {
      return (data != null ? _i8.NotFoundException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.ValidationException?>()) {
      return (data != null ? _i9.ValidationException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.Address?>()) {
      return (data != null ? _i10.Address.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Business?>()) {
      return (data != null ? _i11.Business.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.CreateBusinessRequest?>()) {
      return (data != null ? _i12.CreateBusinessRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.LegalForm?>()) {
      return (data != null ? _i13.LegalForm.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Membership?>()) {
      return (data != null ? _i14.Membership.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.MembershipRole?>()) {
      return (data != null ? _i15.MembershipRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.UpdateBusinessRequest?>()) {
      return (data != null ? _i16.UpdateBusinessRequest.fromJson(data) : null)
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<String>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_i17.Business>) {
      return (data as List).map((e) => deserialize<_i17.Business>(e)).toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.AuditEntry => 'AuditEntry',
      _i6.ConflictException => 'ConflictException',
      _i7.ForbiddenException => 'ForbiddenException',
      _i8.NotFoundException => 'NotFoundException',
      _i9.ValidationException => 'ValidationException',
      _i10.Address => 'Address',
      _i11.Business => 'Business',
      _i12.CreateBusinessRequest => 'CreateBusinessRequest',
      _i13.LegalForm => 'LegalForm',
      _i14.Membership => 'Membership',
      _i15.MembershipRole => 'MembershipRole',
      _i16.UpdateBusinessRequest => 'UpdateBusinessRequest',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'gewerber_backend.',
        '',
      );
    }

    switch (data) {
      case _i5.AuditEntry():
        return 'AuditEntry';
      case _i6.ConflictException():
        return 'ConflictException';
      case _i7.ForbiddenException():
        return 'ForbiddenException';
      case _i8.NotFoundException():
        return 'NotFoundException';
      case _i9.ValidationException():
        return 'ValidationException';
      case _i10.Address():
        return 'Address';
      case _i11.Business():
        return 'Business';
      case _i12.CreateBusinessRequest():
        return 'CreateBusinessRequest';
      case _i13.LegalForm():
        return 'LegalForm';
      case _i14.Membership():
        return 'Membership';
      case _i15.MembershipRole():
        return 'MembershipRole';
      case _i16.UpdateBusinessRequest():
        return 'UpdateBusinessRequest';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AuditEntry') {
      return deserialize<_i5.AuditEntry>(data['data']);
    }
    if (dataClassName == 'ConflictException') {
      return deserialize<_i6.ConflictException>(data['data']);
    }
    if (dataClassName == 'ForbiddenException') {
      return deserialize<_i7.ForbiddenException>(data['data']);
    }
    if (dataClassName == 'NotFoundException') {
      return deserialize<_i8.NotFoundException>(data['data']);
    }
    if (dataClassName == 'ValidationException') {
      return deserialize<_i9.ValidationException>(data['data']);
    }
    if (dataClassName == 'Address') {
      return deserialize<_i10.Address>(data['data']);
    }
    if (dataClassName == 'Business') {
      return deserialize<_i11.Business>(data['data']);
    }
    if (dataClassName == 'CreateBusinessRequest') {
      return deserialize<_i12.CreateBusinessRequest>(data['data']);
    }
    if (dataClassName == 'LegalForm') {
      return deserialize<_i13.LegalForm>(data['data']);
    }
    if (dataClassName == 'Membership') {
      return deserialize<_i14.Membership>(data['data']);
    }
    if (dataClassName == 'MembershipRole') {
      return deserialize<_i15.MembershipRole>(data['data']);
    }
    if (dataClassName == 'UpdateBusinessRequest') {
      return deserialize<_i16.UpdateBusinessRequest>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i4.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _i3.Protocol().registerHostProtocol('gewerber_backend', this);
    _i4.Protocol().registerHostProtocol('gewerber_backend', this);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i5.AuditEntry:
        return _i5.AuditEntry.t;
      case _i11.Business:
        return _i11.Business.t;
      case _i14.Membership:
        return _i14.Membership.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'gewerber_backend';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
