import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'qr_history.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE history(id INTEGER PRIMARY KEY AUTOINCREMENT, data TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertHistory(String data) async {
    final db = await database;
    await db.insert(
      'history',
      {'data': data},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getHistory() async {
    final db = await database;
    return await db.query('history');
  }

  Future<void> deleteHistory(int id) async {
    final db = await database;
    await db.delete(
      'history',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearHistory() async {
    final db = await database;
    await db.delete('history');
  }
}
