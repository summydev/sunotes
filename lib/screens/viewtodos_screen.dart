import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/models/task_model.dart';
import 'package:sunotes/providers/task_provider.dart';
import 'package:sunotes/widgets/addtaskdialog.dart';
import 'package:sunotes/widgets/task_list.dart';
import 'package:sunotes/widgets/brand_colors.dart';

extension DateTimeComparison on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

class ViewTodoScreen extends StatelessWidget {
  final String filter;
  const ViewTodoScreen({super.key, required this.filter});

  List<TaskModel> filterTasks(List<TaskModel> tasks, String filter) {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    final startOfTomorrow = startOfToday.add(const Duration(days: 1));
    final startOfNextweek = startOfToday.add(Duration(days: 7 - now.weekday));
    final startOfNextMonth = DateTime(now.year, now.month + 1);

    switch (filter) {
      case 'Today':
        return tasks
            .where((task) =>
                task.dueDate != null && task.dueDate!.isSameDay(startOfToday))
            .toList();

      case 'Tomorrow':
        return tasks
            .where((task) =>
                task.dueDate != null &&
                task.dueDate!.isSameDay(startOfTomorrow))
            .toList();
      case 'This Week':
        return tasks
            .where((task) =>
                task.dueDate != null &&
                task.dueDate!.isAfter(startOfToday) &&
                task.dueDate!.isBefore(startOfNextweek))
            .toList();
      case 'This Month':
        return tasks
            .where((task) =>
                task.dueDate != null &&
                task.dueDate!.isAfter(startOfToday) &&
                task.dueDate!.isBefore(startOfNextMonth))
            .toList();
      default:
        return tasks.where((task) => task.category == filter).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (context, taskProvider, child) {
      final filteredTasks = filterTasks(taskProvider.tasks, filter);
      int completedCount =
          filteredTasks.where((task) => task.isCompleted).length;
      int pendingCount = filteredTasks.length - completedCount;

      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(220.0),
          child: ClipPath(
            clipper: BottomRightCurveClipper(),
            child: AppBar(
              elevation: 1,
              toolbarHeight: 160,
              backgroundColor: BrandColors.primaryColor, // Primary brand color
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40.0),
                    Text(
                      '$filter Tasks',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$completedCount completed, $pendingCount pending',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButton<TaskFilter>(
                      iconSize: 1,
                      icon: const Icon(
                        Icons.menu_open_rounded,
                        color: Colors.black,
                        size: 30,
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: TaskFilter.all, child: Text('All')),
                        DropdownMenuItem(
                          value: TaskFilter.completed,
                          child: Text('Completed'),
                        ),
                        DropdownMenuItem(
                          value: TaskFilter.pending,
                          child: Text('Pending'),
                        )
                      ],
                      onChanged: (filter) {
                        if (filter != null) {
                          taskProvider.setFilter(filter);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TaskList(filteredTasks: filteredTasks),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // final categories = context.read<TaskProvider>().getCategories();
            showDialog(
              context: context,
              builder: (context) => AddTaskDialog(
                onTaskAdded: (task) {
                  Provider.of<TaskProvider>(context, listen: false)
                      .addTask(task);
                },
                // categories: categories,
              ),
            );
          },
          backgroundColor: BrandColors.accentColor, // Accent color for button
          child: const Icon(Icons.add, color: Colors.white),
        ),
      );
    });
  }
}

class BottomRightCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height); // left side
    path.lineTo(size.width - 100, size.height); // bottom-left to bottom-right
    path.quadraticBezierTo(size.width, size.height, size.width,
        size.height - 100); // curve bottom-right
    path.lineTo(size.width, 0); // right side
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
