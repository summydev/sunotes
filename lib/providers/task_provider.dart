import 'package:flutter/material.dart';
import 'package:sunotes/models/task_model.dart';

enum TaskFilter { all, completed, pending }

class TaskProvider extends ChangeNotifier {
  final List<TaskModel> _tasks = [];
  TaskFilter _filter = TaskFilter.all;
//  List<TaskModel> get tasks => List.unmodifiable(_tasks);
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

  TaskFilter get filter => _filter;
  void setFilter(TaskFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  void addTask(TaskModel task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(TaskModel updatedTask) {
    final taskIndex = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (taskIndex != -1) {
      _tasks[taskIndex] = updatedTask;
      notifyListeners();
    }
  }

  void removeTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  void toggleTaskCompletion(String id) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.toggleCompleted();
    notifyListeners();
  }

  List<TaskModel> get completedTasks =>
      _tasks.where((task) => task.isCompleted).toList();

  List<TaskModel> get pendingTasks =>
      _tasks.where((task) => !task.isCompleted).toList();
}
