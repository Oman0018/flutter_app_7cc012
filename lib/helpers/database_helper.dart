//lib/helpers/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/message.dart';

class DatabaseHelper {
  static Database? _database;
  static const String _tableName = 'messages';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'messages.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT, imagePath TEXT, timestamp TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<int> insertMessage(Message message) async {
    final db = await database;
    return await db.insert(_tableName, message.toMap());
  }

  static Future<List<Message>> getAllMessages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return Message.fromMap(maps[i]);
    });
  }

  static Future<int> deleteMessage(int id) async {
    final db = await database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deleteMessages(List<int> ids) async {
    final db = await database;
    return await db.delete(_tableName, where: 'id IN (${ids.join(",")})');
  }
}
