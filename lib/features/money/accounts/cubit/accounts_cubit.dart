import 'package:bloc/bloc.dart';
import 'package:finance/core/utils/enums.dart';
import 'package:finance/features/money/accounts/data/models/account_model.dart';
import 'package:flutter/material.dart';

part 'accounts_state.dart';

class AccountsCubit extends Cubit<AccountsState> {
  AccountsCubit() : super(AccountsInitial());

  final List<AccountModel> moneyAccounts = [
    AccountModel(
      id: 1,
      type: AccountTypes.main,
      name: "BM EGP",
      amount: 36000,
      rate: 1,
      currency: Currency.egp,
      updatedAt: "9/4/2024",
    ),
    AccountModel(
      id: 2,
      type: AccountTypes.saving,
      name: "BM USD",
      amount: 8400,
      rate: 47.5,
      currency: Currency.usd,
      updatedAt: "9/4/2024",
    ),
  ];

  final List<AccountTypes> accountTypesList = AccountTypes.values;
  final List<Currency> currencyList = Currency.values;
}
