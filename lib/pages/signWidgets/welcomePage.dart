

import 'package:diabetes_app/pages/signWidgets/signInWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../questionare/StepperWidget.dart';
class welcomeWidget extends StatelessWidget{
  
  const welcomeWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text("diabetes app"),
          Text("Welcome to App"),
          Text("Connect with APP for your personalized"),
          OutlinedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> StepperWidget()),
          );
          }, child: Text("Sign me Up")),
          OutlinedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>  SignInWidget()),);
          }, child: Text("Sign me In"))

        ],
      ),
    );
  }
  
}