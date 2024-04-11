import 'package:finance/core/components/app/error_screen.dart';
import 'package:finance/core/routes/routes_names.dart';
import 'package:finance/core/shared/widgets/default_text.dart';
import 'package:finance/core/utils/shared_functions.dart';
import 'package:finance/features/home/cubit/home_cubit.dart';
import 'package:finance/features/home/screens/home_screen.dart';
import 'package:finance/features/money/accounts/cubit/accounts_cubit.dart';
import 'package:finance/features/money/accounts/screens/add_account_screen.dart';
import 'package:finance/features/money/accounts/screens/money_accounts_screen.dart';
import 'package:finance/features/money/cards/cubit/cards_cubit.dart';
import 'package:finance/features/money/cards/screens/add_card_screen.dart';
import 'package:finance/features/money/cards/screens/bank_cards_screen.dart';
import 'package:finance/features/money/expenses/cubit/expenses_cubit.dart';
import 'package:finance/features/money/expenses/screens/add_expenses_screen.dart';
import 'package:finance/features/money/expenses/screens/expenses_screen.dart';
import 'package:finance/features/money/home/cubit/money_cubit.dart';
import 'package:finance/features/money/home/screens/money_home_screen.dart';
import 'package:finance/features/splash/cubit/splash_cubit.dart';
import 'package:finance/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    printLog("Route ${settings.name}");
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.splashRoute),
          builder: (_) => BlocProvider(
            create: (context) => SplashCubit()..init(),
            child: const SplashScreen(),
          ),
        );
      case Routes.errorScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.errorScreen),
          builder: (_) => const ErrorScreen(),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.homeScreen),
          builder: (_) => BlocProvider(
            create: (context) => HomeCubit(),
            child: const HomeScreen(),
          ),
        );
      case Routes.moneyHomeScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.moneyHomeScreen),
          builder: (_) => BlocProvider(
            create: (context) => MoneyCubit(),
            child: const MoneyHomeScreen(),
          ),
        );
      case Routes.accountsScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.accountsScreen),
          builder: (_) => BlocProvider(
            create: (context) => AccountsCubit(),
            child: const MoneyAccountsScreen(),
          ),
        );
      case Routes.addAccountsScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.addAccountsScreen),
          builder: (_) => BlocProvider(
            create: (context) => AccountsCubit(),
            child: const AddAccountScreen(),
          ),
        );
      case Routes.bankCardsScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.bankCardsScreen),
          builder: (_) => BlocProvider(
            create: (context) => CardsCubit(),
            child: const BankCardsScreen(),
          ),
        );
      case Routes.addCardsScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.addCardsScreen),
          builder: (_) => BlocProvider(
            create: (context) => CardsCubit(),
            child: const AddCardScreen(),
          ),
        );
      case Routes.expensesScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.expensesScreen),
          builder: (_) => BlocProvider(
            create: (context) => ExpensesCubit(),
            child: const ExpensesScreen(),
          ),
        );
      case Routes.addExpensesScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: Routes.addExpensesScreen),
          builder: (_) => BlocProvider(
            create: (context) => ExpensesCubit(),
            child: const AddExpensesScreen(),
          ),
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
