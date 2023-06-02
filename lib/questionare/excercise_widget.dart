
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
          RadioListTile(title: Text("test1"), value: "test1", groupValue: _excercise, onChanged: (val){
            setState(() {
              _excercise =val!;
            });
          }),
          RadioListTile(title: Text("test1"), value: "test2", groupValue: _excercise, onChanged: (val){
            setState(() {
              _excercise =val!;
            });
          }),
          RadioListTile(title: Text("test1"), value: "test3", groupValue: _excercise, onChanged: (val){
            setState(() {
              _excercise =val!;
            });
          }),
          RadioListTile(title: Text("test1"), value: "test4", groupValue: _excercise, onChanged: (val){
            setState(() {
              _excercise =val!;
            });
          }),

        ],
      );

  }

}