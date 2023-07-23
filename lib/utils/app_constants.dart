

import '../Models/questions.dart';
import '../Models/User.dart';
class AppConstants {
  static  String APP_NAME = "DIABEAT";
  static  String BASE_URL = "http://10.0.2.2:8000";
  static  String REGISTRATION_URI = "/api/register/";
  static  String LOGIN_URI = "/api/login/";
  static  String MEALS_URI = "/api/meals/";


  static  String EMAIL = "USER_EMAIL";
  static  String PASSWORD = "USER_PASSWORD";
  static  String NAME = "Default Name";
  static  const TOP_RATED_MEALS_URI = " ";
  static  String TOKEN = "";

  static User currentUser = User(firstName: '', lastName: '', userName: '', password: '', email: '');


  static const questions = [
    Questions("Are you vegetarian?", ['yes','no'],'20'),
    Questions("Are you vegan?", ['yes','no'],'19'),
    Questions("Do you like sweety foods?", ['yes','no'],'17'),
    Questions("Do you like warm foods?", ['yes','no'],'12'),
    Questions("Do you like salty foods?", ['yes','no'],'18'),
    Questions("Do you enjoy spicy foods?", ['yes','no'],'11'),
    Questions("Do you like cold foods?", ['yes','no'],'13'),
    Questions("Do you like easy to chew or hard meals?", ['easy to chew','hard'],'21'),
  ];


}