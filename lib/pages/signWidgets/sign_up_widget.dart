

import 'package:diabetes_app/Models/User.dart';
import 'package:flutter/material.dart';

import '../components/my_textfield.dart';

class SignUpWidget extends StatefulWidget {

  const SignUpWidget({Key? key,  required this.onSubmit}) : super(key: key);
  final Function(User) onSubmit;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
      return SignUpState();
  }

}

  class SignUpState extends State<SignUpWidget>{



    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final userNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final rePasswordController = TextEditingController();

    String firstName='';
    String lastname='';
    String username='';
    String email='';
    String password='';

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
            MyTextField(controller: userNameController, hintText: "username",),
            const SizedBox(height: 5,),
            MyTextField(controller: emailController , hintText: "Email",),
            const SizedBox(height: 5,),
            MyTextField(controller: passwordController , hintText: "password",),
            const SizedBox(height: 5,),
            MyTextField(controller: rePasswordController , hintText: "repassword",),
            const SizedBox(height: 5,),
             ElevatedButton(onPressed: (){
              firstName = firstNameController.text;
              lastname = lastNameController.text;
              email = emailController.text;
              password = passwordController.text;
              username = userNameController.text;
              widget.onSubmit(User(firstName: firstName, lastName: lastname, userName: username, password: password, email: email));
            },
              child: const Text("submit")
            )


          ],
        );
    }



}