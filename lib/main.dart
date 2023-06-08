import 'package:diabetes_app/AppPage/mainPage.dart';
import 'package:diabetes_app/questionare/StepperWidget.dart';
import 'package:flutter/material.dart';
import 'package:diabetes_app/signWidgets/welcomePage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'AppPage/top_rated_food_details.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }

}

class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    // welcomeWidget(), MainPage()
    //MainPage()
    return const GetMaterialApp(
      home: Scaffold(
        body: welcomeWidget(),
      ),
    );
  }

}