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
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return ListView.builder(
          itemCount: filteredTasks.length,
          itemBuilder: (context, index) {
            final task = filteredTasks[index];
            // final isOverdue = task.dueDate != null &&
            //     task.dueDate!.day == DateTime.now().day &&
            //     task.dueDate!.year < DateTime.now().year &&
            //     task.dueDate!.isBefore(DateTime.now());
            // In TaskList widget
            final isOverdue =
                task.dueDate != null && task.dueDate!.isBefore(DateTime.now());

            return TaskItem(
              task: task,
              isOverdue: isOverdue,
              categoryColor: taskProvider.getCategoryColor(task.category),
            );
          },
        );
      },
    );
  }
}
