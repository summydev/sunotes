import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/models/task_model.dart';
import 'package:sunotes/providers/task_provider.dart';

class TaskDetailScreen extends StatefulWidget {
  final TaskModel task;

  TaskDetailScreen({required this.task});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController =
        TextEditingController(text: widget.task.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false)
                  .removeTask(widget.task.id);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Title TextField
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
              onChanged: (value) {
                // Update task title
                Provider.of<TaskProvider>(context, listen: false).updateTask(
                  widget.task.copyWith(title: value),
                );
              },
            ),
            SizedBox(height: 16),
            // Description TextField
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                // Update task description
                Provider.of<TaskProvider>(context, listen: false).updateTask(
                  widget.task.copyWith(description: value),
                );
              },
            ),
            SizedBox(height: 16),
            // Checkbox for 'Completed'
            Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                // Fetch the updated task before using it
                TaskModel updatedTask =
                    taskProvider.getTaskById(widget.task.id);

                return Row(
                  children: [
                    Text('Completed:'),
                    Checkbox(
                      value: updatedTask.isCompleted,
                      onChanged: (value) {
                        final updatedTasks =
                            updatedTask.copyWith(isCompleted: value);
                        taskProvider.updateTask(updatedTasks);
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
