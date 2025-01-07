import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/providers/task_provider.dart';
import 'package:sunotes/widgets/task_item.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    // final tasks = Provider.of<TaskProvider>(context).tasks;
    return Consumer<TaskProvider>(builder: (context, taskProvider, child) {
      final tasks = [...taskProvider.tasks];
      tasks.sort((a, b) {
        if (a.dueDate == null) return 1;
        if (b.dueDate == null) return -1;
        return a.dueDate!.compareTo(b.dueDate!);
      });
      return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (ctx, index) {
            final task = tasks[index];
            final isOverdue =
                task.dueDate != null && task.dueDate!.isBefore(DateTime.now());

            return TaskItem(
              task: tasks[index],
              isOverdue: isOverdue,
            );
          });
    });
  }
}
