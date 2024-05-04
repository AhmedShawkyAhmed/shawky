import 'package:bloc/bloc.dart';
import 'package:shawky/core/resources/assets_manager.dart';
import 'package:shawky/core/routes/routes_names.dart';
import 'package:shawky/core/shared/models/home_item_model.dart';
import 'package:flutter/material.dart';

part 'money_state.dart';

class MoneyCubit extends Cubit<MoneyState> {
  MoneyCubit() : super(MoneyInitial());

  final List<DefaultItemModel> itemList = [
    DefaultItemModel(
      id: 1,
      title: "Accounts",
      icon: AssetsManager.passbook,
      route: Routes.accountsScreen,
    ),
    DefaultItemModel(
      id: 2,
      title: "Cards",
      icon: AssetsManager.creditCard,
      route: Routes.bankCardsScreen,
    ),
    DefaultItemModel(
      id: 3,
      title: "Expenses",
      icon: AssetsManager.expenses,
      route: Routes.expensesScreen,
    ),
    DefaultItemModel(
      id: 4,
      title: "Savings",
      icon: AssetsManager.purchases,
      route: Routes.savingsScreen,
    ),
    DefaultItemModel(
      id: 5,
      title: "Gold",
      icon: AssetsManager.gold,
      route: Routes.goldScreen,
    ),
  ];
}
