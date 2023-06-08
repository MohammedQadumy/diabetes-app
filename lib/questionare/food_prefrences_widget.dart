
import 'package:diabetes_app/components/app_elevated_button.dart';
import 'package:diabetes_app/utils/questions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodPrefrencesWidget extends StatefulWidget {
  const FoodPrefrencesWidget({Key? key , required this.onAnswered}) : super(key: key);

  final void Function(String) onAnswered;

  @override
  State<FoodPrefrencesWidget> createState() => _FoodPrefrencesWidgetState();
}

class _FoodPrefrencesWidgetState extends State<FoodPrefrencesWidget> {

  var _index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _index = 0;
  }


  void answerQuestion(String answer){
    widget.onAnswered(answer);
      setState(() {
        _index<questions.length-1?_index++:_index=0;

      });

  }


  @override
  Widget build(BuildContext context) {

    final currentQuestion = questions[_index];

    return Column(
      children: [
        Text(currentQuestion.text),
        ...currentQuestion.answers.map((answer){
            return AppElevateButton(text:answer , onTap:(){
               answerQuestion(answer);
               // print(answer+_index.toString());
            }
            );
        }),
      ],
   );
  }
}
