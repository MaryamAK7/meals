import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static String routeName = '/filters';
  final Map<String, bool> filters;
  final Function setFilters;

  const FiltersScreen(this.setFilters, this.filters, {super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late var _glutenfree = false;
  late var _lactosefree = false;
  late var _vegan = false;
  late var _vegetarian = false;

  @override
  void initState() {
    _glutenfree = widget.filters['gluten'] as bool;
    _lactosefree = widget.filters['lactose'] as bool;
    _vegan = widget.filters['vegan'] as bool;
    _vegetarian = widget.filters['vegetarian'] as bool;

    super.initState();
  }

  Widget buildSwitchTile(
      String title, String subtitle, Function(bool) handler, bool value) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: handler);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
              onPressed: () {
                widget.setFilters({
                  'gluten': _glutenfree,
                  'lactose': _lactosefree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                });
              },
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Text('Adjust your meal selection.',
                style: Theme.of(context).textTheme.headline6),
          ),
          buildSwitchTile('Gluten-free', 'Only show gluten-free meals.',
              (newValue) {
            setState(() {
              _glutenfree = newValue;
            });
          }, _glutenfree),
          buildSwitchTile('Lactose-free', 'Only show lactose-free meals.',
              (newValue) {
            setState(() {
              _lactosefree = newValue;
            });
          }, _lactosefree),
          buildSwitchTile('Vegan', 'Only show Vegan meals.', (newValue) {
            setState(() {
              _vegan = newValue;
            });
          }, _vegan),
          buildSwitchTile('Vegetarian', 'Only show Vegetarian meals.',
              (newValue) {
            setState(() {
              _vegetarian = newValue;
            });
          }, _vegetarian),
        ],
      ),
    );
  }
}
