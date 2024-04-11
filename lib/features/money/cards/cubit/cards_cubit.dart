import 'package:bloc/bloc.dart';
import 'package:finance/core/routes/routes_names.dart';
import 'package:finance/core/services/navigation_service.dart';
import 'package:finance/core/utils/enums.dart';
import 'package:finance/core/utils/shared_functions.dart';
import 'package:finance/features/money/cards/data/models/bank_card_model.dart';
import 'package:finance/features/money/cards/database/cards_database.dart';
import 'package:flutter/material.dart';

part 'cards_state.dart';

class CardsCubit extends Cubit<CardsState> {
  CardsCubit() : super(CardsInitial());

  TextEditingController nameController = TextEditingController();
  TextEditingController nameOnCardController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  CardType cardType = CardType.debit;
  CardCompany cardCompany = CardCompany.visa;
  String year = "00", month = "00";

  List<BankCardModel> moneyCardList = [];

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

  void changeYear(value) {
    year = value;
    printLog(year);
  }

  void changeMonth(value) {
    month = value;
    printLog(month);
  }

  void changeCardType(value) {
    cardType = value;
    printLog(cardType);
  }

  void changeCardCompany(value) {
    cardCompany = value;
    printLog(cardCompany);
  }

  Future emitGetCard() async {
    try {
      emit(GetCardLoading());
      moneyCardList = await CardsDatabase.getCards();
      emit(GetCardSuccess());
    } catch (e) {
      emit(GetCardError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitInsertCard() async {
    try {
      BankCardModel cardModel = BankCardModel(
        name: nameController.text,
        nameOnCard: nameOnCardController.text,
        cardNumber: cardNumberController.text,
        exp: "$month/${year.substring(2,4)}",
        cvv: "123",
        cardType: cardType,
        cardCompany: cardCompany,
      );
      emit(InsertCardLoading());
      await CardsDatabase.insertCard(cardModel);
      moneyCardList.add(cardModel);
      emit(InsertCardSuccess());
      showMyToast(message: "Card Inserted Successfully", success: true);
      NavigationService.pushReplacementNamed(Routes.bankCardsScreen);
    } catch (e) {
      emit(InsertCardError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitDeleteCard({
    required int cardId,
  }) async {
    try {
      emit(DeleteCardLoading());
      await CardsDatabase.deleteCard(cardId);
      moneyCardList.removeWhere((element) => element.id == cardId);
      showMyToast(message: "Card Deleted Successfully", success: true);
      emit(DeleteCardSuccess());
    } catch (e) {
      emit(DeleteCardError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }
}
