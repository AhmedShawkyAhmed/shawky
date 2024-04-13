import 'package:bloc/bloc.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/core/utils/shared_functions.dart';
import 'package:shawky/features/money/accounts/data/models/account_model.dart';
import 'package:flutter/material.dart';
import 'package:shawky/features/money/accounts/database/accounts_database.dart';

part 'accounts_state.dart';

class AccountsCubit extends Cubit<AccountsState> {
  AccountsCubit() : super(AccountsInitial());

  TextEditingController accountNameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  AccountTypes accountType = AccountTypes.main;
  Currency currency = Currency.egp;
  DateTime selectedDate = DateTime.now();

  List<AccountModel> moneyAccounts = [];

  final List<AccountTypes> accountTypesList = AccountTypes.values;
  final List<Currency> currencyList = Currency.values;

  void changeAccountTypes(value) {
    accountType = value;
    printLog(accountType);
  }

  void changeCurrency(value) {
    currency = value;
    if (currency == Currency.egp) {
      rateController.clear();
      rateController.text = "1";
    }
    printLog(currency);
  }

  dispose() {
    accountNameController = TextEditingController();
    amountController = TextEditingController();
    rateController = TextEditingController();
    accountType = AccountTypes.main;
    currency = Currency.egp;
    selectedDate = DateTime.now();
  }

  Future emitGetAccounts() async {
    try {
      emit(GetAccountLoading());
      moneyAccounts = await AccountsDatabase.getAccounts();
      emit(GetAccountSuccess());
    } catch (e) {
      emit(GetAccountError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitAddCard() async {
    try {
      AccountModel accountModel = AccountModel(
        name: accountNameController.text,
        amount: double.tryParse(amountController.text),
        rate: currency == Currency.egp
            ? 1.0
            : double.tryParse(rateController.text),
        accountType: accountType,
        currency: currency,
        updatedAt: selectedDate.toString(),
      );
      emit(AddAccountLoading());
      await AccountsDatabase.addAccount(accountModel);
      emit(AddAccountSuccess());
      emitGetAccounts();
      showMyToast(message: "Account Added Successfully", success: true);
      dispose();
      NavigationService.pop();
    } catch (e) {
      emit(AddAccountError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitUpdateAccount({
    required AccountModel model,
  }) async {
    try {
      AccountModel accountModel = AccountModel(
        id: model.id,
        name: accountNameController.text.isEmpty ? model.name : accountNameController.text,
        amount:amountController.text.isEmpty?model.amount: double.tryParse(amountController.text),
        rate: currency == Currency.egp
            ? 1.0
            :rateController.text.isEmpty?model.rate: double.tryParse(rateController.text),
        accountType: model.accountType,
        currency: model.currency,
        updatedAt: selectedDate.toString(),
      );
      emit(UpdateAccountLoading());
      await AccountsDatabase.updateAccount(accountModel);
      emit(UpdateAccountSuccess());
      int index = moneyAccounts.indexOf(model);
      moneyAccounts.removeAt(index);
      moneyAccounts.insert(index, accountModel);
      showMyToast(message: "Account Updated Successfully", success: true);
      dispose();
      NavigationService.pop();
    } catch (e) {
      emit(UpdateAccountError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitDeleteAccount({
    required String accountId,
  }) async {
    try {
      emit(DeleteAccountLoading());
      await AccountsDatabase.deleteAccount(accountId);
      moneyAccounts.removeWhere((element) => element.id == accountId);
      showMyToast(message: "Card Deleted Successfully", success: true);
      emit(DeleteAccountSuccess());
    } catch (e) {
      emit(DeleteAccountError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }
}
