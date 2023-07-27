
class Meal {
  final int id;
  final String name;
  final String description;
  final String image;
  final int calories;
  final bool warm;
  final bool spicy;
  final bool dinner;
  final bool lunch;
  final bool breakfast;
  final bool snack;

  Meal({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.calories,
    required this.warm,
    required this.spicy,
    required this.dinner,
    required this.lunch,
    required this.breakfast,
    required this.snack,

  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['meal_id'],
      name: json['meal_name'],
      description: json['meal_des'],
      image: json['image'],
      calories: json['calories'],
      warm: json['warm'] == 1 ? true : false,
      spicy: json['spicy'] == 1 ? true : false,
      dinner: json['dinner'] == 1 ? true : false,
      lunch: json['lunch'] == 1 ? true : false,
      breakfast: json['breakfast'] == 1 ? true : false,
      snack: json['snack'] == 1 ? true : false,
    );
  }
  @override
  String toString() {
    return 'Meal{id: $id, name: $name, description: $description, image: $image, calories: $calories, warm: $warm, spicy: $spicy, dinner: $dinner, lunch: $lunch, breakfast: $breakfast, snack: $snack}';
  }
}
