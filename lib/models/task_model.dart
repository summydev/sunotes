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

  // Constructor
  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.isCompleted = false,
    this.dueDate,
    this.timeDeadline,
  });

  // Adding copyWith method
  TaskModel copyWith(
      {String? id,
      String? title,
      String? description,
      String? category,
      bool? isCompleted,
      DateTime? dueDate,
      DateTime? timeDeadline}) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate,
      timeDeadline: timeDeadline ?? this.timeDeadline,
    );
  }

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }
}
