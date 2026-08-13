import 'package:flutter/foundation.dart';
import 'package:my_app/features/tasks/data/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  // Private list of todos
  final List<TodoModel> _todos = [
    TodoModel(
      id: '1',
      title: 'Buy groceries',
      description: 'Milk, eggs, bread, and fresh vegetables from the market.',
      priority: 'high',
      isCompleted: false,
    ),
    TodoModel(
      id: '2',
      title: 'Finish Flutter UI design',
      description:
          'Complete the dashboard screen mockup and check responsiveness.',
      priority: 'medium',
      isCompleted: false,
    ),
    TodoModel(
      id: '3',
      title: 'Call the dentist',
      description: 'Schedule the routine checkup for next Tuesday afternoon.',
      priority: 'low',
      isCompleted: true,
    ),
  ];

  String _searchQuery = "";

  String _filterPriority = "All";

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

  // Add a new todo
  void addTodo(TodoModel todo) {
    _todos.add(todo);
    notifyListeners(); // This triggers the UI to rebuild
  }

  // Toggle completed status
  void toggleTodoStatus(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      // Replace the old todo with an updated copy
      _todos[index] = _todos[index].copyWith(
        isCompleted: !_todos[index].isCompleted,
      );
      notifyListeners();
    }
  }

  // Delete a todo
  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  // Update search query
  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
