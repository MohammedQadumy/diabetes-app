
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message , {bool isError = true , String title ="Error"}){
  Get.snackbar(title, message,
  titleText: Text(title),
    messageText: Text(message),
  );

}