import 'package:finance/core/utils/shared_functions.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();

  factory DatabaseService() {
    return _databaseService;
  }

  DatabaseService._internal();

  static const String appDatabase = "appDatabase.db";
  static late Future<Database> database;

  static Future<void> init() async {
    database = openDatabase(
      join(await getDatabasesPath(), appDatabase),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE cards(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,nameOnCard TEXT,cardNumber TEXT,exp TEXT,cvv TEXT,cardType TEXT,cardCompany TEXT)',
        );
      },
      version: 1,
    );
    printSuccess("Database Created");
  }
}
