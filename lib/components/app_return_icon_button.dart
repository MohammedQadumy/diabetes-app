import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/dimenstions.dart';
import 'app_icon.dart';

class AppReturnIconButton extends StatelessWidget {
  const AppReturnIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(child: AppIcon(icon: Icons.arrow_back_ios) , onTap: (){
              Navigator.pop(context);
            },),
          ],
        );
  }
}
