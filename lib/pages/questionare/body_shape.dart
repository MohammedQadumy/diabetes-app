
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../base/show_custom_message.dart';
import 'date_picker.dart';



class BodyInformationsWidget extends StatefulWidget {
  const BodyInformationsWidget({Key? key}) : super(key: key);

  @override
  State<BodyInformationsWidget> createState() => _BodyInformationsWidgetState();
}

class _BodyInformationsWidgetState extends State<BodyInformationsWidget> {


  double _initialWeightValue = 0;
  double _initialHeightValue = 0;


  void _registration(){


    if(_initialWeightValue==0){
      showCustomSnackBar("choose your weight",title: "Name");

    }else if(_initialWeightValue ==0){
      showCustomSnackBar("choose your height",title: "Name");
    }
    else{


    }
  }




  @override
  Widget build(BuildContext context) {
    return  Column(
      children:  [

        Column(
          children: [
            Column(
              children: [
                Slider(value: _initialWeightValue,
                    min: 0,
                    max: 200,
                    divisions: 200,
                    label: _initialWeightValue.toString(),
                    onChanged: (value){
                      setState(() {
                        _initialWeightValue = value;
                      });
                    }),
                Text(_initialWeightValue.toString())
              ],
            ),
            Slider(value: _initialHeightValue,
                min: 0,
                max: 240,
                divisions: 240,
                label: _initialHeightValue.toString(),
                onChanged: (value){
                  setState(() {
                    _initialHeightValue = value;
                  });
                }),
            Text(_initialHeightValue.toString())
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Gender" ,style: TextStyle(fontWeight: FontWeight.bold),),
            Row(children: [
              ElevatedButton.icon(icon: Icon(Icons.male),label: Text("Male"),onPressed: null),
              ElevatedButton.icon(icon: Icon(Icons.female),label: Text("Female"),onPressed: null),
            ],)
          ],
        ),
        AppDatePicker(),
        ElevatedButton(onPressed: _registration,  child: Text("press"))
      ],
    );
  }
}

