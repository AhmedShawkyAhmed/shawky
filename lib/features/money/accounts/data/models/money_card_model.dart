import 'package:finance/core/utils/enums.dart';

class MoneyCardModel{
  final int id;
  final String name;
  final String nameOnCard;
  final String cardNumber;
  final String exp;
  final CardType cardType;
  final CardCompany cardCompany;


  MoneyCardModel({
    required this.id,
    required this.name,
    required this.nameOnCard,
    required this.cardNumber,
    required this.exp,
    required this.cardType,
    required this.cardCompany,
  });
}