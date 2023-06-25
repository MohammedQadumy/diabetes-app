
import 'package:diabetes_app/utils/colors.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/cupertino.dart';

class AppIcon extends StatelessWidget {

  final IconData icon ;
  final Color backgroundColor;
  final Color iconColor ;
  final double size ;


   AppIcon({Key? key,required this.icon ,
     this.backgroundColor = AppColors.white,
     this.iconColor = AppColors.nearlyBlack,
     this.size=40}
       ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: backgroundColor,
      ),
      child: Icon(icon,color: iconColor,size: Dimensions.iconSize16,),
    );
  }
}
