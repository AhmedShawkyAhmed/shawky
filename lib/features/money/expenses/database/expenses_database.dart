import 'package:shawky/core/database/local_database.dart';
import 'package:shawky/core/utils/enums.dart';
import 'package:shawky/features/money/accounts/models/account_model.dart';
import 'package:shawky/features/money/expenses/models/expenses_model.dart';
import 'package:sqflite/sqflite.dart';

class ExpensesDatabase {
  static const _expensesTable = "expenses";

  Future<List<ExpensesModel>> getExpenses(int month) async {
    final db = await LocalDatabase.database;

    final List<Map<String, dynamic>> maps = await db.query(
      _expensesTable,
      where: "strftime('%m', date) = ?",
      whereArgs: [month.toString().length == 1 ? "0$month" : month],
    );

    return List.generate(maps.length, (i) {
      return ExpensesModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        amount: maps[i]['amount'],
        rate: maps[i]['rate'],
        date: maps[i]['date'],
        currency: Currency.values
            .where((element) => element.name == maps[i]['currency'])
            .first,
        type: ExpensesType.values
            .where((element) => element.name == maps[i]['type'])
            .first,
        category: maps[i]['category'],
        fromAccount: AccountModel(
          name: maps[i]['fromAccount'],
        ),
        toAccount: AccountModel(
          name: maps[i]['toAccount'],
        ),
      );
    });
  }

  Future<void> addExpense(ExpensesModel expensesModel) async {
    final db = await LocalDatabase.database;

    await db.insert(
      _expensesTable,
      expensesModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteExpense(int id) async {
    final db = await LocalDatabase.database;
    await db.delete(
      _expensesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
