import 'package:bloc/bloc.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/core/utils/shared_functions.dart';
import 'package:shawky/features/money/accounts/models/account_model.dart';
import 'package:flutter/material.dart';
import 'package:shawky/features/money/accounts/database/accounts_database.dart';

part 'accounts_state.dart';

class AccountsCubit extends Cubit<AccountsState> {
  AccountsCubit() : super(AccountsInitial());

  TextEditingController accountNameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
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
    printLog(currency);
  }

  dispose() {
    accountNameController = TextEditingController();
    amountController = TextEditingController();
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

  Future emitAddAccount() async {
    try {
      AccountModel accountModel = AccountModel(
        name: accountNameController.text,
        amount: double.tryParse(amountController.text),
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
    bool fromExpenses = false,
  }) async {
    try {
      AccountModel accountModel = AccountModel(
        id: model.id,
        name: accountNameController.text.isEmpty
            ? model.name
            : accountNameController.text,
        amount: amountController.text.isEmpty
            ? model.amount
            : double.tryParse(amountController.text),
        accountType: model.accountType ?? accountType,
        currency: model.currency ?? currency,
        updatedAt: selectedDate.toString(),
      );
      emit(UpdateAccountLoading());
      await AccountsDatabase.updateAccount(accountModel);
      emit(UpdateAccountSuccess());
      if(fromExpenses == false){
        int index = moneyAccounts.indexOf(model);
        moneyAccounts.removeAt(index);
        moneyAccounts.insert(index, accountModel);
        showMyToast(message: "Account Updated Successfully", success: true);
        dispose();
        NavigationService.pop();
      }
    } catch (e) {
      emit(UpdateAccountError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitDeleteAccount({
    required int accountId,
  }) async {
    try {
      emit(DeleteAccountLoading());
      await AccountsDatabase.deleteAccount(accountId);
      moneyAccounts.removeWhere((element) => element.id == accountId);
      showMyToast(message: "Account Deleted Successfully", success: true);
      emit(DeleteAccountSuccess());
    } catch (e) {
      emit(DeleteAccountError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }
}
