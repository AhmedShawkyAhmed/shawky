import 'package:shawky/core/utils/shared_functions.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase _localDatabase = LocalDatabase._internal();

  factory LocalDatabase() {
    return _localDatabase;
  }

  LocalDatabase._internal();

  static const String _appDatabase = "appDatabase.db";
  static late Future<Database> database;

  static Future<void> init() async {
    database = openDatabase(
      join(await getDatabasesPath(), _appDatabase),
      onCreate: _createDatabase,
      version: 1,
    );
    printSuccess("Database Created");
  }

  static void _createDatabase(Database db, int newVersion) async {
    Batch batch = db.batch();
    batch.execute('CREATE TABLE cards(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,nameOnCard TEXT,cardNumber TEXT,exp TEXT,cvv TEXT,cardType TEXT,cardCompany TEXT)');
    batch.execute('CREATE TABLE accounts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,accountType TEXT,currency TEXT,updatedAt TEXT,amount REAL,rate REAL)');
    batch.execute('CREATE TABLE savings(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,target REAL,current REAL)');
    List<dynamic> res = await batch.commit();
    printLog(res);
  }
}
