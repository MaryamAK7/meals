import 'package:flutter/material.dart';

import '../models/Meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavoritesScreen(this.favoriteMeals, {super.key});

  @override
  Widget build(BuildContext context) {
    print(favoriteMeals);
    if (favoriteMeals.isEmpty) {
      return const Center(
        child: Text("There's no favorite meals - Please add some!"),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(favoriteMeals[index]);
        },
        itemCount: favoriteMeals.length ,
      );
    }
  }
}
