
import 'package:diabetes_app/utils/colors.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {

  final String text ;
  final Color backgroundColor ;
  Color? borderColor ;
  final Color textColor ;
  IconData? icon ;
  double? width = Dimensions.screenWidth/2 ;
  double? height;
  final double fontSize;


  final BorderRadius borderRadius;
  final double borderSize;

  AppButton({
    Key? key,
    required this.text,
    this.textColor = AppColors.white,
    this.backgroundColor = AppColors.nearlyBlack,
    this.borderColor,
    this.width,
    this.height,
    this.icon,
    this.borderRadius = BorderRadius.zero,
    this.fontSize = 15,
    this.borderSize = 0
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');

    String fontFamily;
    if (arabicRegex.hasMatch(text)) {
      fontFamily = 'Arabic';
    } else {
      fontFamily = 'Lato';
    }
    return Container(
      margin: EdgeInsets.all(Dimensions.height5),
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(width: borderSize, color: backgroundColor),

        color: backgroundColor,
      ),
      child: Center(
        child: Text(text , style: TextStyle(
        color: textColor,
          fontFamily: fontFamily,
            fontSize: fontSize
        )
        ),
      ),
    );
  }
}
