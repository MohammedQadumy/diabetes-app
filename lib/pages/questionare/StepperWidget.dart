

import 'package:diabetes_app/Models/User.dart';
import 'package:diabetes_app/components/app_big_text.dart';
import 'package:diabetes_app/components/app_button.dart';
import 'package:diabetes_app/pages/questionare/date_picker.dart';
import 'package:diabetes_app/utils/app_constants.dart';
import 'package:diabetes_app/utils/colors.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../AppPage/mainPage.dart';
import '../signWidgets/sign_up_widget.dart';
import 'food_prefrences_widget.dart';


import 'package:get/get.dart';


class StepperWidget extends StatefulWidget {


  const StepperWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StepperWidgetState();
  }
  
  
}


class _StepperWidgetState extends State<StepperWidget> {

  final GlobalKey<SignUpState> _childWidgetKey = GlobalKey<SignUpState>();



  int _index = 0;

  late User newUser;

   List<String> userAnsweres = [];

  double _initialHeightValue = 0;
  double _initialWeightValue = 0;

  String _excercise ="";




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

  User onDataReceived(User newUser){
    return newUser;
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






//   bool isDetailComplete(User newUser){
//
//     if(_index == 0){
//       if(newUser.firstName == null || newUser.firstName == null
//           newUser.lastName == null ||newUser.userName == null||
//           newUser.email == null)
//       return true;
//
//     }else if (_index == 1){
//       return true;
//       // check body
//     }else if (_index == 2){
// // check questions
//       return true;
//     }
//     else if (_index == 3){
// // check excercise
//       return true;
//     }else {
//       return false ;
//     }
//
//
//
//   }


// change state decoration when step is completed

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Form(
          child: Theme(
            data: ThemeData(
              colorScheme: Theme.of(context).colorScheme.copyWith(primary: AppColors.onPrimaryContainer)
            ),
            child: Stepper(
              controlsBuilder:(BuildContext context, ControlsDetails controls) {
                return Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.height15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(onPressed: _index ==0?null:controls.onStepCancel, child: Container(width: Dimensions.screenWidth/5,
                        child: const Center(child: Text("Back")
                        )
                        ,)
                      ),

                      ElevatedButton(onPressed: _index ==6?() { // here make validation before going to next page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainPage()),
                        );
                      }:controls.onStepContinue, child: _index==6?Container(width: Dimensions.screenWidth/5,
                        child: const Center(child: Text("Submit")
                        )
                        ,):Container(width: Dimensions.screenWidth/5,
                        child: const Center(child: Text("Next")
                        )
                        ,)),
                  ],
                ),
                );
              },

              type: StepperType.horizontal,
              currentStep: _index,
              steps:  [
                 Step(content: SingleChildScrollView(child: SignUpWidget(key: _childWidgetKey,)),
                   title: Text(""),
                   state: _stepState(0),
                   isActive: _index == 0,
                 ),
                Step(title: Text(""),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Gender" ,style: TextStyle(fontWeight: FontWeight.bold),),
                        Row(children: [
                          ElevatedButton.icon(icon: Icon(Icons.male),label: Text("Male"),onPressed: null),
                          ElevatedButton.icon(icon: Icon(Icons.female),label: Text("Female"),onPressed: null),
                        ],)

                      ],
                    ),
                  state: _stepState(1),
                  isActive: _index == 1,
                ),
                Step(title: Text(""),
                  content: Column(
                    children: [
                      AppBigText(text: "Choose Your Height"),
                      Slider(value: _initialHeightValue,
                          min: 0,
                          max: 240,
                          divisions: 240,
                          label: _initialHeightValue.toString(),
                          onChanged: (value){
                            setState(() {
                              _initialHeightValue = value;
                            });
                          }),
                      Text(_initialHeightValue.toString())
                    ],
                  ),
                  state: _stepState(2),
                  isActive: _index == 2,
                ),
                Step(title: Text(""),
                  content: Column(
                    children: [
                      AppBigText(text: "Choose Your Weight"),
                      Slider(value: _initialWeightValue,
                          min: 0,
                          max: 240,
                          divisions: 240,
                          label: _initialWeightValue.toString(),
                          onChanged: (value){
                            setState(() {
                              _initialWeightValue = value;
                            });
                          }),
                      Text(_initialWeightValue.toString())
                    ],
                  ),
                  state: _stepState(3),
                  isActive: _index == 3,
                ),
                Step(title: Text(""),
                  content: AppDatePicker(),
                  state: _stepState(4),
                  isActive: _index == 4,
                ),
                Step(title: Text(""),
                    content: FoodPrefrencesWidget(onAnswered: onAnswered,),
                  state: _stepState(5),
                  isActive: _index == 5,),
                Step(title: Text(""),
                    content: Column(
                      children: [
                        AppBigText(text: "How often you make excercises"),
                        RadioListTile(title: Text("Little or no exercise"), value: "Little or no exercise", groupValue: _excercise, onChanged: (val){
                          setState(() {
                            _excercise =val!;
                          });
                        }),
                        RadioListTile(title: Text("Light exercise or sports 1-3 days per week"), value: "Light exercise or sports 1-3 days per week", groupValue: _excercise, onChanged: (val){
                          setState(() {
                            _excercise =val!;
                          });
                        }),
                        RadioListTile(title: Text("Moderate exercise or sports 3-5 days per week"), value: "Moderate exercise or sports 3-5 days per week", groupValue: _excercise, onChanged: (val){
                          setState(() {
                            _excercise =val!;
                          });
                        }),
                        RadioListTile(title: Text("Very hard exercise or sports and physical job or 2x training per week"), value: "Very hard exercise or sports and physical job or 2x training per week", groupValue: _excercise, onChanged: (val){
                          setState(() {
                            _excercise =val!;
                          });
                        }),

                      ],
                    ),
                  state: _stepState(6),
                  ) ,
              ],
              onStepContinue: () {
                if(_index==0){
                  _childWidgetKey.currentState?.registration();
                }
                if(_index ==6){
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
        ),
      ),
    );
  }
}


