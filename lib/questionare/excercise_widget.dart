
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


enum _excerciseWeakly{test1, test2 ,test3}

class ExcerciseWidget extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    return _excersiceWidget();
  }

}

class _excersiceWidget extends State<ExcerciseWidget>{

  String _excercise ="";

  @override
  Widget build(BuildContext context) {
      return Column(
        children: [
          Text("How often you make excercises"),
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
      );

  }

}