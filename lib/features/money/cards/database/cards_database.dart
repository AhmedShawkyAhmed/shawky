import 'package:finance/core/services/database_service.dart';
import 'package:finance/core/utils/enums.dart';
import 'package:finance/features/money/cards/data/models/bank_card_model.dart';
import 'package:sqflite/sqflite.dart';

class CardsDatabase {
  static const cardsTable = "cards";

  static Future<void> insertCard(BankCardModel cardModel) async {
    final db = await DatabaseService.database;

    await db.insert(
      cardsTable,
      cardModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<BankCardModel>> getCards() async {
    final db = await DatabaseService.database;

    final List<Map<String, dynamic>> maps = await db.query(cardsTable);

    return List.generate(maps.length, (i) {
      return BankCardModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        nameOnCard: maps[i]['nameOnCard'],
        cardNumber: maps[i]['cardNumber'],
        exp: maps[i]['exp'],
        cvv: maps[i]['cvv'],
        cardType: CardType.values.where((element) => element.name == maps[i]['cardType']).first,
        cardCompany: CardCompany.values.where((element) => element.name == maps[i]['cardCompany']).first,
      );
    });
  }

  static Future<void> updateCard(BankCardModel card) async {
    final db = await DatabaseService.database;

    await db.update(
      cardsTable,
      card.toMap(),
      where: 'id = ?',
      whereArgs: [card.id],
    );
  }

  static Future<void> deleteCard(int id) async {
    final db = await DatabaseService.database;
    await db.delete(
      cardsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
