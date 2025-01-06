// import 'package:flutter/material.dart';
// import 'package:sunotes/models/task_model.dart';

// enum TaskFilter { all, completed, pending }

// class TaskProvider extends ChangeNotifier {
//   final List<TaskModel> _tasks = [];
//   TaskFilter _filter = TaskFilter.all;
// //  List<TaskModel> get tasks => List.unmodifiable(_tasks);
//   List<TaskModel> get tasks {
//     switch (_filter) {
//       case TaskFilter.completed:
//         return _tasks.where((task) => task.isCompleted).toList();
//       case TaskFilter.pending:
//         return _tasks.where((task) => !task.isCompleted).toList();
//       default:
//         return List.unmodifiable(_tasks);
//     }
//   }

//   TaskFilter get filter => _filter;
//   void setFilter(TaskFilter filter) {
//     _filter = filter;
//     notifyListeners();
//   }

//   void addTask(TaskModel task) {
//     _tasks.add(task);
//     notifyListeners();
//   }

//   void updateTask(TaskModel updatedTask) {
//     final taskIndex = _tasks.indexWhere((task) => task.id == updatedTask.id);
//     if (taskIndex != -1) {
//       _tasks[taskIndex] = updatedTask;
//       notifyListeners();
//     }
//   }

//   void removeTask(String id) {
//     _tasks.removeWhere((task) => task.id == id);
//     notifyListeners();
//   }

//   void toggleTaskCompletion(String id) {
//     final task = _tasks.firstWhere((task) => task.id == id);
//     task.toggleCompleted();
//     notifyListeners();
//   }

//   List<TaskModel> get completedTasks =>
//       _tasks.where((task) => task.isCompleted).toList();

//   List<TaskModel> get pendingTasks =>
//       _tasks.where((task) => !task.isCompleted).toList();
// }

//  TaskModel getTaskById(String id) {
//     return _tasks.firstWhere((task) => task.id == id);
//   }

import 'package:flutter/material.dart';
import 'package:sunotes/models/task_model.dart';

enum TaskFilter { all, completed, pending }

class TaskProvider extends ChangeNotifier {
  final List<TaskModel> _tasks = [];
  TaskFilter _filter = TaskFilter.all;

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
