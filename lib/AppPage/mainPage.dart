
import 'dart:ffi';

import 'package:diabetes_app/components/app_icon.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'food_page_body.dart';

class MainPage extends StatefulWidget{
  const MainPage({super.key});



  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }

}

class _MainPageState extends State<MainPage>{

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height.toString());

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // header container
          Container (
            margin: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30),
            padding: EdgeInsets.only(left: Dimensions.height30,right: Dimensions.height30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  Text("Name"),
                  Text("bbbb ")
                ],

                ),
                Center(
                  child: Container(
                    width: Dimensions.height45,
                    height: Dimensions.height45,
                    child: Icon(Icons.add,color: Colors.black,size: Dimensions.iconSize24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: Colors.red,
                    ),

                  ),
                )
              ],
            ),
          ),
          //
            FoodPageBody(),
        ],
      ),
      // bottomNavigationBar: Container(
      //   height: Dimensions.height45,
      //   decoration: BoxDecoration(
      //     color: Colors.black45
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       InkWell(child: AppIcon(icon: Icons.home),
      //       onTap: () {
      //       },),
      //       AppIcon(icon: Icons.food_bank_rounded),
      //       AppIcon(icon: Icons.person),
      //     ],
      //   ),
      // ),
    );
  }

}