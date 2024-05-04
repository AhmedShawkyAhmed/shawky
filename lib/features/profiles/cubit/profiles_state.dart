part of 'profiles_cubit.dart';

@immutable
abstract class ProfilesState {}

class ProfilesInitial extends ProfilesState {}

class GetProfileLoading extends ProfilesState {}
class GetProfileSuccess extends ProfilesState {}
class GetProfileError extends ProfilesState {}

class AddProfileLoading extends ProfilesState {}
class AddProfileSuccess extends ProfilesState {}
class AddProfileError extends ProfilesState {}

class UpdateProfileLoading extends ProfilesState {}
class UpdateProfileSuccess extends ProfilesState {}
class UpdateProfileError extends ProfilesState {}

class DeleteProfileLoading extends ProfilesState {}
class DeleteProfileSuccess extends ProfilesState {}
class DeleteProfileError extends ProfilesState {}
