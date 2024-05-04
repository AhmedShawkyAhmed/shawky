import 'package:shawky/core/database/local_database.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/features/profiles/models/profile_model.dart';
import 'package:sqflite/sqflite.dart';

class ProfilesDatabase {
  static const _profilesTable = "profiles";

  static Future<List<ProfileModel>> getProfiles() async {
    final db = await LocalDatabase.database;

    final List<Map<String, dynamic>> maps = await db.query(_profilesTable);

    return List.generate(maps.length, (i) {
      return ProfileModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        link: maps[i]['link'],
        type: ProfileType.values
            .where((element) => element.name == maps[i]['type'])
            .first,
      );
    });
  }

  static Future<void> addProfile(ProfileModel profileModel) async {
    final db = await LocalDatabase.database;

    await db.insert(
      _profilesTable,
      profileModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateProfile(ProfileModel profileModel) async {
    final db = await LocalDatabase.database;

    await db.update(
      _profilesTable,
      profileModel.toMap(),
      where: 'id = ?',
      whereArgs: [profileModel.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteProfile(int id) async {
    final db = await LocalDatabase.database;
    await db.delete(
      _profilesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
