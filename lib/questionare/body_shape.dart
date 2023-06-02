

import 'package:diabetes_app/questionare/gender_widget.dart';
import 'package:diabetes_app/questionare/height_widget.dart';
import 'package:diabetes_app/questionare/weight_widget.dart';
import 'package:flutter/cupertino.dart';

class BodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        const WeightWidget(),
        const HeightWidget(),
        GenderWidget(),
        const Text("add date picker widget here "),
      ],
    );
  }

}