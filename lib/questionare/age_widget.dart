

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ageState();
  }

}


class _ageState extends State<AgeWidget>{

  int age = 12 ;

  ageIncrement(){
    setState(() {
      age++;
    });
  }

  ageDecrement(){
    setState(() {
      age--;
    });
  }

  @override
  Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Text(age.toString()),
            Row(
              children: [
                IconButton(onPressed: ageIncrement, icon: Icon(Icons.add)),
                IconButton(onPressed: ageDecrement, icon: Icon(Icons.exposure_minus_1)),
              ],
            )
        ],
      );
  }

}