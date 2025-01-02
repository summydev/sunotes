import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/models/task_model.dart';
import 'package:sunotes/providers/task_provider.dart';

class AddTaskDialog extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  AddTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Task'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(hintText: 'Enter task title'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              final newTask = TaskModel(
                description: '',
                id: DateTime.now().toString(),
                title: _controller.text,
                dueDate: DateTime.now(),
              );
              Provider.of<TaskProvider>(context, listen: false)
                  .addTask(newTask);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
