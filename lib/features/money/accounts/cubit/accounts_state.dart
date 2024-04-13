part of 'accounts_cubit.dart';

@immutable
abstract class AccountsState {}

class AccountsInitial extends AccountsState {}

class GetAccountLoading extends AccountsState {}
class GetAccountSuccess extends AccountsState {}
class GetAccountError extends AccountsState {}

class AddAccountLoading extends AccountsState {}
class AddAccountSuccess extends AccountsState {}
class AddAccountError extends AccountsState {}

class UpdateAccountLoading extends AccountsState {}
class UpdateAccountSuccess extends AccountsState {}
class UpdateAccountError extends AccountsState {}

class DeleteAccountLoading extends AccountsState {}
class DeleteAccountSuccess extends AccountsState {}
class DeleteAccountError extends AccountsState {}
