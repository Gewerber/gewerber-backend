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
import 'core/entitlement/feature.dart' as _i6;
import 'core/errors/conflict_exception.dart' as _i7;
import 'core/errors/forbidden_exception.dart' as _i8;
import 'core/errors/not_found_exception.dart' as _i9;
import 'core/errors/validation_exception.dart' as _i10;
import 'core/sequence/sequence.dart' as _i11;
import 'modules/business/models/address.dart' as _i12;
import 'modules/business/models/business.dart' as _i13;
import 'modules/business/models/business_settings.dart' as _i14;
import 'modules/business/models/country.dart' as _i15;
import 'modules/business/models/create_business_request.dart' as _i16;
import 'modules/business/models/currency.dart' as _i17;
import 'modules/business/models/legal_form.dart' as _i18;
import 'modules/business/models/locale.dart' as _i19;
import 'modules/business/models/membership.dart' as _i20;
import 'modules/business/models/membership_role.dart' as _i21;
import 'modules/business/models/rounding_mode.dart' as _i22;
import 'modules/business/models/update_business_request.dart' as _i23;
import 'modules/business/models/update_business_settings_request.dart' as _i24;
import 'modules/documents/models/document.dart' as _i25;
import 'modules/documents/models/document_kind.dart' as _i26;
import 'modules/documents/models/storage_location.dart' as _i27;
import 'modules/documents/models/upload_document_request.dart' as _i28;
import 'modules/invoicing/models/create_customer_request.dart' as _i29;
import 'modules/invoicing/models/create_invoice_request.dart' as _i30;
import 'modules/invoicing/models/create_invoice_template_request.dart' as _i31;
import 'modules/invoicing/models/customer.dart' as _i32;
import 'modules/invoicing/models/customer_status.dart' as _i33;
import 'modules/invoicing/models/invoice.dart' as _i34;
import 'modules/invoicing/models/invoice_item.dart' as _i35;
import 'modules/invoicing/models/invoice_item_request.dart' as _i36;
import 'modules/invoicing/models/invoice_item_unit.dart' as _i37;
import 'modules/invoicing/models/invoice_status.dart' as _i38;
import 'modules/invoicing/models/invoice_template.dart' as _i39;
import 'modules/invoicing/models/invoice_type.dart' as _i40;
import 'modules/invoicing/models/payment_method.dart' as _i41;
import 'modules/invoicing/models/payment_record.dart' as _i42;
import 'modules/invoicing/models/record_payment_request.dart' as _i43;
import 'modules/invoicing/models/recurrence_interval.dart' as _i44;
import 'modules/invoicing/models/recurrence_rule.dart' as _i45;
import 'modules/invoicing/models/reminder.dart' as _i46;
import 'modules/invoicing/models/update_customer_request.dart' as _i47;
import 'modules/invoicing/models/update_invoice_request.dart' as _i48;
import 'modules/invoicing/models/update_invoice_template_request.dart' as _i49;
import 'modules/invoicing/models/vat_rate.dart' as _i50;
import 'modules/user/models/update_user_profile_request.dart' as _i51;
import 'modules/user/models/user_profile.dart' as _i52;
import 'package:gewerber_backend_server/src/generated/core/entitlement/feature.dart'
    as _i53;
import 'package:gewerber_backend_server/src/generated/modules/business/models/business.dart'
    as _i54;
import 'package:gewerber_backend_server/src/generated/modules/documents/models/document.dart'
    as _i55;
export 'core/audit/audit_entry.dart';
export 'core/entitlement/feature.dart';
export 'core/errors/conflict_exception.dart';
export 'core/errors/forbidden_exception.dart';
export 'core/errors/not_found_exception.dart';
export 'core/errors/validation_exception.dart';
export 'core/sequence/sequence.dart';
export 'modules/business/models/address.dart';
export 'modules/business/models/business.dart';
export 'modules/business/models/business_settings.dart';
export 'modules/business/models/country.dart';
export 'modules/business/models/create_business_request.dart';
export 'modules/business/models/currency.dart';
export 'modules/business/models/legal_form.dart';
export 'modules/business/models/locale.dart';
export 'modules/business/models/membership.dart';
export 'modules/business/models/membership_role.dart';
export 'modules/business/models/rounding_mode.dart';
export 'modules/business/models/update_business_request.dart';
export 'modules/business/models/update_business_settings_request.dart';
export 'modules/documents/models/document.dart';
export 'modules/documents/models/document_kind.dart';
export 'modules/documents/models/storage_location.dart';
export 'modules/documents/models/upload_document_request.dart';
export 'modules/invoicing/models/create_customer_request.dart';
export 'modules/invoicing/models/create_invoice_request.dart';
export 'modules/invoicing/models/create_invoice_template_request.dart';
export 'modules/invoicing/models/customer.dart';
export 'modules/invoicing/models/customer_status.dart';
export 'modules/invoicing/models/invoice.dart';
export 'modules/invoicing/models/invoice_item.dart';
export 'modules/invoicing/models/invoice_item_request.dart';
export 'modules/invoicing/models/invoice_item_unit.dart';
export 'modules/invoicing/models/invoice_status.dart';
export 'modules/invoicing/models/invoice_template.dart';
export 'modules/invoicing/models/invoice_type.dart';
export 'modules/invoicing/models/payment_method.dart';
export 'modules/invoicing/models/payment_record.dart';
export 'modules/invoicing/models/record_payment_request.dart';
export 'modules/invoicing/models/recurrence_interval.dart';
export 'modules/invoicing/models/recurrence_rule.dart';
export 'modules/invoicing/models/reminder.dart';
export 'modules/invoicing/models/update_customer_request.dart';
export 'modules/invoicing/models/update_invoice_request.dart';
export 'modules/invoicing/models/update_invoice_template_request.dart';
export 'modules/invoicing/models/vat_rate.dart';
export 'modules/user/models/update_user_profile_request.dart';
export 'modules/user/models/user_profile.dart';

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
          dartType: 'protocol:Locale',
          columnDefault: '\'de\'',
        ),
        _i2.ColumnDefinition(
          name: 'currency',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Currency',
          columnDefault: '\'eur\'',
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
      name: 'business_settings',
      dartName: 'BusinessSettings',
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
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'paymentTermsDays',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '14',
        ),
        _i2.ColumnDefinition(
          name: 'invoiceNumberPrefix',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'invoiceNumberIncludeYear',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'invoiceNumberMinDigits',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '4',
        ),
        _i2.ColumnDefinition(
          name: 'roundingMode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RoundingMode',
          columnDefault: '\'none\'',
        ),
        _i2.ColumnDefinition(
          name: 'roundingGranularityMinutes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'business_settings_fk_0',
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
          indexName: 'business_settings_business_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'customer',
      dartName: 'Customer',
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
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:CustomerStatus',
          columnDefault: '\'active\'',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'companyName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'vatId',
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
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
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
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'customer_fk_0',
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
          indexName: 'customer_business_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
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
      name: 'document',
      dartName: 'Document',
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
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'kind',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DocumentKind',
          columnDefault: '\'attachment\'',
        ),
        _i2.ColumnDefinition(
          name: 'fileName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'mimeType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'sizeBytes',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'storageLocation',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:StorageLocation',
          columnDefault: '\'private\'',
        ),
        _i2.ColumnDefinition(
          name: 'storagePath',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'relatedEntityType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'relatedEntityId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'uploadedById',
          columnType: _i2.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
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
          constraintName: 'document_fk_0',
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
          indexName: 'document_business_idx',
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
      name: 'invoice',
      dartName: 'Invoice',
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
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'number',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:InvoiceType',
          columnDefault: '\'invoice\'',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:InvoiceStatus',
          columnDefault: '\'draft\'',
        ),
        _i2.ColumnDefinition(
          name: 'customerId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'issueDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'dueDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'serviceDateFrom',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'serviceDateTo',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'locale',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Locale',
          columnDefault: '\'de\'',
        ),
        _i2.ColumnDefinition(
          name: 'currency',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Currency',
          columnDefault: '\'eur\'',
        ),
        _i2.ColumnDefinition(
          name: 'subtotalCents',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'vatTotalCents',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'totalCents',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'paymentTermsDays',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '14',
        ),
        _i2.ColumnDefinition(
          name: 'dunningLevel',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'templateId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'pdfDocumentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'recurrence',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:RecurrenceRule?',
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
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'invoice_fk_0',
          columns: ['businessId'],
          referenceTable: 'business',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'invoice_fk_1',
          columns: ['customerId'],
          referenceTable: 'customer',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.setNull,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'invoice_fk_2',
          columns: ['templateId'],
          referenceTable: 'invoice_template',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.setNull,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'invoice_fk_3',
          columns: ['pdfDocumentId'],
          referenceTable: 'document',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'invoice_business_number_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'number',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'invoice_business_issue_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'issueDate',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'invoice_customer_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'customerId',
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
      name: 'invoice_item',
      dartName: 'InvoiceItem',
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
          name: 'invoiceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'position',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'quantity',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '1',
        ),
        _i2.ColumnDefinition(
          name: 'unit',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:InvoiceItemUnit',
          columnDefault: '\'hour\'',
        ),
        _i2.ColumnDefinition(
          name: 'unitPriceCents',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'vatRate',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:VatRate',
          columnDefault: '\'standard\'',
        ),
        _i2.ColumnDefinition(
          name: 'lineTotalCents',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'invoice_item_fk_0',
          columns: ['invoiceId'],
          referenceTable: 'invoice',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'invoice_item_invoice_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'invoiceId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'position',
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
      name: 'invoice_template',
      dartName: 'InvoiceTemplate',
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
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isDefault',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'headerText',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'footerText',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'logoDocumentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
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
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'invoice_template_fk_0',
          columns: ['businessId'],
          referenceTable: 'business',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'invoice_template_fk_1',
          columns: ['logoDocumentId'],
          referenceTable: 'document',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'invoice_template_business_idx',
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
    _i2.TableDefinition(
      name: 'number_sequence',
      dartName: 'Sequence',
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
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'key',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'year',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'lastValue',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'number_sequence_fk_0',
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
          indexName: 'number_sequence_business_key_year_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'key',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'year',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'payment_record',
      dartName: 'PaymentRecord',
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
          name: 'invoiceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'paidAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _i2.ColumnDefinition(
          name: 'amountCents',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'method',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:PaymentMethod',
          columnDefault: '\'bankTransfer\'',
        ),
        _i2.ColumnDefinition(
          name: 'reference',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
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
          constraintName: 'payment_record_fk_0',
          columns: ['invoiceId'],
          referenceTable: 'invoice',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'payment_record_invoice_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'invoiceId',
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
      name: 'reminder',
      dartName: 'Reminder',
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
          name: 'invoiceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'sentAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'reminder_fk_0',
          columns: ['invoiceId'],
          referenceTable: 'invoice',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'reminder_invoice_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'invoiceId',
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
      name: 'user_profile',
      dartName: 'UserProfile',
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
          name: 'displayName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'locale',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Locale',
          columnDefault: '\'de\'',
        ),
        _i2.ColumnDefinition(
          name: 'timeZone',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
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
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_profile_user_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
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
    if (t == _i6.Feature) {
      return _i6.Feature.fromJson(data) as T;
    }
    if (t == _i7.ConflictException) {
      return _i7.ConflictException.fromJson(data) as T;
    }
    if (t == _i8.ForbiddenException) {
      return _i8.ForbiddenException.fromJson(data) as T;
    }
    if (t == _i9.NotFoundException) {
      return _i9.NotFoundException.fromJson(data) as T;
    }
    if (t == _i10.ValidationException) {
      return _i10.ValidationException.fromJson(data) as T;
    }
    if (t == _i11.Sequence) {
      return _i11.Sequence.fromJson(data) as T;
    }
    if (t == _i12.Address) {
      return _i12.Address.fromJson(data) as T;
    }
    if (t == _i13.Business) {
      return _i13.Business.fromJson(data) as T;
    }
    if (t == _i14.BusinessSettings) {
      return _i14.BusinessSettings.fromJson(data) as T;
    }
    if (t == _i15.Country) {
      return _i15.Country.fromJson(data) as T;
    }
    if (t == _i16.CreateBusinessRequest) {
      return _i16.CreateBusinessRequest.fromJson(data) as T;
    }
    if (t == _i17.Currency) {
      return _i17.Currency.fromJson(data) as T;
    }
    if (t == _i18.LegalForm) {
      return _i18.LegalForm.fromJson(data) as T;
    }
    if (t == _i19.Locale) {
      return _i19.Locale.fromJson(data) as T;
    }
    if (t == _i20.Membership) {
      return _i20.Membership.fromJson(data) as T;
    }
    if (t == _i21.MembershipRole) {
      return _i21.MembershipRole.fromJson(data) as T;
    }
    if (t == _i22.RoundingMode) {
      return _i22.RoundingMode.fromJson(data) as T;
    }
    if (t == _i23.UpdateBusinessRequest) {
      return _i23.UpdateBusinessRequest.fromJson(data) as T;
    }
    if (t == _i24.UpdateBusinessSettingsRequest) {
      return _i24.UpdateBusinessSettingsRequest.fromJson(data) as T;
    }
    if (t == _i25.Document) {
      return _i25.Document.fromJson(data) as T;
    }
    if (t == _i26.DocumentKind) {
      return _i26.DocumentKind.fromJson(data) as T;
    }
    if (t == _i27.StorageLocation) {
      return _i27.StorageLocation.fromJson(data) as T;
    }
    if (t == _i28.UploadDocumentRequest) {
      return _i28.UploadDocumentRequest.fromJson(data) as T;
    }
    if (t == _i29.CreateCustomerRequest) {
      return _i29.CreateCustomerRequest.fromJson(data) as T;
    }
    if (t == _i30.CreateInvoiceRequest) {
      return _i30.CreateInvoiceRequest.fromJson(data) as T;
    }
    if (t == _i31.CreateInvoiceTemplateRequest) {
      return _i31.CreateInvoiceTemplateRequest.fromJson(data) as T;
    }
    if (t == _i32.Customer) {
      return _i32.Customer.fromJson(data) as T;
    }
    if (t == _i33.CustomerStatus) {
      return _i33.CustomerStatus.fromJson(data) as T;
    }
    if (t == _i34.Invoice) {
      return _i34.Invoice.fromJson(data) as T;
    }
    if (t == _i35.InvoiceItem) {
      return _i35.InvoiceItem.fromJson(data) as T;
    }
    if (t == _i36.InvoiceItemRequest) {
      return _i36.InvoiceItemRequest.fromJson(data) as T;
    }
    if (t == _i37.InvoiceItemUnit) {
      return _i37.InvoiceItemUnit.fromJson(data) as T;
    }
    if (t == _i38.InvoiceStatus) {
      return _i38.InvoiceStatus.fromJson(data) as T;
    }
    if (t == _i39.InvoiceTemplate) {
      return _i39.InvoiceTemplate.fromJson(data) as T;
    }
    if (t == _i40.InvoiceType) {
      return _i40.InvoiceType.fromJson(data) as T;
    }
    if (t == _i41.PaymentMethod) {
      return _i41.PaymentMethod.fromJson(data) as T;
    }
    if (t == _i42.PaymentRecord) {
      return _i42.PaymentRecord.fromJson(data) as T;
    }
    if (t == _i43.RecordPaymentRequest) {
      return _i43.RecordPaymentRequest.fromJson(data) as T;
    }
    if (t == _i44.RecurrenceInterval) {
      return _i44.RecurrenceInterval.fromJson(data) as T;
    }
    if (t == _i45.RecurrenceRule) {
      return _i45.RecurrenceRule.fromJson(data) as T;
    }
    if (t == _i46.Reminder) {
      return _i46.Reminder.fromJson(data) as T;
    }
    if (t == _i47.UpdateCustomerRequest) {
      return _i47.UpdateCustomerRequest.fromJson(data) as T;
    }
    if (t == _i48.UpdateInvoiceRequest) {
      return _i48.UpdateInvoiceRequest.fromJson(data) as T;
    }
    if (t == _i49.UpdateInvoiceTemplateRequest) {
      return _i49.UpdateInvoiceTemplateRequest.fromJson(data) as T;
    }
    if (t == _i50.VatRate) {
      return _i50.VatRate.fromJson(data) as T;
    }
    if (t == _i51.UpdateUserProfileRequest) {
      return _i51.UpdateUserProfileRequest.fromJson(data) as T;
    }
    if (t == _i52.UserProfile) {
      return _i52.UserProfile.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.AuditEntry?>()) {
      return (data != null ? _i5.AuditEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Feature?>()) {
      return (data != null ? _i6.Feature.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.ConflictException?>()) {
      return (data != null ? _i7.ConflictException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.ForbiddenException?>()) {
      return (data != null ? _i8.ForbiddenException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.NotFoundException?>()) {
      return (data != null ? _i9.NotFoundException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.ValidationException?>()) {
      return (data != null ? _i10.ValidationException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.Sequence?>()) {
      return (data != null ? _i11.Sequence.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Address?>()) {
      return (data != null ? _i12.Address.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.Business?>()) {
      return (data != null ? _i13.Business.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.BusinessSettings?>()) {
      return (data != null ? _i14.BusinessSettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Country?>()) {
      return (data != null ? _i15.Country.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.CreateBusinessRequest?>()) {
      return (data != null ? _i16.CreateBusinessRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.Currency?>()) {
      return (data != null ? _i17.Currency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.LegalForm?>()) {
      return (data != null ? _i18.LegalForm.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.Locale?>()) {
      return (data != null ? _i19.Locale.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.Membership?>()) {
      return (data != null ? _i20.Membership.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.MembershipRole?>()) {
      return (data != null ? _i21.MembershipRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.RoundingMode?>()) {
      return (data != null ? _i22.RoundingMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.UpdateBusinessRequest?>()) {
      return (data != null ? _i23.UpdateBusinessRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.UpdateBusinessSettingsRequest?>()) {
      return (data != null
              ? _i24.UpdateBusinessSettingsRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i25.Document?>()) {
      return (data != null ? _i25.Document.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.DocumentKind?>()) {
      return (data != null ? _i26.DocumentKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.StorageLocation?>()) {
      return (data != null ? _i27.StorageLocation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.UploadDocumentRequest?>()) {
      return (data != null ? _i28.UploadDocumentRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i29.CreateCustomerRequest?>()) {
      return (data != null ? _i29.CreateCustomerRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i30.CreateInvoiceRequest?>()) {
      return (data != null ? _i30.CreateInvoiceRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.CreateInvoiceTemplateRequest?>()) {
      return (data != null
              ? _i31.CreateInvoiceTemplateRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i32.Customer?>()) {
      return (data != null ? _i32.Customer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.CustomerStatus?>()) {
      return (data != null ? _i33.CustomerStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.Invoice?>()) {
      return (data != null ? _i34.Invoice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.InvoiceItem?>()) {
      return (data != null ? _i35.InvoiceItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.InvoiceItemRequest?>()) {
      return (data != null ? _i36.InvoiceItemRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i37.InvoiceItemUnit?>()) {
      return (data != null ? _i37.InvoiceItemUnit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.InvoiceStatus?>()) {
      return (data != null ? _i38.InvoiceStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.InvoiceTemplate?>()) {
      return (data != null ? _i39.InvoiceTemplate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.InvoiceType?>()) {
      return (data != null ? _i40.InvoiceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.PaymentMethod?>()) {
      return (data != null ? _i41.PaymentMethod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.PaymentRecord?>()) {
      return (data != null ? _i42.PaymentRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.RecordPaymentRequest?>()) {
      return (data != null ? _i43.RecordPaymentRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i44.RecurrenceInterval?>()) {
      return (data != null ? _i44.RecurrenceInterval.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i45.RecurrenceRule?>()) {
      return (data != null ? _i45.RecurrenceRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.Reminder?>()) {
      return (data != null ? _i46.Reminder.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.UpdateCustomerRequest?>()) {
      return (data != null ? _i47.UpdateCustomerRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i48.UpdateInvoiceRequest?>()) {
      return (data != null ? _i48.UpdateInvoiceRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i49.UpdateInvoiceTemplateRequest?>()) {
      return (data != null
              ? _i49.UpdateInvoiceTemplateRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i50.VatRate?>()) {
      return (data != null ? _i50.VatRate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.UpdateUserProfileRequest?>()) {
      return (data != null
              ? _i51.UpdateUserProfileRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i52.UserProfile?>()) {
      return (data != null ? _i52.UserProfile.fromJson(data) : null) as T;
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
    if (t == List<_i36.InvoiceItemRequest>) {
      return (data as List)
              .map((e) => deserialize<_i36.InvoiceItemRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_i53.Feature>) {
      return (data as List).map((e) => deserialize<_i53.Feature>(e)).toList()
          as T;
    }
    if (t == List<_i54.Business>) {
      return (data as List).map((e) => deserialize<_i54.Business>(e)).toList()
          as T;
    }
    if (t == List<_i55.Document>) {
      return (data as List).map((e) => deserialize<_i55.Document>(e)).toList()
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
      _i6.Feature => 'Feature',
      _i7.ConflictException => 'ConflictException',
      _i8.ForbiddenException => 'ForbiddenException',
      _i9.NotFoundException => 'NotFoundException',
      _i10.ValidationException => 'ValidationException',
      _i11.Sequence => 'Sequence',
      _i12.Address => 'Address',
      _i13.Business => 'Business',
      _i14.BusinessSettings => 'BusinessSettings',
      _i15.Country => 'Country',
      _i16.CreateBusinessRequest => 'CreateBusinessRequest',
      _i17.Currency => 'Currency',
      _i18.LegalForm => 'LegalForm',
      _i19.Locale => 'Locale',
      _i20.Membership => 'Membership',
      _i21.MembershipRole => 'MembershipRole',
      _i22.RoundingMode => 'RoundingMode',
      _i23.UpdateBusinessRequest => 'UpdateBusinessRequest',
      _i24.UpdateBusinessSettingsRequest => 'UpdateBusinessSettingsRequest',
      _i25.Document => 'Document',
      _i26.DocumentKind => 'DocumentKind',
      _i27.StorageLocation => 'StorageLocation',
      _i28.UploadDocumentRequest => 'UploadDocumentRequest',
      _i29.CreateCustomerRequest => 'CreateCustomerRequest',
      _i30.CreateInvoiceRequest => 'CreateInvoiceRequest',
      _i31.CreateInvoiceTemplateRequest => 'CreateInvoiceTemplateRequest',
      _i32.Customer => 'Customer',
      _i33.CustomerStatus => 'CustomerStatus',
      _i34.Invoice => 'Invoice',
      _i35.InvoiceItem => 'InvoiceItem',
      _i36.InvoiceItemRequest => 'InvoiceItemRequest',
      _i37.InvoiceItemUnit => 'InvoiceItemUnit',
      _i38.InvoiceStatus => 'InvoiceStatus',
      _i39.InvoiceTemplate => 'InvoiceTemplate',
      _i40.InvoiceType => 'InvoiceType',
      _i41.PaymentMethod => 'PaymentMethod',
      _i42.PaymentRecord => 'PaymentRecord',
      _i43.RecordPaymentRequest => 'RecordPaymentRequest',
      _i44.RecurrenceInterval => 'RecurrenceInterval',
      _i45.RecurrenceRule => 'RecurrenceRule',
      _i46.Reminder => 'Reminder',
      _i47.UpdateCustomerRequest => 'UpdateCustomerRequest',
      _i48.UpdateInvoiceRequest => 'UpdateInvoiceRequest',
      _i49.UpdateInvoiceTemplateRequest => 'UpdateInvoiceTemplateRequest',
      _i50.VatRate => 'VatRate',
      _i51.UpdateUserProfileRequest => 'UpdateUserProfileRequest',
      _i52.UserProfile => 'UserProfile',
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
      case _i6.Feature():
        return 'Feature';
      case _i7.ConflictException():
        return 'ConflictException';
      case _i8.ForbiddenException():
        return 'ForbiddenException';
      case _i9.NotFoundException():
        return 'NotFoundException';
      case _i10.ValidationException():
        return 'ValidationException';
      case _i11.Sequence():
        return 'Sequence';
      case _i12.Address():
        return 'Address';
      case _i13.Business():
        return 'Business';
      case _i14.BusinessSettings():
        return 'BusinessSettings';
      case _i15.Country():
        return 'Country';
      case _i16.CreateBusinessRequest():
        return 'CreateBusinessRequest';
      case _i17.Currency():
        return 'Currency';
      case _i18.LegalForm():
        return 'LegalForm';
      case _i19.Locale():
        return 'Locale';
      case _i20.Membership():
        return 'Membership';
      case _i21.MembershipRole():
        return 'MembershipRole';
      case _i22.RoundingMode():
        return 'RoundingMode';
      case _i23.UpdateBusinessRequest():
        return 'UpdateBusinessRequest';
      case _i24.UpdateBusinessSettingsRequest():
        return 'UpdateBusinessSettingsRequest';
      case _i25.Document():
        return 'Document';
      case _i26.DocumentKind():
        return 'DocumentKind';
      case _i27.StorageLocation():
        return 'StorageLocation';
      case _i28.UploadDocumentRequest():
        return 'UploadDocumentRequest';
      case _i29.CreateCustomerRequest():
        return 'CreateCustomerRequest';
      case _i30.CreateInvoiceRequest():
        return 'CreateInvoiceRequest';
      case _i31.CreateInvoiceTemplateRequest():
        return 'CreateInvoiceTemplateRequest';
      case _i32.Customer():
        return 'Customer';
      case _i33.CustomerStatus():
        return 'CustomerStatus';
      case _i34.Invoice():
        return 'Invoice';
      case _i35.InvoiceItem():
        return 'InvoiceItem';
      case _i36.InvoiceItemRequest():
        return 'InvoiceItemRequest';
      case _i37.InvoiceItemUnit():
        return 'InvoiceItemUnit';
      case _i38.InvoiceStatus():
        return 'InvoiceStatus';
      case _i39.InvoiceTemplate():
        return 'InvoiceTemplate';
      case _i40.InvoiceType():
        return 'InvoiceType';
      case _i41.PaymentMethod():
        return 'PaymentMethod';
      case _i42.PaymentRecord():
        return 'PaymentRecord';
      case _i43.RecordPaymentRequest():
        return 'RecordPaymentRequest';
      case _i44.RecurrenceInterval():
        return 'RecurrenceInterval';
      case _i45.RecurrenceRule():
        return 'RecurrenceRule';
      case _i46.Reminder():
        return 'Reminder';
      case _i47.UpdateCustomerRequest():
        return 'UpdateCustomerRequest';
      case _i48.UpdateInvoiceRequest():
        return 'UpdateInvoiceRequest';
      case _i49.UpdateInvoiceTemplateRequest():
        return 'UpdateInvoiceTemplateRequest';
      case _i50.VatRate():
        return 'VatRate';
      case _i51.UpdateUserProfileRequest():
        return 'UpdateUserProfileRequest';
      case _i52.UserProfile():
        return 'UserProfile';
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
    if (dataClassName == 'Feature') {
      return deserialize<_i6.Feature>(data['data']);
    }
    if (dataClassName == 'ConflictException') {
      return deserialize<_i7.ConflictException>(data['data']);
    }
    if (dataClassName == 'ForbiddenException') {
      return deserialize<_i8.ForbiddenException>(data['data']);
    }
    if (dataClassName == 'NotFoundException') {
      return deserialize<_i9.NotFoundException>(data['data']);
    }
    if (dataClassName == 'ValidationException') {
      return deserialize<_i10.ValidationException>(data['data']);
    }
    if (dataClassName == 'Sequence') {
      return deserialize<_i11.Sequence>(data['data']);
    }
    if (dataClassName == 'Address') {
      return deserialize<_i12.Address>(data['data']);
    }
    if (dataClassName == 'Business') {
      return deserialize<_i13.Business>(data['data']);
    }
    if (dataClassName == 'BusinessSettings') {
      return deserialize<_i14.BusinessSettings>(data['data']);
    }
    if (dataClassName == 'Country') {
      return deserialize<_i15.Country>(data['data']);
    }
    if (dataClassName == 'CreateBusinessRequest') {
      return deserialize<_i16.CreateBusinessRequest>(data['data']);
    }
    if (dataClassName == 'Currency') {
      return deserialize<_i17.Currency>(data['data']);
    }
    if (dataClassName == 'LegalForm') {
      return deserialize<_i18.LegalForm>(data['data']);
    }
    if (dataClassName == 'Locale') {
      return deserialize<_i19.Locale>(data['data']);
    }
    if (dataClassName == 'Membership') {
      return deserialize<_i20.Membership>(data['data']);
    }
    if (dataClassName == 'MembershipRole') {
      return deserialize<_i21.MembershipRole>(data['data']);
    }
    if (dataClassName == 'RoundingMode') {
      return deserialize<_i22.RoundingMode>(data['data']);
    }
    if (dataClassName == 'UpdateBusinessRequest') {
      return deserialize<_i23.UpdateBusinessRequest>(data['data']);
    }
    if (dataClassName == 'UpdateBusinessSettingsRequest') {
      return deserialize<_i24.UpdateBusinessSettingsRequest>(data['data']);
    }
    if (dataClassName == 'Document') {
      return deserialize<_i25.Document>(data['data']);
    }
    if (dataClassName == 'DocumentKind') {
      return deserialize<_i26.DocumentKind>(data['data']);
    }
    if (dataClassName == 'StorageLocation') {
      return deserialize<_i27.StorageLocation>(data['data']);
    }
    if (dataClassName == 'UploadDocumentRequest') {
      return deserialize<_i28.UploadDocumentRequest>(data['data']);
    }
    if (dataClassName == 'CreateCustomerRequest') {
      return deserialize<_i29.CreateCustomerRequest>(data['data']);
    }
    if (dataClassName == 'CreateInvoiceRequest') {
      return deserialize<_i30.CreateInvoiceRequest>(data['data']);
    }
    if (dataClassName == 'CreateInvoiceTemplateRequest') {
      return deserialize<_i31.CreateInvoiceTemplateRequest>(data['data']);
    }
    if (dataClassName == 'Customer') {
      return deserialize<_i32.Customer>(data['data']);
    }
    if (dataClassName == 'CustomerStatus') {
      return deserialize<_i33.CustomerStatus>(data['data']);
    }
    if (dataClassName == 'Invoice') {
      return deserialize<_i34.Invoice>(data['data']);
    }
    if (dataClassName == 'InvoiceItem') {
      return deserialize<_i35.InvoiceItem>(data['data']);
    }
    if (dataClassName == 'InvoiceItemRequest') {
      return deserialize<_i36.InvoiceItemRequest>(data['data']);
    }
    if (dataClassName == 'InvoiceItemUnit') {
      return deserialize<_i37.InvoiceItemUnit>(data['data']);
    }
    if (dataClassName == 'InvoiceStatus') {
      return deserialize<_i38.InvoiceStatus>(data['data']);
    }
    if (dataClassName == 'InvoiceTemplate') {
      return deserialize<_i39.InvoiceTemplate>(data['data']);
    }
    if (dataClassName == 'InvoiceType') {
      return deserialize<_i40.InvoiceType>(data['data']);
    }
    if (dataClassName == 'PaymentMethod') {
      return deserialize<_i41.PaymentMethod>(data['data']);
    }
    if (dataClassName == 'PaymentRecord') {
      return deserialize<_i42.PaymentRecord>(data['data']);
    }
    if (dataClassName == 'RecordPaymentRequest') {
      return deserialize<_i43.RecordPaymentRequest>(data['data']);
    }
    if (dataClassName == 'RecurrenceInterval') {
      return deserialize<_i44.RecurrenceInterval>(data['data']);
    }
    if (dataClassName == 'RecurrenceRule') {
      return deserialize<_i45.RecurrenceRule>(data['data']);
    }
    if (dataClassName == 'Reminder') {
      return deserialize<_i46.Reminder>(data['data']);
    }
    if (dataClassName == 'UpdateCustomerRequest') {
      return deserialize<_i47.UpdateCustomerRequest>(data['data']);
    }
    if (dataClassName == 'UpdateInvoiceRequest') {
      return deserialize<_i48.UpdateInvoiceRequest>(data['data']);
    }
    if (dataClassName == 'UpdateInvoiceTemplateRequest') {
      return deserialize<_i49.UpdateInvoiceTemplateRequest>(data['data']);
    }
    if (dataClassName == 'VatRate') {
      return deserialize<_i50.VatRate>(data['data']);
    }
    if (dataClassName == 'UpdateUserProfileRequest') {
      return deserialize<_i51.UpdateUserProfileRequest>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_i52.UserProfile>(data['data']);
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
      case _i11.Sequence:
        return _i11.Sequence.t;
      case _i13.Business:
        return _i13.Business.t;
      case _i14.BusinessSettings:
        return _i14.BusinessSettings.t;
      case _i20.Membership:
        return _i20.Membership.t;
      case _i25.Document:
        return _i25.Document.t;
      case _i32.Customer:
        return _i32.Customer.t;
      case _i34.Invoice:
        return _i34.Invoice.t;
      case _i35.InvoiceItem:
        return _i35.InvoiceItem.t;
      case _i39.InvoiceTemplate:
        return _i39.InvoiceTemplate.t;
      case _i42.PaymentRecord:
        return _i42.PaymentRecord.t;
      case _i46.Reminder:
        return _i46.Reminder.t;
      case _i52.UserProfile:
        return _i52.UserProfile.t;
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
