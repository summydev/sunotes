// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sunotes/providers/task_provider.dart';
// import 'package:sunotes/screens/viewtodos_screen.dart';
// import 'package:sunotes/widgets/brand_colors.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final taskProvider = Provider.of<TaskProvider>(context);

//     // Check if the provider is initialized
//     if (!taskProvider.isInitialized) {
//       return const Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(
//             color: Colors.red, // Or another color from your brand colors
//           ),
//         ),
//       );
//     }

//     final filters = [
//       {
//         'label': 'Today',
//         'filter': 'Today',
//         'color': BrandColors.secondaryColor
//       },
//       {
//         'label': 'Tomorrow',
//         'filter': 'Tomorrow',
//         'color': BrandColors.primaryColor
//       },
//       {
//         'label': 'This Week',
//         'filter': 'This Week',
//         'color': BrandColors.accentColor
//       },
//       {
//         'label': 'This Month',
//         'filter': 'This Month',
//         'color': BrandColors.textColor
//       },
//     ];

//     final categories = taskProvider.getCategories();

//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 100.0,
//         title: const Text(
//           'Su-Notes',
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: BrandColors.primaryColor,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: CustomScrollView(
//           slivers: [
//             // Filter Options
//             SliverGrid(
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   final filter = filters[index];
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (_) => ViewTodoScreen(
//                               filter: filter['filter'] as String)));
//                     },
//                     child: Card(
//                       elevation: 4,
//                       margin: const EdgeInsets.all(8.0),
//                       child: Stack(
//                         children: [
//                           Positioned(
//                             top: 8,
//                             left: 8,
//                             child: Container(
//                               width: 20,
//                               height: 20,
//                               decoration: BoxDecoration(
//                                 color: filter['color'] as Color,
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                           ),
//                           Center(
//                             child: Text(
//                               filter['label'] as String,
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//                 childCount: filters.length,
//               ),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//               ),
//             ),

//             const SliverToBoxAdapter(
//               child: SizedBox(
//                 height: 24,
//               ),
//             ),

//             // Categories List
//             SliverToBoxAdapter(
//               child: categories.isEmpty
//                   ? const Center(
//                       child: Text("No categories yet, please create a task"),
//                     )
//                   : Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           '${categories.length} categories',
//                           style:
//                               TextStyle(color: Colors.grey[600], fontSize: 16),
//                         ),
//                         const SizedBox(height: 16),
//                         ListView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: categories.length,
//                           itemBuilder: (context, index) {
//                             final category = categories[index];
//                             final itemCount = taskProvider
//                                 .getTasksByCategory(category)
//                                 .length;

//                             return ListTile(
//                               contentPadding:
//                                   const EdgeInsets.symmetric(vertical: 4.0),
//                               leading: Container(
//                                 width: 12,
//                                 height: 12,
//                                 decoration: BoxDecoration(
//                                   color:
//                                       taskProvider.getCategoryColor(category),
//                                   shape: BoxShape.circle,
//                                 ),
//                               ),
//                               title: Text(category),
//                               subtitle: Text('$itemCount items'),
//                               trailing:
//                                   const Icon(Icons.arrow_forward_ios, size: 16),
//                               onTap: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (_) =>
//                                         ViewTodoScreen(filter: category)));
//                               },
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/providers/task_provider.dart';
import 'package:sunotes/screens/viewtodos_screen.dart';
import 'package:sunotes/widgets/brand_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    // Check if the provider is initialized
    if (!taskProvider.isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.red, // Or another color from your brand colors
          ),
        ),
      );
    }

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

    final categories = taskProvider.getCategories();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        title: const Text(
          'Su-Notes',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: BrandColors.primaryColor,
        elevation: 0,
        // Add a search bar in the AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: TaskSearchDelegate(taskProvider),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            // Filter Options
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
                          Center(
                            child: Text(
                              filter['label'] as String,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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

            // Categories List
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
                                  color:
                                      taskProvider.getCategoryColor(category),
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

// Custom Search Delegate for Global Search
class TaskSearchDelegate extends SearchDelegate<String> {
  final TaskProvider taskProvider;

  TaskSearchDelegate(this.taskProvider);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ' ');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = taskProvider.searchTasks(query);

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final task = results[index];
        return ListTile(
          title: Text(task.title),
          subtitle: Text(task.description),
          trailing: Icon(task.isCompleted
              ? Icons.check_circle
              : Icons.radio_button_unchecked),
          onTap: () {
            // Navigate to detailed view or highlight the relevant category/filter
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ViewTodoScreen(filter: task.category),
            ));
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = taskProvider.searchTasks(query);

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final task = suggestions[index];
        return ListTile(
          title: Text(task.title),
          subtitle: Text(task.description),
          trailing: Icon(task.isCompleted
              ? Icons.check_circle
              : Icons.radio_button_unchecked),
          onTap: () {
            // Navigate to detailed view or highlight the relevant category/filter
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ViewTodoScreen(filter: task.category),
            ));
          },
        );
      },
    );
  }
}
