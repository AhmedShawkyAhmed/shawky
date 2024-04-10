import 'package:bloc/bloc.dart';
import 'package:finance/core/resources/assets_manager.dart';
import 'package:finance/core/routes/routes_names.dart';
import 'package:finance/core/shared/models/home_item_model.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final List<DefaultItemModel> itemList = [
    DefaultItemModel(
      id: 1,
      title: "Money",
      icon: ImageAssets.creditCard,
      route: Routes.moneyHomeScreen,
    ),
  ];
}
