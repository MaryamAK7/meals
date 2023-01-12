import 'package:flutter/material.dart';
import '../models/Meal.dart';
import '../screens/categories_screen.dart';
import '../screens/favorites_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabsScreen(this.favoriteMeals, {super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

// class _TabsScreenState extends State<TabsScreen> {
//   TabBar get _tabBar {
//     return const TabBar(
//               indicatorColor: Colors.white,
//               tabs: [
//                 Tab(icon: Icon(Icons.category), text: 'categories'),
//                 Tab(icon: Icon(Icons.star), text: 'Favorites'),
//               ],
//             );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//           appBar: AppBar(title: const Text('Meals')),
//           body: const TabBarView(children: [
//             CategoriesScreen(),
//             FavoritesScreen(),
//           ]),
//           bottomSheet: PreferredSize(
//             preferredSize: _tabBar.preferredSize,
//             child: Material(
//               color: Colors.pink,
//               child: _tabBar,
//             )
//           )),
//     );
//   }
// }
class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
      {'page': const CategoriesScreen(), 'title': 'Categories'},
      {'page': FavoritesScreen(widget.favoriteMeals), 'title': 'Your Favorite'},
    ];
    super.initState();
  }

  var _selectedPageIndex = 0;

  _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(_pages[_selectedPageIndex]['title'] as String)),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      drawer: const MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageIndex,
          backgroundColor: Theme.of(context).colorScheme.primary,
          selectedItemColor: Colors.white,
          onTap: _selectPage,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.star),
              label: 'Favorites',
            ),
          ]),
    );
  }
}
