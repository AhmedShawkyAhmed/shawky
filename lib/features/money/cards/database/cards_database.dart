import 'package:shawky/core/database/local_database.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/features/money/cards/data/models/bank_card_model.dart';
import 'package:sqflite/sqflite.dart';

class CardsDatabase {
  static const _cardsTable = "cards";

  static Future<List<BankCardModel>> getCards() async {
    final db = await LocalDatabase.database;

    final List<Map<String, dynamic>> maps = await db.query(_cardsTable);

    return List.generate(maps.length, (i) {
      return BankCardModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        nameOnCard: maps[i]['nameOnCard'],
        cardNumber: maps[i]['cardNumber'],
        exp: maps[i]['exp'],
        cvv: maps[i]['cvv'],
        cardType: CardType.values
            .where((element) => element.name == maps[i]['cardType'])
            .first,
        cardCompany: CardCompany.values
            .where((element) => element.name == maps[i]['cardCompany'])
            .first,
      );
    });
  }

  static Future<void> addCard(BankCardModel cardModel) async {
    final db = await LocalDatabase.database;

    await db.insert(
      _cardsTable,
      cardModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateCard(BankCardModel card) async {
    final db = await LocalDatabase.database;

    await db.update(
      _cardsTable,
      card.toMap(),
      where: 'id = ?',
      whereArgs: [card.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteCard(int id) async {
    final db = await LocalDatabase.database;
    await db.delete(
      _cardsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
