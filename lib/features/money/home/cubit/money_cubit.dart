import 'package:bloc/bloc.dart';
import 'package:finance/core/resources/assets_manager.dart';
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
      icon: ImageAssets.creditCard,
      route: Routes.moneyAccountsScreen,
    ),
    DefaultItemModel(
      id: 2,
      title: "Cards",
      icon: ImageAssets.creditCard,
      route: Routes.moneyCardsScreen,
    ),
    DefaultItemModel(
      id: 3,
      title: "Expenses",
      icon: ImageAssets.creditCard,
      route: Routes.moneyAccountsScreen,
    ),
    DefaultItemModel(
      id: 4,
      title: "Loans",
      icon: ImageAssets.creditCard,
      route: Routes.moneyAccountsScreen,
    ),
  ];
}
