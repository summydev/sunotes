import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sunotes/providers/task_provider.dart';

class FiteredTaskList extends StatefulWidget {
  const FiteredTaskList({super.key});

  @override
  State<FiteredTaskList> createState() => _FiteredTaskListState();
}

class _FiteredTaskListState extends State<FiteredTaskList> {
  // String _selectedFilter = 'All';
  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     DropdownButton<String>(
    //         value: _selectedFilter,
    //         items: ['All', 'OverDue', 'Due Today', 'Upcoming']
    //             .map((filter) =>
    //                 DropdownMenuItem(value: filter, child: Text(filter)))
    //             .toList(),
    //         onChanged: (value) {
    //           setState(() {
    //             _selectedFilter = value!;
    //           });
    //         }),
    //     Expanded(child:
    //         Consumer<TaskProvider>(builder: (context, taskProvider, child) {
    //       final now = DateTime.now();
    //       final tasks = taskProvider.tasks.where((task) {
    //         switch (_selectedFilter) {
    //           case 'Overdue':
    //             return task.dueDate != null && task.dueDate!.isBefore(now);
    //           case 'Due Today':
    //             return task.dueDate != null &&
    //                 task.dueDate!.year == now.year &&
    //                 task.dueDate!.month == now.month &&
    //                 task.dueDate!.day == now.day;
    //           case 'Upcoming':
    //         }
    //       });
    //     }))
    //   ],
    // );
    return const Placeholder();
  }
}
