import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/models/task_model.dart';
import 'package:sunotes/providers/task_provider.dart';
import 'package:intl/intl.dart'; // For date formatting

class TaskDetailScreen extends StatefulWidget {
  final TaskModel task;

  const TaskDetailScreen({super.key, required this.task});

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
        title: Text('Task Details', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false)
                  .removeTask(widget.task.id);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title TextField
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  Provider.of<TaskProvider>(context, listen: false).updateTask(
                    widget.task.copyWith(title: value),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Description TextField
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  Provider.of<TaskProvider>(context, listen: false).updateTask(
                    widget.task.copyWith(description: value),
                  );
                },
                maxLines: 5,
              ),
              const SizedBox(height: 16),

              // Checkbox for 'Completed'
              Row(
                children: [
                  Text(
                    'Completed:',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(width: 8),
                  Consumer<TaskProvider>(
                    builder: (context, taskProvider, child) {
                      final updatedTask =
                          taskProvider.getTaskById(widget.task.id);
                      return Checkbox(
                        value: updatedTask.isCompleted,
                        onChanged: (value) {
                          if (value != null) {
                            taskProvider.updateTask(
                              updatedTask.copyWith(isCompleted: value),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Due Date Selector
              Row(
                children: [
                  Text(
                    'Due Date:',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const Spacer(),
                  Consumer<TaskProvider>(
                    builder: (context, taskProvider, child) {
                      final updatedTask =
                          taskProvider.getTaskById(widget.task.id);
                      return Row(
                        children: [
                          Text(
                            updatedTask.dueDate != null
                                ? DateFormat('yyyy-MM-dd')
                                    .format(updatedTask.dueDate!)
                                : 'None',
                            style: TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon:
                                Icon(Icons.calendar_today, color: Colors.blue),
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate:
                                    updatedTask.dueDate ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050),
                              );
                              if (pickedDate != null) {
                                taskProvider.updateTask(
                                  updatedTask.copyWith(dueDate: pickedDate),
                                );
                                setState(() {}); // Refresh UI
                              }
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
