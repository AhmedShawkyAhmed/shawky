import 'package:shawky/core/resources/assets_manager.dart';
import 'package:shawky/core/routes/routes_names.dart';
import 'package:shawky/core/shared/models/home_item_model.dart';

class HomeConstants{

  static List<DefaultItemModel> itemList = [
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