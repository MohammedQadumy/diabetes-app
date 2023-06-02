import 'package:flutter/material.dart';
import 'package:diabetes_app/signWidgets/welcomePage.dart';

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

    return MaterialApp(
      home: Scaffold(
        body: welcomeWidget(),
      ),
    );
  }

}