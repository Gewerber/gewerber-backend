/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'package:gewerber_commercial_server/gewerber_commercial_server.dart'
    as _i3;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i4;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i5;
import 'core/audit/audit_entry.dart' as _i6;
import 'core/entitlement/feature.dart' as _i7;
import 'core/errors/conflict_exception.dart' as _i8;
import 'core/errors/forbidden_exception.dart' as _i9;
import 'core/errors/not_found_exception.dart' as _i10;
import 'core/errors/validation_exception.dart' as _i11;
import 'core/sequence/sequence.dart' as _i12;
import 'modules/accounting/models/accounting_transaction.dart' as _i13;
import 'modules/accounting/models/create_transaction_request.dart' as _i14;
import 'modules/accounting/models/profit_loss_line.dart' as _i15;
import 'modules/accounting/models/profit_loss_report.dart' as _i16;
import 'modules/accounting/models/transaction_category.dart' as _i17;
import 'modules/accounting/models/transaction_type.dart' as _i18;
import 'modules/accounting/models/update_transaction_request.dart' as _i19;
import 'modules/business/models/address.dart' as _i20;
import 'modules/business/models/business.dart' as _i21;
import 'modules/business/models/business_settings.dart' as _i22;
import 'modules/business/models/country.dart' as _i23;
import 'modules/business/models/create_business_request.dart' as _i24;
import 'modules/business/models/currency.dart' as _i25;
import 'modules/business/models/legal_form.dart' as _i26;
import 'modules/business/models/locale.dart' as _i27;
import 'modules/business/models/membership.dart' as _i28;
import 'modules/business/models/membership_role.dart' as _i29;
import 'modules/business/models/rounding_mode.dart' as _i30;
import 'modules/business/models/update_business_request.dart' as _i31;
import 'modules/business/models/update_business_settings_request.dart' as _i32;
import 'modules/documents/models/document.dart' as _i33;
import 'modules/documents/models/document_kind.dart' as _i34;
import 'modules/documents/models/storage_location.dart' as _i35;
import 'modules/documents/models/upload_document_request.dart' as _i36;
import 'modules/guidance/models/checklist_definition.dart' as _i37;
import 'modules/guidance/models/checklist_item_definition.dart' as _i38;
import 'modules/guidance/models/guidance_tip.dart' as _i39;
import 'modules/guidance/models/user_guidance_progress.dart' as _i40;
import 'modules/invoicing/models/create_customer_request.dart' as _i41;
import 'modules/invoicing/models/create_invoice_request.dart' as _i42;
import 'modules/invoicing/models/create_invoice_template_request.dart' as _i43;
import 'modules/invoicing/models/create_recurring_schedule_request.dart'
    as _i44;
import 'modules/invoicing/models/customer.dart' as _i45;
import 'modules/invoicing/models/customer_cursor_page.dart' as _i46;
import 'modules/invoicing/models/customer_list_page.dart' as _i47;
import 'modules/invoicing/models/customer_status.dart' as _i48;
import 'modules/invoicing/models/invoice.dart' as _i49;
import 'modules/invoicing/models/invoice_cursor_page.dart' as _i50;
import 'modules/invoicing/models/invoice_item.dart' as _i51;
import 'modules/invoicing/models/invoice_item_request.dart' as _i52;
import 'modules/invoicing/models/invoice_item_unit.dart' as _i53;
import 'modules/invoicing/models/invoice_list_page.dart' as _i54;
import 'modules/invoicing/models/invoice_payment_status.dart' as _i55;
import 'modules/invoicing/models/invoice_status.dart' as _i56;
import 'modules/invoicing/models/invoice_template.dart' as _i57;
import 'modules/invoicing/models/invoice_type.dart' as _i58;
import 'modules/invoicing/models/payment_method.dart' as _i59;
import 'modules/invoicing/models/payment_record.dart' as _i60;
import 'modules/invoicing/models/record_payment_request.dart' as _i61;
import 'modules/invoicing/models/recurrence_interval.dart' as _i62;
import 'modules/invoicing/models/reminder.dart' as _i63;
import 'modules/invoicing/models/update_customer_request.dart' as _i64;
import 'modules/invoicing/models/update_invoice_request.dart' as _i65;
import 'modules/invoicing/models/update_invoice_template_request.dart' as _i66;
import 'modules/invoicing/models/update_recurring_schedule_request.dart'
    as _i67;
import 'modules/invoicing/models/vat_rate.dart' as _i68;
import 'modules/time_tracking/models/create_project_request.dart' as _i69;
import 'modules/time_tracking/models/create_task_request.dart' as _i70;
import 'modules/time_tracking/models/create_time_entries_invoice_request.dart'
    as _i71;
import 'modules/time_tracking/models/create_time_entry_request.dart' as _i72;
import 'modules/time_tracking/models/project.dart' as _i73;
import 'modules/time_tracking/models/project_status.dart' as _i74;
import 'modules/time_tracking/models/start_timer_request.dart' as _i75;
import 'modules/time_tracking/models/task.dart' as _i76;
import 'modules/time_tracking/models/task_status.dart' as _i77;
import 'modules/time_tracking/models/time_entry.dart' as _i78;
import 'modules/time_tracking/models/time_report.dart' as _i79;
import 'modules/time_tracking/models/time_report_line.dart' as _i80;
import 'modules/time_tracking/models/update_project_request.dart' as _i81;
import 'modules/time_tracking/models/update_task_request.dart' as _i82;
import 'modules/time_tracking/models/update_time_entry_request.dart' as _i83;
import 'modules/user/models/app_theme.dart' as _i84;
import 'modules/user/models/update_user_profile_request.dart' as _i85;
import 'modules/user/models/user_profile.dart' as _i86;
import 'package:gewerber_backend_server/src/generated/core/entitlement/feature.dart'
    as _i87;
import 'package:gewerber_backend_server/src/generated/modules/accounting/models/accounting_transaction.dart'
    as _i88;
import 'package:gewerber_backend_server/src/generated/modules/business/models/business.dart'
    as _i89;
import 'package:gewerber_backend_server/src/generated/modules/documents/models/document.dart'
    as _i90;
import 'package:gewerber_backend_server/src/generated/modules/guidance/models/guidance_tip.dart'
    as _i91;
import 'package:gewerber_backend_server/src/generated/modules/guidance/models/checklist_definition.dart'
    as _i92;
import 'package:gewerber_backend_server/src/generated/modules/guidance/models/user_guidance_progress.dart'
    as _i93;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/customer.dart'
    as _i94;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/invoice_item.dart'
    as _i95;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/invoice.dart'
    as _i96;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/invoice_template.dart'
    as _i97;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/reminder.dart'
    as _i98;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/task.dart'
    as _i99;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/project.dart'
    as _i100;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/time_entry.dart'
    as _i101;
export 'core/audit/audit_entry.dart';
export 'core/entitlement/feature.dart';
export 'core/errors/conflict_exception.dart';
export 'core/errors/forbidden_exception.dart';
export 'core/errors/not_found_exception.dart';
export 'core/errors/validation_exception.dart';
export 'core/sequence/sequence.dart';
export 'modules/accounting/models/accounting_transaction.dart';
export 'modules/accounting/models/create_transaction_request.dart';
export 'modules/accounting/models/profit_loss_line.dart';
export 'modules/accounting/models/profit_loss_report.dart';
export 'modules/accounting/models/transaction_category.dart';
export 'modules/accounting/models/transaction_type.dart';
export 'modules/accounting/models/update_transaction_request.dart';
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
export 'modules/guidance/models/checklist_definition.dart';
export 'modules/guidance/models/checklist_item_definition.dart';
export 'modules/guidance/models/guidance_tip.dart';
export 'modules/guidance/models/user_guidance_progress.dart';
export 'modules/invoicing/models/create_customer_request.dart';
export 'modules/invoicing/models/create_invoice_request.dart';
export 'modules/invoicing/models/create_invoice_template_request.dart';
export 'modules/invoicing/models/create_recurring_schedule_request.dart';
export 'modules/invoicing/models/customer.dart';
export 'modules/invoicing/models/customer_cursor_page.dart';
export 'modules/invoicing/models/customer_list_page.dart';
export 'modules/invoicing/models/customer_status.dart';
export 'modules/invoicing/models/invoice.dart';
export 'modules/invoicing/models/invoice_cursor_page.dart';
export 'modules/invoicing/models/invoice_item.dart';
export 'modules/invoicing/models/invoice_item_request.dart';
export 'modules/invoicing/models/invoice_item_unit.dart';
export 'modules/invoicing/models/invoice_list_page.dart';
export 'modules/invoicing/models/invoice_payment_status.dart';
export 'modules/invoicing/models/invoice_status.dart';
export 'modules/invoicing/models/invoice_template.dart';
export 'modules/invoicing/models/invoice_type.dart';
export 'modules/invoicing/models/payment_method.dart';
export 'modules/invoicing/models/payment_record.dart';
export 'modules/invoicing/models/record_payment_request.dart';
export 'modules/invoicing/models/recurrence_interval.dart';
export 'modules/invoicing/models/reminder.dart';
export 'modules/invoicing/models/update_customer_request.dart';
export 'modules/invoicing/models/update_invoice_request.dart';
export 'modules/invoicing/models/update_invoice_template_request.dart';
export 'modules/invoicing/models/update_recurring_schedule_request.dart';
export 'modules/invoicing/models/vat_rate.dart';
export 'modules/time_tracking/models/create_project_request.dart';
export 'modules/time_tracking/models/create_task_request.dart';
export 'modules/time_tracking/models/create_time_entries_invoice_request.dart';
export 'modules/time_tracking/models/create_time_entry_request.dart';
export 'modules/time_tracking/models/project.dart';
export 'modules/time_tracking/models/project_status.dart';
export 'modules/time_tracking/models/start_timer_request.dart';
export 'modules/time_tracking/models/task.dart';
export 'modules/time_tracking/models/task_status.dart';
export 'modules/time_tracking/models/time_entry.dart';
export 'modules/time_tracking/models/time_report.dart';
export 'modules/time_tracking/models/time_report_line.dart';
export 'modules/time_tracking/models/update_project_request.dart';
export 'modules/time_tracking/models/update_task_request.dart';
export 'modules/time_tracking/models/update_time_entry_request.dart';
export 'modules/user/models/app_theme.dart';
export 'modules/user/models/update_user_profile_request.dart';
export 'modules/user/models/user_profile.dart';

class Protocol extends _i1.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_i2.TableDefinition> get targetTableDefinitions => [
    _i2.TableDefinition(
      name: 'accounting_transaction',
      dartName: 'AccountingTransaction',
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
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TransactionType',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TransactionCategory',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'occurredAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'amountCents',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'receiptDocumentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'relatedInvoiceId',
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
          constraintName: 'accounting_transaction_fk_0',
          columns: ['businessId'],
          referenceTable: 'business',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'accounting_transaction_fk_1',
          columns: ['receiptDocumentId'],
          referenceTable: 'document',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.setNull,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'accounting_transaction_fk_2',
          columns: ['relatedInvoiceId'],
          referenceTable: 'invoice',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'accounting_transaction_business_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'occurredAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'accounting_transaction_category_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'category',
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
          name: 'recurrenceInterval',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:RecurrenceInterval?',
        ),
        _i2.ColumnDefinition(
          name: 'nextRecurrenceDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'recurrenceEndDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'recurrenceMaxOccurrences',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'recurrenceOccurrencesCreated',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
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
        _i2.IndexDefinition(
          indexName: 'invoice_recurrence_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'nextRecurrenceDate',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'invoice_business_status_due_idx',
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
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'dueDate',
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
          isNullable: true,
          dartType: 'UuidValue?',
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
      name: 'project',
      dartName: 'Project',
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
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ProjectStatus',
          columnDefault: '\'active\'',
        ),
        _i2.ColumnDefinition(
          name: 'customerId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'hourlyRateCents',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
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
          constraintName: 'project_fk_0',
          columns: ['businessId'],
          referenceTable: 'business',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'project_fk_1',
          columns: ['customerId'],
          referenceTable: 'customer',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'project_business_idx',
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
      name: 'task',
      dartName: 'Task',
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
          name: 'projectId',
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
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TaskStatus',
          columnDefault: '\'open\'',
        ),
        _i2.ColumnDefinition(
          name: 'hourlyRateCents',
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
          constraintName: 'task_fk_0',
          columns: ['businessId'],
          referenceTable: 'business',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'task_fk_1',
          columns: ['projectId'],
          referenceTable: 'project',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'task_business_idx',
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
        _i2.IndexDefinition(
          indexName: 'task_project_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'projectId',
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
      name: 'time_entry',
      dartName: 'TimeEntry',
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
          name: 'projectId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'taskId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'startedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'stoppedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'durationMinutes',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'billable',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'invoicedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
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
          constraintName: 'time_entry_fk_0',
          columns: ['businessId'],
          referenceTable: 'business',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'time_entry_fk_1',
          columns: ['projectId'],
          referenceTable: 'project',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.setNull,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'time_entry_fk_2',
          columns: ['taskId'],
          referenceTable: 'task',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'time_entry_business_started_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'startedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'time_entry_project_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'projectId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'time_entry_task_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'taskId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'time_entry_business_running_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'stoppedAt',
            ),
          ],
          type: 'btree',
          isUnique: true,
          nullsDistinct: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_guidance_progress',
      dartName: 'UserGuidanceProgress',
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
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _i2.ColumnDefinition(
          name: 'itemKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'dismissedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
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
          indexName: 'user_guidance_progress_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'itemKey',
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
          name: 'themeMode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AppTheme',
          columnDefault: '\'system\'',
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
        _i2.ColumnDefinition(
          name: 'deletedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
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
    ..._i5.Protocol.targetTableDefinitions,
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

    if (t == _i6.AuditEntry) {
      return _i6.AuditEntry.fromJson(data) as T;
    }
    if (t == _i7.Feature) {
      return _i7.Feature.fromJson(data) as T;
    }
    if (t == _i8.ConflictException) {
      return _i8.ConflictException.fromJson(data) as T;
    }
    if (t == _i9.ForbiddenException) {
      return _i9.ForbiddenException.fromJson(data) as T;
    }
    if (t == _i10.NotFoundException) {
      return _i10.NotFoundException.fromJson(data) as T;
    }
    if (t == _i11.ValidationException) {
      return _i11.ValidationException.fromJson(data) as T;
    }
    if (t == _i12.Sequence) {
      return _i12.Sequence.fromJson(data) as T;
    }
    if (t == _i13.AccountingTransaction) {
      return _i13.AccountingTransaction.fromJson(data) as T;
    }
    if (t == _i14.CreateTransactionRequest) {
      return _i14.CreateTransactionRequest.fromJson(data) as T;
    }
    if (t == _i15.ProfitLossLine) {
      return _i15.ProfitLossLine.fromJson(data) as T;
    }
    if (t == _i16.ProfitLossReport) {
      return _i16.ProfitLossReport.fromJson(data) as T;
    }
    if (t == _i17.TransactionCategory) {
      return _i17.TransactionCategory.fromJson(data) as T;
    }
    if (t == _i18.TransactionType) {
      return _i18.TransactionType.fromJson(data) as T;
    }
    if (t == _i19.UpdateTransactionRequest) {
      return _i19.UpdateTransactionRequest.fromJson(data) as T;
    }
    if (t == _i20.Address) {
      return _i20.Address.fromJson(data) as T;
    }
    if (t == _i21.Business) {
      return _i21.Business.fromJson(data) as T;
    }
    if (t == _i22.BusinessSettings) {
      return _i22.BusinessSettings.fromJson(data) as T;
    }
    if (t == _i23.Country) {
      return _i23.Country.fromJson(data) as T;
    }
    if (t == _i24.CreateBusinessRequest) {
      return _i24.CreateBusinessRequest.fromJson(data) as T;
    }
    if (t == _i25.Currency) {
      return _i25.Currency.fromJson(data) as T;
    }
    if (t == _i26.LegalForm) {
      return _i26.LegalForm.fromJson(data) as T;
    }
    if (t == _i27.Locale) {
      return _i27.Locale.fromJson(data) as T;
    }
    if (t == _i28.Membership) {
      return _i28.Membership.fromJson(data) as T;
    }
    if (t == _i29.MembershipRole) {
      return _i29.MembershipRole.fromJson(data) as T;
    }
    if (t == _i30.RoundingMode) {
      return _i30.RoundingMode.fromJson(data) as T;
    }
    if (t == _i31.UpdateBusinessRequest) {
      return _i31.UpdateBusinessRequest.fromJson(data) as T;
    }
    if (t == _i32.UpdateBusinessSettingsRequest) {
      return _i32.UpdateBusinessSettingsRequest.fromJson(data) as T;
    }
    if (t == _i33.Document) {
      return _i33.Document.fromJson(data) as T;
    }
    if (t == _i34.DocumentKind) {
      return _i34.DocumentKind.fromJson(data) as T;
    }
    if (t == _i35.StorageLocation) {
      return _i35.StorageLocation.fromJson(data) as T;
    }
    if (t == _i36.UploadDocumentRequest) {
      return _i36.UploadDocumentRequest.fromJson(data) as T;
    }
    if (t == _i37.ChecklistDefinition) {
      return _i37.ChecklistDefinition.fromJson(data) as T;
    }
    if (t == _i38.ChecklistItemDefinition) {
      return _i38.ChecklistItemDefinition.fromJson(data) as T;
    }
    if (t == _i39.GuidanceTip) {
      return _i39.GuidanceTip.fromJson(data) as T;
    }
    if (t == _i40.UserGuidanceProgress) {
      return _i40.UserGuidanceProgress.fromJson(data) as T;
    }
    if (t == _i41.CreateCustomerRequest) {
      return _i41.CreateCustomerRequest.fromJson(data) as T;
    }
    if (t == _i42.CreateInvoiceRequest) {
      return _i42.CreateInvoiceRequest.fromJson(data) as T;
    }
    if (t == _i43.CreateInvoiceTemplateRequest) {
      return _i43.CreateInvoiceTemplateRequest.fromJson(data) as T;
    }
    if (t == _i44.CreateRecurringScheduleRequest) {
      return _i44.CreateRecurringScheduleRequest.fromJson(data) as T;
    }
    if (t == _i45.Customer) {
      return _i45.Customer.fromJson(data) as T;
    }
    if (t == _i46.CustomerCursorPage) {
      return _i46.CustomerCursorPage.fromJson(data) as T;
    }
    if (t == _i47.CustomerListPage) {
      return _i47.CustomerListPage.fromJson(data) as T;
    }
    if (t == _i48.CustomerStatus) {
      return _i48.CustomerStatus.fromJson(data) as T;
    }
    if (t == _i49.Invoice) {
      return _i49.Invoice.fromJson(data) as T;
    }
    if (t == _i50.InvoiceCursorPage) {
      return _i50.InvoiceCursorPage.fromJson(data) as T;
    }
    if (t == _i51.InvoiceItem) {
      return _i51.InvoiceItem.fromJson(data) as T;
    }
    if (t == _i52.InvoiceItemRequest) {
      return _i52.InvoiceItemRequest.fromJson(data) as T;
    }
    if (t == _i53.InvoiceItemUnit) {
      return _i53.InvoiceItemUnit.fromJson(data) as T;
    }
    if (t == _i54.InvoiceListPage) {
      return _i54.InvoiceListPage.fromJson(data) as T;
    }
    if (t == _i55.InvoicePaymentStatus) {
      return _i55.InvoicePaymentStatus.fromJson(data) as T;
    }
    if (t == _i56.InvoiceStatus) {
      return _i56.InvoiceStatus.fromJson(data) as T;
    }
    if (t == _i57.InvoiceTemplate) {
      return _i57.InvoiceTemplate.fromJson(data) as T;
    }
    if (t == _i58.InvoiceType) {
      return _i58.InvoiceType.fromJson(data) as T;
    }
    if (t == _i59.PaymentMethod) {
      return _i59.PaymentMethod.fromJson(data) as T;
    }
    if (t == _i60.PaymentRecord) {
      return _i60.PaymentRecord.fromJson(data) as T;
    }
    if (t == _i61.RecordPaymentRequest) {
      return _i61.RecordPaymentRequest.fromJson(data) as T;
    }
    if (t == _i62.RecurrenceInterval) {
      return _i62.RecurrenceInterval.fromJson(data) as T;
    }
    if (t == _i63.Reminder) {
      return _i63.Reminder.fromJson(data) as T;
    }
    if (t == _i64.UpdateCustomerRequest) {
      return _i64.UpdateCustomerRequest.fromJson(data) as T;
    }
    if (t == _i65.UpdateInvoiceRequest) {
      return _i65.UpdateInvoiceRequest.fromJson(data) as T;
    }
    if (t == _i66.UpdateInvoiceTemplateRequest) {
      return _i66.UpdateInvoiceTemplateRequest.fromJson(data) as T;
    }
    if (t == _i67.UpdateRecurringScheduleRequest) {
      return _i67.UpdateRecurringScheduleRequest.fromJson(data) as T;
    }
    if (t == _i68.VatRate) {
      return _i68.VatRate.fromJson(data) as T;
    }
    if (t == _i69.CreateProjectRequest) {
      return _i69.CreateProjectRequest.fromJson(data) as T;
    }
    if (t == _i70.CreateTaskRequest) {
      return _i70.CreateTaskRequest.fromJson(data) as T;
    }
    if (t == _i71.CreateTimeEntriesInvoiceRequest) {
      return _i71.CreateTimeEntriesInvoiceRequest.fromJson(data) as T;
    }
    if (t == _i72.CreateTimeEntryRequest) {
      return _i72.CreateTimeEntryRequest.fromJson(data) as T;
    }
    if (t == _i73.Project) {
      return _i73.Project.fromJson(data) as T;
    }
    if (t == _i74.ProjectStatus) {
      return _i74.ProjectStatus.fromJson(data) as T;
    }
    if (t == _i75.StartTimerRequest) {
      return _i75.StartTimerRequest.fromJson(data) as T;
    }
    if (t == _i76.Task) {
      return _i76.Task.fromJson(data) as T;
    }
    if (t == _i77.TaskStatus) {
      return _i77.TaskStatus.fromJson(data) as T;
    }
    if (t == _i78.TimeEntry) {
      return _i78.TimeEntry.fromJson(data) as T;
    }
    if (t == _i79.TimeReport) {
      return _i79.TimeReport.fromJson(data) as T;
    }
    if (t == _i80.TimeReportLine) {
      return _i80.TimeReportLine.fromJson(data) as T;
    }
    if (t == _i81.UpdateProjectRequest) {
      return _i81.UpdateProjectRequest.fromJson(data) as T;
    }
    if (t == _i82.UpdateTaskRequest) {
      return _i82.UpdateTaskRequest.fromJson(data) as T;
    }
    if (t == _i83.UpdateTimeEntryRequest) {
      return _i83.UpdateTimeEntryRequest.fromJson(data) as T;
    }
    if (t == _i84.AppTheme) {
      return _i84.AppTheme.fromJson(data) as T;
    }
    if (t == _i85.UpdateUserProfileRequest) {
      return _i85.UpdateUserProfileRequest.fromJson(data) as T;
    }
    if (t == _i86.UserProfile) {
      return _i86.UserProfile.fromJson(data) as T;
    }
    if (t == _i1.getType<_i6.AuditEntry?>()) {
      return (data != null ? _i6.AuditEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Feature?>()) {
      return (data != null ? _i7.Feature.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.ConflictException?>()) {
      return (data != null ? _i8.ConflictException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.ForbiddenException?>()) {
      return (data != null ? _i9.ForbiddenException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.NotFoundException?>()) {
      return (data != null ? _i10.NotFoundException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.ValidationException?>()) {
      return (data != null ? _i11.ValidationException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.Sequence?>()) {
      return (data != null ? _i12.Sequence.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.AccountingTransaction?>()) {
      return (data != null ? _i13.AccountingTransaction.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.CreateTransactionRequest?>()) {
      return (data != null
              ? _i14.CreateTransactionRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i15.ProfitLossLine?>()) {
      return (data != null ? _i15.ProfitLossLine.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.ProfitLossReport?>()) {
      return (data != null ? _i16.ProfitLossReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.TransactionCategory?>()) {
      return (data != null ? _i17.TransactionCategory.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.TransactionType?>()) {
      return (data != null ? _i18.TransactionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.UpdateTransactionRequest?>()) {
      return (data != null
              ? _i19.UpdateTransactionRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i20.Address?>()) {
      return (data != null ? _i20.Address.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.Business?>()) {
      return (data != null ? _i21.Business.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.BusinessSettings?>()) {
      return (data != null ? _i22.BusinessSettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.Country?>()) {
      return (data != null ? _i23.Country.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.CreateBusinessRequest?>()) {
      return (data != null ? _i24.CreateBusinessRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.Currency?>()) {
      return (data != null ? _i25.Currency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.LegalForm?>()) {
      return (data != null ? _i26.LegalForm.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.Locale?>()) {
      return (data != null ? _i27.Locale.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.Membership?>()) {
      return (data != null ? _i28.Membership.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.MembershipRole?>()) {
      return (data != null ? _i29.MembershipRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.RoundingMode?>()) {
      return (data != null ? _i30.RoundingMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.UpdateBusinessRequest?>()) {
      return (data != null ? _i31.UpdateBusinessRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i32.UpdateBusinessSettingsRequest?>()) {
      return (data != null
              ? _i32.UpdateBusinessSettingsRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i33.Document?>()) {
      return (data != null ? _i33.Document.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.DocumentKind?>()) {
      return (data != null ? _i34.DocumentKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.StorageLocation?>()) {
      return (data != null ? _i35.StorageLocation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.UploadDocumentRequest?>()) {
      return (data != null ? _i36.UploadDocumentRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i37.ChecklistDefinition?>()) {
      return (data != null ? _i37.ChecklistDefinition.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i38.ChecklistItemDefinition?>()) {
      return (data != null ? _i38.ChecklistItemDefinition.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i39.GuidanceTip?>()) {
      return (data != null ? _i39.GuidanceTip.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.UserGuidanceProgress?>()) {
      return (data != null ? _i40.UserGuidanceProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i41.CreateCustomerRequest?>()) {
      return (data != null ? _i41.CreateCustomerRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i42.CreateInvoiceRequest?>()) {
      return (data != null ? _i42.CreateInvoiceRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i43.CreateInvoiceTemplateRequest?>()) {
      return (data != null
              ? _i43.CreateInvoiceTemplateRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i44.CreateRecurringScheduleRequest?>()) {
      return (data != null
              ? _i44.CreateRecurringScheduleRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i45.Customer?>()) {
      return (data != null ? _i45.Customer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.CustomerCursorPage?>()) {
      return (data != null ? _i46.CustomerCursorPage.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i47.CustomerListPage?>()) {
      return (data != null ? _i47.CustomerListPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.CustomerStatus?>()) {
      return (data != null ? _i48.CustomerStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.Invoice?>()) {
      return (data != null ? _i49.Invoice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.InvoiceCursorPage?>()) {
      return (data != null ? _i50.InvoiceCursorPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.InvoiceItem?>()) {
      return (data != null ? _i51.InvoiceItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.InvoiceItemRequest?>()) {
      return (data != null ? _i52.InvoiceItemRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i53.InvoiceItemUnit?>()) {
      return (data != null ? _i53.InvoiceItemUnit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.InvoiceListPage?>()) {
      return (data != null ? _i54.InvoiceListPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.InvoicePaymentStatus?>()) {
      return (data != null ? _i55.InvoicePaymentStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i56.InvoiceStatus?>()) {
      return (data != null ? _i56.InvoiceStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.InvoiceTemplate?>()) {
      return (data != null ? _i57.InvoiceTemplate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.InvoiceType?>()) {
      return (data != null ? _i58.InvoiceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.PaymentMethod?>()) {
      return (data != null ? _i59.PaymentMethod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.PaymentRecord?>()) {
      return (data != null ? _i60.PaymentRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.RecordPaymentRequest?>()) {
      return (data != null ? _i61.RecordPaymentRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i62.RecurrenceInterval?>()) {
      return (data != null ? _i62.RecurrenceInterval.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i63.Reminder?>()) {
      return (data != null ? _i63.Reminder.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.UpdateCustomerRequest?>()) {
      return (data != null ? _i64.UpdateCustomerRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i65.UpdateInvoiceRequest?>()) {
      return (data != null ? _i65.UpdateInvoiceRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i66.UpdateInvoiceTemplateRequest?>()) {
      return (data != null
              ? _i66.UpdateInvoiceTemplateRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i67.UpdateRecurringScheduleRequest?>()) {
      return (data != null
              ? _i67.UpdateRecurringScheduleRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i68.VatRate?>()) {
      return (data != null ? _i68.VatRate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.CreateProjectRequest?>()) {
      return (data != null ? _i69.CreateProjectRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i70.CreateTaskRequest?>()) {
      return (data != null ? _i70.CreateTaskRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.CreateTimeEntriesInvoiceRequest?>()) {
      return (data != null
              ? _i71.CreateTimeEntriesInvoiceRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i72.CreateTimeEntryRequest?>()) {
      return (data != null ? _i72.CreateTimeEntryRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i73.Project?>()) {
      return (data != null ? _i73.Project.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i74.ProjectStatus?>()) {
      return (data != null ? _i74.ProjectStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i75.StartTimerRequest?>()) {
      return (data != null ? _i75.StartTimerRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i76.Task?>()) {
      return (data != null ? _i76.Task.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i77.TaskStatus?>()) {
      return (data != null ? _i77.TaskStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i78.TimeEntry?>()) {
      return (data != null ? _i78.TimeEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i79.TimeReport?>()) {
      return (data != null ? _i79.TimeReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i80.TimeReportLine?>()) {
      return (data != null ? _i80.TimeReportLine.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i81.UpdateProjectRequest?>()) {
      return (data != null ? _i81.UpdateProjectRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i82.UpdateTaskRequest?>()) {
      return (data != null ? _i82.UpdateTaskRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i83.UpdateTimeEntryRequest?>()) {
      return (data != null ? _i83.UpdateTimeEntryRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i84.AppTheme?>()) {
      return (data != null ? _i84.AppTheme.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i85.UpdateUserProfileRequest?>()) {
      return (data != null
              ? _i85.UpdateUserProfileRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i86.UserProfile?>()) {
      return (data != null ? _i86.UserProfile.fromJson(data) : null) as T;
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
    if (t == List<_i15.ProfitLossLine>) {
      return (data as List)
              .map((e) => deserialize<_i15.ProfitLossLine>(e))
              .toList()
          as T;
    }
    if (t == List<_i38.ChecklistItemDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i38.ChecklistItemDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i52.InvoiceItemRequest>) {
      return (data as List)
              .map((e) => deserialize<_i52.InvoiceItemRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_i45.Customer>) {
      return (data as List).map((e) => deserialize<_i45.Customer>(e)).toList()
          as T;
    }
    if (t == List<_i49.Invoice>) {
      return (data as List).map((e) => deserialize<_i49.Invoice>(e)).toList()
          as T;
    }
    if (t == List<_i60.PaymentRecord>) {
      return (data as List)
              .map((e) => deserialize<_i60.PaymentRecord>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i80.TimeReportLine>) {
      return (data as List)
              .map((e) => deserialize<_i80.TimeReportLine>(e))
              .toList()
          as T;
    }
    if (t == List<_i87.Feature>) {
      return (data as List).map((e) => deserialize<_i87.Feature>(e)).toList()
          as T;
    }
    if (t == List<_i88.AccountingTransaction>) {
      return (data as List)
              .map((e) => deserialize<_i88.AccountingTransaction>(e))
              .toList()
          as T;
    }
    if (t == List<_i89.Business>) {
      return (data as List).map((e) => deserialize<_i89.Business>(e)).toList()
          as T;
    }
    if (t == List<_i90.Document>) {
      return (data as List).map((e) => deserialize<_i90.Document>(e)).toList()
          as T;
    }
    if (t == List<_i91.GuidanceTip>) {
      return (data as List)
              .map((e) => deserialize<_i91.GuidanceTip>(e))
              .toList()
          as T;
    }
    if (t == List<_i92.ChecklistDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i92.ChecklistDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i93.UserGuidanceProgress>) {
      return (data as List)
              .map((e) => deserialize<_i93.UserGuidanceProgress>(e))
              .toList()
          as T;
    }
    if (t == List<_i94.Customer>) {
      return (data as List).map((e) => deserialize<_i94.Customer>(e)).toList()
          as T;
    }
    if (t == List<_i95.InvoiceItem>) {
      return (data as List)
              .map((e) => deserialize<_i95.InvoiceItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i96.Invoice>) {
      return (data as List).map((e) => deserialize<_i96.Invoice>(e)).toList()
          as T;
    }
    if (t == List<_i97.InvoiceTemplate>) {
      return (data as List)
              .map((e) => deserialize<_i97.InvoiceTemplate>(e))
              .toList()
          as T;
    }
    if (t == List<_i98.Reminder>) {
      return (data as List).map((e) => deserialize<_i98.Reminder>(e)).toList()
          as T;
    }
    if (t == List<_i99.Task>) {
      return (data as List).map((e) => deserialize<_i99.Task>(e)).toList() as T;
    }
    if (t == List<_i100.Project>) {
      return (data as List).map((e) => deserialize<_i100.Project>(e)).toList()
          as T;
    }
    if (t == List<_i101.TimeEntry>) {
      return (data as List).map((e) => deserialize<_i101.TimeEntry>(e)).toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i5.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i6.AuditEntry => 'AuditEntry',
      _i7.Feature => 'Feature',
      _i8.ConflictException => 'ConflictException',
      _i9.ForbiddenException => 'ForbiddenException',
      _i10.NotFoundException => 'NotFoundException',
      _i11.ValidationException => 'ValidationException',
      _i12.Sequence => 'Sequence',
      _i13.AccountingTransaction => 'AccountingTransaction',
      _i14.CreateTransactionRequest => 'CreateTransactionRequest',
      _i15.ProfitLossLine => 'ProfitLossLine',
      _i16.ProfitLossReport => 'ProfitLossReport',
      _i17.TransactionCategory => 'TransactionCategory',
      _i18.TransactionType => 'TransactionType',
      _i19.UpdateTransactionRequest => 'UpdateTransactionRequest',
      _i20.Address => 'Address',
      _i21.Business => 'Business',
      _i22.BusinessSettings => 'BusinessSettings',
      _i23.Country => 'Country',
      _i24.CreateBusinessRequest => 'CreateBusinessRequest',
      _i25.Currency => 'Currency',
      _i26.LegalForm => 'LegalForm',
      _i27.Locale => 'Locale',
      _i28.Membership => 'Membership',
      _i29.MembershipRole => 'MembershipRole',
      _i30.RoundingMode => 'RoundingMode',
      _i31.UpdateBusinessRequest => 'UpdateBusinessRequest',
      _i32.UpdateBusinessSettingsRequest => 'UpdateBusinessSettingsRequest',
      _i33.Document => 'Document',
      _i34.DocumentKind => 'DocumentKind',
      _i35.StorageLocation => 'StorageLocation',
      _i36.UploadDocumentRequest => 'UploadDocumentRequest',
      _i37.ChecklistDefinition => 'ChecklistDefinition',
      _i38.ChecklistItemDefinition => 'ChecklistItemDefinition',
      _i39.GuidanceTip => 'GuidanceTip',
      _i40.UserGuidanceProgress => 'UserGuidanceProgress',
      _i41.CreateCustomerRequest => 'CreateCustomerRequest',
      _i42.CreateInvoiceRequest => 'CreateInvoiceRequest',
      _i43.CreateInvoiceTemplateRequest => 'CreateInvoiceTemplateRequest',
      _i44.CreateRecurringScheduleRequest => 'CreateRecurringScheduleRequest',
      _i45.Customer => 'Customer',
      _i46.CustomerCursorPage => 'CustomerCursorPage',
      _i47.CustomerListPage => 'CustomerListPage',
      _i48.CustomerStatus => 'CustomerStatus',
      _i49.Invoice => 'Invoice',
      _i50.InvoiceCursorPage => 'InvoiceCursorPage',
      _i51.InvoiceItem => 'InvoiceItem',
      _i52.InvoiceItemRequest => 'InvoiceItemRequest',
      _i53.InvoiceItemUnit => 'InvoiceItemUnit',
      _i54.InvoiceListPage => 'InvoiceListPage',
      _i55.InvoicePaymentStatus => 'InvoicePaymentStatus',
      _i56.InvoiceStatus => 'InvoiceStatus',
      _i57.InvoiceTemplate => 'InvoiceTemplate',
      _i58.InvoiceType => 'InvoiceType',
      _i59.PaymentMethod => 'PaymentMethod',
      _i60.PaymentRecord => 'PaymentRecord',
      _i61.RecordPaymentRequest => 'RecordPaymentRequest',
      _i62.RecurrenceInterval => 'RecurrenceInterval',
      _i63.Reminder => 'Reminder',
      _i64.UpdateCustomerRequest => 'UpdateCustomerRequest',
      _i65.UpdateInvoiceRequest => 'UpdateInvoiceRequest',
      _i66.UpdateInvoiceTemplateRequest => 'UpdateInvoiceTemplateRequest',
      _i67.UpdateRecurringScheduleRequest => 'UpdateRecurringScheduleRequest',
      _i68.VatRate => 'VatRate',
      _i69.CreateProjectRequest => 'CreateProjectRequest',
      _i70.CreateTaskRequest => 'CreateTaskRequest',
      _i71.CreateTimeEntriesInvoiceRequest => 'CreateTimeEntriesInvoiceRequest',
      _i72.CreateTimeEntryRequest => 'CreateTimeEntryRequest',
      _i73.Project => 'Project',
      _i74.ProjectStatus => 'ProjectStatus',
      _i75.StartTimerRequest => 'StartTimerRequest',
      _i76.Task => 'Task',
      _i77.TaskStatus => 'TaskStatus',
      _i78.TimeEntry => 'TimeEntry',
      _i79.TimeReport => 'TimeReport',
      _i80.TimeReportLine => 'TimeReportLine',
      _i81.UpdateProjectRequest => 'UpdateProjectRequest',
      _i82.UpdateTaskRequest => 'UpdateTaskRequest',
      _i83.UpdateTimeEntryRequest => 'UpdateTimeEntryRequest',
      _i84.AppTheme => 'AppTheme',
      _i85.UpdateUserProfileRequest => 'UpdateUserProfileRequest',
      _i86.UserProfile => 'UserProfile',
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
      case _i6.AuditEntry():
        return 'AuditEntry';
      case _i7.Feature():
        return 'Feature';
      case _i8.ConflictException():
        return 'ConflictException';
      case _i9.ForbiddenException():
        return 'ForbiddenException';
      case _i10.NotFoundException():
        return 'NotFoundException';
      case _i11.ValidationException():
        return 'ValidationException';
      case _i12.Sequence():
        return 'Sequence';
      case _i13.AccountingTransaction():
        return 'AccountingTransaction';
      case _i14.CreateTransactionRequest():
        return 'CreateTransactionRequest';
      case _i15.ProfitLossLine():
        return 'ProfitLossLine';
      case _i16.ProfitLossReport():
        return 'ProfitLossReport';
      case _i17.TransactionCategory():
        return 'TransactionCategory';
      case _i18.TransactionType():
        return 'TransactionType';
      case _i19.UpdateTransactionRequest():
        return 'UpdateTransactionRequest';
      case _i20.Address():
        return 'Address';
      case _i21.Business():
        return 'Business';
      case _i22.BusinessSettings():
        return 'BusinessSettings';
      case _i23.Country():
        return 'Country';
      case _i24.CreateBusinessRequest():
        return 'CreateBusinessRequest';
      case _i25.Currency():
        return 'Currency';
      case _i26.LegalForm():
        return 'LegalForm';
      case _i27.Locale():
        return 'Locale';
      case _i28.Membership():
        return 'Membership';
      case _i29.MembershipRole():
        return 'MembershipRole';
      case _i30.RoundingMode():
        return 'RoundingMode';
      case _i31.UpdateBusinessRequest():
        return 'UpdateBusinessRequest';
      case _i32.UpdateBusinessSettingsRequest():
        return 'UpdateBusinessSettingsRequest';
      case _i33.Document():
        return 'Document';
      case _i34.DocumentKind():
        return 'DocumentKind';
      case _i35.StorageLocation():
        return 'StorageLocation';
      case _i36.UploadDocumentRequest():
        return 'UploadDocumentRequest';
      case _i37.ChecklistDefinition():
        return 'ChecklistDefinition';
      case _i38.ChecklistItemDefinition():
        return 'ChecklistItemDefinition';
      case _i39.GuidanceTip():
        return 'GuidanceTip';
      case _i40.UserGuidanceProgress():
        return 'UserGuidanceProgress';
      case _i41.CreateCustomerRequest():
        return 'CreateCustomerRequest';
      case _i42.CreateInvoiceRequest():
        return 'CreateInvoiceRequest';
      case _i43.CreateInvoiceTemplateRequest():
        return 'CreateInvoiceTemplateRequest';
      case _i44.CreateRecurringScheduleRequest():
        return 'CreateRecurringScheduleRequest';
      case _i45.Customer():
        return 'Customer';
      case _i46.CustomerCursorPage():
        return 'CustomerCursorPage';
      case _i47.CustomerListPage():
        return 'CustomerListPage';
      case _i48.CustomerStatus():
        return 'CustomerStatus';
      case _i49.Invoice():
        return 'Invoice';
      case _i50.InvoiceCursorPage():
        return 'InvoiceCursorPage';
      case _i51.InvoiceItem():
        return 'InvoiceItem';
      case _i52.InvoiceItemRequest():
        return 'InvoiceItemRequest';
      case _i53.InvoiceItemUnit():
        return 'InvoiceItemUnit';
      case _i54.InvoiceListPage():
        return 'InvoiceListPage';
      case _i55.InvoicePaymentStatus():
        return 'InvoicePaymentStatus';
      case _i56.InvoiceStatus():
        return 'InvoiceStatus';
      case _i57.InvoiceTemplate():
        return 'InvoiceTemplate';
      case _i58.InvoiceType():
        return 'InvoiceType';
      case _i59.PaymentMethod():
        return 'PaymentMethod';
      case _i60.PaymentRecord():
        return 'PaymentRecord';
      case _i61.RecordPaymentRequest():
        return 'RecordPaymentRequest';
      case _i62.RecurrenceInterval():
        return 'RecurrenceInterval';
      case _i63.Reminder():
        return 'Reminder';
      case _i64.UpdateCustomerRequest():
        return 'UpdateCustomerRequest';
      case _i65.UpdateInvoiceRequest():
        return 'UpdateInvoiceRequest';
      case _i66.UpdateInvoiceTemplateRequest():
        return 'UpdateInvoiceTemplateRequest';
      case _i67.UpdateRecurringScheduleRequest():
        return 'UpdateRecurringScheduleRequest';
      case _i68.VatRate():
        return 'VatRate';
      case _i69.CreateProjectRequest():
        return 'CreateProjectRequest';
      case _i70.CreateTaskRequest():
        return 'CreateTaskRequest';
      case _i71.CreateTimeEntriesInvoiceRequest():
        return 'CreateTimeEntriesInvoiceRequest';
      case _i72.CreateTimeEntryRequest():
        return 'CreateTimeEntryRequest';
      case _i73.Project():
        return 'Project';
      case _i74.ProjectStatus():
        return 'ProjectStatus';
      case _i75.StartTimerRequest():
        return 'StartTimerRequest';
      case _i76.Task():
        return 'Task';
      case _i77.TaskStatus():
        return 'TaskStatus';
      case _i78.TimeEntry():
        return 'TimeEntry';
      case _i79.TimeReport():
        return 'TimeReport';
      case _i80.TimeReportLine():
        return 'TimeReportLine';
      case _i81.UpdateProjectRequest():
        return 'UpdateProjectRequest';
      case _i82.UpdateTaskRequest():
        return 'UpdateTaskRequest';
      case _i83.UpdateTimeEntryRequest():
        return 'UpdateTimeEntryRequest';
      case _i84.AppTheme():
        return 'AppTheme';
      case _i85.UpdateUserProfileRequest():
        return 'UpdateUserProfileRequest';
      case _i86.UserProfile():
        return 'UserProfile';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'gewerber_commercial.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _i5.Protocol().getClassNameForObject(data);
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
      return deserialize<_i6.AuditEntry>(data['data']);
    }
    if (dataClassName == 'Feature') {
      return deserialize<_i7.Feature>(data['data']);
    }
    if (dataClassName == 'ConflictException') {
      return deserialize<_i8.ConflictException>(data['data']);
    }
    if (dataClassName == 'ForbiddenException') {
      return deserialize<_i9.ForbiddenException>(data['data']);
    }
    if (dataClassName == 'NotFoundException') {
      return deserialize<_i10.NotFoundException>(data['data']);
    }
    if (dataClassName == 'ValidationException') {
      return deserialize<_i11.ValidationException>(data['data']);
    }
    if (dataClassName == 'Sequence') {
      return deserialize<_i12.Sequence>(data['data']);
    }
    if (dataClassName == 'AccountingTransaction') {
      return deserialize<_i13.AccountingTransaction>(data['data']);
    }
    if (dataClassName == 'CreateTransactionRequest') {
      return deserialize<_i14.CreateTransactionRequest>(data['data']);
    }
    if (dataClassName == 'ProfitLossLine') {
      return deserialize<_i15.ProfitLossLine>(data['data']);
    }
    if (dataClassName == 'ProfitLossReport') {
      return deserialize<_i16.ProfitLossReport>(data['data']);
    }
    if (dataClassName == 'TransactionCategory') {
      return deserialize<_i17.TransactionCategory>(data['data']);
    }
    if (dataClassName == 'TransactionType') {
      return deserialize<_i18.TransactionType>(data['data']);
    }
    if (dataClassName == 'UpdateTransactionRequest') {
      return deserialize<_i19.UpdateTransactionRequest>(data['data']);
    }
    if (dataClassName == 'Address') {
      return deserialize<_i20.Address>(data['data']);
    }
    if (dataClassName == 'Business') {
      return deserialize<_i21.Business>(data['data']);
    }
    if (dataClassName == 'BusinessSettings') {
      return deserialize<_i22.BusinessSettings>(data['data']);
    }
    if (dataClassName == 'Country') {
      return deserialize<_i23.Country>(data['data']);
    }
    if (dataClassName == 'CreateBusinessRequest') {
      return deserialize<_i24.CreateBusinessRequest>(data['data']);
    }
    if (dataClassName == 'Currency') {
      return deserialize<_i25.Currency>(data['data']);
    }
    if (dataClassName == 'LegalForm') {
      return deserialize<_i26.LegalForm>(data['data']);
    }
    if (dataClassName == 'Locale') {
      return deserialize<_i27.Locale>(data['data']);
    }
    if (dataClassName == 'Membership') {
      return deserialize<_i28.Membership>(data['data']);
    }
    if (dataClassName == 'MembershipRole') {
      return deserialize<_i29.MembershipRole>(data['data']);
    }
    if (dataClassName == 'RoundingMode') {
      return deserialize<_i30.RoundingMode>(data['data']);
    }
    if (dataClassName == 'UpdateBusinessRequest') {
      return deserialize<_i31.UpdateBusinessRequest>(data['data']);
    }
    if (dataClassName == 'UpdateBusinessSettingsRequest') {
      return deserialize<_i32.UpdateBusinessSettingsRequest>(data['data']);
    }
    if (dataClassName == 'Document') {
      return deserialize<_i33.Document>(data['data']);
    }
    if (dataClassName == 'DocumentKind') {
      return deserialize<_i34.DocumentKind>(data['data']);
    }
    if (dataClassName == 'StorageLocation') {
      return deserialize<_i35.StorageLocation>(data['data']);
    }
    if (dataClassName == 'UploadDocumentRequest') {
      return deserialize<_i36.UploadDocumentRequest>(data['data']);
    }
    if (dataClassName == 'ChecklistDefinition') {
      return deserialize<_i37.ChecklistDefinition>(data['data']);
    }
    if (dataClassName == 'ChecklistItemDefinition') {
      return deserialize<_i38.ChecklistItemDefinition>(data['data']);
    }
    if (dataClassName == 'GuidanceTip') {
      return deserialize<_i39.GuidanceTip>(data['data']);
    }
    if (dataClassName == 'UserGuidanceProgress') {
      return deserialize<_i40.UserGuidanceProgress>(data['data']);
    }
    if (dataClassName == 'CreateCustomerRequest') {
      return deserialize<_i41.CreateCustomerRequest>(data['data']);
    }
    if (dataClassName == 'CreateInvoiceRequest') {
      return deserialize<_i42.CreateInvoiceRequest>(data['data']);
    }
    if (dataClassName == 'CreateInvoiceTemplateRequest') {
      return deserialize<_i43.CreateInvoiceTemplateRequest>(data['data']);
    }
    if (dataClassName == 'CreateRecurringScheduleRequest') {
      return deserialize<_i44.CreateRecurringScheduleRequest>(data['data']);
    }
    if (dataClassName == 'Customer') {
      return deserialize<_i45.Customer>(data['data']);
    }
    if (dataClassName == 'CustomerCursorPage') {
      return deserialize<_i46.CustomerCursorPage>(data['data']);
    }
    if (dataClassName == 'CustomerListPage') {
      return deserialize<_i47.CustomerListPage>(data['data']);
    }
    if (dataClassName == 'CustomerStatus') {
      return deserialize<_i48.CustomerStatus>(data['data']);
    }
    if (dataClassName == 'Invoice') {
      return deserialize<_i49.Invoice>(data['data']);
    }
    if (dataClassName == 'InvoiceCursorPage') {
      return deserialize<_i50.InvoiceCursorPage>(data['data']);
    }
    if (dataClassName == 'InvoiceItem') {
      return deserialize<_i51.InvoiceItem>(data['data']);
    }
    if (dataClassName == 'InvoiceItemRequest') {
      return deserialize<_i52.InvoiceItemRequest>(data['data']);
    }
    if (dataClassName == 'InvoiceItemUnit') {
      return deserialize<_i53.InvoiceItemUnit>(data['data']);
    }
    if (dataClassName == 'InvoiceListPage') {
      return deserialize<_i54.InvoiceListPage>(data['data']);
    }
    if (dataClassName == 'InvoicePaymentStatus') {
      return deserialize<_i55.InvoicePaymentStatus>(data['data']);
    }
    if (dataClassName == 'InvoiceStatus') {
      return deserialize<_i56.InvoiceStatus>(data['data']);
    }
    if (dataClassName == 'InvoiceTemplate') {
      return deserialize<_i57.InvoiceTemplate>(data['data']);
    }
    if (dataClassName == 'InvoiceType') {
      return deserialize<_i58.InvoiceType>(data['data']);
    }
    if (dataClassName == 'PaymentMethod') {
      return deserialize<_i59.PaymentMethod>(data['data']);
    }
    if (dataClassName == 'PaymentRecord') {
      return deserialize<_i60.PaymentRecord>(data['data']);
    }
    if (dataClassName == 'RecordPaymentRequest') {
      return deserialize<_i61.RecordPaymentRequest>(data['data']);
    }
    if (dataClassName == 'RecurrenceInterval') {
      return deserialize<_i62.RecurrenceInterval>(data['data']);
    }
    if (dataClassName == 'Reminder') {
      return deserialize<_i63.Reminder>(data['data']);
    }
    if (dataClassName == 'UpdateCustomerRequest') {
      return deserialize<_i64.UpdateCustomerRequest>(data['data']);
    }
    if (dataClassName == 'UpdateInvoiceRequest') {
      return deserialize<_i65.UpdateInvoiceRequest>(data['data']);
    }
    if (dataClassName == 'UpdateInvoiceTemplateRequest') {
      return deserialize<_i66.UpdateInvoiceTemplateRequest>(data['data']);
    }
    if (dataClassName == 'UpdateRecurringScheduleRequest') {
      return deserialize<_i67.UpdateRecurringScheduleRequest>(data['data']);
    }
    if (dataClassName == 'VatRate') {
      return deserialize<_i68.VatRate>(data['data']);
    }
    if (dataClassName == 'CreateProjectRequest') {
      return deserialize<_i69.CreateProjectRequest>(data['data']);
    }
    if (dataClassName == 'CreateTaskRequest') {
      return deserialize<_i70.CreateTaskRequest>(data['data']);
    }
    if (dataClassName == 'CreateTimeEntriesInvoiceRequest') {
      return deserialize<_i71.CreateTimeEntriesInvoiceRequest>(data['data']);
    }
    if (dataClassName == 'CreateTimeEntryRequest') {
      return deserialize<_i72.CreateTimeEntryRequest>(data['data']);
    }
    if (dataClassName == 'Project') {
      return deserialize<_i73.Project>(data['data']);
    }
    if (dataClassName == 'ProjectStatus') {
      return deserialize<_i74.ProjectStatus>(data['data']);
    }
    if (dataClassName == 'StartTimerRequest') {
      return deserialize<_i75.StartTimerRequest>(data['data']);
    }
    if (dataClassName == 'Task') {
      return deserialize<_i76.Task>(data['data']);
    }
    if (dataClassName == 'TaskStatus') {
      return deserialize<_i77.TaskStatus>(data['data']);
    }
    if (dataClassName == 'TimeEntry') {
      return deserialize<_i78.TimeEntry>(data['data']);
    }
    if (dataClassName == 'TimeReport') {
      return deserialize<_i79.TimeReport>(data['data']);
    }
    if (dataClassName == 'TimeReportLine') {
      return deserialize<_i80.TimeReportLine>(data['data']);
    }
    if (dataClassName == 'UpdateProjectRequest') {
      return deserialize<_i81.UpdateProjectRequest>(data['data']);
    }
    if (dataClassName == 'UpdateTaskRequest') {
      return deserialize<_i82.UpdateTaskRequest>(data['data']);
    }
    if (dataClassName == 'UpdateTimeEntryRequest') {
      return deserialize<_i83.UpdateTimeEntryRequest>(data['data']);
    }
    if (dataClassName == 'AppTheme') {
      return deserialize<_i84.AppTheme>(data['data']);
    }
    if (dataClassName == 'UpdateUserProfileRequest') {
      return deserialize<_i85.UpdateUserProfileRequest>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_i86.UserProfile>(data['data']);
    }
    if (dataClassName.startsWith('gewerber_commercial.')) {
      data['className'] = dataClassName.substring(20);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i4.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i5.Protocol().deserializeByClassName(data);
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
    _i5.Protocol().registerHostProtocol('gewerber_backend', this);
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
      var table = _i5.Protocol().getTableForType(t);
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
      case _i6.AuditEntry:
        return _i6.AuditEntry.t;
      case _i12.Sequence:
        return _i12.Sequence.t;
      case _i13.AccountingTransaction:
        return _i13.AccountingTransaction.t;
      case _i21.Business:
        return _i21.Business.t;
      case _i22.BusinessSettings:
        return _i22.BusinessSettings.t;
      case _i28.Membership:
        return _i28.Membership.t;
      case _i33.Document:
        return _i33.Document.t;
      case _i40.UserGuidanceProgress:
        return _i40.UserGuidanceProgress.t;
      case _i45.Customer:
        return _i45.Customer.t;
      case _i49.Invoice:
        return _i49.Invoice.t;
      case _i51.InvoiceItem:
        return _i51.InvoiceItem.t;
      case _i57.InvoiceTemplate:
        return _i57.InvoiceTemplate.t;
      case _i60.PaymentRecord:
        return _i60.PaymentRecord.t;
      case _i63.Reminder:
        return _i63.Reminder.t;
      case _i73.Project:
        return _i73.Project.t;
      case _i76.Task:
        return _i76.Task.t;
      case _i78.TimeEntry:
        return _i78.TimeEntry.t;
      case _i86.UserProfile:
        return _i86.UserProfile.t;
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
    try {
      return _i5.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
