

import 'package:diabetes_app/components/app_big_text.dart';
import 'package:diabetes_app/pages/signWidgets/signInWidget.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/app_button.dart';
import '../../utils/colors.dart';
import '../questionare/StepperWidget.dart';
class welcomeWidget extends StatelessWidget{
  
  const welcomeWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          AppBigText(text: "Diabeat app",),
          AppBigText(text: "Welcome to App"),
          AppBigText(text: "Connect with APP for your personalized"),

          SizedBox(height: Dimensions.height10,),

          GestureDetector(child: AppButton(text: 'Sign me Up',width:Dimensions.screenWidth/2,),onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> StepperWidget()),);
          },
          ),

          GestureDetector(child: AppButton(text: 'Sign me In',width:Dimensions.screenWidth/2,),onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>  SignInWidget()),);

          },),

        ],
      ),
    );
  }
  
}