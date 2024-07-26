import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/resources/globals.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/services/service_locator.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/core/utils/shared_functions.dart';
import 'package:shawky/features/money/accounts/cubit/accounts_cubit.dart';
import 'package:shawky/features/money/accounts/data/models/account_model.dart';
import 'package:shawky/features/money/expenses/data/constants/expenses_constants.dart';
import 'package:shawky/features/money/expenses/data/database/expenses_database.dart';
import 'package:shawky/features/money/expenses/data/models/expenses_category_model.dart';
import 'package:shawky/features/money/expenses/data/models/expenses_model.dart';

part 'expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  ExpensesCubit(this.database) : super(ExpensesInitial());

  final ExpensesDatabase database;

  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  ExpensesCategoryModel expensesCategoryModel = ExpensesCategoryModel();
  AccountModel fromAccount = AccountModel();
  AccountModel toAccount = AccountModel();

  ExpensesType expensesType = ExpensesType.expenses;
  Currency currency = Currency.egp;
  int expensesCategory = 0;
  DateTime? currentDate;

  List<ExpensesCategoryModel> categoryList = [];
  List<ExpensesModel> expensesList = [];
  List<ExpensesModel> filteredExpensesList = [];
  List<PieChartSectionData> pieChartSectionData = [];

  clearLists() {
    categoryList.clear();
    expensesList.clear();
    filteredExpensesList.clear();
    pieChartSectionData.clear();
  }

  dispose() {
    nameController = TextEditingController();
    amountController = TextEditingController();
    dateController = TextEditingController();
    expensesCategoryModel = ExpensesCategoryModel();
    fromAccount = AccountModel();
    toAccount = AccountModel();
  }

  Future<void> selectDate(bool inForm) async {
    final DateTime? picked = await showDatePicker(
      context: NavigationService.context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020, 8),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blue,
              cardColor: const Color(0xff232323),
              brightness: Brightness.dark,
            ),
            dialogBackgroundColor: ColorManager.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      if (inForm) {
        dateController.text = picked.toString().substring(0, 10);
      } else {
        currentDate = picked;
        WidgetsBinding.instance.reassembleApplication();
      }
    }
  }

  Future getCategoryList({
    required List<ExpensesModel> expenses,
  }) async {
    categoryList.clear();
    for (int i = 0; i < expenses.length; i++) {
      if (categoryList
          .where((element) => element.id == expenses[i].category)
          .toList()
          .isEmpty) {
        categoryList.add(
          ExpensesCategoryModel(
            id: ExpensesConstants.expensesCategoryList
                .where((element) => (element.id == expenses[i].category))
                .toList()
                .first
                .id,
            name: ExpensesConstants.expensesCategoryList
                .where((element) => (element.id == expenses[i].category))
                .toList()
                .first
                .name,
            color: ExpensesConstants.expensesCategoryList
                .where((element) => (element.id == expenses[i].category))
                .toList()
                .first
                .color,
            amount: (expenses[i].amount * expenses[i].rate),
          ),
        );
      } else {
        int index = categoryList
            .indexWhere((element) => element.id == expenses[i].category);
        categoryList[index].amount = (categoryList[index].amount)! +
            (expenses[i].amount * expenses[i].rate);
      }
    }
  }

  void changeExpensesType(value) {
    expensesType = value;
    WidgetsBinding.instance.reassembleApplication();
  }

  void changeExpensesCategory(value) {
    expensesCategoryModel = value;
    expensesCategory = expensesCategoryModel.id!;
  }

  void changeFromAccount(value) {
    fromAccount = value;
  }

  void changeToAccount(value) {
    toAccount = value;
  }

  void changeCurrency(value) {
    currency = value;
  }

  void chartSections() {
    pieChartSectionData.clear();
    for (var sector in categoryList.toList()) {
      const double radius = 20.0;
      PieChartSectionData data = PieChartSectionData(
        color: sector.color,
        value: sector.amount!.toDouble(),
        radius: radius,
        title: '',
      );
      pieChartSectionData.add(data);
    }
  }

  Color getExpensesColor(int id) {
    return ExpensesConstants.expensesCategoryList
        .where((element) => element.id == id)
        .first
        .color!;
  }

  String getExpensesCategory(int id) {
    return ExpensesConstants.expensesCategoryList
        .where((element) => element.id == id)
        .first
        .name!;
  }

  Future emitGetExpenses({
    required int month,
  }) async {
    try {
      clearLists();
      printLog(month);
      emit(GetExpenseLoading());
      expensesList = await database.getExpenses(month);
      filteredExpensesList = expensesList;
      await getCategoryList(expenses: expensesList);
      chartSections();
      emit(GetExpenseSuccess());
    } catch (e) {
      emit(GetExpenseError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitFilterExpenses() async {
    await selectDate(false);
    emitGetExpenses(month: currentDate?.month ?? DateTime.now().month);
  }

  Future emitAddExpense() async {
    try {
      if (expensesCategory == 0) {
        showMyToast(message: "Select Category");
        return;
      }
      ExpensesModel expensesModel = ExpensesModel(
        name: nameController.text,
        amount: double.tryParse(amountController.text)!,
        rate: currency == Currency.egp ? 1.0 : Globals.settings?.rate ?? 1,
        fromAccount: fromAccount.name == null
            ? ExpensesConstants.salaryAccount
            : fromAccount,
        toAccount: toAccount.name == null
            ? ExpensesConstants.expensesAccount
            : toAccount,
        date: dateController.text.isEmpty
            ? DateTime.now().toString().substring(0, 10)
            : dateController.text,
        currency: currency,
        type: expensesType,
        category: expensesCategory,
      );
      emit(AddExpenseLoading());
      await database.addExpense(expensesModel);
      emit(AddExpenseSuccess());
      emitGetExpenses(month: DateTime.now().month);
      showMyToast(message: "Expense Added Successfully", success: true);
      updateAccounts(
        from: fromAccount,
        to: toAccount,
        type: expensesType,
        amount: amountController.text,
      );
      dispose();
      NavigationService.pop();
    } catch (e) {
      emit(AddExpenseError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future updateAccounts({
    required AccountModel from,
    required AccountModel to,
    required ExpensesType type,
    required String amount,
  }) async {
    if (type == ExpensesType.income) {
      await getIt<AccountsCubit>().emitUpdateAccount(
        fromExpenses: true,
        model: AccountModel(
          id: to.id,
          accountType: to.accountType,
          amount: to.amount! + double.tryParse(amount)!,
          name: to.name,
          currency: to.currency,
          updatedAt: to.updatedAt,
        ),
      );
    } else if (type == ExpensesType.expenses) {
      await getIt<AccountsCubit>().emitUpdateAccount(
        fromExpenses: true,
        model: AccountModel(
          id: from.id,
          accountType: from.accountType,
          amount: from.amount! - double.tryParse(amount)!,
          name: from.name,
          currency: from.currency,
          updatedAt: from.updatedAt,
        ),
      );
    } else {
      await getIt<AccountsCubit>().emitUpdateAccount(
        fromExpenses: true,
        model: AccountModel(
          id: to.id,
          accountType: to.accountType,
          amount: to.amount! + double.tryParse(amount)!,
          name: to.name,
          currency: to.currency,
          updatedAt: to.updatedAt,
        ),
      );
      await getIt<AccountsCubit>().emitUpdateAccount(
        fromExpenses: true,
        model: AccountModel(
          id: from.id,
          accountType: from.accountType,
          amount: from.amount! - double.tryParse(amount)!,
          name: from.name,
          currency: from.currency,
          updatedAt: from.updatedAt,
        ),
      );
    }
  }

  Future emitDeleteExpense({
    required int expenseId,
  }) async {
    try {
      emit(DeleteExpenseLoading());
      await database.deleteExpense(expenseId);
      emitGetExpenses(month: DateTime.now().month);
      showMyToast(message: "Expense Deleted Successfully", success: true);
      emit(DeleteExpenseSuccess());
    } catch (e) {
      emit(DeleteExpenseError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }
}
