

import 'package:diabetes_app/components/app_big_text.dart';
import 'package:diabetes_app/components/app_icon.dart';
import 'package:diabetes_app/components/app_return_icon_button.dart';
import 'package:diabetes_app/pages/stats/body_scale_widget.dart';
import 'package:diabetes_app/pages/stats/calories_portions_widget.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);
  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:ListView(
        children: [
          AppReturnIconButton(),
          Container(margin: EdgeInsets.only(left: Dimensions.height20, top: Dimensions.height30)
              ,child: AppBigText(text: "Body Stats")),
          MediterranesnDietView(),
          Container(margin: EdgeInsets.only(left: Dimensions.height20, top: Dimensions.height30)
              ,child: AppBigText(text: "Body Stats")),
          BodyMeasurementView()

        ],
      )
    );
  }
}
