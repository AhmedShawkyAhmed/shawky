import 'package:shawky/features/money/accounts/cubit/accounts_cubit.dart';
import 'package:shawky/features/money/accounts/data/models/account_model.dart';

class AccountArguments {
  final AccountsCubit cubit;
  final String title;
  final AccountModel? model;

  AccountArguments({
    required this.cubit,
    required this.title,
    this.model,
  });
}
