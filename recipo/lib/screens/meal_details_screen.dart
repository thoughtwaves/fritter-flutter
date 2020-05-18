import 'package:flutter/material.dart';
import 'package:recipo/models/meal.dart';

class MealDetails extends StatelessWidget {
  static final String routeName = '/meal-detail';
  final Function _toggleFavorite;
  final Function _isFavorite;
  const MealDetails(this._toggleFavorite, this._isFavorite);

  Widget buildSectionTitle(BuildContext context, String value) {
    return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              value,
              style: Theme.of(context).textTheme.title,
            ),
          );
  }

  Widget buildListView(BuildContext context, Widget child) {
    return Container(
            height: 200,
            width: double.infinity,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Theme.of(context).primaryColor)
            ),
            child: child
          );
  } 

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context).settings.arguments as Meal;
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(meal.imageUrl, fit: BoxFit.cover),
              ),
              buildSectionTitle(context, 'Ingredients'),
              buildListView(context, ListView.builder(
                  itemBuilder: (context, index) {
                    return Card( elevation: 0,
                    child: Text('${index +1}) ${meal.ingredients[index]}'), );
                  },
                  itemCount: meal.ingredients.length,
                )),
              buildSectionTitle(context, 'Steps'),
              buildListView(context, ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile( leading: CircleAvatar(child: Text('${index + 1}'),),
                    title: Text('${meal.steps[index]}'), );
                  },
                  itemCount: meal.steps.length,
                ))

            ],
          ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _toggleFavorite(meal);
      }, child: Icon( _isFavorite(meal) ? Icons.star : Icons.star_border),),
    );
  }
}
