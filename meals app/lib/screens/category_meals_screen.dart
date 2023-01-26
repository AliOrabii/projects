import 'package:flutter/material.dart';
import '../classes/meal.dart';
import '../widgets/meal_item.dart';
import '../widgets/dummy_data.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> mealsToDisplay;

  CategoryMealScreen(this.mealsToDisplay);

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryTitle;
  List<Meal> DisplayedMeals;
  bool firsttime = true;

  @override
  void didChangeDependencies() {
    if (firsttime) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;

      categoryTitle = routeArgs['title'];
      final String categoryId = routeArgs['id'];

      DisplayedMeals = widget.mealsToDisplay.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      firsttime = false;
    }
    super.didChangeDependencies();
  }

  void _removemeal(String mealid) {
    setState(() {
      DisplayedMeals.removeWhere((element) => element.id == mealid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: DisplayedMeals[index].id,
            title: DisplayedMeals[index].title,
            imageUrl: DisplayedMeals[index].imageUrl,
            duration: DisplayedMeals[index].duration,
            complexity: DisplayedMeals[index].complexity,
            affordability: DisplayedMeals[index].affordability,
          );
        },
        itemCount: DisplayedMeals.length,
      ),
    );
  }
}
