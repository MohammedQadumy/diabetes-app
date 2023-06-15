

import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MealsFavList extends StatelessWidget {
  const MealsFavList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(itemCount : 10 , itemBuilder: (context , index){
        return Container(
          margin: EdgeInsets.only(left: Dimensions.height20),
          child: Row(
            children: [
              Container(decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              color: Colors.white,
              image: const DecorationImage(image: AssetImage("assets/images/cezar.png"))
              ),
              )
            ],
          ),
        );
      }),
    );
  }
}
