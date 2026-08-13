// 1. The Data Model (Immutable)
class TodoModel {
  final String id;
  final String title;
  final String description;
  final String priority; // high, medium, low
  final bool isCompleted; // Changed to final for best practices

  TodoModel({
    required this.id,
    required this.title,
    required this.priority,
    required this.description,
    this.isCompleted = false,
  });

  // Since variables are final, we use copyWith to change values
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
}
