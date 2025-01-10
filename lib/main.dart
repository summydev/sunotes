import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunotes/providers/task_provider.dart';
import 'package:sunotes/screens/home_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => TaskProvider())],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MaterialApp(
        title: 'SUn-otE',
        home: HomeScreen(),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CategoryListScreen(),
//     );
//   }
// }

// class CategoryListScreen extends StatelessWidget {
//   final List<Category> categories = [
//     Category(title: 'Today', items: 6, color: Colors.blue),
//     Category(title: 'This week', items: 20, color: Colors.orange),
//     Category(title: 'This month', items: 25, color: Colors.pink),
//     Category(title: 'All tasks', items: 30, color: Colors.red),
//     Category(title: 'Work', items: 16, color: Colors.lightBlue),
//     Category(title: 'Home', items: 10, color: Colors.purple),
//     Category(title: 'Fun', items: 4, color: Colors.deepOrange),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.menu, color: Colors.black),
//               onPressed: () {},
//               alignment:
//                   Alignment.centerLeft, // Align the menu icon to the left
//             ),
//             const SizedBox(
//                 height: 8), // Add spacing between the icon and the text
//             const Text(
//               'All lists',
//               style: TextStyle(color: Colors.black, fontSize: 20),
//             ),
//           ],
//         ),
//         toolbarHeight:
//             100, // Increase the AppBar height to accommodate both icon and text
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               '7 categories',
//               style: TextStyle(color: Colors.grey[600], fontSize: 16),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: categories.length,
//                 itemBuilder: (context, index) {
//                   final category = categories[index];
//                   return ListTile(
//                     contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
//                     leading: Container(
//                       width: 12,
//                       height: 12,
//                       decoration: BoxDecoration(
//                         color: category.color,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                     title: Text(category.title),
//                     subtitle: Text('${category.items} items'),
//                     trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                     onTap: () {
//                       // Navigate to category details
//                     },
//                   );
//                 },
//               ),
//             ),
//             Row(
//               children: [
//                 const Expanded(
//                   child: Text(
//                     'Add a new list...',
//                     style: TextStyle(color: Colors.grey, fontSize: 16),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.add, color: Colors.black),
//                   onPressed: () {
//                     // Add a new category
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

// class Category {
//   final String title;
//   final int items;
//   final Color color;

//   Category({required this.title, required this.items, required this.color});
// }
