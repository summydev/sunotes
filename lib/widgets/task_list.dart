// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sunotes/models/task_model.dart';
// import 'package:sunotes/providers/task_provider.dart';
// import 'package:sunotes/widgets/task_item.dart';

// class TaskList extends StatelessWidget {
//   final List<TaskModel> filteredTasks;

//   const TaskList({super.key, required this.filteredTasks});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<TaskProvider>(
//       builder: (context, taskProvider, child) {
//         return ListView.builder(
//           itemCount: filteredTasks.length,
//           itemBuilder: (context, index) {
//             final task = filteredTasks[index];
//             final isOverdue = task.dueDate != null &&
//                 task.dueDate!.day == DateTime.now().day &&
//                 task.dueDate!.year < DateTime.now().year &&
//                 task.dueDate!.isBefore(DateTime.now());

//             return TaskItem(
//               task: task,
//               isOverdue: isOverdue,
//               categoryColor: taskProvider.getCategoryColor(
//                   task.category), // Or the appropriate category color
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/models/task_model.dart';
import 'package:sunotes/providers/task_provider.dart';
import 'package:sunotes/widgets/task_item.dart';

class TaskList extends StatelessWidget {
  final List<TaskModel> filteredTasks;

  const TaskList({super.key, required this.filteredTasks});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return ListView.builder(
          itemCount: filteredTasks.length,
          itemBuilder: (context, index) {
            final task = filteredTasks[index];
            final isOverdue = task.dueDate != null &&
                task.dueDate!.day == DateTime.now().day &&
                task.dueDate!.year < DateTime.now().year &&
                task.dueDate!.isBefore(DateTime.now());

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TaskItem(
                  task: task,
                  isOverdue: isOverdue,
                  categoryColor: taskProvider.getCategoryColor(task.category),
                ),
                if (task.subtasks!.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: task.subtasks?.length,
                      itemBuilder: (context, subtaskIndex) {
                        final subtask = task.subtasks?[subtaskIndex];
                        return CheckboxListTile(
                          title: Text(subtask!.title),
                          value: subtask.isCompleted,
                          onChanged: (value) {
                            taskProvider.toggleSubtaskCompletion(
                                task.id, subtaskIndex);
                          },
                          secondary: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              taskProvider.removeSubtask(task.id, subtaskIndex);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
                // Add subtask input field
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Add subtask...',
                          ),
                          onSubmitted: (value) {
                            if (value.trim().isNotEmpty) {
                              taskProvider.addSubtask(
                                task.id,
                                Subtask(title: value.trim()),
                              );
                            }
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.blue),
                        onPressed: () {
                          // Triggered when "add" button is clicked; ensure UI logic fits your app
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
