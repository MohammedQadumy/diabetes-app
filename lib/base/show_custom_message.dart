import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void showCustomSnackBar(String message,
    {bool isError = true, String title = "Error"}) {
  Get.snackbar(
    title,
    message,
    titleText: Directionality(
      textDirection: TextDirection.rtl, // Right to Left
      child:
      Row(
        children: [
          isError
              ? Icon(
            Icons.error_outline,
            color: Colors.red[900],
          )
              : Icon(
            Icons.check_circle_outline,
            color: Colors.green[900],
          ),
          SizedBox(width: 5,),
          Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
    messageText: Directionality(
      textDirection: TextDirection.rtl, // Right to Left
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(width: 8.0),

        ],
      ),
    ),
    shouldIconPulse: false,
    barBlur: 20,
    isDismissible: true,
    snackPosition: SnackPosition.TOP,
    backgroundColor:
    isError ? Colors.red.withOpacity(0.4) : Colors.green.withOpacity(0.3),
    colorText: Colors.white,
    borderRadius: 10,
    margin: EdgeInsets.all(10),
    duration: Duration(seconds: 1),
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
  );
}
