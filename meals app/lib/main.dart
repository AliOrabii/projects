import 'package:flutter/material.dart';
import './widgets/dummy_data.dart';
import './classes/meal.dart';
import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';

import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _fliters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((element) => element.id == id);
  }

  void _togglefavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((element) => element.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _fliters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_fliters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_fliters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_fliters['vegetarian'] && !meal.isVegeterian) {
          return false;
        }
        if (_fliters['vegan'] && !meal.isVegan) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ))),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(_favoriteMeals),
        CategoryMealScreen.routeName: (context) =>
            CategoryMealScreen(_availableMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_togglefavorite, _isMealFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_fliters, _setFilters),
      },
      onUnknownRoute: (RouteSettings) {
        return MaterialPageRoute(
          builder: (ctx) => categories_screen(),
        );
      },
    );
  }
}
