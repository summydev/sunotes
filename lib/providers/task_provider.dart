import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sunotes/models/task_model.dart';
import 'package:sunotes/services/notification_service.dart';

enum TaskFilter { all, completed, pending }

class TaskProvider extends ChangeNotifier {
  late Box<TaskModel> _taskBox;
  final List<TaskModel> _tasks = [];
  TaskFilter _filter = TaskFilter.all;
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

  // Getter for the current filter
  TaskFilter get filter => _filter;

  // Set the task filter (all, completed, pending)
  void setFilter(TaskFilter filter) {
    _filter = filter;
    notifyListeners();
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

    notifyListeners();
    if (task.dueDate != null) {
      NotificationService().scheduleNotification(
        id: task.id.hashCode,
        title: 'Task Reminder 🔔',
        body: 'Your task "${task.title}" is due soon!',
        scheduledTime: task.dueDate!.subtract(Duration(minutes: 1)),
      );
    }
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
}
