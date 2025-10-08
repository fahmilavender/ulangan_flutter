import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/todo_model.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'todos.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todos(
            id TEXT PRIMARY KEY,
            title TEXT,
            description TEXT,
            category TEXT,
            date TEXT,
            startTime TEXT,
            endTime TEXT,
            isDone INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertTodo(Todo todo) async {
    final db = await database;
    await db.insert('todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Todo>> getTodos() async {
    final db = await database;
    final result = await db.query('todos');
    return result.map((map) => Todo.fromMap(map)).toList();
  }

  Future<void> updateTodo(Todo todo) async {
    final db = await database;
    await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodo(String id) async {
    final db = await database;
    await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
