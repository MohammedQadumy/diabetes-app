
import 'package:diabetes_app/components/app_big_text.dart';
import 'package:diabetes_app/components/app_elevated_button.dart';
import 'package:diabetes_app/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodPrefrencesWidget extends StatefulWidget {
  const FoodPrefrencesWidget({Key? key , required this.onAnswered}) : super(key: key);

  final void Function(String,String) onAnswered;

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

  void answerQuestion(String question,String answer){
    if(answer == 'سهلة المضغ')
      answer = "easy to chew";
    else if(answer == 'صعبة المضغ')
      answer  = "hard";
    widget.onAnswered(question,answer);
    if (_index < AppConstants.questions.length - 1) {
      setState(() {
        _index++;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final currentQuestion = AppConstants.questions[_index];

    return Column(
      children: [
        AppBigText(text:currentQuestion.text, size: 28,),
        ...currentQuestion.answers.map((answer){
          return AppElevateButton(text:answer , onTap:(){
            answerQuestion(currentQuestion.id,answer);
            print(answer+_index.toString());
          }
          );
        }),
        if (_index == AppConstants.questions.length - 1)
          ElevatedButton(
            onPressed: () {
              setState(() {
                _index = 0;
              });
            },
            child: AppBigText(text: "تعديل التفضيلات", size: 20,),
          ),
      ],
    );
  }
}
