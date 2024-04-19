part of 'expenses_cubit.dart';

@immutable
abstract class ExpensesState {}

class ExpensesInitial extends ExpensesState {}

class GetExpenseLoading extends ExpensesState {}
class GetExpenseSuccess extends ExpensesState {}
class GetExpenseError extends ExpensesState {}

class AddExpenseLoading extends ExpensesState {}
class AddExpenseSuccess extends ExpensesState {}
class AddExpenseError extends ExpensesState {}

class DeleteExpenseLoading extends ExpensesState {}
class DeleteExpenseSuccess extends ExpensesState {}
class DeleteExpenseError extends ExpensesState {}
