import 'package:bloc/bloc.dart';
import 'package:finance/core/routes/routes_names.dart';
import 'package:finance/core/shared/models/home_item_model.dart';
import 'package:flutter/material.dart';

part 'money_state.dart';

class MoneyCubit extends Cubit<MoneyState> {
  MoneyCubit() : super(MoneyInitial());

  final List<DefaultItemModel> itemList = [
    DefaultItemModel(
      id: 1,
      title: "Accounts",
      icon: Icons.account_balance_rounded,
      route: Routes.moneyAccountsScreen,
    ),
    DefaultItemModel(
      id: 2,
      title: "Cards",
      icon: Icons.credit_card_rounded,
      route: Routes.moneyAccountsScreen,
    ),
    DefaultItemModel(
      id: 3,
      title: "Expenses",
      icon: Icons.local_atm_rounded,
      route: Routes.moneyAccountsScreen,
    ),
    DefaultItemModel(
      id: 4,
      title: "Loans",
      icon: Icons.attach_money_rounded,
      route: Routes.moneyAccountsScreen,
    ),
  ];
}
