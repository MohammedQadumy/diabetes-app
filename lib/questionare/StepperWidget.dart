

import 'package:diabetes_app/questionare/Questionare.dart';
import 'package:diabetes_app/questionare/body_shape.dart';
import 'package:diabetes_app/questionare/favorite_food_widget.dart';
import 'package:diabetes_app/questionare/height_widget.dart';
import 'package:diabetes_app/questionare/weight_widget.dart';
import 'package:diabetes_app/signWidgets/signUpWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'excercise_widget.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StepperWidgetState();
  }
  
  
}


class _StepperWidgetState extends State<StepperWidget> {

  int _index = 0;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stepper(
          type: StepperType.horizontal,
          currentStep: _index,
          steps:  [
             Step(title: Text("Sign Up",style: TextStyle(fontSize: 10)), content: SignUpWidget() ),
            Step(title: Text("part2"), content: BodyWidget()),
            Step(title: Text("part3"), content: Text("test3")),
            Step(title: Text("part4"), content: FavoriteIngredientsWidget()),
            Step(title: Text("Excercise"), content: ExcerciseWidget()) ,
        

          ],
          onStepContinue: () {
                if(_index ==4){
                  setState(() => _index=0);
                }else{
                  setState(() => _index++);
                }

          },
          onStepCancel: () {
            if(_index ==0){
              setState(() => _index=4);
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