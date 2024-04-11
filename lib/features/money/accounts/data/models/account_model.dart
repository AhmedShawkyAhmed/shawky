import 'package:shawky/core/utils/enums.dart';

class AccountModel {
  int? id;
  AccountTypes? type;
  String? name;
  Currency? currency;
  String? updatedAt;
  double? amount;
  double? rate;

  AccountModel({
    this.id,
    this.type,
    this.name,
    this.currency,
    this.updatedAt,
    this.amount,
    this.rate,
  });
}
