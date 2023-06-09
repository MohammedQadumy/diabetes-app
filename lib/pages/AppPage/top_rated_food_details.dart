
import 'package:diabetes_app/components/app_big_text.dart';
import 'package:diabetes_app/components/app_button.dart';
import 'package:diabetes_app/components/app_icon.dart';
import 'package:diabetes_app/components/app_return_icon_button.dart';
import 'package:diabetes_app/components/extendable_text_widget.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/material.dart';

import '../../components/app_column.dart';
import '../../utils/colors.dart';


class TopRatedFoodDetails extends StatelessWidget {
  const TopRatedFoodDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
              width: double.maxFinite,
                height: Dimensions.detailsImageHeight,
                decoration:  BoxDecoration(image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/test.jpg")
                )
                ),
          )
          ),
          Positioned(
              left: Dimensions.height10,
              right: 0,
              top: Dimensions.height30,
              child: Container(child: AppReturnIconButton(),
              )
          ),
          // description
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.detailsImageHeight-Dimensions.height20,
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.height20,right: Dimensions.height20,top: Dimensions.height20,bottom: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight:Radius.circular(Dimensions.radius20),topLeft:Radius.circular(Dimensions.radius20)),
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: 'Chicken',),
                    SizedBox(height: Dimensions.height20,),
                    AppBigText(text: "Description"),
                    SizedBox(height: Dimensions.height20,),
                    const Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableTextWidget(text: "This peri peri chicken is made with my take on African peri peri sauce using fresh and dried chiles."
                            " The marinade is incredibly flavorful and gives the chicken a beautiful color as well." +""
                            "The marinade is incredibly flavorful and gives the chicken a beautiful color as well."
                            "The marinade is incredibly flavorful and gives the chicken a beautiful color as well."
                            "The marinade is incredibly flavorful and gives the chicken a beautiful color as well."
                            "The marinade is incredibly flavorful and gives the chicken a beautiful color as well."
                            "The marinade is incredibly flavorful and gives the chicken a beautiful color as well."
                            "The marinade is incredibly flavorful and gives the chicken a beautiful color as well."
                            "The marinade is incredibly flavorful and gives the chicken a beautiful color as well."
                            "The marinade is incredibly flavorful and gives the chicken a beautiful color as well."
                            "The marinade is incredibly flavorful and gives the chicken a beautiful color as well."
                            "The marinade is incredibly flavorful and gives the chicken a beautiful color as well."
                            "The marinade is incredibly flavorful and gives the chicken a beautiful color as well."
                            "The marinade is incredibly flavorful and gives the chicken a beautiful color as well."
                            "The marinade is incredibly flavorful and gives the chicken a beautiful color as well."
                            "The marinade is incredibly flavorful and gives the chicken a beautiful color as well."
                        ),
                      ),
                    ),

                  ],
                ),
          )
          )
          // expanded text
        ],
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          height: 50,
          padding: EdgeInsets.only(
              left: Dimensions.height20,
              right: Dimensions.height20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20,),
              topRight: Radius.circular(Dimensions.radius20,),
            )
          ),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppButton(text: "Add to my counter",textColor: Colors.white,height: 50,)
            ],
          ),
        ),
        onTap: () {

        },
      ),
    );
  }
}
