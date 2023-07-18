import 'package:diabetes_app/components/app_big_text.dart';
import 'package:diabetes_app/components/app_button.dart';
import 'package:diabetes_app/components/app_return_icon_button.dart';
import 'package:diabetes_app/controllers/meals_controller.dart';
import 'package:diabetes_app/pages/stats/calories_portions_widget.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/material.dart';
import 'package:diabetes_app/Models/Ingredient.dart';
import 'package:get/get.dart';

import '../../Models/Meal.dart';
import '../../utils/colors.dart';

class NewMealPage extends StatefulWidget {
  const NewMealPage({Key? key}) : super(key: key);

  @override
  _NewMealPageState createState() => _NewMealPageState();
}

class _NewMealPageState extends State<NewMealPage> {
  TextEditingController IngredientPortion = TextEditingController();
  String selectedIngredient = '';


  late List<dynamic> meals ;

  Future<void> fillList() async {
    var mealController = Get.find<MealController>();
    meals = mealController.meals;
  }



  List<String> ingredients = [ 'carrot', 'broccoli', 'spinach', 'lettuce', 'cabbage', 'bell pepper', 'tomato', 'onion',
    'potato', 'sweet potato', 'celery', 'zucchini', 'cauliflower', 'eggplant','chicken', 'beef', 'asparagus',
    'green beans', 'mushroom', 'radish', 'beet', 'peas', 'apple', 'banana', 'orange',
    'strawberry', 'grape','watermelon', 'pineapple', 'mango', 'kiwi', 'pear', 'peach',
    'plum', 'cherry', 'blueberry', 'raspberry', 'lemon', 'lime', 'coconut', 'pomegranate', 'avocado',];

  List<Ingredient> AddedIngredients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppReturnIconButton(),
              SizedBox(height: Dimensions.height20,),
              
              AppBigText(text: "Select ingredient",),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: AppColors.nearlyBlack, width: 1),
                ),
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEdittingValue) {
                    if (textEdittingValue.text == "") {
                      return const Iterable.empty();
                    } else {
                      return ingredients.where((String option) {
                        return option.contains(textEdittingValue.text.toLowerCase());
                      });
                    }
                  },
                  onSelected: (String selection) {
                    setState(() {
                      selectedIngredient = selection;
                    });
                  },
                  fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      cursorColor: Colors.black, // Set the cursor color to black
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.0),
              AppBigText(text: "Portion",),
              SizedBox(height: 10.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: Dimensions.screenWidth/2,
                    height: Dimensions.screenHeight/18,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: AppColors.nearlyBlack, width: 1),
                    ),
                    child: TextField(
                      controller: IngredientPortion,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(border: InputBorder.none),
                      cursorColor: AppColors.nearlyBlack,
                    ),
                  ),
                SizedBox(width: Dimensions.height10,),
                Text("weight in gm" , style: TextStyle(
                  color: AppColors.nearlyBlack.withOpacity(0.5)
                ),)
                ],
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                child: AppButton(text: "add Ingredient"),
                onTap: () {
                    String newIngredientPortion = IngredientPortion.text;
                    print(selectedIngredient);
                    Ingredient newIngredient =
                    Ingredient(selectedIngredient, newIngredientPortion);
                    print(newIngredient.name);
                    print(newIngredient.portion);

                    setState(() {
                      AddedIngredients.add(newIngredient);
                    });
                  },
              ),
              
              SizedBox(height: 10.0),
              AddedIngredients.length == 0?AppBigText(text: "No Ingredient Added"): Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children:AddedIngredients.map(
                      (ingredient) => Chip(
                    label: Text(
                      "${ingredient.name}:${ingredient.portion}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: AppColors.nearlyBlack,
                  ),
                ).toList(),
              ),
              SizedBox(height: 20.0),
              AppBigText(text: "Meal Nutrition Values",),
              SizedBox(height: 10.0),
              MediterranesnDietView()
            ],
          ),
        ),
      ),
    );
  }
}
