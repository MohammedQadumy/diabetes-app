import 'package:diabetes_app/controllers/meals_controller.dart';
import 'package:flutter/material.dart';
import 'package:diabetes_app/Models/Ingredient.dart';
import 'package:get/get.dart';

import '../../Models/Meal.dart';

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
      appBar: AppBar(
        title: Text('New Meal'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Ingredient',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.blue, width: 1),
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
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Portion',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.blue, width: 1),
                ),
                child: TextField(
                  controller: IngredientPortion,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
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
                child: Text('Add Ingredient'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Added Ingredients',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: AddedIngredients.map(
                      (ingredient) => Chip(
                    label: Text(
                      "${ingredient.name}:${ingredient.portion}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                ).toList(),
              ),
              SizedBox(height: 20.0),
              Text(
                'Meal Nutrition Portions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.all(16.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.blue,
                ),
                child: Text(
                  "The stats of new meal will go here...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
