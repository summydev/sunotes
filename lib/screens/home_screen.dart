import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/providers/task_provider.dart';
import 'package:sunotes/widgets/addtaskdialog.dart';
import 'package:sunotes/widgets/task_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: Center(child: const Text('SUnotE')),
      //
      // ),

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0), // Increase height for space
        child: ClipPath(
          clipper: BottomRightCurveClipper(),
          child: AppBar(
            backgroundColor: Colors.blue,
            flexibleSpace: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the column vertically
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<TaskFilter>(
                      iconSize: 1,
                      icon: Icon(
                        Icons.menu_open_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      items: [
                        DropdownMenuItem(
                            value: TaskFilter.all, child: Text('All')),
                        DropdownMenuItem(
                          child: Text('Completed'),
                          value: TaskFilter.completed,
                        ),
                        DropdownMenuItem(
                          child: Text('Pending'),
                          value: TaskFilter.pending,
                        )
                      ],
                      onChanged: (filter) {
                        if (filter != null) {
                          taskProvider.setFilter(filter);
                        }
                      },
                    ),
                    Icon(Icons.add)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: TaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (cotext) => AddTaskDialog());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BottomRightCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height); // left side
    path.lineTo(size.width - 100, size.height); // bottom-left to bottom-right
    path.quadraticBezierTo(size.width, size.height, size.width,
        size.height - 100); // curve bottom-right
    path.lineTo(size.width, 0); // right side
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
