

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeightWidget extends StatefulWidget{
  const WeightWidget({super.key});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WeightWidgetState();
  }

}

class _WeightWidgetState extends State<WeightWidget>{


  double _initialValue = 0;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(value: _initialValue,
            min: 0,
            max: 200,
            divisions: 200,
            label: _initialValue.toString(),
            onChanged: (value){
              setState(() {
                _initialValue = value;
              });
            }),
        Text(_initialValue.toString())
      ],
    );
  }

}