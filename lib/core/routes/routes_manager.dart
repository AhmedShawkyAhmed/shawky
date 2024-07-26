import 'package:flutter/material.dart';
import 'package:shawky/core/components/app/error_screen.dart';
import 'package:shawky/core/routes/arguments/account_arguments.dart';
import 'package:shawky/core/routes/arguments/card_arguments.dart';
import 'package:shawky/core/routes/arguments/expenses_arguments.dart';
import 'package:shawky/core/routes/arguments/profiles_arguments.dart';
import 'package:shawky/core/routes/arguments/saving_arguments.dart';
import 'package:shawky/core/routes/routes_names.dart';
import 'package:shawky/core/shared/widgets/default_text.dart';
import 'package:shawky/core/utils/shared_functions.dart';
import 'package:shawky/features/home/ui/screens/home_screen.dart';
import 'package:shawky/features/money/accounts/ui/screens/add_account_screen.dart';
import 'package:shawky/features/money/accounts/ui/screens/money_accounts_screen.dart';
import 'package:shawky/features/money/cards/ui/screens/add_card_screen.dart';
import 'package:shawky/features/money/cards/ui/screens/bank_cards_screen.dart';
import 'package:shawky/features/money/expenses/ui/screens/add_expenses_screen.dart';
import 'package:shawky/features/money/expenses/ui/screens/expenses_screen.dart';
import 'package:shawky/features/money/gold/cubit/gold_cubit.dart';
import 'package:shawky/features/money/gold/ui/screens/add_gold_screen.dart';
import 'package:shawky/features/money/gold/ui/screens/gold_screen.dart';
import 'package:shawky/features/money/home/ui/screens/money_home_screen.dart';
import 'package:shawky/features/money/savings/ui/screens/add_saving_screen.dart';
import 'package:shawky/features/money/savings/ui/screens/savings_screen.dart';
import 'package:shawky/features/profiles/ui/screens/add_profile_screen.dart';
import 'package:shawky/features/profiles/ui/screens/profile_details_screen.dart';
import 'package:shawky/features/profiles/ui/screens/profiles_screen.dart';
import 'package:shawky/features/settings/ui/screens/add_settings_screen.dart';
import 'package:shawky/features/splash/ui/screens/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    printRoute("Route ${settings.name}");
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.splashRoute),
          builder: (_) => const SplashScreen(),
        );
      case Routes.errorScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.errorScreen),
          builder: (_) => const ErrorScreen(),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.homeScreen),
          builder: (_) => const HomeScreen(),
        );
      case Routes.moneyHomeScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.moneyHomeScreen),
          builder: (_) => const MoneyHomeScreen(),
        );
      case Routes.accountsScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.accountsScreen),
          builder: (_) => const MoneyAccountsScreen(),
        );
      case Routes.addAccountsScreen:
        final AccountArguments args = settings.arguments as AccountArguments;
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.addAccountsScreen),
          builder: (_) => AddAccountScreen(args: args),
        );
      case Routes.bankCardsScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.bankCardsScreen),
          builder: (_) => const BankCardsScreen(),
        );
      case Routes.addCardsScreen:
        final CardArguments args = settings.arguments as CardArguments;
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.addCardsScreen),
          builder: (_) => AddCardScreen(args: args),
        );
      case Routes.expensesScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.expensesScreen),
          builder: (_) => const ExpensesScreen(),
        );
      case Routes.addExpensesScreen:
        final ExpensesArguments args = settings.arguments as ExpensesArguments;
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.addExpensesScreen),
          builder: (_) => AddExpensesScreen(args: args),
        );
      case Routes.savingsScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.savingsScreen),
          builder: (_) => const SavingsScreen(),
        );
      case Routes.addSavingScreen:
        final SavingArguments args = settings.arguments as SavingArguments;
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.addSavingScreen),
          builder: (_) => AddSavingScreen(args: args),
        );
      case Routes.goldScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.goldScreen),
          builder: (_) => const GoldScreen(),
        );
      case Routes.addGoldScreen:
        final GoldCubit cubit = settings.arguments as GoldCubit;
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.addGoldScreen),
          builder: (_) => AddGoldScreen(cubit: cubit),
        );
      case Routes.profilesScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.profilesScreen),
          builder: (_) => const ProfilesScreen(),
        );
      case Routes.profileDetailsScreen:
        final ProfilesArguments args = settings.arguments as ProfilesArguments;
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.profileDetailsScreen),
          builder: (_) => ProfileDetailsScreen(args: args),
        );
      case Routes.addProfileScreen:
        final ProfilesArguments args = settings.arguments as ProfilesArguments;
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.addProfileScreen),
          builder: (_) => AddProfileScreen(args: args),
        );
      case Routes.addSettingsScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.addSettingsScreen),
          builder: (_) => const AddSettingsScreen(),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: "unDefinedRoute"),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const DefaultText(text: "No Route Found"),
        ),
        body: const Center(child: DefaultText(text: "No Route Found")),
      ),
    );
  }
}
