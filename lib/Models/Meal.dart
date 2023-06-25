class Meal {
  final int id;
  final String name;
  final String description;
  final String image;
  final int calories;

  Meal({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.calories,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['meal_id'],
      name: json['meal_name'],
      description: json['meal_des'],
      image: json['image'],
      calories: json['calories'],
    );
  }
}