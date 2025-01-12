import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/models/task_model.dart';
import 'package:sunotes/providers/task_provider.dart';
import 'package:sunotes/screens/task_detail_screen.dart';
import 'package:sunotes/widgets/brand_colors.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  final bool isOverdue;
  final Color categoryColor;

  const TaskItem({
    super.key,
    required this.task,
    required this.isOverdue,
    required this.categoryColor,
  });

  String _formatDateTime(DateTime? dueDate) {
    if (dueDate == null) {
      return 'No Deadline';
    }
    return 'Due: ${DateFormat('yyyy-MM-dd h:mm a').format(dueDate)}';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      tileColor: BrandColors.cardColor,
      title: Text(
        task.title,
        style: TextStyle(
          color: isOverdue ? Colors.red : categoryColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        _formatDateTime(task.dueDate),
        style: TextStyle(
          color: isOverdue ? Colors.red : BrandColors.textColor,
          fontSize: 14,
        ),
      ),
      trailing: Checkbox(
        activeColor: categoryColor,
        value: task.isCompleted,
        onChanged: (value) {
          if (value != null) {
            final updatedTask = task.copyWith(isCompleted: value);
            Provider.of<TaskProvider>(context, listen: false)
                .updateTask(updatedTask);
          }
        },
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => TaskDetailScreen(task: task),
          ),
        );
      },
    );
  }
}
