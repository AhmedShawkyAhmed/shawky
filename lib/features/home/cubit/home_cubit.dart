import 'package:bloc/bloc.dart';
import 'package:shawky/core/resources/assets_manager.dart';
import 'package:shawky/core/routes/routes_names.dart';
import 'package:shawky/core/shared/models/home_item_model.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final List<DefaultItemModel> itemList = [
    DefaultItemModel(
      id: 1,
      title: "Profiles",
      icon: AssetsManager.profile,
      route: Routes.profilesScreen,
    ),
    DefaultItemModel(
      id: 2,
      title: "Money",
      icon: AssetsManager.money,
      route: Routes.moneyHomeScreen,
    ),
  ];
}
