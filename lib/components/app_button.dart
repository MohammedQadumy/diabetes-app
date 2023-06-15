
import 'package:diabetes_app/utils/colors.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {

  final String text ;
  final Color backgroundColor ;
  Color? borderColor ;
  final Color textColor ;
  IconData? icon ;
  double? width ;
  double? height;



   AppButton({Key? key , required this.text ,
    this.textColor = Colors.red,
    this.backgroundColor = AppColors.background,
     this.borderColor ,
     this.width,
     this.height,
     this.icon
  }
      ) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.height10),
        border: Border.all(
          // color: borderColor,
          width: 2,
        ),
        color: backgroundColor,
      ),
      child: Center(
        child: Text(text , style: TextStyle(
        color: textColor,
        )
        ),
      ),
    );
  }
}
