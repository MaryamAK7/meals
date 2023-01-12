import 'package:flutter/material.dart';
import 'package:meals/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});
  Widget buildListTile(String title, IconData icon, VoidCallback handler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(title,
          style: const TextStyle(
            fontSize: 24,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.w600,
          )),
      onTap: handler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      Container(
        color: Theme.of(context).colorScheme.secondary,
        width: double.infinity,
        height: 150,
        padding: const EdgeInsets.all(30),
        alignment: Alignment.centerLeft,
        child: const Text('Cooking Up!',
            style: TextStyle(
                color: Colors.pink, fontSize: 30, fontWeight: FontWeight.w900)),
      ),
      const SizedBox(
        height: 20,
      ),
      buildListTile('Meals', Icons.restaurant, () {
        Navigator.of(context).pushReplacementNamed('/');
      }),
      buildListTile('Filters', Icons.settings, () {
         Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
      }),
    ]));
  }
}
