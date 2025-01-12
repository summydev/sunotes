import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/models/task_model.dart';
import 'package:sunotes/providers/task_provider.dart';
import 'package:sunotes/widgets/brand_colors.dart';

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

  Future<void> _updateDueDate(BuildContext context) async {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    // Step 1: Select the date
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.task.dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      // Step 2: Select the time
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: widget.task.dueDate != null
            ? TimeOfDay.fromDateTime(widget.task.dueDate!)
            : TimeOfDay.now(),
      );

      if (pickedTime != null) {
        // Step 3: Combine date and time into a single DateTime
        final updatedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Step 4: Update the task in the provider
        final updatedTask = widget.task.copyWith(dueDate: updatedDateTime);
        taskProvider.updateTask(updatedTask);

        // Step 5: Refresh the UI to reflect the updated due date
        setState(() {
          widget.task.dueDate = updatedDateTime; // Sync the task locally
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Task Details', style: TextStyle(color: Colors.white)),
        backgroundColor: BrandColors.primaryColor,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: BrandColors.dangerColor),
            onPressed: () {
              taskProvider.removeTask(widget.task.id);
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
                  labelStyle: const TextStyle(color: BrandColors.textColor),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: BrandColors.accentColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  final updatedTask = widget.task.copyWith(title: value);
                  taskProvider.updateTask(updatedTask);
                },
              ),
              const SizedBox(height: 16),

              // Description TextField
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: const TextStyle(color: BrandColors.textColor),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: BrandColors.accentColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  final updatedTask = widget.task.copyWith(description: value);
                  taskProvider.updateTask(updatedTask);
                },
                maxLines: 5,
              ),
              const SizedBox(height: 16),

              // Completed Checkbox
              Row(
                children: [
                  const Text(
                    'Completed:',
                    style:
                        TextStyle(fontSize: 16, color: BrandColors.textColor),
                  ),
                  const SizedBox(width: 8),
                  Checkbox(
                    value: widget.task.isCompleted,
                    onChanged: (value) {
                      if (value != null) {
                        final updatedTask =
                            widget.task.copyWith(isCompleted: value);
                        taskProvider.updateTask(updatedTask);
                        setState(() {}); // Refresh UI
                      }
                    },
                    activeColor: BrandColors.accentColor,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Due Date Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Deadline:',
                    style:
                        TextStyle(fontSize: 16, color: BrandColors.textColor),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.task.dueDate != null
                            ? DateFormat('yyyy-MM-dd HH:mm')
                                .format(widget.task.dueDate!)
                            : 'No Deadline',
                        style: TextStyle(
                          fontSize: 16,
                          color: widget.task.dueDate != null
                              ? BrandColors.textColor
                              : Colors.grey,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit_calendar,
                            color: BrandColors.accentColor),
                        onPressed: () => _updateDueDate(context),
                      ),
                    ],
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
