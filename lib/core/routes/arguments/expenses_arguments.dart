import 'package:shawky/features/money/accounts/cubit/accounts_cubit.dart';
import 'package:shawky/features/money/expenses/cubit/expenses_cubit.dart';
import 'package:shawky/features/money/expenses/data/models/expenses_model.dart';

class ExpensesArguments {
  final ExpensesCubit cubit;
  final AccountsCubit accountsCubit;
  final String title;
  final ExpensesModel? model;

  ExpensesArguments({
    required this.cubit,
    required this.accountsCubit,
    required this.title,
    this.model,
  });
}