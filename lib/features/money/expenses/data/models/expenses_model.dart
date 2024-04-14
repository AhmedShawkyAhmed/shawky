import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/features/money/accounts/data/models/account_model.dart';

class ExpensesModel {
  final int? id;
  final String name;
  final double amount;
  final double rate;
  final Currency currency;
  final ExpensesType type;
  final int category;
  final AccountModel fromAccount;
  final AccountModel toAccount;
  final String date;

  ExpensesModel({
    this.id,
    required this.name,
    required this.amount,
    required this.rate,
    required this.currency,
    required this.type,
    required this.category,
    required this.fromAccount,
    required this.toAccount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'rate': rate,
      'currency': currency.name,
      'type': type.name,
      'category': category,
      'fromAccount': fromAccount.name,
      'toAccount': toAccount.name,
      'date': date,
    };
  }

  @override
  String toString() {
    return 'Expenses{'
        'id: $id, '
        'name: $name, '
        'amount: $amount, '
        'rate: $rate, '
        'currency: $currency, '
        'type: $type, '
        'category: $category, '
        'fromAccount: $fromAccount, '
        'toAccount: $toAccount, '
        'date: $date, '
        '}';
  }
}
