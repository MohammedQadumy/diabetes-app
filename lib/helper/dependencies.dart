
import 'package:diabetes_app/controllers/auth_controller.dart';
import 'package:diabetes_app/controllers/meals_controller.dart';
import 'package:diabetes_app/controllers/top_rated_controller.dart';
import 'package:diabetes_app/data/api/api_client.dart';
import 'package:diabetes_app/data/repository/auth_repo.dart';
import 'package:diabetes_app/data/repository/meal_repo.dart';
import 'package:diabetes_app/data/repository/top_rated_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init()async {
  // load dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(()=>sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: "http://13.51.162.14:8000"));
  //repos
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => TopRatedRepo(apiClient: Get.find()));
  Get.lazyPut(() => MealRepo(apiClient: Get.find()));
  // controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => TopRatedController(topRatedRepo: Get.find()));
  Get.lazyPut(() => MealController(mealRepo: Get.find()));




}