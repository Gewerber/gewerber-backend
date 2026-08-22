import '../../../generated/protocol.dart';

/// Maps accounting categories to their transaction type.
class TransactionCategories {
  const TransactionCategories._();

  static const Set<TransactionCategory> incomeCategories = {
    TransactionCategory.salesRevenue,
    TransactionCategory.serviceRevenue,
    TransactionCategory.otherIncome,
  };

  static TransactionType typeOf(TransactionCategory category) {
    return incomeCategories.contains(category)
        ? TransactionType.income
        : TransactionType.expense;
  }

  static bool matches(TransactionType type, TransactionCategory category) {
    return typeOf(category) == type;
  }
}
