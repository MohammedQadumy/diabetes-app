

import 'package:diabetes_app/Models/Ingredient.dart';
import 'package:diabetes_app/components/app_big_text.dart';
import 'package:diabetes_app/components/app_button.dart';
import 'package:diabetes_app/components/app_textfield.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/material.dart';

class NewMealPage extends StatefulWidget {
  const NewMealPage({Key? key}) : super(key: key);

  @override
  State<NewMealPage> createState() => _NewMealPageState();
}

class _NewMealPageState extends State<NewMealPage> {


  TextEditingController IngredientPortion = TextEditingController();
  TextEditingValue textEdittingValue = TextEditingValue();

  List<String> ingredients = [
    'carrot', 'broccoli', 'spinach', 'lettuce', 'cabbage', 'bell pepper', 'tomato',
       'onion', 'potato', 'sweet potato', 'celery',
      'zucchini', 'cauliflower', 'eggplant','chicken', 'beef',
       'asparagus', 'green beans', 'mushroom', 'radish',
       'beet', 'peas', 'apple', 'banana', 'orange', 'strawberry', 'grape','watermelon', 'pineapple', 'mango', 'kiwi', 'pear', 'peach',     'plum', 'cherry', 'blueberry',
       'raspberry', 'lemon', 'lime', 'coconut', 'pomegranate', 'avocado',
  ];

  List<Ingredient> AddedIngredients=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            children: [
              //row for auto fill text field , portion , text gm
              Row(children: [
                Container(
                  padding: EdgeInsets.only(left: Dimensions.height20),
                  width: Dimensions.screenWidth/1.5,
                  child: Autocomplete<String>(optionsBuilder: (textEdittingValue){
                    if(textEdittingValue.text==""){
                      return const Iterable.empty();
                    }else{
                      return ingredients.where(
                              (String element) {
                                return element.contains(textEdittingValue.text.toLowerCase());
                              });
                    }
                  },
                  ),
                ),
                 Container(
                     width: 120
                     ,child: AppTextField(controller: IngredientPortion, icon: Icons.monitor_weight_outlined, obscureText: false)
                 ),
              ],
              ),
              GestureDetector(
                  child: AppButton(text: "ADD" ,height: 50,width: Dimensions.screenWidth/1.5,
                  ),
              onTap: () {
                    String newIngredientPortion = IngredientPortion.toString();

                    Ingredient newIngredient = Ingredient(newIngredientPortion,textEdittingValue.toString().trim() );
                    print(newIngredient.name);
                    print(newIngredient.portion);

                    setState(() {
                      AddedIngredients.add(newIngredient);
                    });


              },),

              // added ingredients
               Container(
                  margin: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20 ,
                      left: Dimensions.height10 , right: Dimensions.height10),
                  padding: EdgeInsets.only(left: Dimensions.height10,right: Dimensions.height10),
                  width: Dimensions.screenWidth,
                  height: Dimensions.screenHeight/3,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius10)),
                  ),
                  child:
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Wrap(
                              spacing: 0.8,
                              runSpacing: 0.8,
                              children: [
                                AddedIngredients.length == 0
                                    ? AppBigText(text: "No Ingredients Added")
                                    :  Column(
                                  children: AddedIngredients.map(
                                          (ingredient) => Chip(
                                        label: Text(ingredient.name),
                                            backgroundColor: Colors.green,
                                      ),
                                  ).toList(),
                                ),

                              ],
                            ),
                          ],
                        ),
                      )

                ),
              // meal nutrition portions
              Container(
                width: Dimensions.screenWidth,
                height: Dimensions.screenHeight/3,
                color: Colors.green,
                child: Text("the stats of new meal"),
              )
            ],



          ),
        ),
      )
    );
  }
}
