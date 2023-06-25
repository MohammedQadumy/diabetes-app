

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

  Future<Response> login(String email , String password) async {
    print("REPOOOOOOOOO is working ");
    return await apiClient.postData(AppConstants.LOGIN_URI,{"email":email,"password":password});
  }

  Future<bool> saveUserToken(String token) async{
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<String> getUserToken() async{
     return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }


  
  Future<void> saveUserUserNameAndPassword(String email, String password)async {
     try{
       await sharedPreferences.setString(AppConstants.EMAIL, email);
       await sharedPreferences.setString(AppConstants.PASSWORD, password);
     }
     catch(e){
       throw e;
     }
  }


  bool clearSharedData(){
     sharedPreferences.remove(AppConstants.TOKEN);
     sharedPreferences.remove(AppConstants.EMAIL);
     sharedPreferences.remove(AppConstants.PASSWORD);
     apiClient.token='';
     apiClient.updateHeader('');
     return true;

  }
  
}