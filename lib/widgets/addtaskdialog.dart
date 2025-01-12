// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sunotes/models/task_model.dart';
// import 'package:sunotes/providers/task_provider.dart';
// import 'package:sunotes/widgets/brand_colors.dart'; // Import the brand colors

// class AddTaskDialog extends StatefulWidget {
//   const AddTaskDialog({super.key});

//   @override
//   _AddTaskDialogState createState() => _AddTaskDialogState();
// }

// class _AddTaskDialogState extends State<AddTaskDialog> {
//   final TextEditingController _controller = TextEditingController();
//   String _selectedCategory = 'Uncategorized';
//   DateTime? _selectedDeadline;

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final categories = [
//       'Uncategorized',
//       'Work',
//       'Personal',
//       'Shopping',
//       'Health'
//     ];

//     return AlertDialog(
//       backgroundColor: BrandColors.cardColor, // Set background color to white
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       title: const Padding(
//         padding: EdgeInsets.all(8.0),
//         child: Text(
//           'Add Task',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: BrandColors.primaryColor, // Use primary color for title text
//           ),
//         ),
//       ),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Task Title Input
//           TextField(
//             controller: _controller,
//             decoration: InputDecoration(
//               hintText: 'Enter task',
//               hintStyle: TextStyle(color: Colors.grey[600]),
//               contentPadding:
//                   const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: const BorderSide(
//                     color: BrandColors
//                         .primaryColor), // Border color for text field
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),

//           // Category Dropdown
//           DropdownButton<String>(
//             value: _selectedCategory,
//             isExpanded: true,
//             style: const TextStyle(
//                 color: BrandColors.textColor), // Use text color from the brand
//             items: categories
//                 .map((category) => DropdownMenuItem(
//                       value: category,
//                       child: Text(category),
//                     ))
//                 .toList(),
//             onChanged: (value) {
//               if (value != null) {
//                 setState(() {
//                   _selectedCategory = value;
//                 });
//               }
//             },
//             // Instead of 'decoration', use 'underline' to style the dropdown
//             underline: Container(
//               height: 1,
//               color: BrandColors.primaryColor, // Border style for the dropdown
//             ),
//           ),
//           const SizedBox(height: 16),

//           // Deadline Row
//           Row(
//             children: [
//               const Text('Deadline:',
//                   style: TextStyle(
//                       color:
//                           BrandColors.textColor)), // Use text color for labels
//               const Spacer(),
//               Text(
//                 _selectedDeadline != null
//                     ? "${_selectedDeadline!.year}-${_selectedDeadline!.month.toString().padLeft(2, '0')}-${_selectedDeadline!.day.toString().padLeft(2, '0')}"
//                     : 'None',
//                 style: TextStyle(color: Colors.grey[700]),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.calendar_today,
//                     color: BrandColors
//                         .primaryColor), // Icon color with primary color
//                 onPressed: () async {
//                   DateTime? pickedDate = await showDatePicker(
//                     context: context,
//                     initialDate: _selectedDeadline ?? DateTime.now(),
//                     firstDate: DateTime.now(),
//                     lastDate: DateTime(2050),
//                   );
//                   if (pickedDate != null) {
//                     setState(() {
//                       _selectedDeadline = pickedDate;
//                     });
//                   }
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//       actions: [
//         // Cancel Button
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           style: TextButton.styleFrom(
//               foregroundColor:
//                   BrandColors.textColor), // Cancel button color with text color
//           child: const Text('Cancel'),
//         ),
//         // Add Task Button
//         TextButton(
//           onPressed: () {
//             if (_controller.text.isNotEmpty) {
//               final DateTime createdDate = DateTime.now();
//               final newTask = TaskModel(
//                 id: DateTime.now().microsecondsSinceEpoch.toString(),
//                 title: _controller.text,
//                 description: '',
//                 isCompleted: false,
//                 category: _selectedCategory,
//                 dueDate: _selectedDeadline ?? createdDate, // Default deadline
//               );
//               // Add the task using the TaskProvider
//               Provider.of<TaskProvider>(context, listen: false)
//                   .addTask(newTask);
//               Navigator.of(context).pop();
//             }
//           },
//           style: TextButton.styleFrom(
//             foregroundColor:
//                 BrandColors.accentColor, // Accent color for Add button
//           ),
//           child: const Text('Add'),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/models/task_model.dart';
import 'package:sunotes/providers/task_provider.dart';

class AddTaskDialog extends StatefulWidget {
  final TaskModel? task;

  const AddTaskDialog({Key? key, this.task}) : super(key: key);

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _formKey = GlobalKey<FormState>();

  String? _title;
  String? _description;
  DateTime? _dueDate;
  DateTime? _timeDeadline;
  String _category = 'Uncategorized';

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _title = widget.task!.title;
      _description = widget.task!.description;
      _dueDate = widget.task!.dueDate;
      _timeDeadline = widget.task!.timeDeadline;
      _category = widget.task!.category;
    }
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      setState(() {
        _dueDate = pickedDate;
      });
    }
  }

  Future<void> _pickTime() async {
    final timeOfDay = await showTimePicker(
      context: context,
      initialTime: _timeDeadline != null
          ? TimeOfDay.fromDateTime(_timeDeadline!)
          : const TimeOfDay(hour: 12, minute: 0),
    );

    if (timeOfDay != null) {
      setState(() {
        _timeDeadline = DateTime(
          _dueDate?.year ?? DateTime.now().year,
          _dueDate?.month ?? DateTime.now().month,
          _dueDate?.day ?? DateTime.now().day,
          timeOfDay.hour,
          timeOfDay.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return AlertDialog(
      title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Title is required' : null,
                onSaved: (value) => _title = value,
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _pickDate,
                child: Text(_dueDate == null
                    ? 'Set Due Date'
                    : 'Due Date: ${DateFormat.yMMMd().format(_dueDate!)}'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _pickTime,
                child: Text(_timeDeadline == null
                    ? 'Set Time Deadline'
                    : 'Time Deadline: ${DateFormat.jm().format(_timeDeadline!)}'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final task = TaskModel(
                id: widget.task?.id ?? DateTime.now().toString(),
                title: _title!,
                description: _description ?? '',
                dueDate: _dueDate,
                timeDeadline: _timeDeadline,
                category: _category,
                isCompleted: widget.task?.isCompleted ?? false,
              );

              if (widget.task == null) {
                taskProvider.addTask(task);
              } else {
                taskProvider.updateTask(task);
              }

              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
