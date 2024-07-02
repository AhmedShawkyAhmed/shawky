import 'package:shawky/features/money/accounts/cubit/accounts_cubit.dart';
import 'package:shawky/features/money/expenses/cubit/expenses_cubit.dart';

class ExpensesArguments {
  final ExpensesCubit cubit;
  final String title;

  ExpensesArguments({
    required this.cubit,
    required this.title,
  });
}