import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/models/task_model.dart';
import 'package:sunotes/providers/task_provider.dart';
import 'package:sunotes/screens/task_detail_screen.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  const TaskItem({super.key, required this.task});

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
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => TaskDetailScreen(task: task)));
      },
    );
  }
}
