

import 'package:diabetes_app/components/app_big_text.dart';
import 'package:diabetes_app/components/app_button.dart';
import 'package:diabetes_app/components/app_textfield.dart';
import 'package:diabetes_app/pages/profilePage/profile_menu.dart';
import 'package:diabetes_app/pages/signWidgets/signInWidget.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';




class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {

  TextEditingController oldOverlayController = TextEditingController() ;
  TextEditingController newOverlayController = TextEditingController() ;
  TextEditingController confirmPasswordController = TextEditingController() ;


  void _openEditInformationOverlay(IconData icon , TextEditingController oldController , TextEditingController newController,  bool isObscureText , String currentInformaion , String hintText){
    oldOverlayController.text= currentInformaion;
    showModalBottomSheet(context: context, builder: (ctx){
      return Container(
        margin: EdgeInsets.only(top: Dimensions.height20),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius15)
        ),
        height: Dimensions.screenHeight/2,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isObscureText==true?AppTextField(controller: oldController, icon: icon, obscureText: isObscureText , hintText: hintText,):Container( margin: EdgeInsets.only(left: Dimensions.height20 , bottom:Dimensions.height20 ) , child: AppBigText(text: currentInformaion)),
            isObscureText==true?AppTextField(controller: newController, icon: icon, obscureText: true , hintText: "New Passwword"):AppTextField(controller: newController, icon: icon, obscureText: false , hintText: hintText,),
            if(isObscureText==true)AppTextField(controller: confirmPasswordController , icon: icon, obscureText: true , hintText: "Re-enter your new Password",),
            Row(
              children: [
                GestureDetector(child: AppButton(text: "Cancel") , onTap: (){
                  Navigator.pop(context);
                },),
                GestureDetector(child: AppButton(text: "Confirm") , onTap: null,),
              ],
            )
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileMenu(icon: Icons.person_2_outlined,text: "Email from request", pressed: (){
          _openEditInformationOverlay(Icons.email , oldOverlayController ,newOverlayController, false , "current: user Email" , "New Email");
        },),
        ProfileMenu(icon: Icons.height,text: "height from request", pressed: (){
          _openEditInformationOverlay(Icons.height , oldOverlayController , newOverlayController,false , "user height" , "New height");
        },),
        ProfileMenu(icon: Icons.monitor_weight,text: "weight from request", pressed: (){
          _openEditInformationOverlay(Icons.monitor_weight , oldOverlayController , newOverlayController,false , "user weight" , "New weight");
        },),
        ProfileMenu(icon: Icons.password,text: "Password", pressed: (){
          _openEditInformationOverlay(Icons.password , oldOverlayController , newOverlayController,true , "" ,"write your current password" );
        },),
        Container(padding:  EdgeInsets.symmetric(horizontal: Dimensions.height20,
            vertical: Dimensions.height10),
            decoration: BoxDecoration(color: AppColors.chipBackground,
                borderRadius: BorderRadius.circular(Dimensions.radius20)
            ),
            margin: EdgeInsets.only(top: Dimensions.height20),
            child: TextButton(onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInWidget()));} ,
              child: Row(
                children: [
                  Icon(Icons.logout , color: AppColors.errorColor),
                  SizedBox(width: Dimensions.height20,),
                  Expanded(child: Text("Log Out" ,style: TextStyle(color: AppColors.errorColor
                  ),
                  )
                  ),
                ],

              ),
            )
        )

      ],
    );

  }
}
