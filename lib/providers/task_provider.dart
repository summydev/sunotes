import 'package:flutter/material.dart';
import 'package:sunotes/models/task_model.dart';

enum TaskFilter { all, completed, pending }

class TaskProvider extends ChangeNotifier {
  final List<TaskModel> _tasks = [];
  TaskFilter _filter = TaskFilter.all;

  final Map<String, Color> _categoryColors = {
    'Uncategorized': Colors.grey,
    'Work': const Color.fromARGB(255, 126, 180, 241),
    'Personal': const Color.fromARGB(255, 50, 202, 114),
    'Shopping': const Color.fromARGB(255, 233, 28, 96),
    'Health': const Color.fromARGB(255, 69, 73, 69),
  };

  // Getter for category colors
  Color getCategoryColor(String category) {
    return _categoryColors[category] ?? const Color.fromARGB(255, 32, 145, 238);
  }

//Getter for task based on categories
  List<String> getCategories() {
    return _tasks.map((task) => task.category).toSet().toList();
  }

  List<TaskModel> getTasksByCategory(String category) {
    return _tasks.where((task) => task.category == category).toList();
  }

  // Getter for tasks based on filter
  List<TaskModel> get tasks {
    switch (_filter) {
      case TaskFilter.completed:
        return _tasks.where((task) => task.isCompleted).toList();
      case TaskFilter.pending:
        return _tasks.where((task) => !task.isCompleted).toList();
      default:
        return List.unmodifiable(_tasks);
    }
  }

  // Getter for filter
  TaskFilter get filter => _filter;

  // Method to set the filter
  void setFilter(TaskFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  // Method to add a task
  void addTask(TaskModel task) {
    _tasks.add(task);
    notifyListeners();
  }

  // Method to update a task
  void updateTask(TaskModel updatedTask) {
    final taskIndex = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (taskIndex != -1) {
      _tasks[taskIndex] = updatedTask;
      notifyListeners();
    }
  }

  // Method to remove a task by ID
  void removeTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  // Method to toggle task completion
  void toggleTaskCompletion(String id) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.toggleCompleted();
    notifyListeners();
  }

  // Getter for completed tasks
  List<TaskModel> get completedTasks =>
      _tasks.where((task) => task.isCompleted).toList();

  // Getter for pending tasks
  List<TaskModel> get pendingTasks =>
      _tasks.where((task) => !task.isCompleted).toList();

  // New method to get a task by its ID
  TaskModel getTaskById(String id) {
    return _tasks.firstWhere((task) => task.id == id);
  }
}
