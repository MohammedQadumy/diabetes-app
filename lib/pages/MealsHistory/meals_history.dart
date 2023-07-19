
import 'package:diabetes_app/components/app_big_text.dart';
import 'package:diabetes_app/components/app_icon.dart';
import 'package:diabetes_app/components/app_return_icon_button.dart';
import 'package:diabetes_app/utils/colors.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/material.dart';

class MealsHistory extends StatelessWidget {
  const MealsHistory({Key? key}) : super(key: key);


  // here we are supposed to have list of all items for the user


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppReturnIconButton(),
                AppBigText(text: "Meals History" ,color: Colors.black),
                AppIcon(icon: Icons.food_bank_sharp , backgroundColor: AppColors.chipBackground,)
              ],

            ),
            color: AppColors.chipBackground,
            width: double.maxFinite,
            height: Dimensions.screenHeight/10,
            padding: EdgeInsets.only(top: Dimensions.height30),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height10 , left: Dimensions.height10 , right: Dimensions.height10 ),
              child: ListView(
                children: [
                  // change 20 to list size
                  for(int i = 0 ; i < 10 ; i++)
                    Container(
                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                      padding: EdgeInsets.symmetric(vertical: Dimensions.height10 , horizontal: Dimensions.height10),
                      decoration: BoxDecoration(
                        color: AppColors.chipBackground, 
                        borderRadius: BorderRadius.circular(Dimensions.radius10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AppBigText(text: "Meal Name"),
                                  SizedBox(height: Dimensions.height10,),
                                  Text( "20/7/2023 6:00 PM"),
                                ],
                              ),
                              IconButton(color: AppColors.errorColor, onPressed: () {  }, icon:Icon(Icons.delete),)
                            ],
                          ),
                          SizedBox(height: Dimensions.height10,),
                        ],
                      ),
                    ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
