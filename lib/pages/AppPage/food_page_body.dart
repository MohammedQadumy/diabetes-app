

import 'package:diabetes_app/pages/AppPage/top_rated_food_details.dart';
import 'package:diabetes_app/utils/colors.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            children: [
              Text("Favorite food"),
              SizedBox(width: Dimensions.height10,),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: const Text("-",style: TextStyle(
                  color: Colors.black54,
                )
                ),
              ),
              SizedBox(width: Dimensions.height10,),
            ],
          ),
        ),
        // MealsFavList(),
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
        margin: EdgeInsets.only(left: 10,right: 10),
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
                color:  AppColors.secondaryContainer,
                boxShadow: const [
                  BoxShadow(color: Color(0xFFe8e8e8),
                    blurRadius: 5,
                    offset: Offset(0, 5)
                  ),
                  BoxShadow(color: Colors.white,
                      offset: Offset(-5, 0)
                  ),
                  BoxShadow(color: Colors.white,
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
