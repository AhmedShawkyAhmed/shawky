import 'package:finance/core/utils/enums.dart';

class BankCardModel{
  final int id;
  final String name;
  final String nameOnCard;
  final String cardNumber;
  final String exp;
  final CardType cardType;
  final CardCompany cardCompany;


  BankCardModel({
    required this.id,
    required this.name,
    required this.nameOnCard,
    required this.cardNumber,
    required this.exp,
    required this.cardType,
    required this.cardCompany,
  });
}