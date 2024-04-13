part of 'savings_cubit.dart';

@immutable
abstract class SavingsState {}

class SavingsInitial extends SavingsState {}


class GetSavingsLoading extends SavingsState {}
class GetSavingsSuccess extends SavingsState {}
class GetSavingsError extends SavingsState {}

class AddSavingsLoading extends SavingsState {}
class AddSavingsSuccess extends SavingsState {}
class AddSavingsError extends SavingsState {}

class UpdateSavingsLoading extends SavingsState {}
class UpdateSavingsSuccess extends SavingsState {}
class UpdateSavingsError extends SavingsState {}

class DeleteSavingsLoading extends SavingsState {}
class DeleteSavingsSuccess extends SavingsState {}
class DeleteSavingsError extends SavingsState {}
