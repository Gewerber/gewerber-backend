/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, no_leading_underscores_for_library_prefixes
// ignore_for_file: unnecessary_type_check

import 'package:gewerber_backend_commercial_server/gewerber_backend_commercial_server.dart'
    as _if53ofrw;
import 'package:gewerber_backend_server/src/generated/core/entitlement/feature.dart'
    as _ipb0z0gh;
import 'package:gewerber_backend_server/src/generated/modules/accounting/models/accounting_transaction.dart'
    as _ipjpfe96;
import 'package:gewerber_backend_server/src/generated/modules/business/models/business.dart'
    as _ipdla2qi;
import 'package:gewerber_backend_server/src/generated/modules/documents/models/document.dart'
    as _inbg4lrm;
import 'package:gewerber_backend_server/src/generated/modules/guidance/models/checklist_definition.dart'
    as _i3jq3nn0;
import 'package:gewerber_backend_server/src/generated/modules/guidance/models/guidance_tip.dart'
    as _imqtlho5;
import 'package:gewerber_backend_server/src/generated/modules/guidance/models/user_guidance_progress.dart'
    as _ivw4ui03;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/customer.dart'
    as _i120uj2v;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/invoice.dart'
    as _icjfst50;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/invoice_item.dart'
    as _i6zkktsi;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/invoice_template.dart'
    as _ier3zpp5;
import 'package:gewerber_backend_server/src/generated/modules/invoicing/models/reminder.dart'
    as _ilvs17xw;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/project.dart'
    as _ido2dfrq;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/task.dart'
    as _icr6zs8m;
import 'package:gewerber_backend_server/src/generated/modules/time_tracking/models/time_entry.dart'
    as _ict1xti5;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'core/admin/admin_role.dart' as _i409qkgd;
import 'core/admin/admin_user.dart' as _ixu4yxcv;
import 'core/audit/audit_entry.dart' as _iv98pmde;
import 'core/entitlement/feature.dart' as _i0s5j3nj;
import 'core/errors/conflict_exception.dart' as _i5epujyq;
import 'core/errors/forbidden_exception.dart' as _io9vwtrc;
import 'core/errors/not_found_exception.dart' as _ixeh2c1z;
import 'core/errors/validation_exception.dart' as _io4t73gt;
import 'core/sequence/sequence.dart' as _iwzk2tv7;
import 'modules/accounting/models/accounting_transaction.dart' as _imcpe7lh;
import 'modules/accounting/models/create_transaction_request.dart' as _ipamnsx8;
import 'modules/accounting/models/profit_loss_line.dart' as _iixw78u5;
import 'modules/accounting/models/profit_loss_report.dart' as _isurdgsv;
import 'modules/accounting/models/transaction_category.dart' as _imo6tjrw;
import 'modules/accounting/models/transaction_type.dart' as _ik9vnz0w;
import 'modules/accounting/models/update_transaction_request.dart' as _iyj5tb39;
import 'modules/admin/models/admin_audit_entry.dart' as _io6p5gfm;
import 'modules/admin/models/admin_audit_page.dart' as _iaab9k46;
import 'modules/admin/models/admin_auth_status.dart' as _ipsgq99z;
import 'modules/admin/models/admin_business_detail.dart' as _i32iaxq2;
import 'modules/admin/models/admin_business_page.dart' as _iytjl6p4;
import 'modules/admin/models/admin_invoice_page.dart' as _ia380t04;
import 'modules/admin/models/admin_membership_info.dart' as _igm2ntgz;
import 'modules/admin/models/admin_stats_overview.dart' as _ihc64acz;
import 'modules/admin/models/admin_user_dossier.dart' as _ibyotlfs;
import 'modules/admin/models/admin_user_summary.dart' as _iwdjv467;
import 'modules/admin/models/admin_user_summary_page.dart' as _i2f075pm;
import 'modules/admin/models/invoice_status_count.dart' as _ikvugyyu;
import 'modules/business/models/address.dart' as _izfx9e18;
import 'modules/business/models/business.dart' as _im9zvu8o;
import 'modules/business/models/business_settings.dart' as _ixvagzl5;
import 'modules/business/models/country.dart' as _i8xf36x2;
import 'modules/business/models/create_business_request.dart' as _i1txccp7;
import 'modules/business/models/currency.dart' as _i1srbh9z;
import 'modules/business/models/invitation.dart' as _iq0b7m5k;
import 'modules/business/models/invitation_status.dart' as _ir4590qc;
import 'modules/business/models/legal_form.dart' as _i5egs7uv;
import 'modules/business/models/locale.dart' as _ii0188h0;
import 'modules/business/models/membership.dart' as _iu72qgm4;
import 'modules/business/models/membership_role.dart' as _iv0iprnk;
import 'modules/business/models/rounding_mode.dart' as _iku7b3rb;
import 'modules/business/models/update_business_request.dart' as _inkd6ewo;
import 'modules/business/models/update_business_settings_request.dart'
    as _ii46p08a;
import 'modules/dashboard/models/dashboard_kpis.dart' as _i1j0w1sv;
import 'modules/dashboard/models/dashboard_summary.dart' as _iw3j14uv;
import 'modules/dashboard/models/debtor_summary.dart' as _ix33w5u6;
import 'modules/dashboard/models/monthly_trend_point.dart' as _ixg6nsli;
import 'modules/dashboard/models/receivables_summary.dart' as _ie3ro5gq;
import 'modules/dashboard/models/recent_time_entry.dart' as _impe7ay9;
import 'modules/documents/models/document.dart' as _i9jvbk51;
import 'modules/documents/models/document_kind.dart' as _imaz1zqg;
import 'modules/documents/models/storage_location.dart' as _i9qnixrl;
import 'modules/documents/models/upload_document_request.dart' as _iz60udpo;
import 'modules/guidance/models/checklist_definition.dart' as _i04z5hwj;
import 'modules/guidance/models/checklist_item_definition.dart' as _i5jbvijx;
import 'modules/guidance/models/guidance_tip.dart' as _irvclg1d;
import 'modules/guidance/models/guidance_tip_override.dart' as _i3qwvpcu;
import 'modules/guidance/models/user_guidance_progress.dart' as _ik05lx5a;
import 'modules/invoicing/models/create_customer_request.dart' as _i90hzmg5;
import 'modules/invoicing/models/create_invoice_request.dart' as _ia6btdit;
import 'modules/invoicing/models/create_invoice_template_request.dart'
    as _iyi9fugk;
import 'modules/invoicing/models/create_recurring_schedule_request.dart'
    as _i4j5ra9q;
import 'modules/invoicing/models/customer.dart' as _ic8wp775;
import 'modules/invoicing/models/customer_cursor_page.dart' as _if0yalhk;
import 'modules/invoicing/models/customer_list_page.dart' as _iakrzq1i;
import 'modules/invoicing/models/customer_status.dart' as _ibddqx0x;
import 'modules/invoicing/models/invoice.dart' as _imguyn55;
import 'modules/invoicing/models/invoice_cursor_page.dart' as _i2f30jh4;
import 'modules/invoicing/models/invoice_item.dart' as _iu86qxr6;
import 'modules/invoicing/models/invoice_item_request.dart' as _it1pcy1x;
import 'modules/invoicing/models/invoice_item_unit.dart' as _ik22qf7o;
import 'modules/invoicing/models/invoice_list_page.dart' as _i6mqpqud;
import 'modules/invoicing/models/invoice_payment_status.dart' as _i6e3kqsf;
import 'modules/invoicing/models/invoice_status.dart' as _i80dthru;
import 'modules/invoicing/models/invoice_template.dart' as _isaqeos4;
import 'modules/invoicing/models/invoice_type.dart' as _io5qrdfp;
import 'modules/invoicing/models/payment_method.dart' as _i31hy3jj;
import 'modules/invoicing/models/payment_record.dart' as _id8w36x8;
import 'modules/invoicing/models/record_payment_request.dart' as _i2drsvke;
import 'modules/invoicing/models/recurrence_interval.dart' as _it8iedui;
import 'modules/invoicing/models/reminder.dart' as _i0xuine3;
import 'modules/invoicing/models/update_customer_request.dart' as _icatwcwa;
import 'modules/invoicing/models/update_invoice_request.dart' as _iteadt76;
import 'modules/invoicing/models/update_invoice_template_request.dart'
    as _ilpliwg4;
import 'modules/invoicing/models/update_recurring_schedule_request.dart'
    as _i037hdza;
import 'modules/invoicing/models/vat_rate.dart' as _id7e2pr5;
import 'modules/time_tracking/models/create_project_request.dart' as _i8rbvyvx;
import 'modules/time_tracking/models/create_task_request.dart' as _iagq7u79;
import 'modules/time_tracking/models/create_time_entries_invoice_request.dart'
    as _i3b86gp3;
import 'modules/time_tracking/models/create_time_entry_request.dart'
    as _i85810i7;
import 'modules/time_tracking/models/project.dart' as _i2wiwzxn;
import 'modules/time_tracking/models/project_status.dart' as _i8h0tbjs;
import 'modules/time_tracking/models/start_timer_request.dart' as _i2ishkic;
import 'modules/time_tracking/models/task.dart' as _ihpxqi7u;
import 'modules/time_tracking/models/task_status.dart' as _iieqkj38;
import 'modules/time_tracking/models/time_entry.dart' as _ii8lft1t;
import 'modules/time_tracking/models/time_report.dart' as _ilk96oxt;
import 'modules/time_tracking/models/time_report_line.dart' as _iify20ly;
import 'modules/time_tracking/models/update_project_request.dart' as _ilqqks6d;
import 'modules/time_tracking/models/update_task_request.dart' as _i3iu7ffh;
import 'modules/time_tracking/models/update_time_entry_request.dart'
    as _iferwyg8;
import 'modules/user/models/app_theme.dart' as _iy79t9m6;
import 'modules/user/models/my_identity.dart' as _i1sqdvz3;
import 'modules/user/models/my_membership_info.dart' as _in8pujw9;
import 'modules/user/models/update_user_profile_request.dart' as _i5r0ss6k;
import 'modules/user/models/user_profile.dart' as _iung9xmp;
export 'core/admin/admin_role.dart';
export 'core/admin/admin_user.dart';
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
export 'modules/admin/models/admin_audit_entry.dart';
export 'modules/admin/models/admin_audit_page.dart';
export 'modules/admin/models/admin_auth_status.dart';
export 'modules/admin/models/admin_business_detail.dart';
export 'modules/admin/models/admin_business_page.dart';
export 'modules/admin/models/admin_invoice_page.dart';
export 'modules/admin/models/admin_membership_info.dart';
export 'modules/admin/models/admin_stats_overview.dart';
export 'modules/admin/models/admin_user_dossier.dart';
export 'modules/admin/models/admin_user_summary.dart';
export 'modules/admin/models/admin_user_summary_page.dart';
export 'modules/admin/models/invoice_status_count.dart';
export 'modules/business/models/address.dart';
export 'modules/business/models/business.dart';
export 'modules/business/models/business_settings.dart';
export 'modules/business/models/country.dart';
export 'modules/business/models/create_business_request.dart';
export 'modules/business/models/currency.dart';
export 'modules/business/models/invitation.dart';
export 'modules/business/models/invitation_status.dart';
export 'modules/business/models/legal_form.dart';
export 'modules/business/models/locale.dart';
export 'modules/business/models/membership.dart';
export 'modules/business/models/membership_role.dart';
export 'modules/business/models/rounding_mode.dart';
export 'modules/business/models/update_business_request.dart';
export 'modules/business/models/update_business_settings_request.dart';
export 'modules/dashboard/models/dashboard_kpis.dart';
export 'modules/dashboard/models/dashboard_summary.dart';
export 'modules/dashboard/models/debtor_summary.dart';
export 'modules/dashboard/models/monthly_trend_point.dart';
export 'modules/dashboard/models/receivables_summary.dart';
export 'modules/dashboard/models/recent_time_entry.dart';
export 'modules/documents/models/document.dart';
export 'modules/documents/models/document_kind.dart';
export 'modules/documents/models/storage_location.dart';
export 'modules/documents/models/upload_document_request.dart';
export 'modules/guidance/models/checklist_definition.dart';
export 'modules/guidance/models/checklist_item_definition.dart';
export 'modules/guidance/models/guidance_tip.dart';
export 'modules/guidance/models/guidance_tip_override.dart';
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
export 'modules/user/models/my_identity.dart';
export 'modules/user/models/my_membership_info.dart';
export 'modules/user/models/update_user_profile_request.dart';
export 'modules/user/models/user_profile.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'accounting_transaction',
      dartName: 'AccountingTransaction',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'businessId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'type',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TransactionType',
        ),
        _isp.ColumnDefinition(
          name: 'category',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TransactionCategory',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'occurredAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'amountCents',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'receiptDocumentId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'relatedInvoiceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'accounting_transaction_fk_0',
          columns: ['businessId'],
          referenceTable: 'business',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'accounting_transaction_fk_1',
          columns: ['receiptDocumentId'],
          referenceTable: 'document',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.setNull,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'accounting_transaction_fk_2',
          columns: ['relatedInvoiceId'],
          referenceTable: 'invoice',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'accounting_transaction_business_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'occurredAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'accounting_transaction_category_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'admin_user',
      dartName: 'AdminUser',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AdminRole',
          columnDefault: '\'moderator\'',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'createdBy',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'admin_user_user_unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'audit_entry',
      dartName: 'AuditEntry',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'businessId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'action',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'entityType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'entityId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'changes',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,String>?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'audit_entry_business_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'business',
      dartName: 'Business',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'legalForm',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:LegalForm',
          columnDefault: '\'einzelunternehmen\'',
        ),
        _isp.ColumnDefinition(
          name: 'isKleinunternehmer',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'vatId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'taxNumber',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'email',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'phone',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'address',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:Address?',
        ),
        _isp.ColumnDefinition(
          name: 'locale',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Locale',
          columnDefault: '\'de\'',
        ),
        _isp.ColumnDefinition(
          name: 'currency',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Currency',
          columnDefault: '\'eur\'',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'business_settings',
      dartName: 'BusinessSettings',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'businessId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'paymentTermsDays',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '14',
        ),
        _isp.ColumnDefinition(
          name: 'invoiceNumberPrefix',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'invoiceNumberIncludeYear',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'invoiceNumberMinDigits',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '4',
        ),
        _isp.ColumnDefinition(
          name: 'roundingMode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:RoundingMode',
          columnDefault: '\'none\'',
        ),
        _isp.ColumnDefinition(
          name: 'roundingGranularityMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'business_settings_fk_0',
          columns: ['businessId'],
          referenceTable: 'business',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'business_settings_business_unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'customer',
      dartName: 'Customer',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'businessId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:CustomerStatus',
          columnDefault: '\'active\'',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'companyName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'vatId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'email',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'phone',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'address',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:Address?',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'customer_fk_0',
          columns: ['businessId'],
          referenceTable: 'business',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'customer_business_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'document',
      dartName: 'Document',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'businessId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'kind',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DocumentKind',
          columnDefault: '\'attachment\'',
        ),
        _isp.ColumnDefinition(
          name: 'fileName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'mimeType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'sizeBytes',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'storageLocation',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:StorageLocation',
          columnDefault: '\'private\'',
        ),
        _isp.ColumnDefinition(
          name: 'storagePath',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'relatedEntityType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'relatedEntityId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'uploadedById',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'document_fk_0',
          columns: ['businessId'],
          referenceTable: 'business',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'document_business_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'guidance_tip_override',
      dartName: 'GuidanceTipOverride',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'topic',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'body',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'guidance_tip_override_topic_unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'topic',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'invitation',
      dartName: 'Invitation',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'businessId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'email',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MembershipRole',
          columnDefault: '\'member\'',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:InvitationStatus',
          columnDefault: '\'pending\'',
        ),
        _isp.ColumnDefinition(
          name: 'invitedByUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'tokenHash',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'expiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'acceptedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'invitation_fk_0',
          columns: ['businessId'],
          referenceTable: 'business',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'invitation_business_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'invitation_business_email_unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'email',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'invitation_token_hash_unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'tokenHash',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'invoice',
      dartName: 'Invoice',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'businessId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'number',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'type',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:InvoiceType',
          columnDefault: '\'invoice\'',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:InvoiceStatus',
          columnDefault: '\'draft\'',
        ),
        _isp.ColumnDefinition(
          name: 'customerId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'issueDate',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'dueDate',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'serviceDateFrom',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'serviceDateTo',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'locale',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Locale',
          columnDefault: '\'de\'',
        ),
        _isp.ColumnDefinition(
          name: 'currency',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Currency',
          columnDefault: '\'eur\'',
        ),
        _isp.ColumnDefinition(
          name: 'subtotalCents',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'vatTotalCents',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'totalCents',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'paymentTermsDays',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '14',
        ),
        _isp.ColumnDefinition(
          name: 'dunningLevel',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'templateId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'pdfDocumentId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'recurrenceInterval',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:RecurrenceInterval?',
        ),
        _isp.ColumnDefinition(
          name: 'nextRecurrenceDate',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'recurrenceEndDate',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'recurrenceMaxOccurrences',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'recurrenceOccurrencesCreated',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'invoice_fk_0',
          columns: ['businessId'],
          referenceTable: 'business',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'invoice_fk_1',
          columns: ['customerId'],
          referenceTable: 'customer',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.setNull,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'invoice_fk_2',
          columns: ['templateId'],
          referenceTable: 'invoice_template',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.setNull,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'invoice_fk_3',
          columns: ['pdfDocumentId'],
          referenceTable: 'document',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'invoice_business_number_unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'number',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'invoice_business_issue_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'issueDate',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'invoice_customer_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'customerId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'invoice_recurrence_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'nextRecurrenceDate',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'invoice_business_status_due_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'invoice_item',
      dartName: 'InvoiceItem',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'invoiceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'position',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'quantity',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
          columnDefault: '1',
        ),
        _isp.ColumnDefinition(
          name: 'unit',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:InvoiceItemUnit',
          columnDefault: '\'hour\'',
        ),
        _isp.ColumnDefinition(
          name: 'unitPriceCents',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'vatRate',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:VatRate',
          columnDefault: '\'standard\'',
        ),
        _isp.ColumnDefinition(
          name: 'lineTotalCents',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'invoice_item_fk_0',
          columns: ['invoiceId'],
          referenceTable: 'invoice',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'invoice_item_invoice_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'invoiceId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'invoice_template',
      dartName: 'InvoiceTemplate',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'businessId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'isDefault',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'headerText',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'footerText',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'logoDocumentId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'invoice_template_fk_0',
          columns: ['businessId'],
          referenceTable: 'business',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'invoice_template_fk_1',
          columns: ['logoDocumentId'],
          referenceTable: 'document',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'invoice_template_business_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'membership',
      dartName: 'Membership',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'businessId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MembershipRole',
          columnDefault: '\'member\'',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'membership_fk_0',
          columns: ['businessId'],
          referenceTable: 'business',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'membership_user_business_unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'membership_business_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'number_sequence',
      dartName: 'Sequence',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'businessId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'key',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'year',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'lastValue',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'number_sequence_fk_0',
          columns: ['businessId'],
          referenceTable: 'business',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'number_sequence_business_key_year_unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'key',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'payment_record',
      dartName: 'PaymentRecord',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'invoiceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'paidAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'amountCents',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'method',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:PaymentMethod',
          columnDefault: '\'bankTransfer\'',
        ),
        _isp.ColumnDefinition(
          name: 'reference',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'payment_record_fk_0',
          columns: ['invoiceId'],
          referenceTable: 'invoice',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'payment_record_invoice_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'project',
      dartName: 'Project',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'businessId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ProjectStatus',
          columnDefault: '\'active\'',
        ),
        _isp.ColumnDefinition(
          name: 'customerId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'hourlyRateCents',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'project_fk_0',
          columns: ['businessId'],
          referenceTable: 'business',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'project_fk_1',
          columns: ['customerId'],
          referenceTable: 'customer',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'project_business_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'reminder',
      dartName: 'Reminder',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'invoiceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'level',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'sent',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'sentAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'reminder_fk_0',
          columns: ['invoiceId'],
          referenceTable: 'invoice',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'reminder_invoice_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'task',
      dartName: 'Task',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'businessId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'projectId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TaskStatus',
          columnDefault: '\'open\'',
        ),
        _isp.ColumnDefinition(
          name: 'hourlyRateCents',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'task_fk_0',
          columns: ['businessId'],
          referenceTable: 'business',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'task_fk_1',
          columns: ['projectId'],
          referenceTable: 'project',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'task_business_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'task_project_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'time_entry',
      dartName: 'TimeEntry',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'businessId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'projectId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'taskId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'startedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'stoppedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'durationMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'billable',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'invoicedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'time_entry_fk_0',
          columns: ['businessId'],
          referenceTable: 'business',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'time_entry_fk_1',
          columns: ['projectId'],
          referenceTable: 'project',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.setNull,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'time_entry_fk_2',
          columns: ['taskId'],
          referenceTable: 'task',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'time_entry_business_started_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'startedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'time_entry_project_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'projectId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'time_entry_task_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'taskId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'time_entry_business_running_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'businessId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'user_guidance_progress',
      dartName: 'UserGuidanceProgress',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'itemKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'completedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'dismissedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'user_guidance_progress_unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'user_profile',
      dartName: 'UserProfile',
      schema: 'public',
      module: 'gewerber_backend',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'displayName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'locale',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Locale',
          columnDefault: '\'de\'',
        ),
        _isp.ColumnDefinition(
          name: 'timeZone',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'themeMode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AppTheme',
          columnDefault: '\'system\'',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'deletedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'user_profile_user_unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    ..._if53ofrw.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._iais.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
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

    if (t == _i409qkgd.AdminRole) {
      return _i409qkgd.AdminRole.fromJson(data) as T;
    }
    if (t == _ixu4yxcv.AdminUser) {
      return _ixu4yxcv.AdminUser.fromJson(data) as T;
    }
    if (t == _iv98pmde.AuditEntry) {
      return _iv98pmde.AuditEntry.fromJson(data) as T;
    }
    if (t == _i0s5j3nj.Feature) {
      return _i0s5j3nj.Feature.fromJson(data) as T;
    }
    if (t == _i5epujyq.ConflictException) {
      return _i5epujyq.ConflictException.fromJson(data) as T;
    }
    if (t == _io9vwtrc.ForbiddenException) {
      return _io9vwtrc.ForbiddenException.fromJson(data) as T;
    }
    if (t == _ixeh2c1z.NotFoundException) {
      return _ixeh2c1z.NotFoundException.fromJson(data) as T;
    }
    if (t == _io4t73gt.ValidationException) {
      return _io4t73gt.ValidationException.fromJson(data) as T;
    }
    if (t == _iwzk2tv7.Sequence) {
      return _iwzk2tv7.Sequence.fromJson(data) as T;
    }
    if (t == _imcpe7lh.AccountingTransaction) {
      return _imcpe7lh.AccountingTransaction.fromJson(data) as T;
    }
    if (t == _ipamnsx8.CreateTransactionRequest) {
      return _ipamnsx8.CreateTransactionRequest.fromJson(data) as T;
    }
    if (t == _iixw78u5.ProfitLossLine) {
      return _iixw78u5.ProfitLossLine.fromJson(data) as T;
    }
    if (t == _isurdgsv.ProfitLossReport) {
      return _isurdgsv.ProfitLossReport.fromJson(data) as T;
    }
    if (t == _imo6tjrw.TransactionCategory) {
      return _imo6tjrw.TransactionCategory.fromJson(data) as T;
    }
    if (t == _ik9vnz0w.TransactionType) {
      return _ik9vnz0w.TransactionType.fromJson(data) as T;
    }
    if (t == _iyj5tb39.UpdateTransactionRequest) {
      return _iyj5tb39.UpdateTransactionRequest.fromJson(data) as T;
    }
    if (t == _io6p5gfm.AdminAuditEntry) {
      return _io6p5gfm.AdminAuditEntry.fromJson(data) as T;
    }
    if (t == _iaab9k46.AdminAuditPage) {
      return _iaab9k46.AdminAuditPage.fromJson(data) as T;
    }
    if (t == _ipsgq99z.AdminAuthStatus) {
      return _ipsgq99z.AdminAuthStatus.fromJson(data) as T;
    }
    if (t == _i32iaxq2.AdminBusinessDetail) {
      return _i32iaxq2.AdminBusinessDetail.fromJson(data) as T;
    }
    if (t == _iytjl6p4.AdminBusinessPage) {
      return _iytjl6p4.AdminBusinessPage.fromJson(data) as T;
    }
    if (t == _ia380t04.AdminInvoicePage) {
      return _ia380t04.AdminInvoicePage.fromJson(data) as T;
    }
    if (t == _igm2ntgz.AdminMembershipInfo) {
      return _igm2ntgz.AdminMembershipInfo.fromJson(data) as T;
    }
    if (t == _ihc64acz.AdminStatsOverview) {
      return _ihc64acz.AdminStatsOverview.fromJson(data) as T;
    }
    if (t == _ibyotlfs.AdminUserDossier) {
      return _ibyotlfs.AdminUserDossier.fromJson(data) as T;
    }
    if (t == _iwdjv467.AdminUserSummary) {
      return _iwdjv467.AdminUserSummary.fromJson(data) as T;
    }
    if (t == _i2f075pm.AdminUserSummaryPage) {
      return _i2f075pm.AdminUserSummaryPage.fromJson(data) as T;
    }
    if (t == _ikvugyyu.InvoiceStatusCount) {
      return _ikvugyyu.InvoiceStatusCount.fromJson(data) as T;
    }
    if (t == _izfx9e18.Address) {
      return _izfx9e18.Address.fromJson(data) as T;
    }
    if (t == _im9zvu8o.Business) {
      return _im9zvu8o.Business.fromJson(data) as T;
    }
    if (t == _ixvagzl5.BusinessSettings) {
      return _ixvagzl5.BusinessSettings.fromJson(data) as T;
    }
    if (t == _i8xf36x2.Country) {
      return _i8xf36x2.Country.fromJson(data) as T;
    }
    if (t == _i1txccp7.CreateBusinessRequest) {
      return _i1txccp7.CreateBusinessRequest.fromJson(data) as T;
    }
    if (t == _i1srbh9z.Currency) {
      return _i1srbh9z.Currency.fromJson(data) as T;
    }
    if (t == _iq0b7m5k.Invitation) {
      return _iq0b7m5k.Invitation.fromJson(data) as T;
    }
    if (t == _ir4590qc.InvitationStatus) {
      return _ir4590qc.InvitationStatus.fromJson(data) as T;
    }
    if (t == _i5egs7uv.LegalForm) {
      return _i5egs7uv.LegalForm.fromJson(data) as T;
    }
    if (t == _ii0188h0.Locale) {
      return _ii0188h0.Locale.fromJson(data) as T;
    }
    if (t == _iu72qgm4.Membership) {
      return _iu72qgm4.Membership.fromJson(data) as T;
    }
    if (t == _iv0iprnk.MembershipRole) {
      return _iv0iprnk.MembershipRole.fromJson(data) as T;
    }
    if (t == _iku7b3rb.RoundingMode) {
      return _iku7b3rb.RoundingMode.fromJson(data) as T;
    }
    if (t == _inkd6ewo.UpdateBusinessRequest) {
      return _inkd6ewo.UpdateBusinessRequest.fromJson(data) as T;
    }
    if (t == _ii46p08a.UpdateBusinessSettingsRequest) {
      return _ii46p08a.UpdateBusinessSettingsRequest.fromJson(data) as T;
    }
    if (t == _i1j0w1sv.DashboardKpis) {
      return _i1j0w1sv.DashboardKpis.fromJson(data) as T;
    }
    if (t == _iw3j14uv.DashboardSummary) {
      return _iw3j14uv.DashboardSummary.fromJson(data) as T;
    }
    if (t == _ix33w5u6.DebtorSummary) {
      return _ix33w5u6.DebtorSummary.fromJson(data) as T;
    }
    if (t == _ixg6nsli.MonthlyTrendPoint) {
      return _ixg6nsli.MonthlyTrendPoint.fromJson(data) as T;
    }
    if (t == _ie3ro5gq.ReceivablesSummary) {
      return _ie3ro5gq.ReceivablesSummary.fromJson(data) as T;
    }
    if (t == _impe7ay9.RecentTimeEntry) {
      return _impe7ay9.RecentTimeEntry.fromJson(data) as T;
    }
    if (t == _i9jvbk51.Document) {
      return _i9jvbk51.Document.fromJson(data) as T;
    }
    if (t == _imaz1zqg.DocumentKind) {
      return _imaz1zqg.DocumentKind.fromJson(data) as T;
    }
    if (t == _i9qnixrl.StorageLocation) {
      return _i9qnixrl.StorageLocation.fromJson(data) as T;
    }
    if (t == _iz60udpo.UploadDocumentRequest) {
      return _iz60udpo.UploadDocumentRequest.fromJson(data) as T;
    }
    if (t == _i04z5hwj.ChecklistDefinition) {
      return _i04z5hwj.ChecklistDefinition.fromJson(data) as T;
    }
    if (t == _i5jbvijx.ChecklistItemDefinition) {
      return _i5jbvijx.ChecklistItemDefinition.fromJson(data) as T;
    }
    if (t == _irvclg1d.GuidanceTip) {
      return _irvclg1d.GuidanceTip.fromJson(data) as T;
    }
    if (t == _i3qwvpcu.GuidanceTipOverride) {
      return _i3qwvpcu.GuidanceTipOverride.fromJson(data) as T;
    }
    if (t == _ik05lx5a.UserGuidanceProgress) {
      return _ik05lx5a.UserGuidanceProgress.fromJson(data) as T;
    }
    if (t == _i90hzmg5.CreateCustomerRequest) {
      return _i90hzmg5.CreateCustomerRequest.fromJson(data) as T;
    }
    if (t == _ia6btdit.CreateInvoiceRequest) {
      return _ia6btdit.CreateInvoiceRequest.fromJson(data) as T;
    }
    if (t == _iyi9fugk.CreateInvoiceTemplateRequest) {
      return _iyi9fugk.CreateInvoiceTemplateRequest.fromJson(data) as T;
    }
    if (t == _i4j5ra9q.CreateRecurringScheduleRequest) {
      return _i4j5ra9q.CreateRecurringScheduleRequest.fromJson(data) as T;
    }
    if (t == _ic8wp775.Customer) {
      return _ic8wp775.Customer.fromJson(data) as T;
    }
    if (t == _if0yalhk.CustomerCursorPage) {
      return _if0yalhk.CustomerCursorPage.fromJson(data) as T;
    }
    if (t == _iakrzq1i.CustomerListPage) {
      return _iakrzq1i.CustomerListPage.fromJson(data) as T;
    }
    if (t == _ibddqx0x.CustomerStatus) {
      return _ibddqx0x.CustomerStatus.fromJson(data) as T;
    }
    if (t == _imguyn55.Invoice) {
      return _imguyn55.Invoice.fromJson(data) as T;
    }
    if (t == _i2f30jh4.InvoiceCursorPage) {
      return _i2f30jh4.InvoiceCursorPage.fromJson(data) as T;
    }
    if (t == _iu86qxr6.InvoiceItem) {
      return _iu86qxr6.InvoiceItem.fromJson(data) as T;
    }
    if (t == _it1pcy1x.InvoiceItemRequest) {
      return _it1pcy1x.InvoiceItemRequest.fromJson(data) as T;
    }
    if (t == _ik22qf7o.InvoiceItemUnit) {
      return _ik22qf7o.InvoiceItemUnit.fromJson(data) as T;
    }
    if (t == _i6mqpqud.InvoiceListPage) {
      return _i6mqpqud.InvoiceListPage.fromJson(data) as T;
    }
    if (t == _i6e3kqsf.InvoicePaymentStatus) {
      return _i6e3kqsf.InvoicePaymentStatus.fromJson(data) as T;
    }
    if (t == _i80dthru.InvoiceStatus) {
      return _i80dthru.InvoiceStatus.fromJson(data) as T;
    }
    if (t == _isaqeos4.InvoiceTemplate) {
      return _isaqeos4.InvoiceTemplate.fromJson(data) as T;
    }
    if (t == _io5qrdfp.InvoiceType) {
      return _io5qrdfp.InvoiceType.fromJson(data) as T;
    }
    if (t == _i31hy3jj.PaymentMethod) {
      return _i31hy3jj.PaymentMethod.fromJson(data) as T;
    }
    if (t == _id8w36x8.PaymentRecord) {
      return _id8w36x8.PaymentRecord.fromJson(data) as T;
    }
    if (t == _i2drsvke.RecordPaymentRequest) {
      return _i2drsvke.RecordPaymentRequest.fromJson(data) as T;
    }
    if (t == _it8iedui.RecurrenceInterval) {
      return _it8iedui.RecurrenceInterval.fromJson(data) as T;
    }
    if (t == _i0xuine3.Reminder) {
      return _i0xuine3.Reminder.fromJson(data) as T;
    }
    if (t == _icatwcwa.UpdateCustomerRequest) {
      return _icatwcwa.UpdateCustomerRequest.fromJson(data) as T;
    }
    if (t == _iteadt76.UpdateInvoiceRequest) {
      return _iteadt76.UpdateInvoiceRequest.fromJson(data) as T;
    }
    if (t == _ilpliwg4.UpdateInvoiceTemplateRequest) {
      return _ilpliwg4.UpdateInvoiceTemplateRequest.fromJson(data) as T;
    }
    if (t == _i037hdza.UpdateRecurringScheduleRequest) {
      return _i037hdza.UpdateRecurringScheduleRequest.fromJson(data) as T;
    }
    if (t == _id7e2pr5.VatRate) {
      return _id7e2pr5.VatRate.fromJson(data) as T;
    }
    if (t == _i8rbvyvx.CreateProjectRequest) {
      return _i8rbvyvx.CreateProjectRequest.fromJson(data) as T;
    }
    if (t == _iagq7u79.CreateTaskRequest) {
      return _iagq7u79.CreateTaskRequest.fromJson(data) as T;
    }
    if (t == _i3b86gp3.CreateTimeEntriesInvoiceRequest) {
      return _i3b86gp3.CreateTimeEntriesInvoiceRequest.fromJson(data) as T;
    }
    if (t == _i85810i7.CreateTimeEntryRequest) {
      return _i85810i7.CreateTimeEntryRequest.fromJson(data) as T;
    }
    if (t == _i2wiwzxn.Project) {
      return _i2wiwzxn.Project.fromJson(data) as T;
    }
    if (t == _i8h0tbjs.ProjectStatus) {
      return _i8h0tbjs.ProjectStatus.fromJson(data) as T;
    }
    if (t == _i2ishkic.StartTimerRequest) {
      return _i2ishkic.StartTimerRequest.fromJson(data) as T;
    }
    if (t == _ihpxqi7u.Task) {
      return _ihpxqi7u.Task.fromJson(data) as T;
    }
    if (t == _iieqkj38.TaskStatus) {
      return _iieqkj38.TaskStatus.fromJson(data) as T;
    }
    if (t == _ii8lft1t.TimeEntry) {
      return _ii8lft1t.TimeEntry.fromJson(data) as T;
    }
    if (t == _ilk96oxt.TimeReport) {
      return _ilk96oxt.TimeReport.fromJson(data) as T;
    }
    if (t == _iify20ly.TimeReportLine) {
      return _iify20ly.TimeReportLine.fromJson(data) as T;
    }
    if (t == _ilqqks6d.UpdateProjectRequest) {
      return _ilqqks6d.UpdateProjectRequest.fromJson(data) as T;
    }
    if (t == _i3iu7ffh.UpdateTaskRequest) {
      return _i3iu7ffh.UpdateTaskRequest.fromJson(data) as T;
    }
    if (t == _iferwyg8.UpdateTimeEntryRequest) {
      return _iferwyg8.UpdateTimeEntryRequest.fromJson(data) as T;
    }
    if (t == _iy79t9m6.AppTheme) {
      return _iy79t9m6.AppTheme.fromJson(data) as T;
    }
    if (t == _i1sqdvz3.MyIdentity) {
      return _i1sqdvz3.MyIdentity.fromJson(data) as T;
    }
    if (t == _in8pujw9.MyMembershipInfo) {
      return _in8pujw9.MyMembershipInfo.fromJson(data) as T;
    }
    if (t == _i5r0ss6k.UpdateUserProfileRequest) {
      return _i5r0ss6k.UpdateUserProfileRequest.fromJson(data) as T;
    }
    if (t == _iung9xmp.UserProfile) {
      return _iung9xmp.UserProfile.fromJson(data) as T;
    }
    if (t == _is.getType<_i409qkgd.AdminRole?>()) {
      return (data != null ? _i409qkgd.AdminRole.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ixu4yxcv.AdminUser?>()) {
      return (data != null ? _ixu4yxcv.AdminUser.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iv98pmde.AuditEntry?>()) {
      return (data != null ? _iv98pmde.AuditEntry.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i0s5j3nj.Feature?>()) {
      return (data != null ? _i0s5j3nj.Feature.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i5epujyq.ConflictException?>()) {
      return (data != null ? _i5epujyq.ConflictException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_io9vwtrc.ForbiddenException?>()) {
      return (data != null ? _io9vwtrc.ForbiddenException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ixeh2c1z.NotFoundException?>()) {
      return (data != null ? _ixeh2c1z.NotFoundException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_io4t73gt.ValidationException?>()) {
      return (data != null
              ? _io4t73gt.ValidationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iwzk2tv7.Sequence?>()) {
      return (data != null ? _iwzk2tv7.Sequence.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_imcpe7lh.AccountingTransaction?>()) {
      return (data != null
              ? _imcpe7lh.AccountingTransaction.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ipamnsx8.CreateTransactionRequest?>()) {
      return (data != null
              ? _ipamnsx8.CreateTransactionRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iixw78u5.ProfitLossLine?>()) {
      return (data != null ? _iixw78u5.ProfitLossLine.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_isurdgsv.ProfitLossReport?>()) {
      return (data != null ? _isurdgsv.ProfitLossReport.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_imo6tjrw.TransactionCategory?>()) {
      return (data != null
              ? _imo6tjrw.TransactionCategory.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ik9vnz0w.TransactionType?>()) {
      return (data != null ? _ik9vnz0w.TransactionType.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iyj5tb39.UpdateTransactionRequest?>()) {
      return (data != null
              ? _iyj5tb39.UpdateTransactionRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_io6p5gfm.AdminAuditEntry?>()) {
      return (data != null ? _io6p5gfm.AdminAuditEntry.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iaab9k46.AdminAuditPage?>()) {
      return (data != null ? _iaab9k46.AdminAuditPage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ipsgq99z.AdminAuthStatus?>()) {
      return (data != null ? _ipsgq99z.AdminAuthStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i32iaxq2.AdminBusinessDetail?>()) {
      return (data != null
              ? _i32iaxq2.AdminBusinessDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iytjl6p4.AdminBusinessPage?>()) {
      return (data != null ? _iytjl6p4.AdminBusinessPage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ia380t04.AdminInvoicePage?>()) {
      return (data != null ? _ia380t04.AdminInvoicePage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_igm2ntgz.AdminMembershipInfo?>()) {
      return (data != null
              ? _igm2ntgz.AdminMembershipInfo.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ihc64acz.AdminStatsOverview?>()) {
      return (data != null ? _ihc64acz.AdminStatsOverview.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ibyotlfs.AdminUserDossier?>()) {
      return (data != null ? _ibyotlfs.AdminUserDossier.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iwdjv467.AdminUserSummary?>()) {
      return (data != null ? _iwdjv467.AdminUserSummary.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i2f075pm.AdminUserSummaryPage?>()) {
      return (data != null
              ? _i2f075pm.AdminUserSummaryPage.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ikvugyyu.InvoiceStatusCount?>()) {
      return (data != null ? _ikvugyyu.InvoiceStatusCount.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_izfx9e18.Address?>()) {
      return (data != null ? _izfx9e18.Address.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_im9zvu8o.Business?>()) {
      return (data != null ? _im9zvu8o.Business.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ixvagzl5.BusinessSettings?>()) {
      return (data != null ? _ixvagzl5.BusinessSettings.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i8xf36x2.Country?>()) {
      return (data != null ? _i8xf36x2.Country.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i1txccp7.CreateBusinessRequest?>()) {
      return (data != null
              ? _i1txccp7.CreateBusinessRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i1srbh9z.Currency?>()) {
      return (data != null ? _i1srbh9z.Currency.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iq0b7m5k.Invitation?>()) {
      return (data != null ? _iq0b7m5k.Invitation.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ir4590qc.InvitationStatus?>()) {
      return (data != null ? _ir4590qc.InvitationStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i5egs7uv.LegalForm?>()) {
      return (data != null ? _i5egs7uv.LegalForm.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ii0188h0.Locale?>()) {
      return (data != null ? _ii0188h0.Locale.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iu72qgm4.Membership?>()) {
      return (data != null ? _iu72qgm4.Membership.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iv0iprnk.MembershipRole?>()) {
      return (data != null ? _iv0iprnk.MembershipRole.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iku7b3rb.RoundingMode?>()) {
      return (data != null ? _iku7b3rb.RoundingMode.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_inkd6ewo.UpdateBusinessRequest?>()) {
      return (data != null
              ? _inkd6ewo.UpdateBusinessRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ii46p08a.UpdateBusinessSettingsRequest?>()) {
      return (data != null
              ? _ii46p08a.UpdateBusinessSettingsRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i1j0w1sv.DashboardKpis?>()) {
      return (data != null ? _i1j0w1sv.DashboardKpis.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iw3j14uv.DashboardSummary?>()) {
      return (data != null ? _iw3j14uv.DashboardSummary.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ix33w5u6.DebtorSummary?>()) {
      return (data != null ? _ix33w5u6.DebtorSummary.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ixg6nsli.MonthlyTrendPoint?>()) {
      return (data != null ? _ixg6nsli.MonthlyTrendPoint.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ie3ro5gq.ReceivablesSummary?>()) {
      return (data != null ? _ie3ro5gq.ReceivablesSummary.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_impe7ay9.RecentTimeEntry?>()) {
      return (data != null ? _impe7ay9.RecentTimeEntry.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i9jvbk51.Document?>()) {
      return (data != null ? _i9jvbk51.Document.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_imaz1zqg.DocumentKind?>()) {
      return (data != null ? _imaz1zqg.DocumentKind.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i9qnixrl.StorageLocation?>()) {
      return (data != null ? _i9qnixrl.StorageLocation.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iz60udpo.UploadDocumentRequest?>()) {
      return (data != null
              ? _iz60udpo.UploadDocumentRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i04z5hwj.ChecklistDefinition?>()) {
      return (data != null
              ? _i04z5hwj.ChecklistDefinition.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i5jbvijx.ChecklistItemDefinition?>()) {
      return (data != null
              ? _i5jbvijx.ChecklistItemDefinition.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_irvclg1d.GuidanceTip?>()) {
      return (data != null ? _irvclg1d.GuidanceTip.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i3qwvpcu.GuidanceTipOverride?>()) {
      return (data != null
              ? _i3qwvpcu.GuidanceTipOverride.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ik05lx5a.UserGuidanceProgress?>()) {
      return (data != null
              ? _ik05lx5a.UserGuidanceProgress.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i90hzmg5.CreateCustomerRequest?>()) {
      return (data != null
              ? _i90hzmg5.CreateCustomerRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ia6btdit.CreateInvoiceRequest?>()) {
      return (data != null
              ? _ia6btdit.CreateInvoiceRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iyi9fugk.CreateInvoiceTemplateRequest?>()) {
      return (data != null
              ? _iyi9fugk.CreateInvoiceTemplateRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i4j5ra9q.CreateRecurringScheduleRequest?>()) {
      return (data != null
              ? _i4j5ra9q.CreateRecurringScheduleRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ic8wp775.Customer?>()) {
      return (data != null ? _ic8wp775.Customer.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_if0yalhk.CustomerCursorPage?>()) {
      return (data != null ? _if0yalhk.CustomerCursorPage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iakrzq1i.CustomerListPage?>()) {
      return (data != null ? _iakrzq1i.CustomerListPage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ibddqx0x.CustomerStatus?>()) {
      return (data != null ? _ibddqx0x.CustomerStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_imguyn55.Invoice?>()) {
      return (data != null ? _imguyn55.Invoice.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i2f30jh4.InvoiceCursorPage?>()) {
      return (data != null ? _i2f30jh4.InvoiceCursorPage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iu86qxr6.InvoiceItem?>()) {
      return (data != null ? _iu86qxr6.InvoiceItem.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_it1pcy1x.InvoiceItemRequest?>()) {
      return (data != null ? _it1pcy1x.InvoiceItemRequest.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ik22qf7o.InvoiceItemUnit?>()) {
      return (data != null ? _ik22qf7o.InvoiceItemUnit.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i6mqpqud.InvoiceListPage?>()) {
      return (data != null ? _i6mqpqud.InvoiceListPage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i6e3kqsf.InvoicePaymentStatus?>()) {
      return (data != null
              ? _i6e3kqsf.InvoicePaymentStatus.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i80dthru.InvoiceStatus?>()) {
      return (data != null ? _i80dthru.InvoiceStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_isaqeos4.InvoiceTemplate?>()) {
      return (data != null ? _isaqeos4.InvoiceTemplate.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_io5qrdfp.InvoiceType?>()) {
      return (data != null ? _io5qrdfp.InvoiceType.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i31hy3jj.PaymentMethod?>()) {
      return (data != null ? _i31hy3jj.PaymentMethod.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_id8w36x8.PaymentRecord?>()) {
      return (data != null ? _id8w36x8.PaymentRecord.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i2drsvke.RecordPaymentRequest?>()) {
      return (data != null
              ? _i2drsvke.RecordPaymentRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_it8iedui.RecurrenceInterval?>()) {
      return (data != null ? _it8iedui.RecurrenceInterval.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i0xuine3.Reminder?>()) {
      return (data != null ? _i0xuine3.Reminder.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_icatwcwa.UpdateCustomerRequest?>()) {
      return (data != null
              ? _icatwcwa.UpdateCustomerRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iteadt76.UpdateInvoiceRequest?>()) {
      return (data != null
              ? _iteadt76.UpdateInvoiceRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ilpliwg4.UpdateInvoiceTemplateRequest?>()) {
      return (data != null
              ? _ilpliwg4.UpdateInvoiceTemplateRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i037hdza.UpdateRecurringScheduleRequest?>()) {
      return (data != null
              ? _i037hdza.UpdateRecurringScheduleRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_id7e2pr5.VatRate?>()) {
      return (data != null ? _id7e2pr5.VatRate.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i8rbvyvx.CreateProjectRequest?>()) {
      return (data != null
              ? _i8rbvyvx.CreateProjectRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iagq7u79.CreateTaskRequest?>()) {
      return (data != null ? _iagq7u79.CreateTaskRequest.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i3b86gp3.CreateTimeEntriesInvoiceRequest?>()) {
      return (data != null
              ? _i3b86gp3.CreateTimeEntriesInvoiceRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i85810i7.CreateTimeEntryRequest?>()) {
      return (data != null
              ? _i85810i7.CreateTimeEntryRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i2wiwzxn.Project?>()) {
      return (data != null ? _i2wiwzxn.Project.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i8h0tbjs.ProjectStatus?>()) {
      return (data != null ? _i8h0tbjs.ProjectStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i2ishkic.StartTimerRequest?>()) {
      return (data != null ? _i2ishkic.StartTimerRequest.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ihpxqi7u.Task?>()) {
      return (data != null ? _ihpxqi7u.Task.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iieqkj38.TaskStatus?>()) {
      return (data != null ? _iieqkj38.TaskStatus.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ii8lft1t.TimeEntry?>()) {
      return (data != null ? _ii8lft1t.TimeEntry.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ilk96oxt.TimeReport?>()) {
      return (data != null ? _ilk96oxt.TimeReport.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iify20ly.TimeReportLine?>()) {
      return (data != null ? _iify20ly.TimeReportLine.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ilqqks6d.UpdateProjectRequest?>()) {
      return (data != null
              ? _ilqqks6d.UpdateProjectRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i3iu7ffh.UpdateTaskRequest?>()) {
      return (data != null ? _i3iu7ffh.UpdateTaskRequest.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iferwyg8.UpdateTimeEntryRequest?>()) {
      return (data != null
              ? _iferwyg8.UpdateTimeEntryRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iy79t9m6.AppTheme?>()) {
      return (data != null ? _iy79t9m6.AppTheme.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i1sqdvz3.MyIdentity?>()) {
      return (data != null ? _i1sqdvz3.MyIdentity.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_in8pujw9.MyMembershipInfo?>()) {
      return (data != null ? _in8pujw9.MyMembershipInfo.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i5r0ss6k.UpdateUserProfileRequest?>()) {
      return (data != null
              ? _i5r0ss6k.UpdateUserProfileRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iung9xmp.UserProfile?>()) {
      return (data != null ? _iung9xmp.UserProfile.fromJson(data) : null) as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == _is.getType<Map<String, String>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<String>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_iixw78u5.ProfitLossLine>) {
      return (data as List)
              .map((e) => deserialize<_iixw78u5.ProfitLossLine>(e))
              .toList()
          as T;
    }
    if (t == List<_io6p5gfm.AdminAuditEntry>) {
      return (data as List)
              .map((e) => deserialize<_io6p5gfm.AdminAuditEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_igm2ntgz.AdminMembershipInfo>) {
      return (data as List)
              .map((e) => deserialize<_igm2ntgz.AdminMembershipInfo>(e))
              .toList()
          as T;
    }
    if (t == List<_im9zvu8o.Business>) {
      return (data as List)
              .map((e) => deserialize<_im9zvu8o.Business>(e))
              .toList()
          as T;
    }
    if (t == List<_imguyn55.Invoice>) {
      return (data as List)
              .map((e) => deserialize<_imguyn55.Invoice>(e))
              .toList()
          as T;
    }
    if (t == List<_ikvugyyu.InvoiceStatusCount>) {
      return (data as List)
              .map((e) => deserialize<_ikvugyyu.InvoiceStatusCount>(e))
              .toList()
          as T;
    }
    if (t == List<_iwdjv467.AdminUserSummary>) {
      return (data as List)
              .map((e) => deserialize<_iwdjv467.AdminUserSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_ixg6nsli.MonthlyTrendPoint>) {
      return (data as List)
              .map((e) => deserialize<_ixg6nsli.MonthlyTrendPoint>(e))
              .toList()
          as T;
    }
    if (t == List<_imcpe7lh.AccountingTransaction>) {
      return (data as List)
              .map((e) => deserialize<_imcpe7lh.AccountingTransaction>(e))
              .toList()
          as T;
    }
    if (t == List<_impe7ay9.RecentTimeEntry>) {
      return (data as List)
              .map((e) => deserialize<_impe7ay9.RecentTimeEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_ix33w5u6.DebtorSummary>) {
      return (data as List)
              .map((e) => deserialize<_ix33w5u6.DebtorSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i5jbvijx.ChecklistItemDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i5jbvijx.ChecklistItemDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_it1pcy1x.InvoiceItemRequest>) {
      return (data as List)
              .map((e) => deserialize<_it1pcy1x.InvoiceItemRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_ic8wp775.Customer>) {
      return (data as List)
              .map((e) => deserialize<_ic8wp775.Customer>(e))
              .toList()
          as T;
    }
    if (t == List<_id8w36x8.PaymentRecord>) {
      return (data as List)
              .map((e) => deserialize<_id8w36x8.PaymentRecord>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _is.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_iify20ly.TimeReportLine>) {
      return (data as List)
              .map((e) => deserialize<_iify20ly.TimeReportLine>(e))
              .toList()
          as T;
    }
    if (t == List<_in8pujw9.MyMembershipInfo>) {
      return (data as List)
              .map((e) => deserialize<_in8pujw9.MyMembershipInfo>(e))
              .toList()
          as T;
    }
    if (t == List<_ipb0z0gh.Feature>) {
      return (data as List)
              .map((e) => deserialize<_ipb0z0gh.Feature>(e))
              .toList()
          as T;
    }
    if (t == List<_ipjpfe96.AccountingTransaction>) {
      return (data as List)
              .map((e) => deserialize<_ipjpfe96.AccountingTransaction>(e))
              .toList()
          as T;
    }
    if (t == List<_imqtlho5.GuidanceTip>) {
      return (data as List)
              .map((e) => deserialize<_imqtlho5.GuidanceTip>(e))
              .toList()
          as T;
    }
    if (t == List<_ipdla2qi.Business>) {
      return (data as List)
              .map((e) => deserialize<_ipdla2qi.Business>(e))
              .toList()
          as T;
    }
    if (t == List<_inbg4lrm.Document>) {
      return (data as List)
              .map((e) => deserialize<_inbg4lrm.Document>(e))
              .toList()
          as T;
    }
    if (t == List<_i3jq3nn0.ChecklistDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i3jq3nn0.ChecklistDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_ivw4ui03.UserGuidanceProgress>) {
      return (data as List)
              .map((e) => deserialize<_ivw4ui03.UserGuidanceProgress>(e))
              .toList()
          as T;
    }
    if (t == List<_i120uj2v.Customer>) {
      return (data as List)
              .map((e) => deserialize<_i120uj2v.Customer>(e))
              .toList()
          as T;
    }
    if (t == List<_i6zkktsi.InvoiceItem>) {
      return (data as List)
              .map((e) => deserialize<_i6zkktsi.InvoiceItem>(e))
              .toList()
          as T;
    }
    if (t == List<_icjfst50.Invoice>) {
      return (data as List)
              .map((e) => deserialize<_icjfst50.Invoice>(e))
              .toList()
          as T;
    }
    if (t == List<_ier3zpp5.InvoiceTemplate>) {
      return (data as List)
              .map((e) => deserialize<_ier3zpp5.InvoiceTemplate>(e))
              .toList()
          as T;
    }
    if (t == List<_ilvs17xw.Reminder>) {
      return (data as List)
              .map((e) => deserialize<_ilvs17xw.Reminder>(e))
              .toList()
          as T;
    }
    if (t == List<_icr6zs8m.Task>) {
      return (data as List).map((e) => deserialize<_icr6zs8m.Task>(e)).toList()
          as T;
    }
    if (t == List<_ido2dfrq.Project>) {
      return (data as List)
              .map((e) => deserialize<_ido2dfrq.Project>(e))
              .toList()
          as T;
    }
    if (t == List<_ict1xti5.TimeEntry>) {
      return (data as List)
              .map((e) => deserialize<_ict1xti5.TimeEntry>(e))
              .toList()
          as T;
    }
    try {
      return _if53ofrw.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i409qkgd.AdminRole => 'AdminRole',
      _ixu4yxcv.AdminUser => 'AdminUser',
      _iv98pmde.AuditEntry => 'AuditEntry',
      _i0s5j3nj.Feature => 'Feature',
      _i5epujyq.ConflictException => 'ConflictException',
      _io9vwtrc.ForbiddenException => 'ForbiddenException',
      _ixeh2c1z.NotFoundException => 'NotFoundException',
      _io4t73gt.ValidationException => 'ValidationException',
      _iwzk2tv7.Sequence => 'Sequence',
      _imcpe7lh.AccountingTransaction => 'AccountingTransaction',
      _ipamnsx8.CreateTransactionRequest => 'CreateTransactionRequest',
      _iixw78u5.ProfitLossLine => 'ProfitLossLine',
      _isurdgsv.ProfitLossReport => 'ProfitLossReport',
      _imo6tjrw.TransactionCategory => 'TransactionCategory',
      _ik9vnz0w.TransactionType => 'TransactionType',
      _iyj5tb39.UpdateTransactionRequest => 'UpdateTransactionRequest',
      _io6p5gfm.AdminAuditEntry => 'AdminAuditEntry',
      _iaab9k46.AdminAuditPage => 'AdminAuditPage',
      _ipsgq99z.AdminAuthStatus => 'AdminAuthStatus',
      _i32iaxq2.AdminBusinessDetail => 'AdminBusinessDetail',
      _iytjl6p4.AdminBusinessPage => 'AdminBusinessPage',
      _ia380t04.AdminInvoicePage => 'AdminInvoicePage',
      _igm2ntgz.AdminMembershipInfo => 'AdminMembershipInfo',
      _ihc64acz.AdminStatsOverview => 'AdminStatsOverview',
      _ibyotlfs.AdminUserDossier => 'AdminUserDossier',
      _iwdjv467.AdminUserSummary => 'AdminUserSummary',
      _i2f075pm.AdminUserSummaryPage => 'AdminUserSummaryPage',
      _ikvugyyu.InvoiceStatusCount => 'InvoiceStatusCount',
      _izfx9e18.Address => 'Address',
      _im9zvu8o.Business => 'Business',
      _ixvagzl5.BusinessSettings => 'BusinessSettings',
      _i8xf36x2.Country => 'Country',
      _i1txccp7.CreateBusinessRequest => 'CreateBusinessRequest',
      _i1srbh9z.Currency => 'Currency',
      _iq0b7m5k.Invitation => 'Invitation',
      _ir4590qc.InvitationStatus => 'InvitationStatus',
      _i5egs7uv.LegalForm => 'LegalForm',
      _ii0188h0.Locale => 'Locale',
      _iu72qgm4.Membership => 'Membership',
      _iv0iprnk.MembershipRole => 'MembershipRole',
      _iku7b3rb.RoundingMode => 'RoundingMode',
      _inkd6ewo.UpdateBusinessRequest => 'UpdateBusinessRequest',
      _ii46p08a.UpdateBusinessSettingsRequest =>
        'UpdateBusinessSettingsRequest',
      _i1j0w1sv.DashboardKpis => 'DashboardKpis',
      _iw3j14uv.DashboardSummary => 'DashboardSummary',
      _ix33w5u6.DebtorSummary => 'DebtorSummary',
      _ixg6nsli.MonthlyTrendPoint => 'MonthlyTrendPoint',
      _ie3ro5gq.ReceivablesSummary => 'ReceivablesSummary',
      _impe7ay9.RecentTimeEntry => 'RecentTimeEntry',
      _i9jvbk51.Document => 'Document',
      _imaz1zqg.DocumentKind => 'DocumentKind',
      _i9qnixrl.StorageLocation => 'StorageLocation',
      _iz60udpo.UploadDocumentRequest => 'UploadDocumentRequest',
      _i04z5hwj.ChecklistDefinition => 'ChecklistDefinition',
      _i5jbvijx.ChecklistItemDefinition => 'ChecklistItemDefinition',
      _irvclg1d.GuidanceTip => 'GuidanceTip',
      _i3qwvpcu.GuidanceTipOverride => 'GuidanceTipOverride',
      _ik05lx5a.UserGuidanceProgress => 'UserGuidanceProgress',
      _i90hzmg5.CreateCustomerRequest => 'CreateCustomerRequest',
      _ia6btdit.CreateInvoiceRequest => 'CreateInvoiceRequest',
      _iyi9fugk.CreateInvoiceTemplateRequest => 'CreateInvoiceTemplateRequest',
      _i4j5ra9q.CreateRecurringScheduleRequest =>
        'CreateRecurringScheduleRequest',
      _ic8wp775.Customer => 'Customer',
      _if0yalhk.CustomerCursorPage => 'CustomerCursorPage',
      _iakrzq1i.CustomerListPage => 'CustomerListPage',
      _ibddqx0x.CustomerStatus => 'CustomerStatus',
      _imguyn55.Invoice => 'Invoice',
      _i2f30jh4.InvoiceCursorPage => 'InvoiceCursorPage',
      _iu86qxr6.InvoiceItem => 'InvoiceItem',
      _it1pcy1x.InvoiceItemRequest => 'InvoiceItemRequest',
      _ik22qf7o.InvoiceItemUnit => 'InvoiceItemUnit',
      _i6mqpqud.InvoiceListPage => 'InvoiceListPage',
      _i6e3kqsf.InvoicePaymentStatus => 'InvoicePaymentStatus',
      _i80dthru.InvoiceStatus => 'InvoiceStatus',
      _isaqeos4.InvoiceTemplate => 'InvoiceTemplate',
      _io5qrdfp.InvoiceType => 'InvoiceType',
      _i31hy3jj.PaymentMethod => 'PaymentMethod',
      _id8w36x8.PaymentRecord => 'PaymentRecord',
      _i2drsvke.RecordPaymentRequest => 'RecordPaymentRequest',
      _it8iedui.RecurrenceInterval => 'RecurrenceInterval',
      _i0xuine3.Reminder => 'Reminder',
      _icatwcwa.UpdateCustomerRequest => 'UpdateCustomerRequest',
      _iteadt76.UpdateInvoiceRequest => 'UpdateInvoiceRequest',
      _ilpliwg4.UpdateInvoiceTemplateRequest => 'UpdateInvoiceTemplateRequest',
      _i037hdza.UpdateRecurringScheduleRequest =>
        'UpdateRecurringScheduleRequest',
      _id7e2pr5.VatRate => 'VatRate',
      _i8rbvyvx.CreateProjectRequest => 'CreateProjectRequest',
      _iagq7u79.CreateTaskRequest => 'CreateTaskRequest',
      _i3b86gp3.CreateTimeEntriesInvoiceRequest =>
        'CreateTimeEntriesInvoiceRequest',
      _i85810i7.CreateTimeEntryRequest => 'CreateTimeEntryRequest',
      _i2wiwzxn.Project => 'Project',
      _i8h0tbjs.ProjectStatus => 'ProjectStatus',
      _i2ishkic.StartTimerRequest => 'StartTimerRequest',
      _ihpxqi7u.Task => 'Task',
      _iieqkj38.TaskStatus => 'TaskStatus',
      _ii8lft1t.TimeEntry => 'TimeEntry',
      _ilk96oxt.TimeReport => 'TimeReport',
      _iify20ly.TimeReportLine => 'TimeReportLine',
      _ilqqks6d.UpdateProjectRequest => 'UpdateProjectRequest',
      _i3iu7ffh.UpdateTaskRequest => 'UpdateTaskRequest',
      _iferwyg8.UpdateTimeEntryRequest => 'UpdateTimeEntryRequest',
      _iy79t9m6.AppTheme => 'AppTheme',
      _i1sqdvz3.MyIdentity => 'MyIdentity',
      _in8pujw9.MyMembershipInfo => 'MyMembershipInfo',
      _i5r0ss6k.UpdateUserProfileRequest => 'UpdateUserProfileRequest',
      _iung9xmp.UserProfile => 'UserProfile',
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
      case _i409qkgd.AdminRole():
        return 'AdminRole';
      case _ixu4yxcv.AdminUser():
        return 'AdminUser';
      case _iv98pmde.AuditEntry():
        return 'AuditEntry';
      case _i0s5j3nj.Feature():
        return 'Feature';
      case _i5epujyq.ConflictException():
        return 'ConflictException';
      case _io9vwtrc.ForbiddenException():
        return 'ForbiddenException';
      case _ixeh2c1z.NotFoundException():
        return 'NotFoundException';
      case _io4t73gt.ValidationException():
        return 'ValidationException';
      case _iwzk2tv7.Sequence():
        return 'Sequence';
      case _imcpe7lh.AccountingTransaction():
        return 'AccountingTransaction';
      case _ipamnsx8.CreateTransactionRequest():
        return 'CreateTransactionRequest';
      case _iixw78u5.ProfitLossLine():
        return 'ProfitLossLine';
      case _isurdgsv.ProfitLossReport():
        return 'ProfitLossReport';
      case _imo6tjrw.TransactionCategory():
        return 'TransactionCategory';
      case _ik9vnz0w.TransactionType():
        return 'TransactionType';
      case _iyj5tb39.UpdateTransactionRequest():
        return 'UpdateTransactionRequest';
      case _io6p5gfm.AdminAuditEntry():
        return 'AdminAuditEntry';
      case _iaab9k46.AdminAuditPage():
        return 'AdminAuditPage';
      case _ipsgq99z.AdminAuthStatus():
        return 'AdminAuthStatus';
      case _i32iaxq2.AdminBusinessDetail():
        return 'AdminBusinessDetail';
      case _iytjl6p4.AdminBusinessPage():
        return 'AdminBusinessPage';
      case _ia380t04.AdminInvoicePage():
        return 'AdminInvoicePage';
      case _igm2ntgz.AdminMembershipInfo():
        return 'AdminMembershipInfo';
      case _ihc64acz.AdminStatsOverview():
        return 'AdminStatsOverview';
      case _ibyotlfs.AdminUserDossier():
        return 'AdminUserDossier';
      case _iwdjv467.AdminUserSummary():
        return 'AdminUserSummary';
      case _i2f075pm.AdminUserSummaryPage():
        return 'AdminUserSummaryPage';
      case _ikvugyyu.InvoiceStatusCount():
        return 'InvoiceStatusCount';
      case _izfx9e18.Address():
        return 'Address';
      case _im9zvu8o.Business():
        return 'Business';
      case _ixvagzl5.BusinessSettings():
        return 'BusinessSettings';
      case _i8xf36x2.Country():
        return 'Country';
      case _i1txccp7.CreateBusinessRequest():
        return 'CreateBusinessRequest';
      case _i1srbh9z.Currency():
        return 'Currency';
      case _iq0b7m5k.Invitation():
        return 'Invitation';
      case _ir4590qc.InvitationStatus():
        return 'InvitationStatus';
      case _i5egs7uv.LegalForm():
        return 'LegalForm';
      case _ii0188h0.Locale():
        return 'Locale';
      case _iu72qgm4.Membership():
        return 'Membership';
      case _iv0iprnk.MembershipRole():
        return 'MembershipRole';
      case _iku7b3rb.RoundingMode():
        return 'RoundingMode';
      case _inkd6ewo.UpdateBusinessRequest():
        return 'UpdateBusinessRequest';
      case _ii46p08a.UpdateBusinessSettingsRequest():
        return 'UpdateBusinessSettingsRequest';
      case _i1j0w1sv.DashboardKpis():
        return 'DashboardKpis';
      case _iw3j14uv.DashboardSummary():
        return 'DashboardSummary';
      case _ix33w5u6.DebtorSummary():
        return 'DebtorSummary';
      case _ixg6nsli.MonthlyTrendPoint():
        return 'MonthlyTrendPoint';
      case _ie3ro5gq.ReceivablesSummary():
        return 'ReceivablesSummary';
      case _impe7ay9.RecentTimeEntry():
        return 'RecentTimeEntry';
      case _i9jvbk51.Document():
        return 'Document';
      case _imaz1zqg.DocumentKind():
        return 'DocumentKind';
      case _i9qnixrl.StorageLocation():
        return 'StorageLocation';
      case _iz60udpo.UploadDocumentRequest():
        return 'UploadDocumentRequest';
      case _i04z5hwj.ChecklistDefinition():
        return 'ChecklistDefinition';
      case _i5jbvijx.ChecklistItemDefinition():
        return 'ChecklistItemDefinition';
      case _irvclg1d.GuidanceTip():
        return 'GuidanceTip';
      case _i3qwvpcu.GuidanceTipOverride():
        return 'GuidanceTipOverride';
      case _ik05lx5a.UserGuidanceProgress():
        return 'UserGuidanceProgress';
      case _i90hzmg5.CreateCustomerRequest():
        return 'CreateCustomerRequest';
      case _ia6btdit.CreateInvoiceRequest():
        return 'CreateInvoiceRequest';
      case _iyi9fugk.CreateInvoiceTemplateRequest():
        return 'CreateInvoiceTemplateRequest';
      case _i4j5ra9q.CreateRecurringScheduleRequest():
        return 'CreateRecurringScheduleRequest';
      case _ic8wp775.Customer():
        return 'Customer';
      case _if0yalhk.CustomerCursorPage():
        return 'CustomerCursorPage';
      case _iakrzq1i.CustomerListPage():
        return 'CustomerListPage';
      case _ibddqx0x.CustomerStatus():
        return 'CustomerStatus';
      case _imguyn55.Invoice():
        return 'Invoice';
      case _i2f30jh4.InvoiceCursorPage():
        return 'InvoiceCursorPage';
      case _iu86qxr6.InvoiceItem():
        return 'InvoiceItem';
      case _it1pcy1x.InvoiceItemRequest():
        return 'InvoiceItemRequest';
      case _ik22qf7o.InvoiceItemUnit():
        return 'InvoiceItemUnit';
      case _i6mqpqud.InvoiceListPage():
        return 'InvoiceListPage';
      case _i6e3kqsf.InvoicePaymentStatus():
        return 'InvoicePaymentStatus';
      case _i80dthru.InvoiceStatus():
        return 'InvoiceStatus';
      case _isaqeos4.InvoiceTemplate():
        return 'InvoiceTemplate';
      case _io5qrdfp.InvoiceType():
        return 'InvoiceType';
      case _i31hy3jj.PaymentMethod():
        return 'PaymentMethod';
      case _id8w36x8.PaymentRecord():
        return 'PaymentRecord';
      case _i2drsvke.RecordPaymentRequest():
        return 'RecordPaymentRequest';
      case _it8iedui.RecurrenceInterval():
        return 'RecurrenceInterval';
      case _i0xuine3.Reminder():
        return 'Reminder';
      case _icatwcwa.UpdateCustomerRequest():
        return 'UpdateCustomerRequest';
      case _iteadt76.UpdateInvoiceRequest():
        return 'UpdateInvoiceRequest';
      case _ilpliwg4.UpdateInvoiceTemplateRequest():
        return 'UpdateInvoiceTemplateRequest';
      case _i037hdza.UpdateRecurringScheduleRequest():
        return 'UpdateRecurringScheduleRequest';
      case _id7e2pr5.VatRate():
        return 'VatRate';
      case _i8rbvyvx.CreateProjectRequest():
        return 'CreateProjectRequest';
      case _iagq7u79.CreateTaskRequest():
        return 'CreateTaskRequest';
      case _i3b86gp3.CreateTimeEntriesInvoiceRequest():
        return 'CreateTimeEntriesInvoiceRequest';
      case _i85810i7.CreateTimeEntryRequest():
        return 'CreateTimeEntryRequest';
      case _i2wiwzxn.Project():
        return 'Project';
      case _i8h0tbjs.ProjectStatus():
        return 'ProjectStatus';
      case _i2ishkic.StartTimerRequest():
        return 'StartTimerRequest';
      case _ihpxqi7u.Task():
        return 'Task';
      case _iieqkj38.TaskStatus():
        return 'TaskStatus';
      case _ii8lft1t.TimeEntry():
        return 'TimeEntry';
      case _ilk96oxt.TimeReport():
        return 'TimeReport';
      case _iify20ly.TimeReportLine():
        return 'TimeReportLine';
      case _ilqqks6d.UpdateProjectRequest():
        return 'UpdateProjectRequest';
      case _i3iu7ffh.UpdateTaskRequest():
        return 'UpdateTaskRequest';
      case _iferwyg8.UpdateTimeEntryRequest():
        return 'UpdateTimeEntryRequest';
      case _iy79t9m6.AppTheme():
        return 'AppTheme';
      case _i1sqdvz3.MyIdentity():
        return 'MyIdentity';
      case _in8pujw9.MyMembershipInfo():
        return 'MyMembershipInfo';
      case _i5r0ss6k.UpdateUserProfileRequest():
        return 'UpdateUserProfileRequest';
      case _iung9xmp.UserProfile():
        return 'UserProfile';
    }
    className = _if53ofrw.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'gewerber_backend_commercial.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'AdminRole') {
      return deserialize<_i409qkgd.AdminRole>(data['data']);
    }
    if (dataClassName == 'AdminUser') {
      return deserialize<_ixu4yxcv.AdminUser>(data['data']);
    }
    if (dataClassName == 'AuditEntry') {
      return deserialize<_iv98pmde.AuditEntry>(data['data']);
    }
    if (dataClassName == 'Feature') {
      return deserialize<_i0s5j3nj.Feature>(data['data']);
    }
    if (dataClassName == 'ConflictException') {
      return deserialize<_i5epujyq.ConflictException>(data['data']);
    }
    if (dataClassName == 'ForbiddenException') {
      return deserialize<_io9vwtrc.ForbiddenException>(data['data']);
    }
    if (dataClassName == 'NotFoundException') {
      return deserialize<_ixeh2c1z.NotFoundException>(data['data']);
    }
    if (dataClassName == 'ValidationException') {
      return deserialize<_io4t73gt.ValidationException>(data['data']);
    }
    if (dataClassName == 'Sequence') {
      return deserialize<_iwzk2tv7.Sequence>(data['data']);
    }
    if (dataClassName == 'AccountingTransaction') {
      return deserialize<_imcpe7lh.AccountingTransaction>(data['data']);
    }
    if (dataClassName == 'CreateTransactionRequest') {
      return deserialize<_ipamnsx8.CreateTransactionRequest>(data['data']);
    }
    if (dataClassName == 'ProfitLossLine') {
      return deserialize<_iixw78u5.ProfitLossLine>(data['data']);
    }
    if (dataClassName == 'ProfitLossReport') {
      return deserialize<_isurdgsv.ProfitLossReport>(data['data']);
    }
    if (dataClassName == 'TransactionCategory') {
      return deserialize<_imo6tjrw.TransactionCategory>(data['data']);
    }
    if (dataClassName == 'TransactionType') {
      return deserialize<_ik9vnz0w.TransactionType>(data['data']);
    }
    if (dataClassName == 'UpdateTransactionRequest') {
      return deserialize<_iyj5tb39.UpdateTransactionRequest>(data['data']);
    }
    if (dataClassName == 'AdminAuditEntry') {
      return deserialize<_io6p5gfm.AdminAuditEntry>(data['data']);
    }
    if (dataClassName == 'AdminAuditPage') {
      return deserialize<_iaab9k46.AdminAuditPage>(data['data']);
    }
    if (dataClassName == 'AdminAuthStatus') {
      return deserialize<_ipsgq99z.AdminAuthStatus>(data['data']);
    }
    if (dataClassName == 'AdminBusinessDetail') {
      return deserialize<_i32iaxq2.AdminBusinessDetail>(data['data']);
    }
    if (dataClassName == 'AdminBusinessPage') {
      return deserialize<_iytjl6p4.AdminBusinessPage>(data['data']);
    }
    if (dataClassName == 'AdminInvoicePage') {
      return deserialize<_ia380t04.AdminInvoicePage>(data['data']);
    }
    if (dataClassName == 'AdminMembershipInfo') {
      return deserialize<_igm2ntgz.AdminMembershipInfo>(data['data']);
    }
    if (dataClassName == 'AdminStatsOverview') {
      return deserialize<_ihc64acz.AdminStatsOverview>(data['data']);
    }
    if (dataClassName == 'AdminUserDossier') {
      return deserialize<_ibyotlfs.AdminUserDossier>(data['data']);
    }
    if (dataClassName == 'AdminUserSummary') {
      return deserialize<_iwdjv467.AdminUserSummary>(data['data']);
    }
    if (dataClassName == 'AdminUserSummaryPage') {
      return deserialize<_i2f075pm.AdminUserSummaryPage>(data['data']);
    }
    if (dataClassName == 'InvoiceStatusCount') {
      return deserialize<_ikvugyyu.InvoiceStatusCount>(data['data']);
    }
    if (dataClassName == 'Address') {
      return deserialize<_izfx9e18.Address>(data['data']);
    }
    if (dataClassName == 'Business') {
      return deserialize<_im9zvu8o.Business>(data['data']);
    }
    if (dataClassName == 'BusinessSettings') {
      return deserialize<_ixvagzl5.BusinessSettings>(data['data']);
    }
    if (dataClassName == 'Country') {
      return deserialize<_i8xf36x2.Country>(data['data']);
    }
    if (dataClassName == 'CreateBusinessRequest') {
      return deserialize<_i1txccp7.CreateBusinessRequest>(data['data']);
    }
    if (dataClassName == 'Currency') {
      return deserialize<_i1srbh9z.Currency>(data['data']);
    }
    if (dataClassName == 'Invitation') {
      return deserialize<_iq0b7m5k.Invitation>(data['data']);
    }
    if (dataClassName == 'InvitationStatus') {
      return deserialize<_ir4590qc.InvitationStatus>(data['data']);
    }
    if (dataClassName == 'LegalForm') {
      return deserialize<_i5egs7uv.LegalForm>(data['data']);
    }
    if (dataClassName == 'Locale') {
      return deserialize<_ii0188h0.Locale>(data['data']);
    }
    if (dataClassName == 'Membership') {
      return deserialize<_iu72qgm4.Membership>(data['data']);
    }
    if (dataClassName == 'MembershipRole') {
      return deserialize<_iv0iprnk.MembershipRole>(data['data']);
    }
    if (dataClassName == 'RoundingMode') {
      return deserialize<_iku7b3rb.RoundingMode>(data['data']);
    }
    if (dataClassName == 'UpdateBusinessRequest') {
      return deserialize<_inkd6ewo.UpdateBusinessRequest>(data['data']);
    }
    if (dataClassName == 'UpdateBusinessSettingsRequest') {
      return deserialize<_ii46p08a.UpdateBusinessSettingsRequest>(data['data']);
    }
    if (dataClassName == 'DashboardKpis') {
      return deserialize<_i1j0w1sv.DashboardKpis>(data['data']);
    }
    if (dataClassName == 'DashboardSummary') {
      return deserialize<_iw3j14uv.DashboardSummary>(data['data']);
    }
    if (dataClassName == 'DebtorSummary') {
      return deserialize<_ix33w5u6.DebtorSummary>(data['data']);
    }
    if (dataClassName == 'MonthlyTrendPoint') {
      return deserialize<_ixg6nsli.MonthlyTrendPoint>(data['data']);
    }
    if (dataClassName == 'ReceivablesSummary') {
      return deserialize<_ie3ro5gq.ReceivablesSummary>(data['data']);
    }
    if (dataClassName == 'RecentTimeEntry') {
      return deserialize<_impe7ay9.RecentTimeEntry>(data['data']);
    }
    if (dataClassName == 'Document') {
      return deserialize<_i9jvbk51.Document>(data['data']);
    }
    if (dataClassName == 'DocumentKind') {
      return deserialize<_imaz1zqg.DocumentKind>(data['data']);
    }
    if (dataClassName == 'StorageLocation') {
      return deserialize<_i9qnixrl.StorageLocation>(data['data']);
    }
    if (dataClassName == 'UploadDocumentRequest') {
      return deserialize<_iz60udpo.UploadDocumentRequest>(data['data']);
    }
    if (dataClassName == 'ChecklistDefinition') {
      return deserialize<_i04z5hwj.ChecklistDefinition>(data['data']);
    }
    if (dataClassName == 'ChecklistItemDefinition') {
      return deserialize<_i5jbvijx.ChecklistItemDefinition>(data['data']);
    }
    if (dataClassName == 'GuidanceTip') {
      return deserialize<_irvclg1d.GuidanceTip>(data['data']);
    }
    if (dataClassName == 'GuidanceTipOverride') {
      return deserialize<_i3qwvpcu.GuidanceTipOverride>(data['data']);
    }
    if (dataClassName == 'UserGuidanceProgress') {
      return deserialize<_ik05lx5a.UserGuidanceProgress>(data['data']);
    }
    if (dataClassName == 'CreateCustomerRequest') {
      return deserialize<_i90hzmg5.CreateCustomerRequest>(data['data']);
    }
    if (dataClassName == 'CreateInvoiceRequest') {
      return deserialize<_ia6btdit.CreateInvoiceRequest>(data['data']);
    }
    if (dataClassName == 'CreateInvoiceTemplateRequest') {
      return deserialize<_iyi9fugk.CreateInvoiceTemplateRequest>(data['data']);
    }
    if (dataClassName == 'CreateRecurringScheduleRequest') {
      return deserialize<_i4j5ra9q.CreateRecurringScheduleRequest>(
        data['data'],
      );
    }
    if (dataClassName == 'Customer') {
      return deserialize<_ic8wp775.Customer>(data['data']);
    }
    if (dataClassName == 'CustomerCursorPage') {
      return deserialize<_if0yalhk.CustomerCursorPage>(data['data']);
    }
    if (dataClassName == 'CustomerListPage') {
      return deserialize<_iakrzq1i.CustomerListPage>(data['data']);
    }
    if (dataClassName == 'CustomerStatus') {
      return deserialize<_ibddqx0x.CustomerStatus>(data['data']);
    }
    if (dataClassName == 'Invoice') {
      return deserialize<_imguyn55.Invoice>(data['data']);
    }
    if (dataClassName == 'InvoiceCursorPage') {
      return deserialize<_i2f30jh4.InvoiceCursorPage>(data['data']);
    }
    if (dataClassName == 'InvoiceItem') {
      return deserialize<_iu86qxr6.InvoiceItem>(data['data']);
    }
    if (dataClassName == 'InvoiceItemRequest') {
      return deserialize<_it1pcy1x.InvoiceItemRequest>(data['data']);
    }
    if (dataClassName == 'InvoiceItemUnit') {
      return deserialize<_ik22qf7o.InvoiceItemUnit>(data['data']);
    }
    if (dataClassName == 'InvoiceListPage') {
      return deserialize<_i6mqpqud.InvoiceListPage>(data['data']);
    }
    if (dataClassName == 'InvoicePaymentStatus') {
      return deserialize<_i6e3kqsf.InvoicePaymentStatus>(data['data']);
    }
    if (dataClassName == 'InvoiceStatus') {
      return deserialize<_i80dthru.InvoiceStatus>(data['data']);
    }
    if (dataClassName == 'InvoiceTemplate') {
      return deserialize<_isaqeos4.InvoiceTemplate>(data['data']);
    }
    if (dataClassName == 'InvoiceType') {
      return deserialize<_io5qrdfp.InvoiceType>(data['data']);
    }
    if (dataClassName == 'PaymentMethod') {
      return deserialize<_i31hy3jj.PaymentMethod>(data['data']);
    }
    if (dataClassName == 'PaymentRecord') {
      return deserialize<_id8w36x8.PaymentRecord>(data['data']);
    }
    if (dataClassName == 'RecordPaymentRequest') {
      return deserialize<_i2drsvke.RecordPaymentRequest>(data['data']);
    }
    if (dataClassName == 'RecurrenceInterval') {
      return deserialize<_it8iedui.RecurrenceInterval>(data['data']);
    }
    if (dataClassName == 'Reminder') {
      return deserialize<_i0xuine3.Reminder>(data['data']);
    }
    if (dataClassName == 'UpdateCustomerRequest') {
      return deserialize<_icatwcwa.UpdateCustomerRequest>(data['data']);
    }
    if (dataClassName == 'UpdateInvoiceRequest') {
      return deserialize<_iteadt76.UpdateInvoiceRequest>(data['data']);
    }
    if (dataClassName == 'UpdateInvoiceTemplateRequest') {
      return deserialize<_ilpliwg4.UpdateInvoiceTemplateRequest>(data['data']);
    }
    if (dataClassName == 'UpdateRecurringScheduleRequest') {
      return deserialize<_i037hdza.UpdateRecurringScheduleRequest>(
        data['data'],
      );
    }
    if (dataClassName == 'VatRate') {
      return deserialize<_id7e2pr5.VatRate>(data['data']);
    }
    if (dataClassName == 'CreateProjectRequest') {
      return deserialize<_i8rbvyvx.CreateProjectRequest>(data['data']);
    }
    if (dataClassName == 'CreateTaskRequest') {
      return deserialize<_iagq7u79.CreateTaskRequest>(data['data']);
    }
    if (dataClassName == 'CreateTimeEntriesInvoiceRequest') {
      return deserialize<_i3b86gp3.CreateTimeEntriesInvoiceRequest>(
        data['data'],
      );
    }
    if (dataClassName == 'CreateTimeEntryRequest') {
      return deserialize<_i85810i7.CreateTimeEntryRequest>(data['data']);
    }
    if (dataClassName == 'Project') {
      return deserialize<_i2wiwzxn.Project>(data['data']);
    }
    if (dataClassName == 'ProjectStatus') {
      return deserialize<_i8h0tbjs.ProjectStatus>(data['data']);
    }
    if (dataClassName == 'StartTimerRequest') {
      return deserialize<_i2ishkic.StartTimerRequest>(data['data']);
    }
    if (dataClassName == 'Task') {
      return deserialize<_ihpxqi7u.Task>(data['data']);
    }
    if (dataClassName == 'TaskStatus') {
      return deserialize<_iieqkj38.TaskStatus>(data['data']);
    }
    if (dataClassName == 'TimeEntry') {
      return deserialize<_ii8lft1t.TimeEntry>(data['data']);
    }
    if (dataClassName == 'TimeReport') {
      return deserialize<_ilk96oxt.TimeReport>(data['data']);
    }
    if (dataClassName == 'TimeReportLine') {
      return deserialize<_iify20ly.TimeReportLine>(data['data']);
    }
    if (dataClassName == 'UpdateProjectRequest') {
      return deserialize<_ilqqks6d.UpdateProjectRequest>(data['data']);
    }
    if (dataClassName == 'UpdateTaskRequest') {
      return deserialize<_i3iu7ffh.UpdateTaskRequest>(data['data']);
    }
    if (dataClassName == 'UpdateTimeEntryRequest') {
      return deserialize<_iferwyg8.UpdateTimeEntryRequest>(data['data']);
    }
    if (dataClassName == 'AppTheme') {
      return deserialize<_iy79t9m6.AppTheme>(data['data']);
    }
    if (dataClassName == 'MyIdentity') {
      return deserialize<_i1sqdvz3.MyIdentity>(data['data']);
    }
    if (dataClassName == 'MyMembershipInfo') {
      return deserialize<_in8pujw9.MyMembershipInfo>(data['data']);
    }
    if (dataClassName == 'UpdateUserProfileRequest') {
      return deserialize<_i5r0ss6k.UpdateUserProfileRequest>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_iung9xmp.UserProfile>(data['data']);
    }
    if (dataClassName.startsWith('gewerber_backend_commercial.')) {
      data['className'] = dataClassName.substring(28);
      return _if53ofrw.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _if53ofrw.Protocol().registerHostProtocol('gewerber_backend', this);
    _iacs.Protocol().registerHostProtocol('gewerber_backend', this);
    _iais.Protocol().registerHostProtocol('gewerber_backend', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _if53ofrw.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _ixu4yxcv.AdminUser:
        return _ixu4yxcv.AdminUser.t;
      case _iv98pmde.AuditEntry:
        return _iv98pmde.AuditEntry.t;
      case _iwzk2tv7.Sequence:
        return _iwzk2tv7.Sequence.t;
      case _imcpe7lh.AccountingTransaction:
        return _imcpe7lh.AccountingTransaction.t;
      case _im9zvu8o.Business:
        return _im9zvu8o.Business.t;
      case _ixvagzl5.BusinessSettings:
        return _ixvagzl5.BusinessSettings.t;
      case _iq0b7m5k.Invitation:
        return _iq0b7m5k.Invitation.t;
      case _iu72qgm4.Membership:
        return _iu72qgm4.Membership.t;
      case _i9jvbk51.Document:
        return _i9jvbk51.Document.t;
      case _i3qwvpcu.GuidanceTipOverride:
        return _i3qwvpcu.GuidanceTipOverride.t;
      case _ik05lx5a.UserGuidanceProgress:
        return _ik05lx5a.UserGuidanceProgress.t;
      case _ic8wp775.Customer:
        return _ic8wp775.Customer.t;
      case _imguyn55.Invoice:
        return _imguyn55.Invoice.t;
      case _iu86qxr6.InvoiceItem:
        return _iu86qxr6.InvoiceItem.t;
      case _isaqeos4.InvoiceTemplate:
        return _isaqeos4.InvoiceTemplate.t;
      case _id8w36x8.PaymentRecord:
        return _id8w36x8.PaymentRecord.t;
      case _i0xuine3.Reminder:
        return _i0xuine3.Reminder.t;
      case _i2wiwzxn.Project:
        return _i2wiwzxn.Project.t;
      case _ihpxqi7u.Task:
        return _ihpxqi7u.Task.t;
      case _ii8lft1t.TimeEntry:
        return _ii8lft1t.TimeEntry.t;
      case _iung9xmp.UserProfile:
        return _iung9xmp.UserProfile.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
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
      return _if53ofrw.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
