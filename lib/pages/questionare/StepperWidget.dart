

import 'package:diabetes_app/Models/User.dart';
import 'package:diabetes_app/questionare/body_shape.dart';
import 'package:diabetes_app/signWidgets/sign_up_widget.dart';
import 'package:diabetes_app/utils/app_constants.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../AppPage/mainPage.dart';
import 'excercise_widget.dart';
import 'food_prefrences_widget.dart';

class StepperWidget extends StatefulWidget {

  const StepperWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StepperWidgetState();
  }
  
  
}


class _StepperWidgetState extends State<StepperWidget> {


  int _index = 0;

  late User newUser;

   List<String> userAnsweres = [];


  _stepState(int step) {
    if (_index > step) {
      return StepState.complete;
    } else {
      return StepState.editing;
    }
  }

  void onStepContinue(){

  }


  void onAnswered(String question, String answer){
    userAnsweres.add(answer);
    _questionAndAnswer(question, answer);
    // print(userAnsweres);
    if(userAnsweres.length == AppConstants.questions.length){
      setState(() {
        userAnsweres = [];
        _index++;
      });
    }
  }


  Future<String> _questionAndAnswer(String question , String answer) async {
    final response = await http.post(
      Uri.parse('http://13.51.162.14:8000/api/question/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'questions': question,
        'answer': answer
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response,
      // then parse the JSON.
      return "Question sent";
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('question failed to send');
    }
  }



  Future<String> _signUp(User addedUser) async {
    final response = await http.post(
      Uri.parse('http://13.51.162.14:8000/api/register/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'email': addedUser.email,
        'password': addedUser.password,
        'first_name': addedUser.firstName,
        'last_name': addedUser.lastName,
        'username': addedUser.userName
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response,
      // then parse the JSON.
      return "Signed up succefully";
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to login.');
    }
  }


// change state decoration when step is completed

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stepper(
          controlsBuilder:(BuildContext context, ControlsDetails controls) {
            return Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.height20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(onPressed: _index ==0?null:controls.onStepCancel, child: Text("back")),
                  ElevatedButton(onPressed: _index ==3?() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );
                  }:controls.onStepContinue, child: _index==4?Text("Submit"):Text("Next")),
              ],
            ),
            );
          },
          type: StepperType.horizontal,
          currentStep: _index,
          steps:  [
             Step(content: SignUpWidget(onSubmit: (User tempUser) {
               newUser = tempUser;
               print(newUser.firstName);
               () async {
                 try {
                   await _signUp(newUser);
                   print('signed up');
                 } catch (e) {
                   print('signed up failed: $e');
                   return Text("failed");
                 }
               }();
             },
             ), title: Text(""),
               state: _stepState(0),
               isActive: _index == 0,
             ),
            Step(title: Text(""),
                content: BodyWidget(),
              state: _stepState(1),
              isActive: _index == 1,
            ),
            Step(title: Text(""),
                content: FoodPrefrencesWidget(onAnswered: onAnswered,),
              state: _stepState(2),
              isActive: _index == 2,),
            Step(title: Text(""),
                content: ExcerciseWidget(),
              state: _stepState(3),
              ) ,
          ],
          onStepContinue: () {
            if(_index ==3){
              setState(() => _index=0);
            }else{
              setState(() => _index++);
            }
          },
          onStepCancel: () {
            if(_index ==0){
              setState(() => _index=0);
            }else{
              setState(() => _index--);
            }
            },
          onStepTapped: (int index) => setState(() => _index = index),


        ),
      ),
    );
  }
}