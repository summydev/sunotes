import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/models/task_model.dart';
import 'package:sunotes/providers/task_provider.dart';
import 'package:sunotes/screens/task_detail_screen.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  final bool isOverdue;
  final Color categoryColor;

  const TaskItem(
      {super.key,
      required this.task,
      required this.isOverdue,
      required this.categoryColor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(color: isOverdue ? Colors.red : categoryColor),
      ),
      subtitle: Text(
        task.dueDate != null
            ? 'Due: ${DateFormat('yyyy-MM-dd').format(task.dueDate!)}'
            : 'No Deadline',
        style: TextStyle(color: isOverdue ? Colors.red : Colors.black),
      ),
      trailing: Checkbox(
          activeColor: categoryColor,
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
