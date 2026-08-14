// 1. The Data Model (Immutable)
class TodoModel {
  final String id;
  final String title;
  final String description;
  final String priority; // high, medium, low
  final bool isCompleted;

  TodoModel({
    required this.id,
    required this.title,
    required this.priority,
    required this.description,
    this.isCompleted = false,
  });

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    String? priority,
    bool? isCompleted,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  // Convert object to Map for SharedPreferences
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'isCompleted': isCompleted,
    };
  }

  // Create TodoModel from Map (Local Storage)
  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      priority: map['priority'] ?? 'low',
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}
