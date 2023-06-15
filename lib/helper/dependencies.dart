
import 'package:diabetes_app/controllers/top_rated_controller.dart';
import 'package:diabetes_app/data/api/api_client.dart';
import 'package:diabetes_app/data/repository/top_rated_repo.dart';
import 'package:get/get.dart';

Future<void> init()async {
  // load dependencies

  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: "http://13.51.162.14:8000"));
  //repos
  Get.lazyPut(() => TopRatedRepo(apiClient: Get.find()));
  // controllers
  Get.lazyPut(() => TopRatedController(topRatedRepo: Get.find()));



}