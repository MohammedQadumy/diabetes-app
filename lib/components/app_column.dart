

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
        Text(text ,style: TextStyle(
          color: AppColors.background
        ),
        ),
        SizedBox(height: Dimensions.height10,),
        Row(children: [
          // wrap widget used to draw things multiple times
          Wrap(children: List.generate(5, (index) => const Icon(Icons.star , color: AppColors.onSecondary,)),),
          SizedBox(width: Dimensions.height10,),
          const Text("rating : 3")
          // can add clickable text here
        ],
        ),
        SizedBox(height: Dimensions.height20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            MyIconTextWidget(icon: Icons.circle, text: "hot", color: Colors.black, iconColor: Colors.red),
            MyIconTextWidget(icon: Icons.food_bank, text: "lunch", color: Colors.black, iconColor: Colors.blue),
            MyIconTextWidget(icon: Icons.spa, text: "spicy", color: Colors.black, iconColor: Colors.red),
          ],
        ),
      ],
    );
  }
}
