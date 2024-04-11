import 'package:shawky/features/money/cards/cubit/cards_cubit.dart';
import 'package:shawky/features/money/cards/data/models/bank_card_model.dart';

class CardArguments {
  final CardsCubit cubit;
  final String title;
  final BankCardModel? model;
  final bool isEdit;

  CardArguments({
    required this.cubit,
    required this.title,
    this.model,
    this.isEdit = false,
  });
}
