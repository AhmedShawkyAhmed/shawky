import 'package:shawky/features/money/cards/cubit/cards_cubit.dart';
import 'package:shawky/features/money/cards/models/bank_card_model.dart';

class CardArguments {
  final CardsCubit cubit;
  final String title;
  final BankCardModel? model;

  CardArguments({
    required this.cubit,
    required this.title,
    this.model,
  });
}
