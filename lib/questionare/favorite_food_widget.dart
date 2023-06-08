//
// import 'package:diabetes_app/questionare/height_widget.dart';
// import 'package:diabetes_app/questionare/weight_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'age_widget.dart';
// import 'excercise_widget.dart';
// import 'gender_widget.dart';
//
// class FavoriteIngredientsWidget extends StatelessWidget
// {
//   Map<String, List<String>> foodMap = {
//     'vegetables': [
//       'carrot', 'broccoli', 'spinach', 'lettuce', 'cabbage', 'bell pepper', 'tomato',
//       'onion', 'potato', 'sweet potato', 'celery',
//       'zucchini', 'cauliflower', 'eggplant',
//       'asparagus', 'green beans',
//       'mushroom', 'radish',
//       'beet', 'peas',
//     ],
//     'fruits': [
//       'apple', 'banana', 'orange', 'strawberry', 'grape',
//       'watermelon', 'pineapple', 'mango', 'kiwi', 'pear', 'peach',
//       'plum', 'cherry', 'blueberry',
//       'raspberry', 'lemon', 'lime', 'coconut', 'pomegranate', 'avocado',
//     ],
//     'meats': ['chicken', 'beef']
//   };
//
//   FavoriteIngredientsWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       // this widgets is just for testing chip widget
//          SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children:  [
//               const Padding(padding: EdgeInsets.all(8),
//                 child: Text("Vege",style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold)),
//               ),
//               Wrap(
//                 spacing: 8.0,
//                 runSpacing: 8.0,
//                 children: foodMap['vegetables']?.map((vegetable) => Chip(
//                   label: Text(vegetable),
//                   backgroundColor: Colors.green,
//                   labelStyle: TextStyle(color: Colors.white),
//                 ))?.toList() ?? [],
//               ),
//               const Padding(padding: EdgeInsets.all(8),
//                 child: Text("Fruits",style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold)),
//               ),
//               Wrap(
//                 spacing: 8.0,
//                 runSpacing: 8.0,
//                 children: foodMap['fruits']?.map((fruit) => Chip(
//                   label: Text(fruit),
//                   backgroundColor: Colors.orange,
//                   labelStyle: TextStyle(color: Colors.white),
//                 ))?.toList() ?? [],
//               ),
//
//             ],
//           ),
//         );
//   }
//
// }