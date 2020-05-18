import 'package:flutter/material.dart';
import './data/dummy_data.dart';
import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';

import './screens/meal_details_screen.dart';
import './screens/meals_screen.dart';
import './screens/categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _meals = DUMMY_MEALS;
  List<Meal> _favorites = [];

  void _setFilters(Map<String, bool> filters) {
    setState(() {
      _filters = filters;

      _meals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) return false;
        if (_filters['lactose'] == true && !meal.isGlutenFree) return false;
        if (_filters['vegan'] == true && !meal.isGlutenFree) return false;
        if (_filters['vegetarian'] == true && !meal.isGlutenFree) return false;
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    if(_favorites.contains(meal)) {
      setState(() {
        _favorites.remove(meal);
      });
    } else {
      setState(() {
        _favorites.add(meal);
      });
    }
  }

  bool _isFavorite(Meal meal) {
    return _favorites.contains(meal);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.amber,
        accentColor: Colors.red,
        canvasColor: Color.fromRGBO(255, 250, 240, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            title: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 25)),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (ctx) => TabsScreen(_favorites),
        MealsScreen.routeName: (ctx) => MealsScreen(_meals),
        MealDetails.routeName: (ctx) => MealDetails(_toggleFavorite, _isFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
    );
  }
}
