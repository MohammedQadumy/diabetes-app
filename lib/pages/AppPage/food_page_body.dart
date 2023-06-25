

import 'package:diabetes_app/components/app_big_text.dart';
import 'package:diabetes_app/controllers/auth_controller.dart';
import 'package:diabetes_app/pages/AppPage/top_rated_food_details.dart';
import 'package:diabetes_app/pages/signWidgets/signInWidget.dart';
import 'package:diabetes_app/utils/colors.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../components/app_column.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {


  PageController pageController = PageController(viewportFraction: 0.8);
  var _currentPage = 0.0;
  double _scaleFactor = 0.8;
  double height = Dimensions.pageViewContainer;


  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPage = pageController.page!;
        // print("current value is $_currentPage");
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: Dimensions.height20,),
            AppBigText(text: "Top Rated Meals" ),
            SizedBox(height: Dimensions.height10,)
          ],
        ),
        InkWell(
          child: Container(
            height: Dimensions.pageViewContainer+Dimensions.pageViewTextContainer,
            child: PageView.builder(
              controller: pageController,
                itemCount: 5,
                itemBuilder: (context,position){
                   return _buildPageItem(position);
            }),
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> TopRatedFoodDetails()));
          },
        ),
     DotsIndicator(
    dotsCount: 5,
    position: _currentPage.toInt(),
    decorator: DotsDecorator(
    size: const Size.square(9.0),
    activeSize: const Size(18.0, 9.0),
    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    ),
    ),
        SizedBox(height: Dimensions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.height30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppBigText(text: "Meals Today"),
              SizedBox(width: Dimensions.height10,),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: const Text("-",style: TextStyle(
                  color: Colors.black54,
                )
                ),
              ),
              SizedBox(width: Dimensions.height10,),
              AppBigText(text: "Customize"),
              SizedBox(width: Dimensions.height10,)
            ],
          ),
        ),
    Container(
      height: 900,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,itemBuilder: (context,index){
              return GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(left: Dimensions.height10, right: Dimensions.height10,),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                       margin:EdgeInsets.all(Dimensions.height10)
                      ,decoration:  BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/test.jpg"
                      ),
                      fit: BoxFit.cover)
                      ,borderRadius: BorderRadius.circular(Dimensions.radius10),
                      ),
                      ),
                      Expanded(
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radius10),
                              bottomRight: Radius.circular(Dimensions.radius10)
                            ),
                            color: AppColors.chipBackground
                          ),
                        child: Padding(padding: EdgeInsets.only(left: Dimensions.height10,top: Dimensions.height10),
                          child: AppColumn(text: "Testtttttttttttttttttttttttttttttttttttttttt"),
                        ),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> TopRatedFoodDetails()));
                },
              );
            }),
          ),

        // GestureDetector(
        //   onTap: (){
        //     // here you may add a check for user logining in
        //     Get.find<AuthController>().clearSharedData();
        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>  SignInWidget()),);
        //   },
        //   child: Text("logout") ,
        // ),
      ],
    );
  }

  Widget _buildPageItem(int index){

    Matrix4 matrix4 = new Matrix4.identity();
    if(index == _currentPage.floor())
    {
      var currScale = 1-(_currentPage - index)*(1-_scaleFactor);
      var currTrans = height*(1-currScale)/2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(index == _currentPage.floor()+1){
      var currScale = _scaleFactor+(_currentPage-index+1)*(1-_scaleFactor);
      var currTrans = height*(1-currScale)/2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
    else if(index == _currentPage.floor()-1){
      var currScale = 1.2-(_currentPage-index+1)*(1-_scaleFactor);
      var currTrans = height*(1-currScale)/2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
    else {
      var currScale = 0.8;
      var currTrans = height*(1-currScale)/2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
        Container(
        height: Dimensions.pageViewContainer,
        margin: EdgeInsets.only(left: Dimensions.height10,right: Dimensions.height10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: const DecorationImage(image: AssetImage(
              "assets/images/cezar.png"
          ),
            fit: BoxFit.cover,
          ),
        ),
      ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.height30,right: Dimensions.height30 , bottom: Dimensions.height25 ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color:  AppColors.chipBackground,
                boxShadow: const [
                  BoxShadow(color: AppColors.chipBackground,
                    blurRadius: 5,
                    offset: Offset(0, 5)
                  ),
                  BoxShadow(color: AppColors.chipBackground,
                      offset: Offset(-5, 0)
                  ),
                  BoxShadow(color: AppColors.chipBackground,
                      offset: Offset(5, 0)
                  ),
                ]
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height10 , left: Dimensions.height25 , right: Dimensions.height10),
                child: AppColumn(text: 'Cezar',),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
