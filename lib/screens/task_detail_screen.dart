import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/models/task_model.dart';
import 'package:sunotes/providers/task_provider.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel task;

  TaskDetailScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final TextEditingController titleController = TextEditingController();
    final TextEditingController desriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        actions: [
          IconButton(
              onPressed: () {
                taskProvider.removeTask(task.id);
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: task.title),
              onChanged: (value) {
                taskProvider.updateTask(task.copyWith(title: value));
              },
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: desriptionController,
              decoration: InputDecoration(labelText: task.description),
              onChanged: (value) {
                taskProvider.updateTask(task.copyWith(description: value));
              },
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text('Completed'),
                Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      taskProvider.updateTask(
                          task.copyWith(isCompleted: value ?? false));
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
