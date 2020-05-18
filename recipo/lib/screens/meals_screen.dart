import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  static final routeName = '/category';

  final List<Meal> meals;

  const MealsScreen(this.meals);

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final title = routeArgs['title'];
    final id = routeArgs['id'];
    final meals = this.meals.where( (meal) {
      return meal.categories.contains(id);
      }
      ).toList();
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: ListView.builder(itemBuilder: (context, index) {
        return MealItem(meals[index]);
      }, itemCount: meals.length,),
      
    );
  }
}