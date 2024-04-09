import 'package:finance/core/utils/enums.dart';

class MoneyAccountModel{
  final int id;
  final AccountTypes type;
  final String name;
  final Currency currency;
  final String updatedAt;
  final double amount;
  final double rate;

  MoneyAccountModel({
    required this.id,
    required this.type,
    required this.name,
    required this.currency,
    required this.updatedAt,
    required this.amount,
    required this.rate,
});
}