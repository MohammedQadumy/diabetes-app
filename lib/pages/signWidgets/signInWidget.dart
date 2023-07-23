import 'package:diabetes_app/components/app_big_text.dart';
import 'package:diabetes_app/components/app_button.dart';
import 'package:diabetes_app/utils/colors.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../base/show_custom_message.dart';
import '../../components/app_textfield.dart';
import '../../controllers/auth_controller.dart';
import '../AppPage/mainPage.dart';
import '../questionare/StepperWidget.dart';
import '/../API/Methods.dart';
import '/../utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignInStateClass();
  }
}

class _SignInStateClass extends State<SignInWidget> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  late bool loginSucceed = true;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    loadCredentials();
  }

  void loadCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userNameController.text = prefs.getString('email') ?? '';
      _passwordController.text = prefs.getString('password') ?? '';
      rememberMe = prefs.getBool('rememberMe') ?? false;
    });
  }

  void saveCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
    prefs.setBool('rememberMe', rememberMe);
  }
  void _registration() {
    var authController = Get.find<AuthController>();

    String username = _userNameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty) {
      showCustomSnackBar("Type your username", title: "Error");
    } else if (password.isEmpty || password.length < 8) {
      showCustomSnackBar("Type your password", title: "Error");
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        },
      );

      loginUser(username, password).then((result) {
        Navigator.pop(context);
        if (result['status'] == 200) {
          if (rememberMe) {
            saveCredentials(username, password);
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
          print("Success registration");
        } else {
          showCustomSnackBar(result['message'], title: "Error");
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nearlyWhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/images/logo.png")),
            AppBigText(text: "Welcome back"),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
              controller: _userNameController,
              hintText: "Email",
              icon: Icons.person,
              obscureText: false,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            AppTextField(
              controller: _passwordController,
              hintText: "Password",
              icon: Icons.password,
              obscureText: true,
            ),
            CheckboxListTile(
              title: Text("Remember me"),
              value: rememberMe,
              onChanged: (newValue) {
                setState(() {
                  rememberMe = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.height20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppBigText(text: "Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StepperWidget()),
                        );
                      },
                      child: const Text(
                        "Create",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkerText),
                      ))
                ],
              ),
            ),
            // AppButton(text: "SignIn", width:150 ,height: 30, textColor: AppColors.onPrimary , backgroundColor: AppColors.primaryContainer,),

            GestureDetector(
                onTap: _registration,
                child: AppButton(
                  text: "Sign In",
                  width: Dimensions.screenWidth / 1.5,
                )),
          ],
        ),
      ),
    );
  }
}
