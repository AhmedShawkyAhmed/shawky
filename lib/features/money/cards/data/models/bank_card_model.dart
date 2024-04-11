import 'package:finance/core/utils/enums.dart';

class BankCardModel{
   int? id;
   String? name;
   String? nameOnCard;
   String? cardNumber;
   String? exp;
   String? cvv;
   CardType? cardType;
   CardCompany? cardCompany;


  BankCardModel({
     this.id,
     this.name,
     this.nameOnCard,
     this.cardNumber,
     this.exp,
     this.cvv,
     this.cardType,
     this.cardCompany,
  });
}