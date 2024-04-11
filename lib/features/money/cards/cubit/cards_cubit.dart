import 'package:bloc/bloc.dart';
import 'package:finance/core/utils/enums.dart';
import 'package:finance/features/money/cards/data/models/bank_card_model.dart';
import 'package:flutter/material.dart';

part 'cards_state.dart';

class CardsCubit extends Cubit<CardsState> {
  CardsCubit() : super(CardsInitial());

  final List<BankCardModel> moneyCardList = [
    BankCardModel(
      id: 1,
      name: "Banque Misr",
      nameOnCard: "AHMED SHAWKY AHMED",
      exp: "04/28",
      cardNumber: "1542 1565 1565 1545",
      cardType: CardType.debit,
      cardCompany: CardCompany.visa,
    ),
    BankCardModel(
      id: 2,
      name: "Banque Misr",
      nameOnCard: "AHMED SHAWKY AHMED",
      exp: "04/28",
      cardNumber: "1542 1565 1565 1545",
      cardType: CardType.debit,
      cardCompany: CardCompany.visa,
    ),
    BankCardModel(
      id: 3,
      name: "Banque Misr",
      nameOnCard: "AHMED SHAWKY AHMED",
      exp: "04/28",
      cardNumber: "1542 1565 1565 1545",
      cardType: CardType.prepaid,
      cardCompany: CardCompany.mastercard,
    ),
  ];

  final List<CardType> cardTypeList = CardType.values;
  final List<CardCompany> cardCompanyList = CardCompany.values;
  final List<String> monthList = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
  ];
  final List<String> yearList = [
    (DateTime.now().year).toString(),
    (DateTime.now().year + 1).toString(),
    (DateTime.now().year + 2).toString(),
    (DateTime.now().year + 3).toString(),
    (DateTime.now().year + 4).toString(),
    (DateTime.now().year + 5).toString(),
    (DateTime.now().year + 6).toString(),
    (DateTime.now().year + 7).toString(),
    (DateTime.now().year + 8).toString(),
    (DateTime.now().year + 9).toString(),
    (DateTime.now().year + 10).toString(),
  ];
}
