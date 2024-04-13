import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory AccountModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return AccountModel(
      id: data?['id'],
      accountType: AccountTypes.values
          .where((element) => element.name == data?['type'])
          .first,
      name: data?['name'],
      currency: Currency.values
          .where((element) => element.name == data?['currency'])
          .first,
      updatedAt: data?['updatedAt'],
      amount: data?['amount'],
      rate: data?['rate'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (accountType != null) "type": accountType?.name,
      if (name != null) "name": name,
      if (currency != null) "currency": currency?.name,
      if (updatedAt != null) "updatedAt": updatedAt,
      if (amount != null) "amount": amount,
      if (rate != null) "rate": rate,
    };
  }
}
