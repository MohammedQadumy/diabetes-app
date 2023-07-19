

import 'package:diabetes_app/components/app_big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimenstions.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;

  const AppColumn({Key? key , required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBigText(text: text,
          color: AppColors.darkText,
        ),
        SizedBox(height: Dimensions.height10,),
        Row(children: [
          // wrap widget used to draw things multiple times
          Wrap(children: List.generate(5, (index) => const Icon(Icons.star , color: AppColors.darkText,)),),
          SizedBox(width: Dimensions.height10,),
           AppBigText(color: AppColors.darkText, text: 'rating : 3',)
          // can add clickable text here
        ],
        ),
        SizedBox(height: Dimensions.height20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            MyIconTextWidget(icon: Icons.circle, text: "hot", color: AppColors.nearlyBlack, iconColor: AppColors.darkText),
            MyIconTextWidget(icon: Icons.food_bank, text: "lunch", color: AppColors.nearlyBlack, iconColor: AppColors.darkText),
            MyIconTextWidget(icon: Icons.spa, text: "spicy", color: AppColors.nearlyBlack, iconColor: AppColors.darkText),
          ],
        ),
      ],
    );
  }
}
