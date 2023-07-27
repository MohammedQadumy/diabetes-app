

import '../Models/questions.dart';
import '../Models/User.dart';
class AppConstants {
  static  String APP_NAME = "DIABEAT";
  static  String BASE_URL = "http://13.51.162.14:8000/";
  static  String REGISTRATION_URI = "${BASE_URL}/api/register/";
  static  String LOGIN_URI = "/api/login/";
  static  String MEALS_URI = "/api/meals/";


  static  String EMAIL = "USER_EMAIL";
  static  String PASSWORD = "USER_PASSWORD";
  static  String NAME = "Default Name";
  static  const TOP_RATED_MEALS_URI = " ";
  static  String TOKEN = "";

  static User currentUser = User(firstName: '', lastName: '', userName: '', password: '', email: '');


  static const questions = [
    Questions("هل أنت نباتي بالكامل؟", ['yes','no'],'20'),
    Questions("هل أنت نباتي؟", ['yes','no'],'19'),
    Questions("هل تحب الحلويات؟", ['yes','no'],'17'),
    Questions("هل تحب الإكثار من الأطعمة الساخنة؟", ['yes','no'],'12'),
    Questions("هل تحب الأطعمة المالحة؟", ['yes','no'],'18'),
    Questions("هل تحب الأطعمة كثيرة البهارات؟", ['yes','no'],'11'),
    Questions("هل تحب الأطعمة الباردة أو الفاترة؟", ['yes','no'],'13'),
    Questions("هل تحب الأغذية السهلة أو الصعبة المضغ؟", ['easy to chew','hard'],'21'),
  ];


}