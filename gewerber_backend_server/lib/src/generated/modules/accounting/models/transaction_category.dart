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

import 'package:serverpod/serverpod.dart' as _is;

enum TransactionCategory implements _is.SerializableModel {
  salesRevenue,
  serviceRevenue,
  otherIncome,
  goodsPurchase,
  rent,
  office,
  travel,
  vehicle,
  advertising,
  insurance,
  telecommunication,
  training,
  consulting,
  feesAndDuties,
  tools,
  otherExpense;

  static TransactionCategory fromJson(String name) {
    switch (name) {
      case 'salesRevenue':
        return TransactionCategory.salesRevenue;
      case 'serviceRevenue':
        return TransactionCategory.serviceRevenue;
      case 'otherIncome':
        return TransactionCategory.otherIncome;
      case 'goodsPurchase':
        return TransactionCategory.goodsPurchase;
      case 'rent':
        return TransactionCategory.rent;
      case 'office':
        return TransactionCategory.office;
      case 'travel':
        return TransactionCategory.travel;
      case 'vehicle':
        return TransactionCategory.vehicle;
      case 'advertising':
        return TransactionCategory.advertising;
      case 'insurance':
        return TransactionCategory.insurance;
      case 'telecommunication':
        return TransactionCategory.telecommunication;
      case 'training':
        return TransactionCategory.training;
      case 'consulting':
        return TransactionCategory.consulting;
      case 'feesAndDuties':
        return TransactionCategory.feesAndDuties;
      case 'tools':
        return TransactionCategory.tools;
      case 'otherExpense':
        return TransactionCategory.otherExpense;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "TransactionCategory"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
