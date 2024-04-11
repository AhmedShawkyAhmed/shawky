import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/features/money/accounts/data/models/account_model.dart';
import 'package:shawky/features/money/expenses/data/models/expenses_category_model.dart';

class ExpensesModel {
  final int id;
  final String name;
  final Currency currency;
  final double amount;
  final double rate;
  final ExpensesType type;
  final ExpensesCategoryModel category;
  final AccountModel fromAccount;
  final AccountModel toAccount;
  final String date;

  ExpensesModel({
    required this.id,
    required this.name,
    required this.currency,
    required this.amount,
    required this.rate,
    required this.type,
    required this.category,
    required this.fromAccount,
    required this.toAccount,
    required this.date,
  });
}
