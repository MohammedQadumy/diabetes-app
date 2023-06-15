

import '../Models/questions.dart';

class AppConstants {
  static const String APP_NAME = "DIABEAT";
  static const String BASE_URL = "http://13.51.162.14:8000";
  static const TOP_RATED_MEALS_URI = " ";

  static const String TOKEN = "DBtoken";


  static const questions = [
    Questions("Are you vegetarian?", ['yes','no']),
    Questions("Are you vegan?", ['yes','no']),
    Questions("Do you like sweety foods?", ['yes','no']),
    Questions("Do you like warm foods?", ['yes','no']),
    Questions("Do you like salty foods?", ['yes','no']),
    Questions("Do you enjoy spicy foods?", ['yes','no']),
    Questions("Do you like cold foods?", ['yes','no']),
    Questions("Do you like easy to chew or hard meals?", ['easy to chew','hard']),
  ];


}