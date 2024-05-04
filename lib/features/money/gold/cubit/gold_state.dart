part of 'gold_cubit.dart';

@immutable
abstract class GoldState {}

class GoldInitial extends GoldState {}

class GetGoldLoading extends GoldState {}
class GetGoldSuccess extends GoldState {}
class GetGoldError extends GoldState {}

class AddGoldLoading extends GoldState {}
class AddGoldSuccess extends GoldState {}
class AddGoldError extends GoldState {}

class DeleteGoldLoading extends GoldState {}
class DeleteGoldSuccess extends GoldState {}
class DeleteGoldError extends GoldState {}
