

import 'package:diabetes_app/components/app_big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimenstions.dart';
import 'icon_and_text_widget.dart';
import '../API/Methods.dart';
import '../Models/Meal.dart';

class AppColumn extends StatelessWidget {
  final double rating;
  final Meal meal;
  const AppColumn({Key? key , required this.meal, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBigText(text: meal.name,
          color: AppColors.darkText,
        ),
        SizedBox(height: Dimensions.height10,),
        Row(children: [
          Row(
              children: [
                Wrap(
                  children: List.generate(rating.round(), (index) => Icon(Icons.star , color: AppColors.darkText)),
                ),
                SizedBox(width: Dimensions.height5,),
                AppBigText(color: AppColors.darkText, text: 'rating : ${rating.round()}')
              ]
          ),
        ],
        ),


        SizedBox(height: Dimensions.height5,),
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

