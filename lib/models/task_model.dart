class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime? dueDate;
  bool isCompleted;
  final String category;

  TaskModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.dueDate,
      this.isCompleted = false,
      this.category = 'Uncategorized'});

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isCompleted,
    String? category,
  }) {
    return TaskModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        dueDate: dueDate ?? this.dueDate,
        isCompleted: isCompleted ?? this.isCompleted,
        category: category ?? this.category);
  }
}
