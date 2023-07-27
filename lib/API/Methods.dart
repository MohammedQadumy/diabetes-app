import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:diabetes_app/Models/User.dart';
import 'package:diabetes_app/utils/app_constants.dart';
import '../Models/Meal.dart';
import '../Models/Item.dart';
import '../Models/Intake.dart';
import '../Models/ItemSearch.dart';
import '../Models/MealWithRating.dart';
import 'dart:convert' as convert;
import 'dart:math';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

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
  } catch (e) {
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
    print(
        'Height and weight update failed. Status code: ${response.statusCode}');
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
    print(
        'Height and weight update failed. Status code: ${response.statusCode}');
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
  var url =
      Uri.parse('${AppConstants.BASE_URL}/api/recommendations/$mealTypeString');

  final response = await http.get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AppConstants.TOKEN}',
    },
  );

  if (response.statusCode == 200) {
    List jsonResponse =
        convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
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
  List<MealType> mealOrder = [
    MealType.breakfast,
    MealType.snack,
    MealType.lunch,
    MealType.snack,
    MealType.dinner
  ];

  for (MealType type in mealOrder) {
    Meal meal = await fetchMeal(type);
    double rating = await fetchMealRating(meal.id);
    mealsWithRatings.add(MealWithRating(
        meal: meal, rating: rating, type: type.toString().split('.').last));
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

Future<List<MealWithRating>> fetchTopRatedMeals() async {
  var url = Uri.parse('${AppConstants.BASE_URL}/api/top-rated');

  final response = await http.get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AppConstants.TOKEN}',
    },
  );

  if (response.statusCode == 200) {
    List jsonResponse =
        convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
    if (jsonResponse.isNotEmpty) {
      List<MealWithRating> topRatedMeals = [];
      for (var item in jsonResponse) {
        Meal meal = Meal.fromJson(item);
        double rating = await fetchMealRating(meal.id);
        topRatedMeals
            .add(MealWithRating(meal: meal, rating: rating, type: "Any"));
      }
      return topRatedMeals;
    } else {
      throw Exception('No meals returned!');
    }
  } else {
    throw Exception('Unexpected error occurred!');
  }
}

Future<List<Item>> fetchItems(int mealId) async {
  final response = await http
      .get(Uri.parse('${AppConstants.BASE_URL}/api/meal_items/$mealId'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => new Item.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load items');
  }
}

Future<void> reportConsumedMeal(int mealId) async {
  final response = await http.post(
    Uri.parse('${AppConstants.BASE_URL}/api/consumed/'),
    // Replace with your server URL
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AppConstants.TOKEN}',
      // Replace with user's token
    },
    body: jsonEncode(<String, String>{
      'meal_id': mealId.toString(),
    }),
  );

  if (response.statusCode == 200) {
    print('Meal consumption reported successfully');
  } else {
    throw Exception('Failed to report meal consumption');
  }
}

Future<List<Meal>> fetchConsumedMeals() async {
  final response =
  await http.get(
    Uri.parse('${AppConstants.BASE_URL}/api/consumed_meals/'),
    headers: <String, String>{
      'Authorization': 'Bearer ${AppConstants.TOKEN}',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> body = convert.jsonDecode(convert.utf8.decode(response.bodyBytes))['consumed_meals'];
    List<Meal> meals = [];
    for (int id in body) {
      final mealResponse =
      await http.get(
        Uri.parse('${AppConstants.BASE_URL}/api/meals/$id/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${AppConstants.TOKEN}',
        },

      );
      if (mealResponse.statusCode == 200) {
        meals.add(Meal.fromJson(convert.jsonDecode(convert.utf8.decode(mealResponse.bodyBytes))));
      }
    }
    return meals;
  } else {
    throw Exception('Failed to load consumed meals');
  }
}



Future<http.Response> deleteMeal(int mealId) {
  return http.delete(
    Uri.parse('${AppConstants.BASE_URL}/api/consumed_meals/delete/'),  //replace with your API URL
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AppConstants.TOKEN}',
    },
    body: jsonEncode(<String, String>{
      'meal_id': mealId.toString(),
    }),
  );
}


void rateMeal(int mealId, int rating) async {
  // Change this URL to your backend endpoint
  final url = Uri.parse('${AppConstants.BASE_URL}/api/rate/');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AppConstants.TOKEN}',
    },
    body: json.encode({
      'meal': mealId,
      'rating': rating,
    }),
  );

  if (response.statusCode == 201) {
    // Rating was created
    print('Rating was successfully submitted.');
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to submit rating');
  }
}



Future<List<ItemSearch>> fetchAllItems() async {

  final url = Uri.parse('${AppConstants.BASE_URL}/api/items');
  final response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AppConstants.TOKEN}',
    },
  );
  if (response.statusCode == 200) {
    List jsonResponse =
    convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
    return jsonResponse.map((item) => new ItemSearch.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load items');
  }
}

Future<int> getNextMealId() async {
  final response = await http.get(
    Uri.parse('${AppConstants.BASE_URL}/api/meals/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AppConstants.TOKEN}',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> meals = jsonDecode(response.body);
    if (meals.isNotEmpty) {
      final maxIdMeal = meals.reduce((curr, next) => curr['meal_id'] > next['meal_id'] ? curr : next);
      return maxIdMeal['meal_id'] + 1;
    } else {
      return 1;
    }
  } else {
    throw Exception('Failed to load meals');
  }
}

Future<int> createMeal(Meal meal) async {
  final url = Uri.parse('${AppConstants.BASE_URL}/api/meals/');
  final mealId = await getNextMealId();

  var request = http.MultipartRequest('POST', url);

  request.headers.addAll(<String, String>{
    'Authorization': 'Bearer ${AppConstants.TOKEN}',
  });

  request.fields['meal_id'] = mealId.toString();
  request.fields['meal_name'] = meal.name;
  request.fields['meal_des'] = meal.description;
  request.fields['snack'] = "1";
  request.fields['breakfast'] = "1";
  request.fields['lunch'] = "1";
  request.fields['dinner'] = meal.dinner ? "1" : "0";
  request.fields['warm'] = meal.warm ? "1" : "0";
  request.fields['hard'] = "1";
  request.fields['salty'] = "1";
  request.fields['sweety'] = "1";
  request.fields['spicy'] = meal.spicy ? "1" : "0";
  request.fields['vegan'] = "1";
  request.fields['calories'] = meal.calories.toString();

  if (_file != null) {
    request.files.add(await http.MultipartFile.fromPath('image', _file!.path));
  }

  var response = await request.send();

  if (response.statusCode == 201) {
    final responseBody = await response.stream.bytesToString();
    return jsonDecode(responseBody)['meal_id'];
  } else {
    throw Exception('Failed to create meal');
  }
}




File? _file;

Future<void> pickImage() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if(result != null) {
    String? filePath = result.files.single.path;
    if(filePath != null) {
      _file = File(filePath);
    }
  } else {
    // User canceled the picker
  }

}





Future<void> postMealItem(int mealId, int itemId, double weight) async {
  final response = await http.post(
    Uri.parse('${AppConstants.BASE_URL}/api/save_meal_item/'),
    // Replace with your server URL
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AppConstants.TOKEN}',
    },
    body: jsonEncode(<String, dynamic>{
      'item_id': itemId,
      'meal_id': mealId,
      'weight': weight,
    }),
  );

  if (response.statusCode == 200) {
    print('Added item to the meal');
  } else {
    throw Exception('Failed to add item with the meal');
  }
}



Future<Intake> fetchIntake() async {
  var url =
  Uri.parse('${AppConstants.BASE_URL}/api/daily_calorie_intake');

  final response = await http.get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AppConstants.TOKEN}',
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (jsonResponse.isNotEmpty) {
      return Intake.fromJson(jsonResponse);
    } else {
      throw Exception('No meals returned for this type!');
    }
  } else {
    throw Exception('Unexpected error occurred!');
  }
}


Future<double> fetchTotalProtein() async {
  var url = Uri.parse('${AppConstants.BASE_URL}/api/consumed_meals_protein');
  try {
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AppConstants.TOKEN}',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['total_protein'] as double;
    } else {
      throw Exception('Failed to fetch total protein');
    }
  } catch (e) {
    throw Exception('Unexpected error occurred');
  }
}



Future<double> fetchTotalCarbs() async {
  var url = Uri.parse('${AppConstants.BASE_URL}/api/consumed_meals_carbs');
  try {
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AppConstants.TOKEN}',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['total_carbs'] as double;
    } else {
      throw Exception('Failed to fetch total Carbs');
    }
  } catch (e) {
    throw Exception('Unexpected error occurred');
  }
}


Future<double> fetchTotalFat() async {
  var url = Uri.parse('${AppConstants.BASE_URL}/api/consumed_meals_fat');
  try {
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AppConstants.TOKEN}',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['total_fat'] as double;
    } else {
      throw Exception('Failed to fetch total Fat');
    }
  } catch (e) {
    throw Exception('Unexpected error occurred');
  }
}


Future<Map<String, double>> fetchWeightAndHeight() async {
  var url = Uri.parse('${AppConstants.BASE_URL}/api/height-weight/');
  try {
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AppConstants.TOKEN}',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      double weight = double.parse(responseData['weight']);
      double height = double.parse(responseData['height']);
      return {'weight': weight, 'height': height};
    } else {
      throw Exception('Failed to fetch weight and height');
    }
  } catch (e) {
    throw Exception('Unexpected error occurred');
  }
}

Future<int> fetchBMI() async {
  var url = Uri.parse('${AppConstants.BASE_URL}/api/bmi');
  try {
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AppConstants.TOKEN}',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData.containsKey("BMI")) {
        double bmi = double.parse(responseData["BMI"].toString());
        return bmi.toInt();
      } else {
        throw Exception('BMI data not found in the response');
      }
    } else {
      throw Exception('Failed to fetch BMI');
    }
  } catch (e) {
    throw Exception('Unexpected error occurred');
  }
}




Future<String> questionAndAnswer(String question , String answer) async {
  final response = await http.post(
    Uri.parse('${AppConstants.BASE_URL}/api/question/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${AppConstants.TOKEN}',
    },
    body: jsonEncode(<String, String>{
      'question': question,
      'question_answer': answer
    }),
  );

  if (response.statusCode == 200) {
    return "Answer sent";
  } else {
    throw Exception('Answer failed to send');
  }
}


