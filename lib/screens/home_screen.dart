import 'package:flutter/material.dart';
import 'package:sunotes/screens/viewtodos_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filters = [
      {'label': 'Today', 'filter': 'Today'},
      {'label': 'Tomorrow', 'filter': 'Tomorrow'},
      {'label': 'This Week', 'filter': 'This Week'},
      {'label': 'This Month', 'filter': 'This Month'}
    ];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Task Filters'),
        ),
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
            padding: EdgeInsets.all(16.0),
            itemCount: filters.length,
            itemBuilder: (context, index) {
              final filter = filters[index];

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          ViewTodoScreen(filter: filter['filter']!)));
                },
                child: Card(
                  elevation: 4,
                  color: Colors.blueAccent,
                  child: Center(
                    child: Text(filter['label']!),
                  ),
                ),
              );
            }));
  }
}
