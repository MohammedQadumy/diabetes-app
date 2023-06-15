import 'package:diabetes_app/pages/signWidgets/welcomePage.dart';
import 'package:diabetes_app/pages/stats/stats_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


import 'package:diabetes_app/helper/dependencies.dart' as dep;

Future <void>  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }

}

class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    // welcomeWidget(), MainPage() ,StatsPage()
    //MainPage()
    return const GetMaterialApp(
      home: Scaffold(
        body: welcomeWidget(),
      ),
    );
  }

}