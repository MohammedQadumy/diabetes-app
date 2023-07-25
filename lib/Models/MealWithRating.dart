import '../../Models/Meal.dart';
class MealWithRating {
  final Meal meal;
  final double rating;
  final String type;
  bool isConsumed;

  MealWithRating({required this.meal, required this.rating, required this.type, this.isConsumed = false});
}