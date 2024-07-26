import 'package:shawky/core/database/local_database.dart';
import 'package:shawky/features/money/savings/data/models/saving_model.dart';
import 'package:sqflite/sqflite.dart';

class SavingsDatabase {
  static const _savingTable = "savings";

  Future<List<SavingModel>> getSavings() async {
    final db = await LocalDatabase.database;

    final List<Map<String, dynamic>> maps = await db.query(_savingTable);

    return List.generate(maps.length, (i) {
      return SavingModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        target: maps[i]['target'],
        current: maps[i]['current'],
      );
    });
  }

  Future<void> addSavings(SavingModel accountModel) async {
    final db = await LocalDatabase.database;

    await db.insert(
      _savingTable,
      accountModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateSavings(SavingModel accountModel) async {
    final db = await LocalDatabase.database;

    await db.update(
      _savingTable,
      accountModel.toMap(),
      where: 'id = ?',
      whereArgs: [accountModel.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteSavings(int id) async {
    final db = await LocalDatabase.database;
    await db.delete(
      _savingTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
