
import 'package:diabetes_app/utils/colors.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../components/app_textfield.dart';
import '../AppPage/mainPage.dart';


class SignInWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SignInStateClass();
  }

  }

  class _SignInStateClass extends State<SignInWidget> {


    final _userNameController = TextEditingController();
    final _passwordController = TextEditingController();
    late bool loginSucceed = true;

    Future<String> loginUser(String email, String password) async {
      final response = await http.post(
        Uri.parse('http://13.51.162.14:8000/api/login/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response,
        // then parse the JSON.
        setState(() {
          loginSucceed = true ;
        });

        return jsonDecode(response.body)['access'];
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        setState(() {
          loginSucceed = false ;
        });
        throw Exception('Failed to login.');
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor:  AppColors.background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage("assets/images/logo.png")),
              const Text("Welcome back"),
               SizedBox(height: Dimensions.height20,),
              AppTextField(
                  controller: _userNameController, hintText: "Enter UserName", icon: Icons.person, obscureText: false,),
              SizedBox(height: Dimensions.height20,),
              AppTextField(
                controller: _passwordController, hintText: "Enter Password", icon: Icons.password, obscureText: true,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Dimensions.height20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text("Don't have an account?"),
                    TextButton(onPressed: null, child: Text("Create" ,style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    )
                    )
                  ],
                ),
              ),
              // AppButton(text: "SignIn", width:150 ,height: 30, textColor: AppColors.onPrimary , backgroundColor: AppColors.primaryContainer,),
              OutlinedButton(onPressed: () async {
                try {
                  final accessToken = await loginUser(
                    _userNameController.text,
                    _passwordController.text,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                  print('Logged in with token: $accessToken');
                } catch (e) {
                  print('Login failed: $e');
                }
              },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ), child: const Text("sign in", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ))),
            ],
          ),
        ),
      );
    }

  }



