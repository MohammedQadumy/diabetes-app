
import 'dart:ffi';

import 'package:diabetes_app/components/app_big_text.dart';
import 'package:diabetes_app/components/app_icon.dart';
import 'package:diabetes_app/pages/AppPage/new_meal_page.dart';
import 'package:diabetes_app/pages/MealsHistory/meals_history.dart';
import 'package:diabetes_app/pages/profilePage/profile_page.dart';
import 'package:diabetes_app/pages/stats/stats_page.dart';
import 'package:diabetes_app/utils/colors.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/app_constants.dart';
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
      backgroundColor: AppColors.nearlyWhite,
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
                  AppBigText(text: "${AppConstants.currentUser.firstName}  ${AppConstants.currentUser.lastName}"),
                ],

                ),
                InkWell(
                  child: Center(
                    child: Container(
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      child: Icon(Icons.add,color: Colors.black,size: Dimensions.iconSize24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.chipBackground,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewMealPage()));
                  },
                )
              ],
            ),
          ),
          //
            Expanded(child: SingleChildScrollView(child: FoodPageBody())),
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.height45,
        decoration: BoxDecoration(
          color: AppColors.chipBackground,
          borderRadius: BorderRadius.circular(Dimensions.height10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // home page icon
            GestureDetector(child: AppIcon(icon: Icons.home),
            onTap: () {
            },),
            // daily calories , protien , carbs counters and stats
            GestureDetector(child:  AppIcon(icon: Icons.food_bank_rounded) , onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>  MealsHistory()));
            },),

            // explore new meals
            GestureDetector(child: AppIcon(icon: Icons.percent) , onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>  StatsPage()));
            },),
            // profile page
            GestureDetector(child: AppIcon(icon: Icons.person) , onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
            },
            ),
          ],
        ),
      ),
    );
  }

}