

import 'dart:convert';

import 'package:diabetes_app/Models/User.dart';
import 'package:diabetes_app/controllers/auth_controller.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/show_custom_message.dart';
import '../../components/app_textfield.dart';
import 'package:http/http.dart' as http;



class SignUpWidget extends StatefulWidget {


  const SignUpWidget({Key? key,}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
      return SignUpState();
  }

}

  class SignUpState extends State<SignUpWidget> {


    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final userNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final rePasswordController = TextEditingController();

    bool isCompleted = false;


    Future<String> _signUp(User addedUser) async {
      final response = await http.post(
        Uri.parse('http://13.51.162.14:8000/api/register/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'email': addedUser.email,
          'password': addedUser.password,
          'first_name': addedUser.firstName,
          'last_name': addedUser.lastName,
          'username': addedUser.userName
        }),
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response,
        // then parse the JSON.
        return "Signed up succefully";
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to login.');
      }
    }


    void registration() {
      var authController = Get.find<AuthController>();

      String firstName = firstNameController.text.trim();
      String lastname = lastNameController.text.trim();
      String username = userNameController.text.trim();
      String email = emailController.text;
      String password = passwordController.text.trim();


      if (firstName.isEmpty) {
        showCustomSnackBar("type your name", title: "Name");
      } else if (lastname.isEmpty) {
        showCustomSnackBar("type your last name", title: "Name");
      } else if (username.isEmpty) {
        showCustomSnackBar("type your username", title: "Name");
      } else if (!GetUtils.isEmail(email) || email.isEmpty) {
        showCustomSnackBar("type your email", title: "Name");
      } else if (password.isEmpty || password.length < 8) {
        showCustomSnackBar("type your password", title: "Name");
      }
      else {
        print(email);
        User newUser = User(firstName: firstName,
            lastName: lastname,
            userName: username,
            password: password,
            email: email
        );

        authController.registration(newUser).then((status) {
          if (status.isSuccess) {
            showCustomSnackBar("welcome , you signed successfully", title: "Hi $firstName");
            print("Success registration");
            isCompleted = true;
          } else {
            print("failed");
            showCustomSnackBar(status.message);
            print(status.message);
            isCompleted = false;
          }
        });


        //
        // String logInUsername = authController.returnUserEmail();
        // String logInpassword = authController.returnUserPassword();
        //
        // print(logInpassword);
        // print(logInUsername);
        //
        //
        //
        //   authController.login(logInUsername, logInpassword).then((status) {
        //     if (status.isSuccess) {
        //       showCustomSnackBar(logInpassword, title: logInUsername);
        //       print("Success log in");
        //     } else {
        //       print("failed");
        //       showCustomSnackBar(status.message);
        //       print(status.message);
        //     }
        //   });

      }
    }





    @override
    Widget build(BuildContext context) {
      return
        Column(
          children: [
            Image(image: AssetImage("assets/images/logo2.png"
            ),
              height: Dimensions.iconImageWidthAndHeight,
              width: Dimensions.iconImageWidthAndHeight,
            ),
            AppTextField(controller: firstNameController,hintText: "First Name", icon: Icons.person, obscureText: false,),
             SizedBox(height: Dimensions.height5,),
            AppTextField(controller: lastNameController , hintText: "last Name", icon: Icons.person, obscureText: false,),
             SizedBox(height: Dimensions.height5,),
            AppTextField(controller: userNameController, hintText: "username", icon: Icons.person, obscureText: false,),
             SizedBox(height: Dimensions.height5,),
            AppTextField(controller: emailController , hintText: "Email", icon: Icons.email, obscureText: false,),
             SizedBox(height: Dimensions.height5,),
            AppTextField(controller: passwordController , hintText: "password", icon: Icons.password, obscureText: true,),
             SizedBox(height: Dimensions.height5,),
          ],
        );
    }



}