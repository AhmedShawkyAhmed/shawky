part of 'cards_cubit.dart';

@immutable
abstract class CardsState {}

class CardsInitial extends CardsState {}

class GetCardLoading extends CardsState {}
class GetCardSuccess extends CardsState {}
class GetCardError extends CardsState {}

class AddCardLoading extends CardsState {}
class AddCardSuccess extends CardsState {}
class AddCardError extends CardsState {}

class UpdateCardLoading extends CardsState {}
class UpdateCardSuccess extends CardsState {}
class UpdateCardError extends CardsState {}

class DeleteCardLoading extends CardsState {}
class DeleteCardSuccess extends CardsState {}
class DeleteCardError extends CardsState {}


