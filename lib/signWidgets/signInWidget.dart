

import 'package:diabetes_app/AppPage/mainPage.dart';
import 'package:diabetes_app/components/my_textfield.dart';
import 'package:diabetes_app/questionare/StepperWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class SignInWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SignInStateClass();
  }

  }

  class _SignInStateClass extends State<SignInWidget> {


    final _userNameController = TextEditingController();
    final _passwordController = TextEditingController();


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
        return jsonDecode(response.body)['access'];
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to login.');
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            const SizedBox(height: 20,),
            const Text("Welcome back"),
            const SizedBox(height: 20,),
            MyTextField(
                controller: _userNameController, hintText: "Enter UserName"),
            SizedBox(height: 20,),
            MyTextField(
              controller: _passwordController, hintText: "Enter Password",),

            Padding(padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text("Forgot password?", style: TextStyle(
                    color: Colors.black54,
                  )),
                ],),
            ),
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
            OutlinedButton(onPressed: () {
              Navigator.pop(context);
            }
                ,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.black,
                ), child: const Text("back", style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ))),
          ],
        ),
      );
    }

  }



