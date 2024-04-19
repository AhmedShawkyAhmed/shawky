import 'package:shawky/features/money/accounts/cubit/accounts_cubit.dart';
import 'package:shawky/features/money/expenses/cubit/expenses_cubit.dart';

class ExpensesArguments {
  final ExpensesCubit cubit;
  final AccountsCubit accountsCubit;
  final String title;

  ExpensesArguments({
    required this.cubit,
    required this.accountsCubit,
    required this.title,
  });
}