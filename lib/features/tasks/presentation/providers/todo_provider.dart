import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_flow/features/tasks/data/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  // Private list of todos
  List<TodoModel> _todos = [];

  String _searchQuery = "";
  String _filterPriority = "All";

  // Constructor initializes data loading
  TodoProvider() {
    _loadTodos();
  }

  // ---------------- LOCAL STORAGE LOGIC ---------------- //

  // Load data from SharedPreferences
  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosString = prefs.getString('saved_todos');

    if (todosString != null) {
      final List<dynamic> decodedList = jsonDecode(todosString);
      _todos = decodedList.map((item) => TodoModel.fromMap(item)).toList();
      notifyListeners(); // Rebuild UI after loading data
    }
  }

  // Save current state to SharedPreferences
  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(
      _todos.map((todo) => todo.toMap()).toList(),
    );
    await prefs.setString('saved_todos', encodedData);
  }

  // --------------------------------------------------- //

  String get filterPriority => _filterPriority;

  void updateFilter(String priority) {
    _filterPriority = priority;
    notifyListeners();
  }

  List<TodoModel> get filteredTodos {
    return _todos.where((todo) {
      final matchesSearch = todo.title.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );

      final matchesPriority =
          _filterPriority == "All" ||
          todo.priority.toLowerCase() == _filterPriority.toLowerCase();

      return matchesSearch && matchesPriority;
    }).toList();
  }

  // Expose the list to the UI
  List<TodoModel> get todos => _todos;
  int get totalTasks => _todos.length;
  int get completedTasks => _todos.where((todo) => todo.isCompleted).length;
  int get pendingTasks => totalTasks - completedTasks;

  // Add a new todo and save locally
  void addTodo(TodoModel todo) {
    _todos.add(todo);
    _saveToPrefs();
    notifyListeners();
  }

  // Toggle completed status and save locally
  void toggleTodoStatus(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      // Replace the old todo with an updated copy
      _todos[index] = _todos[index].copyWith(
        isCompleted: !_todos[index].isCompleted,
      );
      _saveToPrefs();
      notifyListeners();
    }
  }

  // Delete a todo and save locally
  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    _saveToPrefs();
    notifyListeners();
  }

  // Update search query
  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
