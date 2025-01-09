import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/models/task_model.dart';
import 'package:sunotes/providers/task_provider.dart';
import 'package:sunotes/widgets/addtaskdialog.dart';
import 'package:sunotes/widgets/task_list.dart';

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
        return tasks;
    }
  }

  @override
  Widget build(BuildContext context) {
    //final taskProvider = Provider.of<TaskProvider>(context);

    return Consumer<TaskProvider>(builder: (context, taskProvider, child) {
      final filteredTasks = filterTasks(taskProvider.tasks, filter);

      return Scaffold(
        // appBar: AppBar(
        //   title: Center(child: const Text('SUnotE')),
        //
        // ),

        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(200.0), // Increase height for space
          child: ClipPath(
            clipper: BottomRightCurveClipper(),
            child: AppBar(
              title: Text('$filter Tasks (${filteredTasks.length})'),
              backgroundColor: Colors.blue,
              flexibleSpace: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the column vertically
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<TaskFilter>(
                        iconSize: 1,
                        icon: const Icon(
                          Icons.menu_open_rounded,
                          color: Colors.white,
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
                      const Icon(Icons.add)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TaskList(
          filteredTasks: filteredTasks,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context, builder: (cotext) => const AddTaskDialog());
          },
          child: const Icon(Icons.add),
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
