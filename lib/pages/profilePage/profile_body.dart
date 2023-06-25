

import 'package:diabetes_app/pages/profilePage/profile_menu.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileMenu(icon: Icons.person_2_outlined,text: "My Account", pressed: (){},),
        ProfileMenu(icon: Icons.settings,text: "Settings", pressed: (){},),
        ProfileMenu(icon: Icons.logout,text: "Log Out", pressed: (){},),

      ],
    );

  }
}
