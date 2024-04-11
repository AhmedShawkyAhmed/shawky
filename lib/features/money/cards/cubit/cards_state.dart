part of 'cards_cubit.dart';

@immutable
abstract class CardsState {}

class CardsInitial extends CardsState {}

class GetCardLoading extends CardsState {}
class GetCardSuccess extends CardsState {}
class GetCardError extends CardsState {}

class InsertCardLoading extends CardsState {}
class InsertCardSuccess extends CardsState {}
class InsertCardError extends CardsState {}

class DeleteCardLoading extends CardsState {}
class DeleteCardSuccess extends CardsState {}
class DeleteCardError extends CardsState {}


