import 'package:finance/features/home/cubit/home_cubit.dart';
import 'package:finance/features/money/accounts/cubit/money_accounts_cubit.dart';
import 'package:finance/features/money/home/cubit/money_cubit.dart';
import 'package:finance/features/splash/cubit/splash_cubit.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;

Future<void> initAppModule() async {
  getIt.registerFactory<SplashCubit>(() => SplashCubit());
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
  // Money
  getIt.registerFactory<MoneyCubit>(() => MoneyCubit());
  getIt.registerFactory<MoneyAccountsCubit>(() => MoneyAccountsCubit());
}
