class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime? dueDate;
  bool isCompleted;

  TaskModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.dueDate,
      this.isCompleted = false});

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
