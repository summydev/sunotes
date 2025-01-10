import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/models/task_model.dart';
import 'package:sunotes/providers/task_provider.dart';
import 'package:sunotes/widgets/task_item.dart';

class TaskList extends StatelessWidget {
  final List<TaskModel> filteredTasks;
  const TaskList({super.key, required this.filteredTasks});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return ListView.builder(
        itemCount: filteredTasks.length,
        itemBuilder: (ctx, index) {
          // final task = tasks[index];
          final task = filteredTasks[index];
          final isOverdue =
              task.dueDate != null && task.dueDate!.isBefore(DateTime.now());
          final categoryColor = taskProvider.getCategoryColor(task.category);

          return TaskItem(
            categoryColor: categoryColor,
            task: task,
            isOverdue: isOverdue,
          );
        });
  }
}
