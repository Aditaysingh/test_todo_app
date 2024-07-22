import 'package:flutter/material.dart';
import '../models/todo_models.dart';
import '../screens/db_helper.dart';
import '../provider/theme_provider.dart';


class ProviderDB extends ChangeNotifier {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  List<Todo> _todos = [];
  List<Todo> _filteredTodos = [];
  String _filter = 'All';
  String get currentFilter => _filter;

  List<Todo> get todos => _todos;
  List<Todo> get filteredTodos => _filteredTodos;
  final ThemeProvider themeProvider;

  ProviderDB(this.themeProvider) {
    fetchTodo();
  }

  Future<void> fetchTodo() async {
    try {
      await databaseHelper.initDB();
      _todos = await databaseHelper.getTodo();
      applyFilter();
      notifyListeners();
    } catch (e) {
      print("Error fetching todos: $e");
    }
  }

  Future<void> insertTodo(Todo todo) async {
    try {
      await databaseHelper.addTodo(todo);
      await fetchTodo();
    } catch (e) {
      print("Error inserting todo: $e");
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      await databaseHelper.updateTodo(todo);
      await fetchTodo();
    } catch (e) {
      print("Error updating todo: $e");
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      await databaseHelper.deleteTodo(id);
      await fetchTodo();
    } catch (e) {
      print("Error deleting todo: $e");
    }
  }

  void toggleTheme(bool value) {
    themeProvider.toggleTheme(value);
    notifyListeners();
  }

  void setFilter(String filter) {
    _filter = filter;
    applyFilter();
    notifyListeners();
  }

  void applyFilter() {
    if (_filter == 'Completed') {
      _filteredTodos = _todos.where((todo) => todo.completed).toList();
    } else if (_filter == 'Active') {
      _filteredTodos = _todos.where((todo) => !todo.completed).toList();
    } else {
      _filteredTodos = List.from(_todos);
    }
  }
}
