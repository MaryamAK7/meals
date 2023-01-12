import 'package:flutter/material.dart';

import '../screens/category_meals_Screen.dart';


class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  const CategoryItem(this.id, this.title, this.color, {super.key});
  onSelectCategory(ctx) {
    Navigator.of(ctx).pushNamed(CategoryMealsScreen.routeName, arguments: {'id': id, 'title':title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelectCategory(context),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              // colors: [Color.fromARGB(255, 206, 23, 84).withOpacity(0.7), Color.fromARGB(255, 206, 23, 84)],
              colors: [color.withOpacity(0.7), color],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text(
            title, 
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
