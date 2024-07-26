import 'package:shawky/features/home/cubit/home_cubit.dart';
import 'package:shawky/features/money/accounts/cubit/accounts_cubit.dart';
import 'package:shawky/features/money/accounts/data/database/accounts_database.dart';
import 'package:shawky/features/money/cards/cubit/cards_cubit.dart';
import 'package:shawky/features/money/cards/data/database/cards_database.dart';
import 'package:shawky/features/money/expenses/cubit/expenses_cubit.dart';
import 'package:shawky/features/money/expenses/data/database/expenses_database.dart';
import 'package:shawky/features/money/gold/cubit/gold_cubit.dart';
import 'package:shawky/features/money/gold/data/database/gold_database.dart';
import 'package:shawky/features/money/savings/cubit/savings_cubit.dart';
import 'package:shawky/features/money/savings/data/database/saving_database.dart';
import 'package:shawky/features/profiles/cubit/profiles_cubit.dart';
import 'package:shawky/features/profiles/data/database/profiles_database.dart';
import 'package:shawky/features/settings/cubit/settings_cubit.dart';
import 'package:shawky/features/settings/data/database/settings_database.dart';
import 'package:shawky/features/splash/cubit/splash_cubit.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;

Future<void> initAppModule() async {
  // ------------------------- Cubits
  getIt.registerFactory<SplashCubit>(() => SplashCubit());
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
  getIt.registerFactory<AccountsCubit>(() => AccountsCubit(getIt()));
  getIt.registerFactory<CardsCubit>(() => CardsCubit(getIt()));
  getIt.registerFactory<ExpensesCubit>(() => ExpensesCubit(getIt()));
  getIt.registerFactory<GoldCubit>(() => GoldCubit(getIt()));
  getIt.registerFactory<SavingsCubit>(() => SavingsCubit(getIt()));
  getIt.registerFactory<ProfilesCubit>(() => ProfilesCubit(getIt()));
  getIt.registerFactory<SettingsCubit>(() => SettingsCubit(getIt()));
  // ------------------------- Database
  getIt.registerLazySingleton<AccountsDatabase>(() => AccountsDatabase());
  getIt.registerLazySingleton<CardsDatabase>(() => CardsDatabase());
  getIt.registerLazySingleton<ExpensesDatabase>(() => ExpensesDatabase());
  getIt.registerLazySingleton<GoldDatabase>(() => GoldDatabase());
  getIt.registerLazySingleton<SavingsDatabase>(() => SavingsDatabase());
  getIt.registerLazySingleton<ProfilesDatabase>(() => ProfilesDatabase());
  getIt.registerLazySingleton<SettingsDatabase>(() => SettingsDatabase());
}
