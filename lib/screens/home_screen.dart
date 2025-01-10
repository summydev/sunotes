import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/providers/task_provider.dart';
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

    final taskProvider = Provider.of<TaskProvider>(context);

    final categories = taskProvider.getCategories();

    final cardColors = [
      Colors.orangeAccent,
      Colors.blueAccent,
      Colors.greenAccent,
      Colors.purpleAccent,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('su-Notes'),
      ),
      body: CustomScrollView(
        slivers: [
          // First Sliver for the filter options (ListView)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final filter = filters[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            ViewTodoScreen(filter: filter['filter']!)));
                  },
                  child: Card(
                    elevation: 1,
                    color: cardColors[index %
                        cardColors.length], // Assign color based on index
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0), // Margin between cards
                    child: Container(
                      width: double
                          .infinity, // Stretches the card across the width
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          filter['label']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: filters.length,
            ),
          ),

          // SizedBox equivalent in CustomScrollView
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 24,
            ),
          ),

          // Sliver for categories (GridView)
          SliverToBoxAdapter(
            child: categories.isEmpty
                ? const Center(child: Text("No categories available"))
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                                  ViewTodoScreen(filter: category)));
                        },
                        child: Card(
                          elevation: 4,
                          color: Colors.greenAccent,
                          child: Center(
                            child: Text(
                              category,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
