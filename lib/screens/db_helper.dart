
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo_models.dart';

class DatabaseHelper {
  final databaseName = "todoApp.db";
  static String todoTableName = "todo";


  String todoTable = '''
  CREATE TABLE IF NOT EXISTS $todoTableName (
  todoId INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT,
  content TEXT,
  completed INTEGER,
  dateTime TEXT NOT NULL
  )''';


  Future<Database> initDB() async {
    final databasePath = await getApplicationDocumentsDirectory();
    final path = "${databasePath.path}/$databaseName";
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(todoTable);
    });
  }

  Future<List<Todo>> getTodo() async {
    final db = await initDB();
    final List<Map<String, Object?>> res = await db.query(todoTableName);
    return res.map((e) => Todo.fromMap(e)).toList();

  }


  Future<void> addTodo(Todo todo) async {
    final db = await initDB();
    db.insert(todoTableName, todo.toMap());
  }

  Future<void> updateTodo(Todo todo) async {
    final db = await initDB();
    db.update(todoTableName, todo.toMap(), where: "todoId = ?", whereArgs: [todo.todoId]);
  }


  Future<void> deleteTodo(int id) async {
    final db = await initDB();
    db.delete(todoTableName, where: "todoId = ?", whereArgs: [id]);
  }

}