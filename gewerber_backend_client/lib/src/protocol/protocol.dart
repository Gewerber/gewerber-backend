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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'core/entitlement/feature.dart' as _i2;
import 'core/errors/conflict_exception.dart' as _i3;
import 'core/errors/forbidden_exception.dart' as _i4;
import 'core/errors/not_found_exception.dart' as _i5;
import 'core/errors/validation_exception.dart' as _i6;
import 'modules/business/models/address.dart' as _i7;
import 'modules/business/models/business.dart' as _i8;
import 'modules/business/models/business_settings.dart' as _i9;
import 'modules/business/models/country.dart' as _i10;
import 'modules/business/models/create_business_request.dart' as _i11;
import 'modules/business/models/currency.dart' as _i12;
import 'modules/business/models/legal_form.dart' as _i13;
import 'modules/business/models/locale.dart' as _i14;
import 'modules/business/models/membership.dart' as _i15;
import 'modules/business/models/membership_role.dart' as _i16;
import 'modules/business/models/rounding_mode.dart' as _i17;
import 'modules/business/models/update_business_request.dart' as _i18;
import 'modules/business/models/update_business_settings_request.dart' as _i19;
import 'modules/documents/models/document.dart' as _i20;
import 'modules/documents/models/document_kind.dart' as _i21;
import 'modules/documents/models/storage_location.dart' as _i22;
import 'modules/documents/models/upload_document_request.dart' as _i23;
import 'modules/invoicing/models/create_customer_request.dart' as _i24;
import 'modules/invoicing/models/create_invoice_request.dart' as _i25;
import 'modules/invoicing/models/create_invoice_template_request.dart' as _i26;
import 'modules/invoicing/models/customer.dart' as _i27;
import 'modules/invoicing/models/customer_status.dart' as _i28;
import 'modules/invoicing/models/invoice.dart' as _i29;
import 'modules/invoicing/models/invoice_item.dart' as _i30;
import 'modules/invoicing/models/invoice_item_request.dart' as _i31;
import 'modules/invoicing/models/invoice_item_unit.dart' as _i32;
import 'modules/invoicing/models/invoice_status.dart' as _i33;
import 'modules/invoicing/models/invoice_template.dart' as _i34;
import 'modules/invoicing/models/invoice_type.dart' as _i35;
import 'modules/invoicing/models/payment_method.dart' as _i36;
import 'modules/invoicing/models/payment_record.dart' as _i37;
import 'modules/invoicing/models/record_payment_request.dart' as _i38;
import 'modules/invoicing/models/recurrence_interval.dart' as _i39;
import 'modules/invoicing/models/recurrence_rule.dart' as _i40;
import 'modules/invoicing/models/reminder.dart' as _i41;
import 'modules/invoicing/models/update_customer_request.dart' as _i42;
import 'modules/invoicing/models/update_invoice_request.dart' as _i43;
import 'modules/invoicing/models/update_invoice_template_request.dart' as _i44;
import 'modules/invoicing/models/vat_rate.dart' as _i45;
import 'modules/user/models/update_user_profile_request.dart' as _i46;
import 'modules/user/models/user_profile.dart' as _i47;
import 'package:gewerber_backend_client/src/protocol/core/entitlement/feature.dart'
    as _i48;
import 'package:gewerber_backend_client/src/protocol/modules/business/models/business.dart'
    as _i49;
import 'package:gewerber_backend_client/src/protocol/modules/documents/models/document.dart'
    as _i50;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i51;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i52;
export 'core/entitlement/feature.dart';
export 'core/errors/conflict_exception.dart';
export 'core/errors/forbidden_exception.dart';
export 'core/errors/not_found_exception.dart';
export 'core/errors/validation_exception.dart';
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
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

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

    if (t == _i2.Feature) {
      return _i2.Feature.fromJson(data) as T;
    }
    if (t == _i3.ConflictException) {
      return _i3.ConflictException.fromJson(data) as T;
    }
    if (t == _i4.ForbiddenException) {
      return _i4.ForbiddenException.fromJson(data) as T;
    }
    if (t == _i5.NotFoundException) {
      return _i5.NotFoundException.fromJson(data) as T;
    }
    if (t == _i6.ValidationException) {
      return _i6.ValidationException.fromJson(data) as T;
    }
    if (t == _i7.Address) {
      return _i7.Address.fromJson(data) as T;
    }
    if (t == _i8.Business) {
      return _i8.Business.fromJson(data) as T;
    }
    if (t == _i9.BusinessSettings) {
      return _i9.BusinessSettings.fromJson(data) as T;
    }
    if (t == _i10.Country) {
      return _i10.Country.fromJson(data) as T;
    }
    if (t == _i11.CreateBusinessRequest) {
      return _i11.CreateBusinessRequest.fromJson(data) as T;
    }
    if (t == _i12.Currency) {
      return _i12.Currency.fromJson(data) as T;
    }
    if (t == _i13.LegalForm) {
      return _i13.LegalForm.fromJson(data) as T;
    }
    if (t == _i14.Locale) {
      return _i14.Locale.fromJson(data) as T;
    }
    if (t == _i15.Membership) {
      return _i15.Membership.fromJson(data) as T;
    }
    if (t == _i16.MembershipRole) {
      return _i16.MembershipRole.fromJson(data) as T;
    }
    if (t == _i17.RoundingMode) {
      return _i17.RoundingMode.fromJson(data) as T;
    }
    if (t == _i18.UpdateBusinessRequest) {
      return _i18.UpdateBusinessRequest.fromJson(data) as T;
    }
    if (t == _i19.UpdateBusinessSettingsRequest) {
      return _i19.UpdateBusinessSettingsRequest.fromJson(data) as T;
    }
    if (t == _i20.Document) {
      return _i20.Document.fromJson(data) as T;
    }
    if (t == _i21.DocumentKind) {
      return _i21.DocumentKind.fromJson(data) as T;
    }
    if (t == _i22.StorageLocation) {
      return _i22.StorageLocation.fromJson(data) as T;
    }
    if (t == _i23.UploadDocumentRequest) {
      return _i23.UploadDocumentRequest.fromJson(data) as T;
    }
    if (t == _i24.CreateCustomerRequest) {
      return _i24.CreateCustomerRequest.fromJson(data) as T;
    }
    if (t == _i25.CreateInvoiceRequest) {
      return _i25.CreateInvoiceRequest.fromJson(data) as T;
    }
    if (t == _i26.CreateInvoiceTemplateRequest) {
      return _i26.CreateInvoiceTemplateRequest.fromJson(data) as T;
    }
    if (t == _i27.Customer) {
      return _i27.Customer.fromJson(data) as T;
    }
    if (t == _i28.CustomerStatus) {
      return _i28.CustomerStatus.fromJson(data) as T;
    }
    if (t == _i29.Invoice) {
      return _i29.Invoice.fromJson(data) as T;
    }
    if (t == _i30.InvoiceItem) {
      return _i30.InvoiceItem.fromJson(data) as T;
    }
    if (t == _i31.InvoiceItemRequest) {
      return _i31.InvoiceItemRequest.fromJson(data) as T;
    }
    if (t == _i32.InvoiceItemUnit) {
      return _i32.InvoiceItemUnit.fromJson(data) as T;
    }
    if (t == _i33.InvoiceStatus) {
      return _i33.InvoiceStatus.fromJson(data) as T;
    }
    if (t == _i34.InvoiceTemplate) {
      return _i34.InvoiceTemplate.fromJson(data) as T;
    }
    if (t == _i35.InvoiceType) {
      return _i35.InvoiceType.fromJson(data) as T;
    }
    if (t == _i36.PaymentMethod) {
      return _i36.PaymentMethod.fromJson(data) as T;
    }
    if (t == _i37.PaymentRecord) {
      return _i37.PaymentRecord.fromJson(data) as T;
    }
    if (t == _i38.RecordPaymentRequest) {
      return _i38.RecordPaymentRequest.fromJson(data) as T;
    }
    if (t == _i39.RecurrenceInterval) {
      return _i39.RecurrenceInterval.fromJson(data) as T;
    }
    if (t == _i40.RecurrenceRule) {
      return _i40.RecurrenceRule.fromJson(data) as T;
    }
    if (t == _i41.Reminder) {
      return _i41.Reminder.fromJson(data) as T;
    }
    if (t == _i42.UpdateCustomerRequest) {
      return _i42.UpdateCustomerRequest.fromJson(data) as T;
    }
    if (t == _i43.UpdateInvoiceRequest) {
      return _i43.UpdateInvoiceRequest.fromJson(data) as T;
    }
    if (t == _i44.UpdateInvoiceTemplateRequest) {
      return _i44.UpdateInvoiceTemplateRequest.fromJson(data) as T;
    }
    if (t == _i45.VatRate) {
      return _i45.VatRate.fromJson(data) as T;
    }
    if (t == _i46.UpdateUserProfileRequest) {
      return _i46.UpdateUserProfileRequest.fromJson(data) as T;
    }
    if (t == _i47.UserProfile) {
      return _i47.UserProfile.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Feature?>()) {
      return (data != null ? _i2.Feature.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.ConflictException?>()) {
      return (data != null ? _i3.ConflictException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.ForbiddenException?>()) {
      return (data != null ? _i4.ForbiddenException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.NotFoundException?>()) {
      return (data != null ? _i5.NotFoundException.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ValidationException?>()) {
      return (data != null ? _i6.ValidationException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.Address?>()) {
      return (data != null ? _i7.Address.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Business?>()) {
      return (data != null ? _i8.Business.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.BusinessSettings?>()) {
      return (data != null ? _i9.BusinessSettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Country?>()) {
      return (data != null ? _i10.Country.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.CreateBusinessRequest?>()) {
      return (data != null ? _i11.CreateBusinessRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.Currency?>()) {
      return (data != null ? _i12.Currency.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.LegalForm?>()) {
      return (data != null ? _i13.LegalForm.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Locale?>()) {
      return (data != null ? _i14.Locale.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Membership?>()) {
      return (data != null ? _i15.Membership.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.MembershipRole?>()) {
      return (data != null ? _i16.MembershipRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.RoundingMode?>()) {
      return (data != null ? _i17.RoundingMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.UpdateBusinessRequest?>()) {
      return (data != null ? _i18.UpdateBusinessRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.UpdateBusinessSettingsRequest?>()) {
      return (data != null
              ? _i19.UpdateBusinessSettingsRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i20.Document?>()) {
      return (data != null ? _i20.Document.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.DocumentKind?>()) {
      return (data != null ? _i21.DocumentKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.StorageLocation?>()) {
      return (data != null ? _i22.StorageLocation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.UploadDocumentRequest?>()) {
      return (data != null ? _i23.UploadDocumentRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.CreateCustomerRequest?>()) {
      return (data != null ? _i24.CreateCustomerRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.CreateInvoiceRequest?>()) {
      return (data != null ? _i25.CreateInvoiceRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.CreateInvoiceTemplateRequest?>()) {
      return (data != null
              ? _i26.CreateInvoiceTemplateRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i27.Customer?>()) {
      return (data != null ? _i27.Customer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.CustomerStatus?>()) {
      return (data != null ? _i28.CustomerStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.Invoice?>()) {
      return (data != null ? _i29.Invoice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.InvoiceItem?>()) {
      return (data != null ? _i30.InvoiceItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.InvoiceItemRequest?>()) {
      return (data != null ? _i31.InvoiceItemRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i32.InvoiceItemUnit?>()) {
      return (data != null ? _i32.InvoiceItemUnit.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.InvoiceStatus?>()) {
      return (data != null ? _i33.InvoiceStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.InvoiceTemplate?>()) {
      return (data != null ? _i34.InvoiceTemplate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.InvoiceType?>()) {
      return (data != null ? _i35.InvoiceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.PaymentMethod?>()) {
      return (data != null ? _i36.PaymentMethod.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.PaymentRecord?>()) {
      return (data != null ? _i37.PaymentRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.RecordPaymentRequest?>()) {
      return (data != null ? _i38.RecordPaymentRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i39.RecurrenceInterval?>()) {
      return (data != null ? _i39.RecurrenceInterval.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i40.RecurrenceRule?>()) {
      return (data != null ? _i40.RecurrenceRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.Reminder?>()) {
      return (data != null ? _i41.Reminder.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.UpdateCustomerRequest?>()) {
      return (data != null ? _i42.UpdateCustomerRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i43.UpdateInvoiceRequest?>()) {
      return (data != null ? _i43.UpdateInvoiceRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i44.UpdateInvoiceTemplateRequest?>()) {
      return (data != null
              ? _i44.UpdateInvoiceTemplateRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i45.VatRate?>()) {
      return (data != null ? _i45.VatRate.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.UpdateUserProfileRequest?>()) {
      return (data != null
              ? _i46.UpdateUserProfileRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i47.UserProfile?>()) {
      return (data != null ? _i47.UserProfile.fromJson(data) : null) as T;
    }
    if (t == List<_i31.InvoiceItemRequest>) {
      return (data as List)
              .map((e) => deserialize<_i31.InvoiceItemRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_i48.Feature>) {
      return (data as List).map((e) => deserialize<_i48.Feature>(e)).toList()
          as T;
    }
    if (t == List<_i49.Business>) {
      return (data as List).map((e) => deserialize<_i49.Business>(e)).toList()
          as T;
    }
    if (t == List<_i50.Document>) {
      return (data as List).map((e) => deserialize<_i50.Document>(e)).toList()
          as T;
    }
    try {
      return _i51.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i52.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Feature => 'Feature',
      _i3.ConflictException => 'ConflictException',
      _i4.ForbiddenException => 'ForbiddenException',
      _i5.NotFoundException => 'NotFoundException',
      _i6.ValidationException => 'ValidationException',
      _i7.Address => 'Address',
      _i8.Business => 'Business',
      _i9.BusinessSettings => 'BusinessSettings',
      _i10.Country => 'Country',
      _i11.CreateBusinessRequest => 'CreateBusinessRequest',
      _i12.Currency => 'Currency',
      _i13.LegalForm => 'LegalForm',
      _i14.Locale => 'Locale',
      _i15.Membership => 'Membership',
      _i16.MembershipRole => 'MembershipRole',
      _i17.RoundingMode => 'RoundingMode',
      _i18.UpdateBusinessRequest => 'UpdateBusinessRequest',
      _i19.UpdateBusinessSettingsRequest => 'UpdateBusinessSettingsRequest',
      _i20.Document => 'Document',
      _i21.DocumentKind => 'DocumentKind',
      _i22.StorageLocation => 'StorageLocation',
      _i23.UploadDocumentRequest => 'UploadDocumentRequest',
      _i24.CreateCustomerRequest => 'CreateCustomerRequest',
      _i25.CreateInvoiceRequest => 'CreateInvoiceRequest',
      _i26.CreateInvoiceTemplateRequest => 'CreateInvoiceTemplateRequest',
      _i27.Customer => 'Customer',
      _i28.CustomerStatus => 'CustomerStatus',
      _i29.Invoice => 'Invoice',
      _i30.InvoiceItem => 'InvoiceItem',
      _i31.InvoiceItemRequest => 'InvoiceItemRequest',
      _i32.InvoiceItemUnit => 'InvoiceItemUnit',
      _i33.InvoiceStatus => 'InvoiceStatus',
      _i34.InvoiceTemplate => 'InvoiceTemplate',
      _i35.InvoiceType => 'InvoiceType',
      _i36.PaymentMethod => 'PaymentMethod',
      _i37.PaymentRecord => 'PaymentRecord',
      _i38.RecordPaymentRequest => 'RecordPaymentRequest',
      _i39.RecurrenceInterval => 'RecurrenceInterval',
      _i40.RecurrenceRule => 'RecurrenceRule',
      _i41.Reminder => 'Reminder',
      _i42.UpdateCustomerRequest => 'UpdateCustomerRequest',
      _i43.UpdateInvoiceRequest => 'UpdateInvoiceRequest',
      _i44.UpdateInvoiceTemplateRequest => 'UpdateInvoiceTemplateRequest',
      _i45.VatRate => 'VatRate',
      _i46.UpdateUserProfileRequest => 'UpdateUserProfileRequest',
      _i47.UserProfile => 'UserProfile',
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
      case _i2.Feature():
        return 'Feature';
      case _i3.ConflictException():
        return 'ConflictException';
      case _i4.ForbiddenException():
        return 'ForbiddenException';
      case _i5.NotFoundException():
        return 'NotFoundException';
      case _i6.ValidationException():
        return 'ValidationException';
      case _i7.Address():
        return 'Address';
      case _i8.Business():
        return 'Business';
      case _i9.BusinessSettings():
        return 'BusinessSettings';
      case _i10.Country():
        return 'Country';
      case _i11.CreateBusinessRequest():
        return 'CreateBusinessRequest';
      case _i12.Currency():
        return 'Currency';
      case _i13.LegalForm():
        return 'LegalForm';
      case _i14.Locale():
        return 'Locale';
      case _i15.Membership():
        return 'Membership';
      case _i16.MembershipRole():
        return 'MembershipRole';
      case _i17.RoundingMode():
        return 'RoundingMode';
      case _i18.UpdateBusinessRequest():
        return 'UpdateBusinessRequest';
      case _i19.UpdateBusinessSettingsRequest():
        return 'UpdateBusinessSettingsRequest';
      case _i20.Document():
        return 'Document';
      case _i21.DocumentKind():
        return 'DocumentKind';
      case _i22.StorageLocation():
        return 'StorageLocation';
      case _i23.UploadDocumentRequest():
        return 'UploadDocumentRequest';
      case _i24.CreateCustomerRequest():
        return 'CreateCustomerRequest';
      case _i25.CreateInvoiceRequest():
        return 'CreateInvoiceRequest';
      case _i26.CreateInvoiceTemplateRequest():
        return 'CreateInvoiceTemplateRequest';
      case _i27.Customer():
        return 'Customer';
      case _i28.CustomerStatus():
        return 'CustomerStatus';
      case _i29.Invoice():
        return 'Invoice';
      case _i30.InvoiceItem():
        return 'InvoiceItem';
      case _i31.InvoiceItemRequest():
        return 'InvoiceItemRequest';
      case _i32.InvoiceItemUnit():
        return 'InvoiceItemUnit';
      case _i33.InvoiceStatus():
        return 'InvoiceStatus';
      case _i34.InvoiceTemplate():
        return 'InvoiceTemplate';
      case _i35.InvoiceType():
        return 'InvoiceType';
      case _i36.PaymentMethod():
        return 'PaymentMethod';
      case _i37.PaymentRecord():
        return 'PaymentRecord';
      case _i38.RecordPaymentRequest():
        return 'RecordPaymentRequest';
      case _i39.RecurrenceInterval():
        return 'RecurrenceInterval';
      case _i40.RecurrenceRule():
        return 'RecurrenceRule';
      case _i41.Reminder():
        return 'Reminder';
      case _i42.UpdateCustomerRequest():
        return 'UpdateCustomerRequest';
      case _i43.UpdateInvoiceRequest():
        return 'UpdateInvoiceRequest';
      case _i44.UpdateInvoiceTemplateRequest():
        return 'UpdateInvoiceTemplateRequest';
      case _i45.VatRate():
        return 'VatRate';
      case _i46.UpdateUserProfileRequest():
        return 'UpdateUserProfileRequest';
      case _i47.UserProfile():
        return 'UserProfile';
    }
    className = _i51.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _i52.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Feature') {
      return deserialize<_i2.Feature>(data['data']);
    }
    if (dataClassName == 'ConflictException') {
      return deserialize<_i3.ConflictException>(data['data']);
    }
    if (dataClassName == 'ForbiddenException') {
      return deserialize<_i4.ForbiddenException>(data['data']);
    }
    if (dataClassName == 'NotFoundException') {
      return deserialize<_i5.NotFoundException>(data['data']);
    }
    if (dataClassName == 'ValidationException') {
      return deserialize<_i6.ValidationException>(data['data']);
    }
    if (dataClassName == 'Address') {
      return deserialize<_i7.Address>(data['data']);
    }
    if (dataClassName == 'Business') {
      return deserialize<_i8.Business>(data['data']);
    }
    if (dataClassName == 'BusinessSettings') {
      return deserialize<_i9.BusinessSettings>(data['data']);
    }
    if (dataClassName == 'Country') {
      return deserialize<_i10.Country>(data['data']);
    }
    if (dataClassName == 'CreateBusinessRequest') {
      return deserialize<_i11.CreateBusinessRequest>(data['data']);
    }
    if (dataClassName == 'Currency') {
      return deserialize<_i12.Currency>(data['data']);
    }
    if (dataClassName == 'LegalForm') {
      return deserialize<_i13.LegalForm>(data['data']);
    }
    if (dataClassName == 'Locale') {
      return deserialize<_i14.Locale>(data['data']);
    }
    if (dataClassName == 'Membership') {
      return deserialize<_i15.Membership>(data['data']);
    }
    if (dataClassName == 'MembershipRole') {
      return deserialize<_i16.MembershipRole>(data['data']);
    }
    if (dataClassName == 'RoundingMode') {
      return deserialize<_i17.RoundingMode>(data['data']);
    }
    if (dataClassName == 'UpdateBusinessRequest') {
      return deserialize<_i18.UpdateBusinessRequest>(data['data']);
    }
    if (dataClassName == 'UpdateBusinessSettingsRequest') {
      return deserialize<_i19.UpdateBusinessSettingsRequest>(data['data']);
    }
    if (dataClassName == 'Document') {
      return deserialize<_i20.Document>(data['data']);
    }
    if (dataClassName == 'DocumentKind') {
      return deserialize<_i21.DocumentKind>(data['data']);
    }
    if (dataClassName == 'StorageLocation') {
      return deserialize<_i22.StorageLocation>(data['data']);
    }
    if (dataClassName == 'UploadDocumentRequest') {
      return deserialize<_i23.UploadDocumentRequest>(data['data']);
    }
    if (dataClassName == 'CreateCustomerRequest') {
      return deserialize<_i24.CreateCustomerRequest>(data['data']);
    }
    if (dataClassName == 'CreateInvoiceRequest') {
      return deserialize<_i25.CreateInvoiceRequest>(data['data']);
    }
    if (dataClassName == 'CreateInvoiceTemplateRequest') {
      return deserialize<_i26.CreateInvoiceTemplateRequest>(data['data']);
    }
    if (dataClassName == 'Customer') {
      return deserialize<_i27.Customer>(data['data']);
    }
    if (dataClassName == 'CustomerStatus') {
      return deserialize<_i28.CustomerStatus>(data['data']);
    }
    if (dataClassName == 'Invoice') {
      return deserialize<_i29.Invoice>(data['data']);
    }
    if (dataClassName == 'InvoiceItem') {
      return deserialize<_i30.InvoiceItem>(data['data']);
    }
    if (dataClassName == 'InvoiceItemRequest') {
      return deserialize<_i31.InvoiceItemRequest>(data['data']);
    }
    if (dataClassName == 'InvoiceItemUnit') {
      return deserialize<_i32.InvoiceItemUnit>(data['data']);
    }
    if (dataClassName == 'InvoiceStatus') {
      return deserialize<_i33.InvoiceStatus>(data['data']);
    }
    if (dataClassName == 'InvoiceTemplate') {
      return deserialize<_i34.InvoiceTemplate>(data['data']);
    }
    if (dataClassName == 'InvoiceType') {
      return deserialize<_i35.InvoiceType>(data['data']);
    }
    if (dataClassName == 'PaymentMethod') {
      return deserialize<_i36.PaymentMethod>(data['data']);
    }
    if (dataClassName == 'PaymentRecord') {
      return deserialize<_i37.PaymentRecord>(data['data']);
    }
    if (dataClassName == 'RecordPaymentRequest') {
      return deserialize<_i38.RecordPaymentRequest>(data['data']);
    }
    if (dataClassName == 'RecurrenceInterval') {
      return deserialize<_i39.RecurrenceInterval>(data['data']);
    }
    if (dataClassName == 'RecurrenceRule') {
      return deserialize<_i40.RecurrenceRule>(data['data']);
    }
    if (dataClassName == 'Reminder') {
      return deserialize<_i41.Reminder>(data['data']);
    }
    if (dataClassName == 'UpdateCustomerRequest') {
      return deserialize<_i42.UpdateCustomerRequest>(data['data']);
    }
    if (dataClassName == 'UpdateInvoiceRequest') {
      return deserialize<_i43.UpdateInvoiceRequest>(data['data']);
    }
    if (dataClassName == 'UpdateInvoiceTemplateRequest') {
      return deserialize<_i44.UpdateInvoiceTemplateRequest>(data['data']);
    }
    if (dataClassName == 'VatRate') {
      return deserialize<_i45.VatRate>(data['data']);
    }
    if (dataClassName == 'UpdateUserProfileRequest') {
      return deserialize<_i46.UpdateUserProfileRequest>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_i47.UserProfile>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i51.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i52.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _i51.Protocol().registerHostProtocol('gewerber_backend', this);
    _i52.Protocol().registerHostProtocol('gewerber_backend', this);
  }

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
      return _i51.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i52.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
