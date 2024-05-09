part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class GetSettingsLoading extends SettingsState {}
class GetSettingsSuccess extends SettingsState {}
class GetSettingsError extends SettingsState {}

class AddSettingsLoading extends SettingsState {}
class AddSettingsSuccess extends SettingsState {}
class AddSettingsError extends SettingsState {}

class UpdateSettingsLoading extends SettingsState {}
class UpdateSettingsSuccess extends SettingsState {}
class UpdateSettingsError extends SettingsState {}

class DeleteSettingsLoading extends SettingsState {}
class DeleteSettingsSuccess extends SettingsState {}
class DeleteSettingsError extends SettingsState {}
