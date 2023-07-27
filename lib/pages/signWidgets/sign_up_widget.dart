import 'dart:convert';

import 'package:diabetes_app/Models/User.dart';
import 'package:diabetes_app/utils/app_constants.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import '../../base/show_custom_message.dart';
import '../../components/app_textfield.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../API/Methods.dart';

class SignUpWidget extends StatefulWidget {
  SignUpWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SignUpState();
  }
}

class SignUpState extends State<SignUpWidget> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  Future<bool> registration() async {
    String firstName = firstNameController.text.trim();
    String lastname = lastNameController.text.trim();
    String username = userNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    var url = Uri.parse('${AppConstants.BASE_URL}/api/register/');

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'first_name': firstName,
        'last_name': lastname,
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      showCustomSnackBar(isError: false ,"welcome , you signed up successfully", title: "Hi $firstName");
      print("Success registration");
      await loginUser(email, password);
      return true;

    } else {
      print("failed sign up");
      var errorData = jsonDecode(response.body);
      var errorMessage = '';
      errorData.forEach((key, value) {
        errorMessage += '$key: ${value[0]}\n'; // value appears to be a list, so we get the first item
      });
      showCustomSnackBar('Signup failed: $errorMessage');
      print('Signup failed: $errorMessage');
      return false;
    }


    return false;
  }
  bool validate() {
    String firstName = firstNameController.text.trim();
    String lastname = lastNameController.text.trim();
    String username = userNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (firstName.isEmpty) {
      showCustomSnackBar("type your name", title: "Name");
      return false;
    } else if (lastname.isEmpty) {
      showCustomSnackBar("type your last name", title: "Name");
      return false;
    } else if (username.isEmpty) {
      showCustomSnackBar("type your username", title: "Name");
      return false;
    } else if (!GetUtils.isEmail(email) || email.isEmpty) {
      showCustomSnackBar("type your email", title: "Name");
      return false;
    } else if (password.isEmpty || password.length < 8) {
      showCustomSnackBar("type your password", title: "Name");
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Image(
            image: AssetImage("assets/images/logo2.png"),
            height: Dimensions.iconImageWidthAndHeight,
            width: Dimensions.iconImageWidthAndHeight,
          ),
          AppTextField(
            controller: firstNameController,
            hintText: "First Name",
            icon: Icons.person,
            obscureText: false,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
          ),
          SizedBox(
            height: Dimensions.height5,
          ),
          AppTextField(
            controller: lastNameController,
            hintText: "last Name",
            icon: Icons.person,
            obscureText: false,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
          ),
          SizedBox(
            height: Dimensions.height5,
          ),
          AppTextField(
            controller: userNameController,
            hintText: "username",
            icon: Icons.person,
            obscureText: false,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          SizedBox(
            height: Dimensions.height5,
          ),
          AppTextField(
            controller: emailController,
            hintText: "Email",
            icon: Icons.email,
            obscureText: false,
            validator: (value) {
              if (value!.isEmpty || !GetUtils.isEmail(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(
            height: Dimensions.height5,
          ),
          AppTextField(
            controller: passwordController,
            hintText: "password",
            icon: Icons.password,
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty || value.length < 8) {
                return 'Password should be at least 8 characters';
              }
              return null;
            },
          ),
          SizedBox(
            height: Dimensions.height5,
          ),
        ],
      ),
    );
  }
}
