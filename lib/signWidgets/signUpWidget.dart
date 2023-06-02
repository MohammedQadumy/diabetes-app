

import 'package:diabetes_app/components/my_textfield.dart';
import 'package:diabetes_app/questionare/Questionare.dart';
import 'package:diabetes_app/questionare/StepperWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpWidget extends StatefulWidget {

  const SignUpWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
      return _SignUpState();
  }

}

  class _SignUpState extends State<SignUpWidget>{


    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final rePasswordController = TextEditingController();


  //   void sendData() {
  //     setState(() {
  //
  //     });
  // }

    @override
    Widget build(BuildContext context) {
      return
        Column(
          children: [
            const SizedBox(height: 30,),
            MyTextField(controller: firstNameController,hintText: "First Name",),
            const SizedBox(height: 5,),
            MyTextField(controller: lastNameController , hintText: "last Name",),
            const SizedBox(height: 5,),
            MyTextField(controller: emailController , hintText: "Email",),
            const SizedBox(height: 5,),
            MyTextField(controller: passwordController , hintText: "password",),
            const SizedBox(height: 5,),
            MyTextField(controller: rePasswordController , hintText: "repassword",),
            const SizedBox(height: 5,),

            // Expanded(child: Row(
            //   children: const [
            //     Checkbox(value: false, onChanged: null),
            //     Text("agree to terms")
            //   ],
            // )),

          ],
        );
    }



}