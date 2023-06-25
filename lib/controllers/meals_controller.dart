import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Models/Meal.dart';
import '../data/repository/meal_repo.dart';

class MealController extends GetxController implements GetxService {
  final MealRepo mealRepo;

  var meals = <Meal>[].obs; // Observable list of meals

  MealController({required this.mealRepo});

  @override
  void onInit() {
    fetchMeals();
  }

  void fetchMeals() async {
    Response response = (await mealRepo.getMeals());
    if(response.statusCode ==200){
      var decodedData = json.decode(response.body);
      meals.clear(); // Clearing the old data
      for (var meal in decodedData) {
        meals.add(Meal.fromJson(meal)); // Adding new meals to the list
      }
    }
  }
}