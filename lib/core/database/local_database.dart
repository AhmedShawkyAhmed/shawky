import 'package:path/path.dart';
import 'package:shawky/core/utils/shared_functions.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase _localDatabase = LocalDatabase._internal();

  factory LocalDatabase() {
    return _localDatabase;
  }

  LocalDatabase._internal();

  static const String _appDatabase = "appDatabase.db";
  static late Future<Database> database;
  static const int oldVersion = 4;
  static const int currentVersion = oldVersion + 1;

  static Future<void> init() async {
    printResponse("oldVersion $oldVersion - currentVersion $currentVersion");
    database = openDatabase(
      join(await getDatabasesPath(), _appDatabase),
      onCreate: _createDatabase,
      onUpgrade: _onUpgrade,
      version: currentVersion,
    );
  }

  static void _createDatabase(Database db, int newVersion) async {
    Batch batch = db.batch();
    batch.execute(
        'CREATE TABLE cards(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,nameOnCard TEXT,cardNumber TEXT,exp TEXT,cvv TEXT,cardType TEXT,cardCompany TEXT)');
    batch.execute(
        'CREATE TABLE accounts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,accountType TEXT,currency TEXT,updatedAt TEXT,amount REAL,rate REAL)');
    batch.execute(
        'CREATE TABLE savings(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,target REAL,current REAL)');
    batch.execute(
        'CREATE TABLE expenses(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,amount REAL,rate REAL, date TEXT, currency TEXT, type TEXT, category INTEGER, fromAccount TEXT, toAccount TEXT)');
    batch.execute(
        'CREATE TABLE gold(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,weight TEXT,price REAL,date TEXT)');
    List<dynamic> res = await batch.commit();
    printLog(res);
    printSuccess("Database Created");
  }

  static void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    Batch batch = db.batch();
    if (oldVersion == oldVersion) {
      batch.execute(
          'CREATE TABLE profiles(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,link TEXT,type TEXT)');
      List<dynamic> res = await batch.commit();
      printLog(res);
      printSuccess("Database Upgraded");
    }
  }
}
