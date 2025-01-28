import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String category;

  @HiveField(4)
  bool isCompleted;

  @HiveField(5)
  DateTime? dueDate;

  @HiveField(6)
  DateTime? timeDeadline;
  @HiveField(7)
  final String? priority;

  @HiveField(8)
  List<Subtask>? subtasks; // New Field

  // Constructor
  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.isCompleted = false,
    this.dueDate,
    this.timeDeadline,
    required this.priority,
    this.subtasks = const [],
  });

  // Adding copyWith method
  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    bool? isCompleted,
    DateTime? dueDate,
    DateTime? timeDeadline,
    String? priority,
    List<Subtask>? subtasks,
  }) {
    return TaskModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        isCompleted: isCompleted ?? this.isCompleted,
        dueDate: dueDate ?? this.dueDate,
        timeDeadline: timeDeadline ?? this.timeDeadline,
        priority: priority ?? this.priority,
        subtasks: subtasks ?? this.subtasks);
  }

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }
}

@HiveType(typeId: 1)
class Subtask {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isCompleted;

  Subtask({
    required this.title,
    this.isCompleted = false,
  });

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }
}
