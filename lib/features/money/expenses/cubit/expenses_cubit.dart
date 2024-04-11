import 'package:bloc/bloc.dart';
import 'package:finance/core/resources/color_manger.dart';
import 'package:finance/core/utils/enums.dart';
import 'package:finance/features/money/expenses/data/models/expenses_category_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

part 'expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  ExpensesCubit() : super(ExpensesInitial());

  final List<ExpensesType> expensesTypeList = ExpensesType.values;
  final List<Currency> currencyList = Currency.values;
  final List<ExpensesCategoryModel> expensesCategoryList = [
    ExpensesCategoryModel(
      id: 1,
      name: "Home",
      color: ExpensesCategoryColors.home,
    ),
    ExpensesCategoryModel(
      id: 2,
      name: "Internet",
      color: ExpensesCategoryColors.internet,
    ),
    ExpensesCategoryModel(
      id: 3,
      name: "Gas",
      color: ExpensesCategoryColors.gas,
    ),
    ExpensesCategoryModel(
      id: 4,
      name: "Stocks",
      color: ExpensesCategoryColors.stocks,
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
      name: "Other Bills",
      color: ExpensesCategoryColors.otherBills,
    ),
  ];

  List<PieChartSectionData> chartSections(List<ExpensesCategoryModel> sectors) {
    final List<PieChartSectionData> list = [];
    for (var sector in sectors) {
      const double radius = 20.0;
      final data = PieChartSectionData(
        color: sector.color,
        value: sector.id!.toDouble(),
        radius: radius,
        title: '',
      );
      list.add(data);
    }
    return list;
  }
}
