import 'package:diabetes_app/components/app_icon.dart';
import 'package:diabetes_app/utils/colors.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/cupertino.dart';

class MyIconTextWidget extends StatelessWidget {

  final IconData icon ;
  final String text ;
  final Color color ;
  final Color iconColor ;

  const MyIconTextWidget({Key? key,
  required this.icon,
  required this.text,
  required this.color,
  required this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        AppIcon(icon: this.icon,size: Dimensions.iconSize30,backgroundColor: AppColors.white,iconColor: this.iconColor,),
        SizedBox(width: 5,),
        Text(text , style: TextStyle(
          color: this.color
        ),)
      ],
    );
  }
}
