import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/core/utils/shared_functions.dart';
import 'package:shawky/features/money/cards/database/cards_database.dart';
import 'package:shawky/features/money/cards/models/bank_card_model.dart';

part 'cards_state.dart';

class CardsCubit extends Cubit<CardsState> {
  CardsCubit(this.database) : super(CardsInitial());

  final CardsDatabase database;

  TextEditingController nameController = TextEditingController();
  TextEditingController nameOnCardController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  CardType cardType = CardType.debit;
  CardCompany cardCompany = CardCompany.visa;
  String year = "00", month = "00";

  List<BankCardModel> moneyCardList = [];

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

  void dispose() {
    nameController = TextEditingController();
    nameOnCardController = TextEditingController();
    cardNumberController = TextEditingController();
    cvvController = TextEditingController();
  }

  Future emitGetCard() async {
    try {
      emit(GetCardLoading());
      moneyCardList = await database.getCards();
      emit(GetCardSuccess());
    } catch (e) {
      emit(GetCardError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitAddCard() async {
    try {
      BankCardModel cardModel = BankCardModel(
        name: nameController.text,
        nameOnCard: nameOnCardController.text,
        cardNumber: cardNumberController.text,
        exp: "$month/${year.substring(2, 4)}",
        cvv: cvvController.text,
        cardType: cardType,
        cardCompany: cardCompany,
      );
      emit(AddCardLoading());
      await database.addCard(cardModel);
      emit(AddCardSuccess());
      emitGetCard();
      showMyToast(message: "Card Added Successfully", success: true);
      dispose();
      NavigationService.pop();
    } catch (e) {
      emit(AddCardError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitUpdateCard({
    required BankCardModel model,
  }) async {
    try {
      BankCardModel cardModel = BankCardModel(
        id: model.id,
        name: nameController.text.isEmpty ? model.name : nameController.text,
        nameOnCard: nameOnCardController.text.isEmpty
            ? model.nameOnCard
            : nameOnCardController.text,
        cardNumber: cardNumberController.text.isEmpty
            ? model.cardNumber
            : cardNumberController.text,
        exp:
            "${month == "00" ? model.exp.substring(0, 2) : month}/${year == "00" ? model.exp.substring(3, 5) : year.substring(2, 4)}",
        cvv: cvvController.text.isEmpty ? model.cvv : cvvController.text,
        cardType: model.cardType,
        cardCompany: model.cardCompany,
      );
      emit(UpdateCardLoading());
      await database.updateCard(cardModel);
      emit(UpdateCardSuccess());
      int index = moneyCardList.indexOf(model);
      moneyCardList.removeAt(index);
      moneyCardList.insert(index, cardModel);
      showMyToast(message: "Card Updated Successfully", success: true);
      dispose();
      NavigationService.pop();
    } catch (e) {
      emit(UpdateCardError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitDeleteCard({
    required int cardId,
  }) async {
    try {
      emit(DeleteCardLoading());
      await database.deleteCard(cardId);
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
