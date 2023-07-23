import '../../Models/Meal.dart';
class MealWithRating {
  final Meal meal;
  final double rating;
  final String type;

  MealWithRating({required this.meal, required this.rating, required this.type});
}