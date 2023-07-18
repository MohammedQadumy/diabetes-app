
import 'package:get/get.dart';

import '../api/api_client.dart';

class TopRatedRepo extends GetxService {

  final ApiClient apiClient ;
  TopRatedRepo({required this.apiClient});

  Future<Response> getTopRatedMealsList() async {
    // this return takes only endpoint , base url is defined in helper folder/ dependencies
    return await apiClient.getData("http://13.51.162.14:8000/api/meals/");
  }


}