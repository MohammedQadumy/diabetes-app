
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimenstions.dart';

class ProfileMenu extends StatelessWidget {

  final String text;
  final IconData icon;
  final VoidCallback pressed;


  const ProfileMenu({
    super.key, required this.text, required this.icon, required this.pressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(padding:  EdgeInsets.symmetric(horizontal: Dimensions.height20,
        vertical: Dimensions.height10),
      margin: EdgeInsets.only(top: Dimensions.height30),
      decoration: BoxDecoration(color: AppColors.chipBackground,
          borderRadius: BorderRadius.circular(Dimensions.radius20)
      ),
      child: TextButton(onPressed: pressed ,
        child: Row(
          children: [
            Icon(icon , color: AppColors.nearlyBlack),
            SizedBox(width: Dimensions.height20,),
            Expanded(child: Text(text ,style: TextStyle(color: AppColors.nearlyBlack
            ),
            )
            ),
            Icon(Icons.edit , color: AppColors.nearlyBlack)
          ],

        ),
      )
      );
  }
}
