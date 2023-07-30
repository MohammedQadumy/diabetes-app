import 'package:diabetes_app/components/app_big_text.dart';
import 'package:diabetes_app/components/app_button.dart';
import 'package:diabetes_app/components/app_textfield.dart';
import 'package:diabetes_app/pages/profilePage/profile_menu.dart';
import 'package:diabetes_app/pages/signWidgets/signInWidget.dart';
import 'package:diabetes_app/utils/app_constants.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../base/show_custom_message.dart';
import '../../utils/colors.dart';
import 'package:diabetes_app/API/Methods.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  TextEditingController oldOverlayController = TextEditingController();

  TextEditingController newOverlayController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  void _openEditInformationOverlay(
      IconData icon,
      TextEditingController oldController,
      TextEditingController newController,
      bool isObscureText,
      String currentInformaion,
      String hintText) {
    oldOverlayController.text = currentInformaion;
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            margin: EdgeInsets.only(top: Dimensions.height20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius15)),
            height: Dimensions.screenHeight / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isObscureText == true
                    ? AppTextField(
                        controller: oldController,
                        icon: icon,
                        obscureText: isObscureText,
                        hintText: hintText,
                      )
                    : Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.height20,
                            bottom: Dimensions.height20),
                        child: AppBigText(text: currentInformaion)),
                isObscureText == true
                    ? AppTextField(
                        controller: newController,
                        icon: icon,
                        obscureText: true,
                        hintText: "New Passwword")
                    : AppTextField(
                        controller: newController,
                        icon: icon,
                        obscureText: false,
                        hintText: hintText,
                      ),
                if (isObscureText == true)
                  AppTextField(
                    controller: confirmPasswordController,
                    icon: icon,
                    obscureText: true,
                    hintText: "Re-enter your new Password",
                  ),
                Row(
                  children: [
                    GestureDetector(
                      child: AppButton(text: "Cancel"),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    GestureDetector(
                      child: AppButton(text: "Confirm"),
                      onTap: () {
                        bool passFlag = true;
                        Map<String, String> updates = {};
                        if (icon == Icons.person_2) {
                          updates['username'] =
                              newOverlayController.text.trim();
                        } else if (icon == Icons.height) {
                          updates['height'] = newOverlayController.text.trim();
                        } else if (icon == Icons.monitor_weight) {
                          updates['weight'] = newOverlayController.text.trim();
                        } else if (icon == Icons.password) {
                          if (confirmPasswordController.text
                                  .trim()
                                  .toString() !=
                              newController.text.trim().toString()) {
                            showCustomSnackBar("Passwords are not matching!");
                            passFlag = false;
                          } else {
                            updates['password'] =
                                confirmPasswordController.text.trim();
                          }
                        }
                        if (icon == Icons.password && passFlag) {
                          changePassword(updates['password'].toString());
                        } else if (icon == Icons.person_2) {
                          updateUser(updates).catchError((error) {
                            print('Failed to update user info: $error');
                          });
                        } else if (icon == Icons.height) {
                          updateHeight(int.parse(updates['height'].toString()))
                              .catchError((error) {
                            print('Failed to update user info: $error');
                          });
                        } else if (icon == Icons.monitor_weight) {
                          updateWeight(int.parse(updates['weight'].toString()))
                              .catchError((error) {
                            print('Failed to update user info: $error');
                          });
                        }
                        if (icon == Icons.password && !passFlag) {
                        } else {
                          Navigator.pop(context);
                          showCustomSnackBar(
                              isError: false,"UpdatedTo: ${updates.values.toString().substring(1, updates.values.toString().length - 1)}",
                              title: "Sucess");
                        }
                      },
                    ),
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
        //Update UserName
        ProfileMenu(
          icon: Icons.person_2_outlined,
          text: "UserName from request",
          pressed: () {
            _openEditInformationOverlay(
                Icons.person_2,
                oldOverlayController,
                newOverlayController,
                false,
                "Current: ${AppConstants.currentUser.userName}",
                "New UserName");
          },
        ),
        ProfileMenu(
          icon: Icons.height,
          text: "height from request",
          pressed: () {
            _openEditInformationOverlay(Icons.height, oldOverlayController,
                newOverlayController, false, "user height", "New height");
          },
        ),
        ProfileMenu(
          icon: Icons.monitor_weight,
          text: "weight from request",
          pressed: () {
            _openEditInformationOverlay(
                Icons.monitor_weight,
                oldOverlayController,
                newOverlayController,
                false,
                "user weight",
                "New weight");
          },
        ),
        ProfileMenu(
          icon: Icons.password,
          text: "Password",
          pressed: () {
            _openEditInformationOverlay(Icons.password, oldOverlayController,
                newOverlayController, true, "", "write your current password");
          },
        ),
        Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.height20, vertical: Dimensions.height10),
            decoration: BoxDecoration(
                color: AppColors.chipBackground,
                borderRadius: BorderRadius.circular(Dimensions.radius20)),
            margin: EdgeInsets.only(top: Dimensions.height20),
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignInWidget()));
              },
              child: Row(
                children: [
                  Icon(Icons.logout, color: AppColors.errorColor),
                  SizedBox(
                    width: Dimensions.height20,
                  ),
                  Expanded(
                      child: Text(
                    "Log Out",
                    style: TextStyle(color: AppColors.errorColor),
                  )),
                ],
              ),
            ))
      ],
    );
  }
}
