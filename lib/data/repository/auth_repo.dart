

import 'package:diabetes_app/data/api/api_client.dart';
import 'package:diabetes_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../../Models/User.dart';

class AuthRepo {

  final ApiClient apiClient;
  final SharedPreferences sharedPreferences ;

  AuthRepo({
    required this.apiClient ,
    required this.sharedPreferences });

  Future<Response> registration(User newUser) async {
    print("REPOOOOOOOOO is working ");
    return await apiClient.postData(AppConstants.REGISTRATION_URI,newUser.toJson());
  }

  saveUserToken(String token) async{
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

}