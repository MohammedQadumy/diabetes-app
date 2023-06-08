

import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/material.dart';

class AppElevateButton extends StatelessWidget {
  const AppElevateButton({Key? key ,required this.text ,required this.onTap}) : super(key: key);

  final String text ;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onTap, child: Text(text),
    style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.height20,vertical: Dimensions.height10),

    ),
    );
  }
}
