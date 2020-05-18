import 'package:flutter/material.dart';
import 'package:recipo/widgets/meal_item.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favorites;
  const FavoritesScreen(this._favorites);
  
  @override
  Widget build(BuildContext context) {
    final meals = this._favorites;
    return Scaffold(
      //appBar: AppBar(title: Text('Favorites'),),
      body: ListView.builder(itemBuilder: (context, index) {
        return MealItem(meals[index]);
      }, itemCount: meals.length,),
      
    );
  }

}