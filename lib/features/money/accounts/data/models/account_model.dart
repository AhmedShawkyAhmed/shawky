import 'package:shawky/core/utils/enums.dart';

class AccountModel {
  String? id;
  AccountTypes? accountType;
  String? name;
  Currency? currency;
  String? updatedAt;
  double? amount;
  double? rate;

  AccountModel({
    this.id,
    this.accountType,
    this.name,
    this.currency,
    this.updatedAt,
    this.amount,
    this.rate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'updatedAt': updatedAt,
      'amount': amount,
      'rate': rate,
      'accountType': accountType?.name,
      'currency': currency?.name,
    };
  }

  @override
  String toString() {
    return 'Account{'
        'id: $id, '
        'name: $name, '
        'accountType: $accountType, '
        'currency: $currency, '
        'amount: $amount, '
        'rate: $rate, '
        'updatedAt: $updatedAt, '
        '}';
  }
}
