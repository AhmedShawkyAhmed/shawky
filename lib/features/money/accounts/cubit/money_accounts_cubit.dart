import 'package:bloc/bloc.dart';
import 'package:finance/core/utils/enums.dart';
import 'package:finance/features/money/accounts/data/models/money_account_model.dart';
import 'package:flutter/material.dart';

part 'money_accounts_state.dart';

class MoneyAccountsCubit extends Cubit<MoneyAccountsState> {
  MoneyAccountsCubit() : super(MoneyAccountsInitial());

  final List<MoneyAccountModel> moneyAccounts = [
    MoneyAccountModel(
      id: 1,
      type: "Main",
      name: "BM EGP",
      amount: 36000,
      rate: 1,
      currency: Currency.egp,
      updatedAt: "9/4/2024"
    ),
    MoneyAccountModel(
        id: 2,
        type: "Saving",
        name: "BM USD",
        amount: 8400,
        rate: 47.5,
        currency: Currency.usd,
        updatedAt: "9/4/2024"
    ),
  ];
}
