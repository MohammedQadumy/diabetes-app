

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeightWidget extends StatefulWidget{
  const HeightWidget({super.key});

  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _heightWidgetState();
  }
  
}

class _heightWidgetState extends State<HeightWidget>{


  double _initialValue = 0;


  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Slider(value: _initialValue,
              min: 0,
              max: 240,
              divisions: 240,
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