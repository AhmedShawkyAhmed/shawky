import 'package:shawky/features/home/cubit/home_cubit.dart';
import 'package:shawky/features/money/accounts/cubit/accounts_cubit.dart';
import 'package:shawky/features/money/cards/cubit/cards_cubit.dart';
import 'package:shawky/features/money/expenses/cubit/expenses_cubit.dart';
import 'package:shawky/features/money/home/cubit/money_cubit.dart';
import 'package:shawky/features/settings/cubit/settings_cubit.dart';
import 'package:shawky/features/splash/cubit/splash_cubit.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;

Future<void> initAppModule() async {
  getIt.registerFactory<SplashCubit>(() => SplashCubit());
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
  getIt.registerFactory<SettingsCubit>(() => SettingsCubit());
  // Money
  getIt.registerFactory<MoneyCubit>(() => MoneyCubit());
  getIt.registerFactory<AccountsCubit>(() => AccountsCubit());
  getIt.registerFactory<CardsCubit>(() => CardsCubit());
  getIt.registerFactory<ExpensesCubit>(() => ExpensesCubit());
}
