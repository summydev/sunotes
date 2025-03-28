// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:sunotes/models/task_model.dart';

// enum TaskFilter { all, completed, pending }

// class TaskProvider extends ChangeNotifier {
//   late Box<TaskModel> _taskBox;
//   final List<TaskModel> _tasks = [];
//   TaskFilter _filter = TaskFilter.all;
//   String _searchQuery = '';
//   bool _isInitialized = false;

//   bool get isInitialized => _isInitialized;

//   TaskProvider() {
//     initialize();
//   }

//   // Category color mapping
//   final Map<String, Color> _categoryColors = {
//     'Uncategorized': Colors.grey,
//     'Work': const Color.fromARGB(255, 126, 180, 241),
//     'Personal': const Color.fromARGB(255, 50, 202, 114),
//     'Shopping': const Color.fromARGB(255, 233, 28, 96),
//     'Health': const Color.fromARGB(255, 69, 73, 69),
//   };

//   // Initialize the Hive box and load tasks
//   Future<void> initialize() async {
//     _taskBox = await Hive.openBox<TaskModel>('tasks');
//     _tasks.clear();
//     _tasks.addAll(_taskBox.values);
//     print("Loaded tasks from Hive: ${_tasks.length}");
//     _isInitialized = true;
//     notifyListeners();
//   }

//   // Getter for tasks based on filter and search query
//   List<TaskModel> get tasks {
//     var filteredTasks = _tasks;

//     if (_searchQuery.isNotEmpty) {
//       filteredTasks = filteredTasks
//           .where((task) =>
//               task.title.toLowerCase().contains(_searchQuery) ||
//               (task.description.toLowerCase().contains(_searchQuery)))
//           .toList();
//     }

//     switch (_filter) {
//       case TaskFilter.completed:
//         return filteredTasks.where((task) => task.isCompleted).toList();
//       case TaskFilter.pending:
//         return filteredTasks.where((task) => !task.isCompleted).toList();
//       default:
//         return List.unmodifiable(filteredTasks);
//     }
//   }

//   // Getter for the current filter
//   TaskFilter get filter => _filter;

//   // Update the task filter (all, completed, pending)
//   void setFilter(TaskFilter filter) {
//     _filter = filter;
//     notifyListeners();
//   }

//   // Update the search query
//   void updateSearchQuery(String query) {
//     _searchQuery = query.toLowerCase();
//     notifyListeners();
//   }

//   // Search tasks globally (used for the search delegate)
//   List<TaskModel> searchTasks(String query) {
//     return _tasks
//         .where((task) =>
//             task.title.toLowerCase().contains(query.toLowerCase()) ||
//             (task.description.toLowerCase().contains(query.toLowerCase())))
//         .toList();
//   }

//   // Get tasks by category
//   List<TaskModel> getTasksByCategory(String category) {
//     return _tasks.where((task) => task.category == category).toList();
//   }

//   // Get categories
//   List<String> getCategories() {
//     return _tasks.map((task) => task.category).toSet().toList();
//   }

//   // Get color for a given category
//   Color getCategoryColor(String category) {
//     return _categoryColors[category] ?? const Color.fromARGB(255, 32, 145, 238);
//   }

//   // Add a task to the list and save to Hive
//   void addTask(TaskModel task) {
//     _tasks.add(task);
//     _taskBox.put(task.id, task);
//     print("Task added: ${task.title}, ID: ${task.id}");
//     notifyListeners();
//     printBoxContent();
//   }

//   void printBoxContent() {
//     print("Hive Box Content:");
//     for (var key in _taskBox.keys) {
//       print("Key: $key, Value: ${_taskBox.get(key)}");
//     }
//   }

//   // Update a task in the list and Hive
//   void updateTask(TaskModel updatedTask) {
//     final taskIndex = _tasks.indexWhere((task) => task.id == updatedTask.id);
//     if (taskIndex != -1) {
//       _tasks[taskIndex] = updatedTask;
//       _taskBox.put(updatedTask.id, updatedTask);
//       notifyListeners();
//     }
//   }

//   // Remove a task by ID from the list and Hive
//   void removeTask(String id) {
//     _tasks.removeWhere((task) => task.id == id);
//     _taskBox.delete(id);
//     notifyListeners();
//   }

//   // Toggle task completion status
//   void toggleTaskCompletion(String id) {
//     final task = _tasks.firstWhere((task) => task.id == id);
//     task.toggleCompleted();
//     _taskBox.put(task.id, task);
//     notifyListeners();
//   }

//   // Getter for completed tasks
//   List<TaskModel> get completedTasks =>
//       _tasks.where((task) => task.isCompleted).toList();

//   // Getter for pending tasks
//   List<TaskModel> get pendingTasks =>
//       _tasks.where((task) => !task.isCompleted).toList();

//   // Get a task by its ID
//   TaskModel getTaskById(String id) {
//     return _tasks.firstWhere((task) => task.id == id);
//   }

//   // Clear all tasks from both the list and Hive
//   void clearAllTasks() {
//     _tasks.clear();
//     _taskBox.clear();
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sunotes/models/task_model.dart';

enum TaskFilter { all, completed, pending }

class TaskProvider extends ChangeNotifier {
  late Box<TaskModel> _taskBox;
  final List<TaskModel> _tasks = [];
  TaskFilter _filter = TaskFilter.all;
  String _searchQuery = '';
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  TaskProvider() {
    initialize();
  }

  // Category color mapping
  final Map<String, Color> _categoryColors = {
    'Uncategorized': Colors.grey,
    'Work': const Color.fromARGB(255, 126, 180, 241),
    'Personal': const Color.fromARGB(255, 50, 202, 114),
    'Shopping': const Color.fromARGB(255, 233, 28, 96),
    'Health': const Color.fromARGB(255, 69, 73, 69),
  };

  // Initialize the Hive box and load tasks
  Future<void> initialize() async {
    _taskBox = await Hive.openBox<TaskModel>('tasks');
    _tasks.clear();
    _tasks.addAll(_taskBox.values);
    print("Loaded tasks from Hive: ${_tasks.length}");
    _isInitialized = true;
    notifyListeners();
  }

  // Getter for tasks based on filter and search query, with completed tasks moved to the bottom
  List<TaskModel> get tasks {
    var filteredTasks = _tasks;

    if (_searchQuery.isNotEmpty) {
      filteredTasks = filteredTasks
          .where((task) =>
              task.title.toLowerCase().contains(_searchQuery) ||
              (task.description.toLowerCase().contains(_searchQuery)))
          .toList();
    }

    switch (_filter) {
      case TaskFilter.completed:
        filteredTasks =
            filteredTasks.where((task) => task.isCompleted).toList();
        break;
      case TaskFilter.pending:
        filteredTasks =
            filteredTasks.where((task) => !task.isCompleted).toList();
        break;
      default:
        break;
    }

    // Sort tasks: pending tasks first, completed tasks last
    filteredTasks.sort((a, b) {
      if (a.isCompleted && !b.isCompleted) return 1;
      if (!a.isCompleted && b.isCompleted) return -1;
      return 0;
    });

    return List.unmodifiable(filteredTasks);
  }

  // Getter for the current filter
  TaskFilter get filter => _filter;

  // Update the task filter (all, completed, pending)
  void setFilter(TaskFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  // Update the search query
  void updateSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    notifyListeners();
  }

  // Search tasks globally (used for the search delegate)
  List<TaskModel> searchTasks(String query) {
    return _tasks
        .where((task) =>
            task.title.toLowerCase().contains(query.toLowerCase()) ||
            (task.description.toLowerCase().contains(query.toLowerCase())))
        .toList();
  }

  // Get tasks by category
  List<TaskModel> getTasksByCategory(String category) {
    return _tasks.where((task) => task.category == category).toList();
  }

  // Get categories
  List<String> getCategories() {
    return _tasks.map((task) => task.category).toSet().toList();
  }

  // Get color for a given category
  Color getCategoryColor(String category) {
    return _categoryColors[category] ?? const Color.fromARGB(255, 32, 145, 238);
  }

  // Add a task to the list and save to Hive
  void addTask(TaskModel task) {
    _tasks.add(task);
    _taskBox.put(task.id, task);
    print("Task added: ${task.title}, ID: ${task.id}");
    notifyListeners();
    printBoxContent();
  }

  void printBoxContent() {
    print("Hive Box Content:");
    for (var key in _taskBox.keys) {
      print("Key: $key, Value: ${_taskBox.get(key)}");
    }
  }

  // Update a task in the list and Hive
  void updateTask(TaskModel updatedTask) {
    final taskIndex = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (taskIndex != -1) {
      _tasks[taskIndex] = updatedTask;
      _taskBox.put(updatedTask.id, updatedTask);
      notifyListeners();
    }
  }

  // Remove a task by ID from the list and Hive
  void removeTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    _taskBox.delete(id);
    notifyListeners();
  }

  // Toggle task completion status
  void toggleTaskCompletion(String id) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.toggleCompleted();
    _taskBox.put(task.id, task);
    notifyListeners();
  }

  // Getter for completed tasks
  List<TaskModel> get completedTasks =>
      _tasks.where((task) => task.isCompleted).toList();

  // Getter for pending tasks
  List<TaskModel> get pendingTasks =>
      _tasks.where((task) => !task.isCompleted).toList();

  // Get a task by its ID
  TaskModel getTaskById(String id) {
    return _tasks.firstWhere((task) => task.id == id);
  }

  // Clear all tasks from both the list and Hive
  void clearAllTasks() {
    _tasks.clear();
    _taskBox.clear();
    notifyListeners();
  }

  // Add a subtask to a specific task
  void addSubtask(String taskId, Subtask subtask) {
    final task = _tasks.firstWhere((task) => task.id == taskId);
    task.subtasks?.add(subtask);
    _taskBox.put(task.id, task); // Save to Hive
    notifyListeners();
  }

// Toggle subtask completion
  void toggleSubtaskCompletion(String taskId, int subtaskIndex) {
    final task = _tasks.firstWhere((task) => task.id == taskId);
    task.subtasks?[subtaskIndex].toggleCompleted();
    _taskBox.put(task.id, task); // Save to Hive
    notifyListeners();
  }

// Remove a subtask
  void removeSubtask(String taskId, int subtaskIndex) {
    final task = _tasks.firstWhere((task) => task.id == taskId);
    task.subtasks?.removeAt(subtaskIndex);
    _taskBox.put(task.id, task); // Save to Hive
    notifyListeners();
  }
}
