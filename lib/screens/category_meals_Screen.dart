import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/Meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> displayMeals;

  const CategoryMealsScreen(this.displayMeals, {super.key});
  
  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late List<Meal> meals;
  late String title;
  var _loadedInitData = false;

  // removeMeal(String id) {
  //   setState(() {
  //     meals.removeWhere((meal) => meal.id == id);
  //   });
  // }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      title = routeArgs['title']!;
      final id = routeArgs['id']!;
      meals =
          widget.displayMeals.where((meal) => meal.categories.contains(id)).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(meals[index]);
        },
        itemCount: meals.length,
      ),
    );
  }
}
