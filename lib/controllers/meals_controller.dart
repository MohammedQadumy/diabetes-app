import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Models/Meal.dart';
import '../data/repository/meal_repo.dart';

class MealController extends GetxController implements GetxService {
  final MealRepo mealRepo;

  MealController({required this.mealRepo});

  List<dynamic> _meals = [];
  List<dynamic> get meals => _meals;

  Future<void> getMeals() async {
    Response response = await mealRepo.getMeals();
    if(response.statusCode == 200){
      _meals = [];
      // _meals.addAll();
      update();
    }else{
    }

  }

}