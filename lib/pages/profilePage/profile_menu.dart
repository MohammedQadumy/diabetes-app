
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Padding(padding:  EdgeInsets.symmetric(horizontal: Dimensions.height20,
        vertical: Dimensions.height20),
      child: TextButton(onPressed: pressed , child: Row(
        children: [
          Icon(icon),
          SizedBox(width: Dimensions.height20,),
          Expanded(child: Text(text)),
          Icon(Icons.arrow_right_alt_outlined)
        ],

      )
      ),
    );
  }
}
