
import 'package:get/get_connect/http/src/response/response.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';
import 'package:get/get.dart';

class MealRepo {
  final ApiClient apiClient;

  MealRepo({
    required this.apiClient ,
  });

  Future<Response> getMeals() async {
    Response response = await apiClient.getData(AppConstants.MEALS_URI);
    return response;
    }
  }
