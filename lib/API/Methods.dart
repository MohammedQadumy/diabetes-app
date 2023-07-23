import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:diabetes_app/Models/User.dart';
import 'package:diabetes_app/utils/app_constants.dart';
import '../Models/Meal.dart';
import '../Models/MealWithRating.dart';
import 'dart:convert' as convert;
import 'dart:math';

Future<User> fetchUser() async {
  try {
    final response = await http.get(
      Uri.parse(AppConstants.BASE_URL + '/api/profile/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AppConstants.TOKEN}',
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  } catch(e) {
    print('Failed to fetch user: $e');
    throw Exception('Failed to fetch user: $e');
  }
}


Future<Map<String, dynamic>> loginUser(String email, String password) async {
  var url = Uri.parse('${AppConstants.BASE_URL}/api/login/');

  var response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
  Map<String, dynamic> result = {
    'status': response.statusCode,
    'message': '',
  };

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    AppConstants.TOKEN = data['access'];
    print('Login successful. Token saved.');

    AppConstants.currentUser = await fetchUser();
    result['message'] = 'Login successful. Token saved.';

  } else {
    var errorData = jsonDecode(response.body);
    print('Login failed. Status code: ${errorData['message']}');
    result['message'] = 'Login failed: ${errorData['detail']}';
  }
  return result;
}

Future<void> updateUser(Map<String, dynamic> updates) async {
  var url = Uri.parse('${AppConstants.BASE_URL}/api/profile/');

  var response = await http.patch(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AppConstants.TOKEN}',
    },
    body: jsonEncode(updates),
  );

  if (response.statusCode == 200) {
    print('Update successful.');
    AppConstants.currentUser = User.fromJson(jsonDecode(response.body));
  } else {
    print('Update failed. Status code: ${response.statusCode}');
  }
}



Future<void> updateWeight(int weight) async {
  var url = Uri.parse('${AppConstants.BASE_URL}/api/answers/update/');

  var updates = [
    {
      'question_id': 5,
      'question_answer': weight.toString(),
    },
  ];

  var response = await http.patch(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AppConstants.TOKEN}',
    },
    body: jsonEncode(updates),
  );

  if (response.statusCode == 204) {
    print('Height and weight update successful.');
  } else {
    print('Height and weight update failed. Status code: ${response.statusCode}');
  }
}


Future<void> updateHeight(int height) async {
  var url = Uri.parse('${AppConstants.BASE_URL}/api/answers/update/');

  var updates = [
    {
      'question_id': 4,
      'question_answer': height.toString(),
    },
  ];

  var response = await http.patch(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AppConstants.TOKEN}',
    },
    body: jsonEncode(updates),
  );

  if (response.statusCode == 204) {
    print('Height and weight update successful.');
  } else {
    print('Height and weight update failed. Status code: ${response.statusCode}');
  }
}


Future<void> changePassword(String newPassword) async {
  var url = Uri.parse('${AppConstants.BASE_URL}/api/change-password/');

  var response = await http.put(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AppConstants.TOKEN}',
    },
    body: jsonEncode(<String, String>{
      'new_password': newPassword,
    }),
  );

  if (response.statusCode == 200) {
    print('Password changed successfully.');
  } else {
    print('Password change failed. Status code: ${response.statusCode}');
  }
}


enum MealType { breakfast, lunch, snack, dinner }

Future<Meal> fetchMeal(MealType type) async {
  String mealTypeString = type.toString().split('.').last;
  var url = Uri.parse('${AppConstants.BASE_URL}/api/recommendations/$mealTypeString');

  final response = await http.get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AppConstants.TOKEN}',
    },
  );

  if (response.statusCode == 200) {
    List jsonResponse = convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
    print(jsonResponse);
    // Assumes that the response is a list of meals
    if (jsonResponse.isNotEmpty) {
      var random = Random();
      var randomMeal = jsonResponse[random.nextInt(jsonResponse.length)];
      return Meal.fromJson(randomMeal);
    } else {
      throw Exception('No meals returned for this type!');
    }
  } else {
    throw Exception('Unexpected error occured!');
  }
}



Future<List<MealWithRating>> fetchRecommendations() async {
  List<MealWithRating> mealsWithRatings = [];
  List<MealType> mealOrder = [MealType.breakfast, MealType.snack, MealType.lunch, MealType.snack, MealType.dinner];

  for (MealType type in mealOrder) {
    Meal meal = await fetchMeal(type);
    double rating = await fetchMealRating(meal.id);
    mealsWithRatings.add(MealWithRating(meal: meal, rating: rating));
  }
  return mealsWithRatings;
}




Future<double> fetchMealRating(int mealId) async {
  var url = Uri.parse('${AppConstants.BASE_URL}/api/average-rating/$mealId/');

  final response = await http.get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AppConstants.TOKEN}',
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse['average_rating'] ?? 0.0;

  } else {
    throw Exception('Unexpected error occured!');
  }
}
