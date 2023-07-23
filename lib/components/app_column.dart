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
  final String? type;

  const AppColumn(
      {Key? key, required this.meal, required this.rating, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBigText(
          text: meal.name,
          color: AppColors.darkText,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Row(children: [
              AppBigText(color: AppColors.darkText, text: '             '),
              Wrap(
                children: List<Widget>.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    color: index < rating.round() ? Colors.black : Colors.grey,
                  );
                }),
              ),
              SizedBox(
                width: Dimensions.height5,
              ),
            ]),
          ],
        ),
        SizedBox(
          height: Dimensions.height5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MyIconTextWidget(
                icon: Icons.circle,
                text: meal.warm ? "Warm" : "Cold",
                color: AppColors.nearlyBlack,
                iconColor: meal.warm ? Colors.red : Colors.blue),
            MyIconTextWidget(
                icon: Icons.food_bank,
                text: "${this.type}",
                color: AppColors.nearlyBlack,
                iconColor: AppColors.darkText),
            MyIconTextWidget(
                icon: Icons.spa,
                text: meal.spicy ? "Spicy" : "Mild",
                color: AppColors.nearlyBlack,
                iconColor: meal.spicy ? Colors.red : Colors.blue),
          ],
        ),
      ],
    );
  }
}
