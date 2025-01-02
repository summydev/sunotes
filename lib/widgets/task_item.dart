import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/models/task_model.dart';
import 'package:sunotes/providers/task_provider.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.dueDate.toString()),
      trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (value) {
            final updatedTask = task.copyWith(isCompleted: value);
            Provider.of<TaskProvider>(context, listen: false)
                .updateTask(updatedTask);
          }),
    );
  }
}
