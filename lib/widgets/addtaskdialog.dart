// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sunotes/models/task_model.dart';
// import 'package:sunotes/providers/task_provider.dart';

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
//     final categories = ['Work', 'Personal', 'Shopping', 'Health'];

//     return AlertDialog(
//       title: const Text('Add Task'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Task Title Input
//           TextField(
//             controller: _controller,
//             decoration: const InputDecoration(hintText: 'Enter task title'),
//           ),
//           const SizedBox(height: 16),
//           // Deadline Selector
//           Column(
//             children: [
//               DropdownButton<String>(
//                   value: _selectedCategory,
//                   items: categories
//                       .map((category) => DropdownMenuItem(
//                             value: category,
//                             child: Text(category),
//                           ))
//                       .toList(),
//                   onChanged: (value) {
//                     if (value != null) {
//                       _selectedCategory = value;
//                     }
//                   }),
//               Row(
//                 children: [
//                   const Text('Deadline:'),
//                   const Spacer(),
//                   Text(
//                     _selectedDeadline != null
//                         ? "${_selectedDeadline!.year}-${_selectedDeadline!.month.toString().padLeft(2, '0')}-${_selectedDeadline!.day.toString().padLeft(2, '0')}"
//                         : 'None',
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.calendar_today),
//                     onPressed: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: _selectedDeadline ?? DateTime.now(),
//                         firstDate: DateTime.now(),
//                         lastDate: DateTime(2050),
//                       );
//                       if (pickedDate != null) {
//                         setState(() {
//                           _selectedDeadline = pickedDate;
//                         });
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//       actions: [
//         // Cancel Button
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
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
//           child: const Text('Add'),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/models/task_model.dart';
import 'package:sunotes/providers/task_provider.dart';

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
    // Including 'Uncategorized' as the first category
    final categories = [
      'Uncategorized',
      'Work',
      'Personal',
      'Shopping',
      'Health'
    ];

    return AlertDialog(
      title: const Text('Add Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Task Title Input
          TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Enter task title'),
          ),
          const SizedBox(height: 16),
          // Deadline Selector
          Column(
            children: [
              DropdownButton<String>(
                value: _selectedCategory,
                items: categories
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory =
                          value; // Update state when category is changed
                    });
                  }
                },
              ),
              Row(
                children: [
                  const Text('Deadline:'),
                  const Spacer(),
                  Text(
                    _selectedDeadline != null
                        ? "${_selectedDeadline!.year}-${_selectedDeadline!.month.toString().padLeft(2, '0')}-${_selectedDeadline!.day.toString().padLeft(2, '0')}"
                        : 'None',
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
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
        ],
      ),
      actions: [
        // Cancel Button
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
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
          child: const Text('Add'),
        ),
      ],
    );
  }
}
