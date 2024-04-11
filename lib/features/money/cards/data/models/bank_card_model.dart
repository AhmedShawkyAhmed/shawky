import 'package:finance/core/utils/enums.dart';

class BankCardModel {
  int? id;
  final String name;
  final String nameOnCard;
  final String cardNumber;
  final String exp;
  final String cvv;
  final CardType cardType;
  final CardCompany cardCompany;

  BankCardModel({
    this.id,
    required this.name,
    required this.nameOnCard,
    required this.cardNumber,
    required this.exp,
    required this.cvv,
    required this.cardType,
    required this.cardCompany,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nameOnCard': nameOnCard,
      'cardNumber': cardNumber,
      'exp': exp,
      'cvv': cvv,
      'cardType': cardType.name,
      'cardCompany': cardCompany.name,
    };
  }

  @override
  String toString() {
    return 'Card{'
        'id: $id, '
        'name: $name, '
        'nameOnCard: $nameOnCard, '
        'cardNumber: $cardNumber, '
        'exp: $exp, '
        'cvv: $cvv, '
        'cardType: $cardType, '
        'cardCompany: $cardCompany'
        '}';
  }
}
