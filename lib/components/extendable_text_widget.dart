
import 'package:diabetes_app/components/app_icon.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {

  final String text;

  const ExpandableTextWidget({Key? key , required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {

  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true ;
  double textHeight = Dimensions.screenHeight/7.455;

  @override
  void initState(){
    super.initState();
    if(widget.text.length>textHeight){
      firstHalf = widget.text.substring(0,textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1,widget.text.length);
    }else{
      firstHalf = widget.text;
      secondHalf = "";
    }


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?Text(firstHalf):Column(
        children: [
          Text(hiddenText?(firstHalf+"..."):(firstHalf + secondHalf)),
          InkWell(
            onTap: (){
                setState(() {
                  hiddenText=!hiddenText;
                });
            },
            child: Row(
             children:  [
               hiddenText?Text("Show more"):Text("Show less"),
               Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up),
             ],
            ),
          )
        ],
      ),
    );
  }
}
