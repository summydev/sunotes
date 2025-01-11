import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/models/task_model.dart';
import 'package:sunotes/providers/task_provider.dart';
import 'package:sunotes/widgets/brand_colors.dart'; // Import the brand colors

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _controller = TextEditingController();
  String _selectedCategory = 'Uncategorized';
  DateTime? _selectedDeadline;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
      backgroundColor: BrandColors.cardColor, // Set background color to white
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Add Task',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: BrandColors.primaryColor, // Use primary color for title text
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Task Title Input
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter task',
              hintStyle: TextStyle(color: Colors.grey[600]),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: BrandColors
                        .primaryColor), // Border color for text field
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Category Dropdown
          DropdownButton<String>(
            value: _selectedCategory,
            isExpanded: true,
            style: TextStyle(
                color: BrandColors.textColor), // Use text color from the brand
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
            // Instead of 'decoration', use 'underline' to style the dropdown
            underline: Container(
              height: 1,
              color: BrandColors.primaryColor, // Border style for the dropdown
            ),
          ),
          const SizedBox(height: 16),

          // Deadline Row
          Row(
            children: [
              const Text('Deadline:',
                  style: TextStyle(
                      color:
                          BrandColors.textColor)), // Use text color for labels
              const Spacer(),
              Text(
                _selectedDeadline != null
                    ? "${_selectedDeadline!.year}-${_selectedDeadline!.month.toString().padLeft(2, '0')}-${_selectedDeadline!.day.toString().padLeft(2, '0')}"
                    : 'None',
                style: TextStyle(color: Colors.grey[700]),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today,
                    color: BrandColors
                        .primaryColor), // Icon color with primary color
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDeadline ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2050),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _selectedDeadline = pickedDate;
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        // Cancel Button
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
              foregroundColor:
                  BrandColors.textColor), // Cancel button color with text color
          child: const Text('Cancel'),
        ),
        // Add Task Button
        TextButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              final DateTime createdDate = DateTime.now();
              final newTask = TaskModel(
                id: DateTime.now().microsecondsSinceEpoch.toString(),
                title: _controller.text,
                description: '',
                isCompleted: false,
                category: _selectedCategory,
                dueDate: _selectedDeadline ?? createdDate, // Default deadline
              );
              // Add the task using the TaskProvider
              Provider.of<TaskProvider>(context, listen: false)
                  .addTask(newTask);
              Navigator.of(context).pop();
            }
          },
          style: TextButton.styleFrom(
            foregroundColor:
                BrandColors.accentColor, // Accent color for Add button
          ),
          child: const Text('Add'),
        ),
      ],
    );
  }
}
