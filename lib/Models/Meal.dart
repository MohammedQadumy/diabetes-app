
class Meal {
  final int id;
  final String name;
  final String description;
  final String image;
  final int calories;
  final bool warm;
  final bool spicy;

  Meal({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.calories,
    required this.warm,
    required this.spicy,
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
    );
  }

}