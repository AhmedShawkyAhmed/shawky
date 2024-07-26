import 'package:shawky/features/money/savings/cubit/savings_cubit.dart';
import 'package:shawky/features/money/savings/data/models/saving_model.dart';

class SavingArguments {
  final SavingsCubit cubit;
  final String title;
  final SavingModel? model;

  SavingArguments({
    required this.cubit,
    required this.title,
    this.model,
  });
}
