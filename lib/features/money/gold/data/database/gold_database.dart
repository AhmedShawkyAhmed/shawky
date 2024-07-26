import 'package:shawky/core/database/local_database.dart';
import 'package:shawky/features/money/gold/data/models/gold_model.dart';
import 'package:sqflite/sqflite.dart';

class GoldDatabase {
  static const _goldTable = "gold";

  Future<List<GoldModel>> getGold() async {
    final db = await LocalDatabase.database;

    final List<Map<String, dynamic>> maps = await db.query(_goldTable);

    return List.generate(maps.length, (i) {
      return GoldModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        price: maps[i]['price'],
        weight: maps[i]['weight'],
        date: maps[i]['date'],
      );
    });
  }

  Future<void> addGold(GoldModel goldModel) async {
    final db = await LocalDatabase.database;

    await db.insert(
      _goldTable,
      goldModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteGold(int id) async {
    final db = await LocalDatabase.database;
    await db.delete(
      _goldTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
