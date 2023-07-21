

import 'package:diabetes_app/pages/AppPage/mainPage.dart';
import 'package:diabetes_app/pages/profilePage/profile_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/app_icon.dart';
import '../../utils/colors.dart';
import '../../utils/dimenstions.dart';
import '../MealsHistory/meals_history.dart';
import '../stats/stats_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileBody(),
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=>  MainPage()));
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
      GestureDetector(child: AppIcon(icon: Icons.person) , onTap: null
      ),
        ],
      ),
    ),
    );
  }
}
