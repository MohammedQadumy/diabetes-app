import 'package:diabetes_app/components/app_big_text.dart';
import 'package:diabetes_app/components/app_button.dart';
import 'package:diabetes_app/components/app_return_icon_button.dart';
import 'package:diabetes_app/components/app_textfield.dart';
import 'package:diabetes_app/controllers/meals_controller.dart';
import 'package:diabetes_app/pages/stats/calories_portions_widget.dart';
import 'package:diabetes_app/pages/stats/new_meal_calories_counter.dart';
import 'package:diabetes_app/utils/app_constants.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/material.dart';
import 'package:diabetes_app/Models/Ingredient.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Models/Meal.dart';
import '../../utils/colors.dart';
import '../../Models/ItemSearch.dart';
import '../../Models/Meal.dart';
import '../../API/Methods.dart';

class NewMealPage extends StatefulWidget {
  const NewMealPage({Key? key}) : super(key: key);

  @override
  _NewMealPageState createState() => _NewMealPageState();
}

class _NewMealPageState extends State<NewMealPage> {
  TextEditingController IngredientPortion = TextEditingController();
  TextEditingController mealNameController = TextEditingController();
  TextEditingController mealDescriptionController = TextEditingController();
  TextEditingController mealImageController = TextEditingController();
  TextEditingController mealCaloriesController = TextEditingController();

  bool mealWarm = false;
  bool mealSpicy = false;
  ItemSearch? selectedIngredient;

  late List<dynamic> meals;

  Future<void> fillList() async {
    var mealController = Get.find<MealController>();
    meals = mealController.meals;
  }

  List<ItemSearch> ingredients = [];

  @override
  void initState() {
    super.initState();
    fetchIngredients();
  }

  void fetchIngredients() async {
    try {
      List<ItemSearch> items = await fetchAllItems();
      setState(() {
        ingredients = items; // Directly assign items to ingredients
      });
    } catch (e) {
      // Handle exception
      print(e.toString());
    }
  }

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
              SizedBox(
                height: Dimensions.height20,
              ),
              AppBigText(
                text: "Select ingredient",
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: AppColors.nearlyBlack, width: 1),
                ),
                child: Autocomplete<ItemSearch>(
                  // Type should be ItemSearch
                  optionsBuilder: (TextEditingValue textEdittingValue) {
                    if (textEdittingValue.text == "") {
                      return const Iterable.empty();
                    } else {
                      return ingredients.where((ItemSearch option) {
                        // Type is ItemSearch
                        return option.itemName.contains(textEdittingValue.text
                            .toLowerCase()); // Use itemName property
                      });
                    }
                  },
                  onSelected: (ItemSearch selection) {
                    // Type should be ItemSearch
                    setState(() {
                      selectedIngredient =
                          selection; // Store the entire selected ItemSearch object
                    });
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController textEditingController,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      cursorColor: Colors.black,
                      // Set the cursor color to black
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.0),
              AppBigText(
                text: "Portion",
              ),
              SizedBox(height: 10.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: Dimensions.screenWidth / 2,
                    height: Dimensions.screenHeight / 18,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border:
                          Border.all(color: AppColors.nearlyBlack, width: 1),
                    ),
                    child: TextField(
                      controller: IngredientPortion,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(border: InputBorder.none),
                      cursorColor: AppColors.nearlyBlack,
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.height10,
                  ),
                  Text(
                    "weight in gm",
                    style: TextStyle(
                        color: AppColors.nearlyBlack.withOpacity(0.5)),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                child: AppButton(
                  text: "أضف المكون",
                  fontSize: 25,
                ),
                onTap: () {
                  String newIngredientPortion = IngredientPortion.text;
                  if (selectedIngredient != null) {
                    // Add this check
                    Ingredient newIngredient = Ingredient(
                        selectedIngredient!.itemID,
                        selectedIngredient!.itemName,
                        newIngredientPortion); // Use id and itemName properties
                    setState(() {
                      AddedIngredients.add(newIngredient);
                    });
                  } else {
                    // Handle the case where no ingredient has been selected
                    print("No ingredient selected");
                  }
                },
              ),
              SizedBox(height: 10.0),
              AddedIngredients.length == 0
                  ? AppBigText(text: "No Ingredient Added")
                  : Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: AddedIngredients.map(
                        (ingredient) => Chip(
                          label: Text(
                            "${ingredient.name}gm: ${ingredient.portion}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.height15),
                          ),
                          backgroundColor: AppColors.nearlyBlack,
                        ),
                      ).toList(),
                    ),
              Container(
                margin: EdgeInsets.symmetric(vertical: Dimensions.height20),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Name your meal",
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      )),
                  controller: mealNameController,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: Dimensions.height20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Describe your meal",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius10),
                    ),
                  ),
                  controller: mealDescriptionController,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: Dimensions.height20),
                child: Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.nearlyBlack)),
                    child: Text("Select Image"),
                    onPressed: () {
                      pickImage();
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: Dimensions.height20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Calories in your meal",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius10),
                    ),
                  ),
                  controller: mealCaloriesController,
                  keyboardType: TextInputType.number,
                ),
              ),
              SwitchListTile(
                title: const Text('Is the meal warm?'),
                value: mealWarm,
                onChanged: (bool value) {
                  setState(() {
                    mealWarm = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Is the meal spicy?'),
                value: mealSpicy,
                onChanged: (bool value) {
                  setState(() {
                    mealSpicy = value;
                  });
                },
              ),
              GestureDetector(
                child: Container(
                  child: AppButton(
                    text: "أضف الوجبة",
                    fontSize: 25,
                  ),
                ),
                onTap: () async {
                  Meal newMeal = Meal(
                    id: 0,
                    name: mealNameController.text,
                    description: mealDescriptionController.text,
                    image: mealImageController.text,
                    calories: int.parse(mealCaloriesController.text),
                    warm: mealWarm,
                    spicy: mealSpicy,
                  );
                  int newMealId = await createMeal(newMeal);
                  print(newMealId);
                  AddedIngredients.forEach((ingredient) async {
                    print('==============');
                    print(ingredient.id);
                    print(ingredient.name);
                    print(ingredient.portion);
                    print('==============');
                    await postMealItem(newMealId, ingredient.id, double.parse(ingredient.portion));

                  });
                },
              ),
              SizedBox(height: 20.0),
              AppBigText(
                text: "Meal Nutrition Values",
              ),
              NewMealCounter(),
            ],
          ),
        ),
      ),
    );
  }
}
