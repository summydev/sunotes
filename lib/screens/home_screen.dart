import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/providers/task_provider.dart';
import 'package:sunotes/screens/viewtodos_screen.dart';
import 'package:sunotes/widgets/brand_colors.dart'; // Import the brand colors

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filters = [
      {
        'label': 'Today',
        'filter': 'Today',
        'color': BrandColors.secondaryColor
      },
      {
        'label': 'Tomorrow',
        'filter': 'Tomorrow',
        'color': BrandColors.primaryColor
      },
      {
        'label': 'This Week',
        'filter': 'This Week',
        'color': BrandColors.accentColor
      },
      {
        'label': 'This Month',
        'filter': 'This Month',
        'color': BrandColors.textColor
      },
    ];

    final taskProvider = Provider.of<TaskProvider>(context);
    final categories =
        taskProvider.getCategories(); // Get categories from TaskProvider

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {},
              alignment: Alignment.centerLeft,
            ),
            const SizedBox(height: 8),
            const Text(
              'Su-Notes',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
        toolbarHeight: 100,
        backgroundColor:
            BrandColors.primaryColor, // Using the primary brand color
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            // First Sliver for the filter options (GridView)
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final filter = filters[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ViewTodoScreen(
                              filter: filter['filter'] as String)));
                    },
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          // Color circle at the top-left corner
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: filter['color'] as Color,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          // Card content
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                filter['label'] as String,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: filters.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(
                height: 24,
              ),
            ),

            // Sliver for categories (ListView)
            SliverToBoxAdapter(
              child: categories.isEmpty
                  ? const Center(
                      child: Text("No categories yet, please create a task"),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${categories.length} categories',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];

                            // Get the number of tasks in the current category
                            final itemCount = taskProvider
                                .getTasksByCategory(category)
                                .length;

                            return ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              leading: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: taskProvider.getCategoryColor(
                                      category), // Get color for category
                                  shape: BoxShape.circle,
                                ),
                              ),
                              title: Text(category),
                              subtitle: Text('$itemCount items'),
                              trailing:
                                  const Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) =>
                                        ViewTodoScreen(filter: category)));
                              },
                            );
                          },
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
