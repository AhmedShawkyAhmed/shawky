import 'package:shawky/core/resources/color_manger.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/features/money/accounts/data/models/account_model.dart';
import 'package:shawky/features/money/expenses/data/models/expenses_category_model.dart';

class ExpensesConstants {
  static AccountModel expensesAccount = AccountModel(
    id: 0,
    name: "Expenses",
  );
  static AccountModel salaryAccount = AccountModel(
    id: 0,
    name: "Salary",
  );
  static const List<ExpensesType> expensesTypeList = ExpensesType.values;

  static const List<Currency> currencyList = Currency.values;

  static List<ExpensesCategoryModel> expensesCategoryList = [
    ExpensesCategoryModel(
      id: 1,
      name: "Salary",
      color: ExpensesCategoryColors.salary,
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
      name: "Gold",
      color: ExpensesCategoryColors.gold,
    ),
    ExpensesCategoryModel(
      id: 23,
      name: "Installment",
      color: ExpensesCategoryColors.installment,
    ),
    ExpensesCategoryModel(
      id: 24,
      name: "Other Bills",
      color: ExpensesCategoryColors.otherBills,
    ),
  ];
}
