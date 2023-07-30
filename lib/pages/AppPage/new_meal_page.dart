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
import '../../base/show_custom_message.dart';
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
  Meal? newMeal;
  bool mealWarm = false;
  bool mealSpicy = false;
  bool dinner = false;
  bool breakfast = false;
  bool lunch = false;
  bool snack = false;
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
                text: "ابحث عن مكون",
                size: 25,
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
                text: "الكمية",
                size: 25,
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
                    "الوزن بال(غم)",
                    style: TextStyle(
                        fontSize: 18,
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
                    double? ingredientCalories = selectedIngredient?.cal ?? 0.0;
                    Ingredient newIngredient = Ingredient(
                        selectedIngredient!.itemID,
                        selectedIngredient!.itemName,
                        newIngredientPortion,
                        ingredientCalories
                    );
                    setState(() {
                      AddedIngredients.add(newIngredient);
                    });
                  } else {
                    // Handle the case where no ingredient has been selected
                    print("لم يتم اختيار أي مكون");
                  }
                },
              ),
              SizedBox(height: 10.0),
              AddedIngredients.length == 0
                  ? AppBigText(text: "لم يتم اختيار مكون", color: Colors.black54)
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
                      hintText: "اسم الوجبة",
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
                    hintText: "وصف الوجبة",
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
                    child: Text("اختر صورة", style: TextStyle(fontSize: 18),),
                    onPressed: () {
                      pickImage();
                    },
                  ),
                ),
              ),
              SwitchListTile(
                title: const Text('هل الوجبة حارة؟'),
                value: mealWarm,
                onChanged: (bool value) {
                  setState(() {
                    mealWarm = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('هل الوجبة كثيرة التاوبل؟'),
                value: mealSpicy,
                onChanged: (bool value) {
                  setState(() {
                    mealSpicy = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('هل الوجبة كعشاء؟'),
                value: dinner,
                onChanged: (bool value) {
                  setState(() {
                    dinner = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('هل الوجبة غداء؟'),
                value: lunch,
                onChanged: (bool value) {
                  setState(() {
                    lunch = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('هل الوجبة فطور؟'),
                value: breakfast,
                onChanged: (bool value) {
                  setState(() {
                    breakfast = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('هل الوجبة كوجبة خفيفة؟'),
                value: snack,
                onChanged: (bool value) {
                  setState(() {
                    snack = value;
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
                  double calories = 0;
                  AddedIngredients.forEach((ingredient){
                    calories = calories + ingredient.cal;
                  });
                   newMeal = Meal(
                    id: 0,
                    name: mealNameController.text,
                    description: mealDescriptionController.text,
                    image: mealImageController.text,
                    calories: calories.toInt(),
                    warm: mealWarm,
                    spicy: mealSpicy,
                     dinner: dinner,
                     lunch: lunch,
                     breakfast: breakfast,
                     snack: snack,
                  );
                  int newMealId = await createMeal(newMeal!);
                  await reportConsumedMeal(newMealId);
                  print(newMealId);
                  AddedIngredients.forEach((ingredient) async {
                    print('==============');
                    print(ingredient.id);
                    print(ingredient.name);
                    print(ingredient.portion);
                    print('==============');
                    await postMealItem(newMealId, ingredient.id, double.parse(ingredient.portion));

                  });
                  showCustomSnackBar(isError: false,"ثم إضافة الوجبة", title: "تم");
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
