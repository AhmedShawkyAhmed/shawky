import 'package:shawky/core/database/local_database.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/features/money/accounts/data/models/account_model.dart';
import 'package:sqflite/sqflite.dart';

class AccountsDatabase {
  static const _accountTable = "accounts";

  static Future<List<AccountModel>> getAccounts() async {
    final db = await LocalDatabase.database;

    final List<Map<String, dynamic>> maps = await db.query(_accountTable);

    return List.generate(maps.length, (i) {
      return AccountModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        updatedAt: maps[i]['updatedAt'],
        amount: maps[i]['amount'],
        rate: maps[i]['rate'],
        accountType: AccountTypes.values
            .where((element) => element.name == maps[i]['accountType'])
            .first,
        currency: Currency.values
            .where((element) => element.name == maps[i]['currency'])
            .first,
      );
    });
  }

  static Future<void> addAccount(AccountModel accountModel) async {
    final db = await LocalDatabase.database;

    await db.insert(
      _accountTable,
      accountModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateAccount(AccountModel accountModel) async {
    final db = await LocalDatabase.database;

    await db.update(
      _accountTable,
      accountModel.toMap(),
      where: 'id = ?',
      whereArgs: [accountModel.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteAccount(int id) async {
    final db = await LocalDatabase.database;
    await db.delete(
      _accountTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
