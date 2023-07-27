import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';


class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon ;
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  AppTextField({
    Key? key,
    required this.controller,
    this.hintText = "",
    required this.icon,
    required this.obscureText,
    this.validator,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.height10,right: Dimensions.height10),
      padding: EdgeInsets.only(bottom: Dimensions.height5,top: Dimensions.height5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: Dimensions.height10,
              spreadRadius: Dimensions.height5,
              offset: Offset(1,Dimensions.height10),
              color: AppColors.nearlyWhite.withOpacity(0.2)
          )
        ],
      ),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          prefixIcon: Icon(icon , color: AppColors.grey),
          enabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(Dimensions.height20)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(Dimensions.height20),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.height10)
          ),
        ),
      ),
    );
  }
}
