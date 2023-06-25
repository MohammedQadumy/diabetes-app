

import '../Models/questions.dart';

class AppConstants {
  static const String APP_NAME = "DIABEAT";
  static const String BASE_URL = "http://13.51.162.14:8000";
  static const String REGISTRATION_URI = "/api/register/";
  static const String LOGIN_URI = "/api/login/";
  static const String MEALS_URI = "/api/meals/";


  static const String EMAIL = "USER_EMAIL";
  static const String PASSWORD = "USER_PASSWORD";

  static const TOP_RATED_MEALS_URI = " ";

  static const String TOKEN = "";


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