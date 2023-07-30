

import 'package:diabetes_app/Models/Meal.dart';
import 'package:diabetes_app/components/app_big_text.dart';
import 'package:diabetes_app/components/app_button.dart';
import 'package:diabetes_app/components/app_return_icon_button.dart';
import 'package:diabetes_app/components/extendable_text_widget.dart';
import 'package:diabetes_app/utils/colors.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../Models/Item.dart';
import '../../Models/MealWithRating.dart';
import '../../components/app_column.dart';
import '../../API/Methods.dart';
import '../../base/show_custom_message.dart';
import '../../Models/Intake.dart';

class TopRatedFoodDetails extends StatefulWidget {
  final MealWithRating meal;
  final Function(MealWithRating) onMealConsumed;

  TopRatedFoodDetails({required this.meal, required this.onMealConsumed});

  @override
  _TopRatedFoodDetailsState createState() => _TopRatedFoodDetailsState();
}

class _TopRatedFoodDetailsState extends State<TopRatedFoodDetails> {
  bool isConsumed = false;


  late Future<List<Item>> futureItems;
  @override
  void initState() {
    super.initState();
    futureItems = fetchItems(widget.meal.meal.id);
  }

  double  rating = 0 ;
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          widget.meal.meal.image),
                      fit: BoxFit.cover),
                  borderRadius:
                  BorderRadius.circular(Dimensions.radius10),
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // AppColumn(meal: this.meal, rating: 4),
                      SizedBox(height: Dimensions.height20,),
                      AppBigText(text: "وصف الوجبة", size: 30,),
                      SizedBox(height: Dimensions.height20,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ExpandableTextWidget(text: "${widget.meal.meal.description}"),
                        ),
                      ),
                      AppBigText(text: "المكونات", size: 30,),
                      FutureBuilder<List<Item>>(
                        future: futureItems,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: snapshot.data!.map((item) =>
                                  ListTile(
                                    title: Text(item.itemName),
                                    trailing: Text('${(item.weight/5).toString()}غم'),
                                  )
                              ).toList(),
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          // By default, show a loading spinner.
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                      // add more widgets as needed
                    ],
                  ),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  child: AppButton(
                    text: "تقييم",
                    textColor: Colors.white,
                    height: 50,
                    fontSize: 20,

                  ),
                  onTap: () => showRating(),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: AppButton(
                    text: "أضف إلى وجباتي",
                    textColor: Colors.white,
                    backgroundColor: widget.meal.isConsumed ? Colors.red : AppColors.nearlyBlack,
                    height: 50,
                    fontSize: 20,
                  ),
                  onTap: widget.meal.isConsumed ? null : () async {
                    Intake intake = await fetchIntake();
                    var rem = intake.recommended - intake.consumed;
                    print("Meal cal: ${widget.meal.meal.calories} || Remaining: ${rem}");
                    if (widget.meal.meal.calories <= rem) {

                      showCustomSnackBar(title: "إضافة وجبة", "ثم إضافة الوجبة ${widget.meal.meal.name}" ,isError: false);
                      reportConsumedMeal(widget.meal.meal.id);
                      setState(() {
                        widget.meal.isConsumed = true;
                      });
                    } else {
                      showCustomSnackBar(title: "عذرا", "لقد تجاوزت الحد المسموح به من الكالوري");
                    }
                  },
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }

  void showRating() {
    showDialog(
      context: this.context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBigText(text: "اترك تقييما للوجبة"),
            buildRating(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              rateMeal(widget.meal.meal.id, rating.toInt());
              Navigator.pop(context);
              showCustomSnackBar(isError: false,title: "تقييم","ثم تقييم الوجبة ب ${rating.toInt()} نجوم");
            },
            child: AppBigText(
              text: "تقييم",
              color: AppColors.nearlyBlack,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRating() => RatingBar.builder(
      minRating: 1,
      itemSize: 46,
      itemPadding: EdgeInsets.symmetric(horizontal: 5 , vertical: 5),
      itemBuilder: (context,_) => Icon(Icons.star),
      onRatingUpdate: (rating) => setState(() {
        this.rating = rating;
      }),
  );
}



