
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


class SignInWidget extends StatefulWidget{
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



    void _registration(){

      var authController = Get.find<AuthController>();


      String username = _userNameController.text.trim();
      String password = _passwordController.text.trim();

      if(username.isEmpty){
        showCustomSnackBar("type your username",title: "Name");
      }else if(password.isEmpty || password.length <8){
        showCustomSnackBar("type your password",title: "Name");
      }
      else{


        authController.login(username , password).then((status){
          if(status.isSuccess){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>  MainPage()),);
            print("Success registration");
          }else{
            print("failed");
            showCustomSnackBar(status.message);
            print(status.message);
          }
        });





      }
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor:  AppColors.background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage("assets/images/logo.png")),
               AppBigText(text: "Welcome back"),
               SizedBox(height: Dimensions.height20,),
              AppTextField(
                  controller: _userNameController, hintText: "Enter UserName", icon: Icons.person, obscureText: false,),
              SizedBox(height: Dimensions.height20,),
              AppTextField(
                controller: _passwordController, hintText: "Enter Password", icon: Icons.password, obscureText: true,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Dimensions.height20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:  [
                    AppBigText(text: "Don't have an account?"),
                     TextButton(onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> StepperWidget()),
                      );},
                        child: const Text("Create" ,style: TextStyle(
                      fontWeight: FontWeight.bold,
                          color: AppColors.primary
                    ),
                    )
                    )
                  ],
                ),
              ),
              // AppButton(text: "SignIn", width:150 ,height: 30, textColor: AppColors.onPrimary , backgroundColor: AppColors.primaryContainer,),
              
              
              
              GestureDetector(onTap:_registration, child: AppButton(text: "Sign In" , width: Dimensions.screenWidth/1.5,)),

            ],
          ),
        ),
      );
    }

  }



