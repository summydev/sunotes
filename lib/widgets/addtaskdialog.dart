import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sunotes/models/task_model.dart';
import 'package:sunotes/services/notification_service.dart';
import 'package:sunotes/widgets/brand_colors.dart';

class AddTaskDialog extends StatefulWidget {
  final Function(TaskModel) onTaskAdded;

  AddTaskDialog({required this.onTaskAdded});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _taskTitleController = TextEditingController();
  DateTime? _selectedDueDate;
  Duration? _selectedReminderDuration;
  String _selectedCategory = 'Uncategorized';
  @override
  void dispose() {
    _taskTitleController.dispose();
    super.dispose();
  }

  void _pickDueDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDueDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _pickReminderDuration() async {
    final pickedDuration = await showModalBottomSheet<Duration>(
      context: context,
      builder: (context) {
        return ListView(
          children: [
            ListTile(
              title: Text("5 minutes before"),
              onTap: () => Navigator.of(context).pop(Duration(minutes: 5)),
            ),
            ListTile(
              title: Text("15 minutes before"),
              onTap: () => Navigator.of(context).pop(Duration(minutes: 15)),
            ),
            ListTile(
              title: Text("30 minutes before"),
              onTap: () => Navigator.of(context).pop(Duration(minutes: 30)),
            ),
            ListTile(
              title: Text("1 hour before"),
              onTap: () => Navigator.of(context).pop(Duration(hours: 1)),
            ),
          ],
        );
      },
    );

    if (pickedDuration != null) {
      setState(() {
        _selectedReminderDuration = pickedDuration;
      });
    }
  }

  void _addTask() {
    final title = _taskTitleController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Task title cannot be empty")),
      );
      return;
    }

    if (_selectedDueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a due date")),
      );
      return;
    }

    final reminderTime = _selectedReminderDuration != null
        ? _selectedDueDate!.subtract(_selectedReminderDuration!)
        : null;

    if (reminderTime != null && reminderTime.isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Reminder time must be in the future")),
      );
      return;
    }

    final newTask = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      dueDate: _selectedDueDate,
      category: _selectedCategory, // Update based on your UI
      isCompleted: false, description: '', priority: '',
    );

    widget.onTaskAdded(newTask);

    if (reminderTime != null) {
      NotificationService().scheduleNotification(
        id: newTask.id.hashCode,
        title: 'Task Reminder 🔔',
        body: 'Reminder for task: "$title"',
        scheduledTime: reminderTime,
      );
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Uncategorized',
      'Work',
      'Personal',
      'Shopping',
      'Health'
    ];
    return AlertDialog(
      title: Text('Add New Task'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _taskTitleController,
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            SizedBox(height: 16),
            // Category Dropdown
            DropdownButton<String>(
              value: _selectedCategory,
              isExpanded: true,
              style: const TextStyle(color: BrandColors.textColor),
              items: categories
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              },
              underline: Container(
                height: 1,
                color: BrandColors.primaryColor,
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDueDate != null
                      ? 'Due Date: ${DateFormat.yMMMd().add_jm().format(_selectedDueDate!)}'
                      : 'No Due Date Set',
                ),
                TextButton(
                  onPressed: _pickDueDate,
                  child: Text('Set Due Date'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedReminderDuration != null
                      ? 'Reminder: ${_selectedReminderDuration!.inMinutes} mins before'
                      : 'No Reminder Set',
                ),
                TextButton(
                  onPressed: _pickReminderDuration,
                  child: Text('Set Reminder'),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _addTask,
          child: Text('Add Task'),
        ),
      ],
    );
  }
}
