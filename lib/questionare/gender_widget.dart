

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Sex { Male, Female }

class GenderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Gender" ,style: TextStyle(fontWeight: FontWeight.bold),),
        Row(children: [
          ElevatedButton.icon(icon: Icon(Icons.male),label: Text("Male"),onPressed: null),
          ElevatedButton.icon(icon: Icon(Icons.female),label: Text("Female"),onPressed: null),
        ],)

      ],
    );
  }

}