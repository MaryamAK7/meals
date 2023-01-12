import 'package:flutter/material.dart';
import 'package:meals/data.dart';

import './screens/filters_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/tabs_screen.dart';
import '../screens/category_meals_Screen.dart';
import './models/Meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };
  List<Meal> meals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void _toggleFavorite(String mealId) {
    int mealIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (mealIndex >= 0) {
      setState(() {
        favoriteMeals.removeWhere((element) => element.id == mealId);
      });
    } else {
      var meal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
      setState(() {
        favoriteMeals.add(meal);
      });
    }
  }

  bool isFavorite(String mealId) {
    return favoriteMeals.any((meal) => meal.id == mealId);
  }

  _setfilters(Map<String, bool> newfilters) {
    setState(() {
      _filters = newfilters;

      meals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] as bool && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] as bool && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] as bool && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] as bool && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
              .copyWith(secondary: const Color.fromARGB(255, 255, 171, 199)),
          canvasColor: const Color.fromARGB(255, 254, 255, 246),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
                    fontFamily: 'RobotoCondensed', fontSize: 24),
                bodyText1:
                    const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                bodyText2:
                    const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              )),
      home: TabsScreen(favoriteMeals),
      routes: {
        // '/': (context) => const TabsScreen(),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(meals),
        MealDetailsScreen.routeName: (context) =>
            MealDetailsScreen(_toggleFavorite, isFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_setfilters, _filters),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (ctx) => CategoryMealsScreen());
      // },
      onUnknownRoute: (settings) {
        // error screen
        return MaterialPageRoute(builder: (ctx) => CategoryMealsScreen(meals));
      },
    );
  }
}
