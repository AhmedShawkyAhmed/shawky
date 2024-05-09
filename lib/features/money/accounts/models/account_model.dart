import 'package:shawky/core/utils/enums.dart';

class AccountModel {
  int? id;
  AccountTypes? accountType;
  String? name;
  Currency? currency;
  String? updatedAt;
  double? amount;

  AccountModel({
    this.id,
    this.accountType,
    this.name,
    this.currency,
    this.updatedAt,
    this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'updatedAt': updatedAt,
      'amount': amount,
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
        'updatedAt: $updatedAt, '
        '}';
  }
}
