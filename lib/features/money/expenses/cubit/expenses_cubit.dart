import 'package:bloc/bloc.dart';
import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/services/navigation_service.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/core/utils/shared_functions.dart';
import 'package:shawky/features/money/accounts/data/models/account_model.dart';
import 'package:shawky/features/money/expenses/data/models/expenses_category_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shawky/features/money/expenses/data/models/expenses_model.dart';
import 'package:shawky/features/money/expenses/database/expenses_database.dart';

part 'expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  ExpensesCubit() : super(ExpensesInitial());

  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController rateController = TextEditingController();
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
  ExpensesType expensesType = ExpensesType.income;
  Currency currency = Currency.egp;
  int expensesCategory = 0;

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
  List<PieChartSectionData> pieChartSectionData = [];

  clearLists() {
    categoryList.clear();
    expensesList.clear();
    pieChartSectionData.clear();
  }

  dispose() {
    nameController = TextEditingController();
    amountController = TextEditingController();
    rateController = TextEditingController();
    dateController = TextEditingController();
    expensesCategoryModel = ExpensesCategoryModel();
    fromAccount = AccountModel();
    toAccount = AccountModel();
  }

  void getCategoryList() {
    categoryList.clear();
    for (int i = 0; i < expensesList.length; i++) {
      if (categoryList
          .where((element) => element.id == expensesList[i].category)
          .toList()
          .isEmpty) {
        categoryList.add(
          ExpensesCategoryModel(
            id: expensesCategoryList
                .where((element) => (element.id == expensesList[i].category))
                .toList()
                .first
                .id,
            name: expensesCategoryList
                .where((element) => (element.id == expensesList[i].category))
                .toList()
                .first
                .name,
            color: expensesCategoryList
                .where((element) => (element.id == expensesList[i].category))
                .toList()
                .first
                .color,
            amount: (expensesList[i].amount * expensesList[i].rate),
          ),
        );
      } else {
        int index = categoryList
            .indexWhere((element) => element.id == expensesList[i].category);
        categoryList[index].amount = (categoryList[index].amount)! +
            (expensesList[i].amount * expensesList[i].rate);
      }
    }
  }

  void changeExpensesType(value) {
    expensesType = value;
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
    if (currency == Currency.egp) {
      rateController.clear();
      rateController.text = "1";
    }
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
      printSuccess(pieChartSectionData.length);
    }
  }

  Future emitGetExpenses() async {
    try {
      clearLists();
      emit(GetExpenseLoading());
      expensesList = await ExpensesDatabase.getExpenses();
      getCategoryList();
      chartSections();
      emit(GetExpenseSuccess());
    } catch (e) {
      emit(GetExpenseError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitAddExpense() async {
    try {
      ExpensesModel expensesModel = ExpensesModel(
        name: nameController.text,
        amount: double.tryParse(amountController.text)!,
        rate: currency == Currency.egp
            ? 1.0
            : double.tryParse(rateController.text)!,
        fromAccount: fromAccount.name == null ? salaryAccount : fromAccount,
        toAccount: toAccount.name == null ? expensesAccount : toAccount,
        date: DateTime.now().toString(),
        currency: currency,
        type: expensesType,
        category: expensesCategory,
      );
      emit(AddExpenseLoading());
      await ExpensesDatabase.addExpense(expensesModel);
      emit(AddExpenseSuccess());
      emitGetExpenses();
      showMyToast(message: "Expense Added Successfully", success: true);
      dispose();
      NavigationService.pop();
    } catch (e) {
      emit(AddExpenseError());
      showMyToast(message: e.toString(), success: false);
      printError(e.toString());
    }
  }

  Future emitDeleteExpense({
    required int expenseId,
  }) async {
    try {
      emit(DeleteExpenseLoading());
      await ExpensesDatabase.deleteExpense(expenseId);
      // expensesList.removeWhere((element) => element.id == expenseId);
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
