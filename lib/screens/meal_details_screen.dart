import 'package:flutter/material.dart';
import 'package:meals/data.dart';

class MealDetailsScreen extends StatelessWidget {
  static String routeName = '/meal-details';
  final Function _toggleFavorite;
  final Function isFavorite;

  const MealDetailsScreen(this._toggleFavorite, this.isFavorite, {super.key});

  Widget buildSectionTitle(String text, BuildContext ctx) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Text(text, style: Theme.of(ctx).textTheme.headline6),
    );
  }

  Widget buildContainer(Widget child, BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 200,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final meal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(title: Text(meal.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            buildSectionTitle('Ingredients', context),
            buildContainer(
                ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(meal.ingredients[index]),
                      ),
                    );
                  },
                  itemCount: meal.ingredients.length,
                ),
                context),
            buildSectionTitle('Steps', context),
            buildContainer(
                ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: Text(
                            '#${(index + 1)}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(meal.steps[index]),
                      ),
                    );
                  },
                  itemCount: meal.steps.length,
                ),
                context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(mealId) ? Icons.star : Icons.star_border, color: Colors.white),
        onPressed: () => _toggleFavorite(mealId),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.delete),
      //   onPressed: () {
      //     Navigator.of(context).pop(mealId);
      //   },
      // ),
    );
  }
}
