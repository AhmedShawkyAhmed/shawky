import 'package:shawky/core/database/local_database.dart';
import 'package:shawky/features/settings/models/settings_model.dart';
import 'package:sqflite/sqflite.dart';

class SettingsDatabase {
  static const _settingsTable = "settings";

  static Future<List<SettingsModel>> getSettings() async {
    final db = await LocalDatabase.database;

    final List<Map<String, dynamic>> maps = await db.query(_settingsTable);

    return List.generate(maps.length, (i) {
      return SettingsModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        title: maps[i]['title'],
        rate: maps[i]['rate'],
        gold: maps[i]['gold'],
      );
    });
  }

  static Future<void> addSettings(SettingsModel settingsModel) async {
    final db = await LocalDatabase.database;

    await db.insert(
      _settingsTable,
      settingsModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateSettings(SettingsModel settingsModel) async {
    final db = await LocalDatabase.database;

    await db.update(
      _settingsTable,
      settingsModel.toMap(),
      where: 'id = ?',
      whereArgs: [settingsModel.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteSettings(int id) async {
    final db = await LocalDatabase.database;
    await db.delete(
      _settingsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
