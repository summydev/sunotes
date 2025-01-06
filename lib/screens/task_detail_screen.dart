// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:sunotes/models/task_model.dart';
// // import 'package:sunotes/providers/task_provider.dart';

// // class TaskDetailScreen extends StatefulWidget {
// //   final TaskModel task;

// //   const TaskDetailScreen({super.key, required this.task});

// //   @override
// //   _TaskDetailScreenState createState() => _TaskDetailScreenState();
// // }

// // class _TaskDetailScreenState extends State<TaskDetailScreen> {
// //   late TextEditingController titleController;
// //   late TextEditingController descriptionController;

// //   @override
// //   void initState() {
// //     super.initState();
// //     titleController = TextEditingController(text: widget.task.title);
// //     descriptionController =
// //         TextEditingController(text: widget.task.description);
// //   }

// //   @override
// //   void dispose() {
// //     titleController.dispose();
// //     descriptionController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Task Details'),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.delete),
// //             onPressed: () {
// //               Provider.of<TaskProvider>(context, listen: false)
// //                   .removeTask(widget.task.id);
// //               Navigator.of(context).pop();
// //             },
// //           ),
// //         ],
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             // Title TextField
// //             TextField(
// //               controller: titleController,
// //               decoration: const InputDecoration(labelText: 'Title'),
// //               onChanged: (value) {
// //                 // Update task title
// //                 Provider.of<TaskProvider>(context, listen: false).updateTask(
// //                   widget.task.copyWith(title: value),
// //                 );
// //               },
// //             ),
// //             const SizedBox(height: 16),
// //             // Description TextField
// //             TextField(
// //               controller: descriptionController,
// //               decoration: const InputDecoration(labelText: 'Description'),
// //               onChanged: (value) {
// //                 // Update task description
// //                 Provider.of<TaskProvider>(context, listen: false).updateTask(
// //                   widget.task.copyWith(description: value),
// //                 );
// //               },
// //             ),
// //             const SizedBox(height: 16),
// //             // Checkbox for 'Completed'
// //             Consumer<TaskProvider>(
// //               builder: (context, taskProvider, child) {
// //                 // Fetch the updated task before using it
// //                 TaskModel updatedTask =
// //                     taskProvider.getTaskById(widget.task.id);

// //                 return Row(
// //                   children: [
// //                     const Text('Completed:'),
// //                     Checkbox(
// //                       value: updatedTask.isCompleted,
// //                       onChanged: (value) {
// //                         final updatedTasks =
// //                             updatedTask.copyWith(isCompleted: value);
// //                         taskProvider.updateTask(updatedTasks);
// //                       },
// //                     ),
// //                   ],
// //                 );
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sunotes/models/task_model.dart';
// import 'package:sunotes/providers/task_provider.dart';

// class TaskDetailScreen extends StatefulWidget {
//   final TaskModel task;

//   const TaskDetailScreen({super.key, required this.task});

//   @override
//   _TaskDetailScreenState createState() => _TaskDetailScreenState();
// }

// class _TaskDetailScreenState extends State<TaskDetailScreen> {
//   late TextEditingController titleController;
//   late TextEditingController descriptionController;

//   @override
//   void initState() {
//     super.initState();
//     titleController = TextEditingController(text: widget.task.title);
//     descriptionController =
//         TextEditingController(text: widget.task.description);
//   }

//   @override
//   void dispose() {
//     titleController.dispose();
//     descriptionController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Task Details'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.delete),
//             onPressed: () {
//               Provider.of<TaskProvider>(context, listen: false)
//                   .removeTask(widget.task.id);
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title TextField
//             TextField(
//               controller: titleController,
//               decoration: const InputDecoration(labelText: 'Title'),
//               onChanged: (value) {
//                 Provider.of<TaskProvider>(context, listen: false).updateTask(
//                   widget.task.copyWith(title: value),
//                 );
//               },
//             ),
//             const SizedBox(height: 16),
//             // Description TextField
//             TextField(
//               controller: descriptionController,
//               decoration: const InputDecoration(labelText: 'Description'),
//               onChanged: (value) {
//                 Provider.of<TaskProvider>(context, listen: false).updateTask(
//                   widget.task.copyWith(description: value),
//                 );
//               },
//             ),
//             const SizedBox(height: 16),
//             // Checkbox for 'Completed'
//             Row(
//               children: [
//                 const Text('Completed:'),
//                 Consumer<TaskProvider>(
//                   builder: (context, taskProvider, child) {
//                     // Fetch updated task state
//                     final updatedTask =
//                         taskProvider.getTaskById(widget.task.id);

//                     return Checkbox(
//                       value: updatedTask.isCompleted,
//                       onChanged: (value) {
//                         if (value != null) {
//                           taskProvider.updateTask(
//                             updatedTask.copyWith(isCompleted: value),
//                           );
//                         }
//                       },
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title TextField
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
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
              decoration: const InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                Provider.of<TaskProvider>(context, listen: false).updateTask(
                  widget.task.copyWith(description: value),
                );
              },
            ),
            const SizedBox(height: 16),
            // Checkbox for 'Completed'
            Row(
              children: [
                const Text('Completed:'),
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
                const Text('Due Date:'),
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
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate:
                                  updatedTask.dueDate ?? DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
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
    );
  }
}
