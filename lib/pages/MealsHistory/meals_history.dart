
import 'package:diabetes_app/components/app_big_text.dart';
import 'package:diabetes_app/components/app_icon.dart';
import 'package:diabetes_app/components/app_return_icon_button.dart';
import 'package:diabetes_app/utils/colors.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/material.dart';
import '../../API/Methods.dart';
import '../../Models/Meal.dart';
class MealsHistory extends StatefulWidget {
  @override
  _MealsHistoryState createState() => _MealsHistoryState();
}

class _MealsHistoryState extends State<MealsHistory> {
  late Future<List<Meal>> futureMeals;

  @override
  void initState() {
    super.initState();
    refreshMeals();
  }

  Future<void> refreshMeals() async {
    futureMeals = fetchConsumedMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppReturnIconButton(),
                AppBigText(text: "Meals History" ,color: Colors.black),
                AppIcon(icon: Icons.food_bank_sharp , backgroundColor: AppColors.chipBackground,)
              ],
            ),
            color: AppColors.chipBackground,
            width: double.maxFinite,
            height: Dimensions.screenHeight/10,
            padding: EdgeInsets.only(top: Dimensions.height30),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height10 , left: Dimensions.height10 , right: Dimensions.height10 ),
              child: FutureBuilder<List<Meal>>(
                future: futureMeals,
                builder: (BuildContext context, AsyncSnapshot<List<Meal>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(  // centers the CircularProgressIndicator
                      child: SizedBox(  // constrains the size of CircularProgressIndicator
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    );  // or your custom loader
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final meal = snapshot.data![index];
                        return Container(
                          margin: EdgeInsets.only(bottom: Dimensions.height10),
                          padding: EdgeInsets.symmetric(vertical: Dimensions.height10 , horizontal: Dimensions.height10),
                          decoration: BoxDecoration(
                              color: AppColors.chipBackground,
                              borderRadius: BorderRadius.circular(Dimensions.radius10)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppBigText(text: meal.name),
                                      SizedBox(height: Dimensions.height10,),
                                      Text( "20/7/2023 6:00 PM"), // you should use actual time when the meal was consumed
                                    ],
                                  ),
                                  IconButton(
                                    color: AppColors.errorColor,
                                    onPressed: () async {
                                      try {
                                        var response = await deleteMeal(meal.id);
                                        setState(() {
                                          refreshMeals();  // Refresh meals after deletion
                                        });
                                        if (response.statusCode == 200) {
                                          print("Meal deleted successfully");

                                        } else {
                                          print('Failed to delete meal. Server response: ${response.body}');
                                        }
                                      } catch (e) {
                                        print('An error occurred while deleting meal: $e');
                                      }
                                    },
                                    icon: Icon(Icons.delete),
                                  )




                                ],
                              ),
                              SizedBox(height: Dimensions.height10,),
                              // Add more fields to display other Meal data...
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}