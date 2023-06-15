import 'package:flutter/material.dart';

class User{
  final String firstName ;
  final String lastName;
  final String userName;
  final String password;
  final String email;

  User({
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.password,
      required this.email
      });


  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();

    data["first_name"] = firstName;
    data["last_name"] = lastName;
    data["username"] = userName;
    data["email"] = email;
    data["password"] = password;


    return data;
  }




}