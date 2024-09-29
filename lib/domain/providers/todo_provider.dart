import 'package:flutter/material.dart';
import 'package:practical/data/database/database_tables/todo_table.dart';

class TodoProvider with ChangeNotifier {
  bool isLoading = false;
  List<Map<String, dynamic>> todosList = [];

  startLoader() {
    isLoading = true;
    notifyListeners();
  }

  stopLoader() {
    Future.delayed(const Duration(seconds: 1), () {
      isLoading = false;
      notifyListeners();
    });
  }

  /// Get Stored ToDos
  getStoredToDos() async {
    final List<Map<String, dynamic>> storedToDos = await TodoTable.getData();
    todosList = storedToDos;
    notifyListeners();
  }

  /// Append new ToDos
  appendTodo() async {
    startLoader();
    final List<Map<String, dynamic>> storedRepos = await TodoTable.getData();
    todosList = storedRepos;
    stopLoader();
  }

  /// Delete ToDos
  deleteTodo(int id) async {
    await TodoTable.delete(id);
    final List<Map<String, dynamic>> storedRepos = await TodoTable.getData();
    todosList = storedRepos;
    notifyListeners();
  }

  updateTodo(Map<String, String> todoData, dynamic id) async {
    startLoader();
    await TodoTable.update([todoData], id);
    stopLoader();
  }

  /// Add ToDos
  addTodo(Map<String, String> todoData) async {
    startLoader();
    await TodoTable.insertData([todoData]);
    stopLoader();
  }
}
