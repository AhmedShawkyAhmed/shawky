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
import 'package:shawky/features/money/accounts/models/account_model.dart';
import 'package:shawky/features/money/expenses/database/expenses_database.dart';
import 'package:shawky/features/money/expenses/models/expenses_category_model.dart';
import 'package:shawky/features/money/expenses/models/expenses_model.dart';

part 'expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  ExpensesCubit() : super(ExpensesInitial());

  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  ExpensesCategoryModel expensesCategoryModel = ExpensesCategoryModel();
  AccountModel fromAccount = AccountModel();
  AccountModel toAccount = AccountModel();
  AccountModel expensesAccount = AccountModel(
    id: 0,
    name: "Expenses",
  );
  AccountModel salaryAccount = AccountModel(
    id: 0,
    name: "Salary",
  );
  ExpensesType expensesType = ExpensesType.expenses;
  Currency currency = Currency.egp;
  int expensesCategory = 0;
  DateTime? currentDate;

  final List<ExpensesType> expensesTypeList = ExpensesType.values;
  final List<Currency> currencyList = Currency.values;
  final List<ExpensesCategoryModel> expensesCategoryList = [
    ExpensesCategoryModel(
      id: 1,
      name: "Salary",
      color: ExpensesCategoryColors.home,
    ),
    ExpensesCategoryModel(
      id: 2,
      name: "Profit",
      color: ExpensesCategoryColors.profit,
    ),
    ExpensesCategoryModel(
      id: 3,
      name: "Home",
      color: ExpensesCategoryColors.home,
    ),
    ExpensesCategoryModel(
      id: 4,
      name: "Internet",
      color: ExpensesCategoryColors.internet,
    ),
    ExpensesCategoryModel(
      id: 5,
      name: "Retirement",
      color: ExpensesCategoryColors.retirement,
    ),
    ExpensesCategoryModel(
      id: 6,
      name: "Electricity",
      color: ExpensesCategoryColors.electricity,
    ),
    ExpensesCategoryModel(
      id: 7,
      name: "Mobile",
      color: ExpensesCategoryColors.mobile,
    ),
    ExpensesCategoryModel(
      id: 8,
      name: "Fund",
      color: ExpensesCategoryColors.fund,
    ),
    ExpensesCategoryModel(
      id: 9,
      name: "Food",
      color: ExpensesCategoryColors.food,
    ),
    ExpensesCategoryModel(
      id: 10,
      name: "Clothing",
      color: ExpensesCategoryColors.clothing,
    ),
    ExpensesCategoryModel(
      id: 11,
      name: "Entertainment",
      color: ExpensesCategoryColors.entertainment,
    ),
    ExpensesCategoryModel(
      id: 12,
      name: "Transportation",
      color: ExpensesCategoryColors.transportation,
    ),
    ExpensesCategoryModel(
      id: 13,
      name: "Loan",
      color: ExpensesCategoryColors.loan,
    ),
    ExpensesCategoryModel(
      id: 14,
      name: "Transfer",
      color: ExpensesCategoryColors.transfer,
    ),
    ExpensesCategoryModel(
      id: 15,
      name: "Rent",
      color: ExpensesCategoryColors.rent,
    ),
    ExpensesCategoryModel(
      id: 16,
      name: "Tools",
      color: ExpensesCategoryColors.tools,
    ),
    ExpensesCategoryModel(
      id: 17,
      name: "Electronics",
      color: ExpensesCategoryColors.electronics,
    ),
    ExpensesCategoryModel(
      id: 18,
      name: "Education",
      color: ExpensesCategoryColors.education,
    ),
    ExpensesCategoryModel(
      id: 19,
      name: "Insurance",
      color: ExpensesCategoryColors.insurance,
    ),
    ExpensesCategoryModel(
      id: 20,
      name: "Gas",
      color: ExpensesCategoryColors.gas,
    ),
    ExpensesCategoryModel(
      id: 21,
      name: "Stocks",
      color: ExpensesCategoryColors.stocks,
    ),
    ExpensesCategoryModel(
      id: 22,
      name: "Other Bills",
      color: ExpensesCategoryColors.otherBills,
    ),
  ];
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
            id: expensesCategoryList
                .where((element) => (element.id == expenses[i].category))
                .toList()
                .first
                .id,
            name: expensesCategoryList
                .where((element) => (element.id == expenses[i].category))
                .toList()
                .first
                .name,
            color: expensesCategoryList
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
    return expensesCategoryList
        .where((element) => element.id == id)
        .first
        .color!;
  }

  Future emitGetExpenses() async {
    try {
      clearLists();
      emit(GetExpenseLoading());
      expensesList = await ExpensesDatabase.getExpenses();
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
    if (currentDate!.day == 1) {
      emitGetExpenses();
    } else {
      filteredExpensesList = expensesList
          .where((element) =>
              element.date.substring(5, 7) ==
              currentDate.toString().substring(5, 7))
          .toList();
      await getCategoryList(expenses: filteredExpensesList);
      chartSections();
    }
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
        fromAccount: fromAccount.name == null ? salaryAccount : fromAccount,
        toAccount: toAccount.name == null ? expensesAccount : toAccount,
        date: dateController.text.isEmpty
            ? DateTime.now().toString().substring(0, 10)
            : dateController.text,
        currency: currency,
        type: expensesType,
        category: expensesCategory,
      );
      emit(AddExpenseLoading());
      await ExpensesDatabase.addExpense(expensesModel);
      emit(AddExpenseSuccess());
      emitGetExpenses();
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
      await ExpensesDatabase.deleteExpense(expenseId);
      emitGetExpenses();
      showMyToast(message: "Expense Deleted Successfully", success: true);
      emit(DeleteExpenseSuccess());
    } catch (e) {
      emit(DeleteExpenseError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }
}
