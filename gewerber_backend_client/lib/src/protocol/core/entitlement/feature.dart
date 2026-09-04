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

import 'package:serverpod_client/serverpod_client.dart' as _isc;

enum Feature implements _isc.SerializableModel {
  invoicing,
  time_tracking,
  accounting,
  documents,
  guidance,
  banking,
  tax,
  employees,
  subscriptions,
  ai_assistant,
  multi_currency;

  static Feature fromJson(String name) {
    switch (name) {
      case 'invoicing':
        return Feature.invoicing;
      case 'time_tracking':
        return Feature.time_tracking;
      case 'accounting':
        return Feature.accounting;
      case 'documents':
        return Feature.documents;
      case 'guidance':
        return Feature.guidance;
      case 'banking':
        return Feature.banking;
      case 'tax':
        return Feature.tax;
      case 'employees':
        return Feature.employees;
      case 'subscriptions':
        return Feature.subscriptions;
      case 'ai_assistant':
        return Feature.ai_assistant;
      case 'multi_currency':
        return Feature.multi_currency;
      default:
        throw ArgumentError('Value "$name" cannot be converted to "Feature"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
