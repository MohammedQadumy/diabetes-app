import 'package:diabetes_app/Models/User.dart';
import 'package:diabetes_app/components/app_big_text.dart';
import 'package:diabetes_app/components/app_button.dart';
import 'package:diabetes_app/pages/questionare/date_picker.dart';
import 'package:diabetes_app/utils/app_constants.dart';
import 'package:diabetes_app/utils/colors.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../AppPage/mainPage.dart';
import '../signWidgets/sign_up_widget.dart';
import 'food_prefrences_widget.dart';
import '../../base/show_custom_message.dart';
import 'package:get/get.dart';
import '../../components/app_big_text.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StepperWidgetState();
  }
}

class _StepperWidgetState extends State<StepperWidget> {
  final GlobalKey<SignUpState> _childWidgetKey = GlobalKey<SignUpState>();

  int _index = 0;
  DateTime _selectedDate = DateTime.now();

  late User newUser;

  List<String> userAnsweres = [];

  double _initialHeightValue =50;
  double _initialWeightValue = 50;

  String _excercise = "";

  _stepState(int step) {
    if (_index > step) {
      return StepState.complete;
    } else {
      return StepState.editing;
    }
  }

  void onStepContinue() {}

  void onAnswered(String question, String answer) async {
    userAnsweres.add(answer);
    String res = await _questionAndAnswer(question, answer);
    showCustomSnackBar(isError: false ,res, title: "Note:");
    print(userAnsweres);
    if (userAnsweres.length == AppConstants.questions.length) {
      setState(() {
        userAnsweres = [];
        _index++;
      });
    }
  }

  User onDataReceived(User newUser) {
    return newUser;
  }

  Future<String> _questionAndAnswer(String questionId, String answer) async {
    final response = await http.post(
      Uri.parse('${AppConstants.BASE_URL}/api/answers/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AppConstants.TOKEN}',
      },
      body: jsonEncode(<String, dynamic>{
        'question': int.parse(questionId),
        'question_answer': answer
      }),
    );

    if (response.statusCode == 204) {
      return "Question sent";
    } else {
      throw Exception('question failed to send');
    }
  }

  late bool isCompleted;
  bool registrationCompleted = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Form(
          child: Theme(
            data: ThemeData(
                colorScheme: Theme.of(context)
                    .colorScheme
                    .copyWith(primary: AppColors.nearlyBlack)),
            child: Stepper(
              controlsBuilder:
                  (BuildContext context, ControlsDetails controls) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.height15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: (_index == 0 || registrationCompleted)
                            ? null
                            : controls.onStepCancel,
                        child: Container(
                          width: Dimensions.screenWidth / 5,
                          child: const Center(child: Text("Back")),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: _index == 6
                              ? () {
                                  // here make validation before going to next page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainPage()),
                                  );
                                }
                              : controls.onStepContinue,
                          child: _index == 6
                              ? Container(
                                  width: Dimensions.screenWidth / 5,
                                  child: const Center(child: Text("Submit")),
                                )
                              : Container(
                                  width: Dimensions.screenWidth / 5,
                                  child: const Center(child: Text("Next")),
                                )),
                    ],
                  ),
                );
              },
              type: StepperType.horizontal,
              currentStep: _index,
              steps: [
                Step(
                  content: SingleChildScrollView(
                      child: SignUpWidget(
                    key: _childWidgetKey,
                  )),
                  title: Text(""),
                  state: _stepState(0),
                  isActive: _index == 0,
                ),
                Step(
                  title: Text(""),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBigText(
                        text: "الجنس",
                        size: 30,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 100,
                            child: ElevatedButton.icon(
                              icon: Icon(Icons.male),
                              label: AppBigText(text: "ذكر"),
                              onPressed: () async {
                                await _questionAndAnswer("2", "male");
                              },
                            ),
                          ),
                          SizedBox(width: 20),
                          Container(
                            height: 50,
                            width: 100,
                            child: ElevatedButton.icon(
                              icon: Icon(Icons.female),
                              label: AppBigText(text: "أنثى"),
                              onPressed: () async {
                                await _questionAndAnswer("2", "female");
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  state: _stepState(1),
                  isActive: _index == 1,
                ),
                Step(
                  title: Text(""),
                  content: Column(
                    children: [
                      AppBigText(text: "اختر طولك", size: 30),
                      Slider(
                          value: _initialHeightValue,
                          min: 20,
                          max: 240,
                          divisions: 240,
                          label: _initialHeightValue.toString(),
                          onChanged: (value) {
                            setState(() {
                              _initialHeightValue = value;
                            });
                          }),
                      Text(_initialHeightValue.toString())
                    ],
                  ),
                  state: _stepState(2),
                  isActive: _index == 2,
                ),
                Step(
                  title: Text(""),
                  content: Column(
                    children: [
                      AppBigText(text: "اختر وزنك", size: 30),
                      Slider(
                          value: _initialWeightValue,
                          min: 20,
                          max: 240,
                          divisions: 240,
                          label: _initialWeightValue.toString(),
                          onChanged: (value) {
                            setState(() {
                              _initialWeightValue = value;
                            });
                          }),
                      Text(_initialWeightValue.toString())
                    ],
                  ),
                  state: _stepState(3),
                  isActive: _index == 3,
                ),
                Step(
                  title: Text(""),
                  content: AppDatePicker(
                    onChanged: (DateTime date) {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                  ),
                  state: _stepState(4),
                  isActive: _index == 4,
                ),
                Step(
                  title: Text(""),
                  content: FoodPrefrencesWidget(
                    onAnswered: onAnswered,
                  ),
                  state: _stepState(5),
                  isActive: _index == 5,
                ),
                Step(
                  title: Text(""),
                  content: Column(
                    children: [
                      AppBigText(text: "ما هي طبيعة نشاطك البدني؟", size: 30,),
                      RadioListTile(
                          title: AppBigText(text: "لا أتمرن", size: 26,),
                          value: "1",
                          groupValue: _excercise,
                          onChanged: (val) {
                            setState(() {
                              _excercise = val!;
                            });
                          }),
                      RadioListTile(
                          title: AppBigText(text: "تمرينات خفيفة من يوم لثلاثة أيام", size: 26,),
                          value: "2",
                          groupValue: _excercise,
                          onChanged: (val) {
                            setState(() {
                              _excercise = val!;
                            });
                          }),
                      RadioListTile(
                          title: AppBigText(text: "متوسط: من 3 ل 5 أيام", size: 26,),
                          value:
                              "3",
                          groupValue: _excercise,
                          onChanged: (val) {
                            setState(() {
                              _excercise = val!;
                            });
                          }),
                      RadioListTile(
                          title: AppBigText(text: "تمرينات طوال الأسبوع", size: 26,),
                          value:
                              "4",
                          groupValue: _excercise,
                          onChanged: (val) {
                            setState(() {
                              _excercise = val!;
                            });
                          }),
                      RadioListTile(
                          title: AppBigText(text: "تمارين مع عمل مجهد", size: 26,),
                          value: "5",
                          groupValue: _excercise,
                          onChanged: (val) {
                            setState(() {
                              _excercise = val!;
                            });
                          }),
                    ],
                  ),
                  state: _stepState(6),
                ),
              ],
              onStepContinue: () async {
                if (_index == 0) {
                  // validate SignUpWidget
                  bool isValid =
                      _childWidgetKey.currentState?.validate() ?? false;
                  if (isValid) {
                    registrationCompleted = true;
                    bool? registrationResult =
                        await _childWidgetKey.currentState?.registration();
                    if (registrationResult!) {
                      // check the result of registration
                      registrationCompleted = true;
                      setState(() => _index++);
                    }
                  }
                } else if (_index == 2) {
                  setState(() => _index++);
                  await _questionAndAnswer("4", _initialHeightValue.toString());
                } else if (_index == 3) {
                  setState(() => _index++);
                  await _questionAndAnswer("5", _initialWeightValue.toString());
                } else if (_index == 4) {
                  setState(() => _index++);
                  await _questionAndAnswer("6", _selectedDate.year.toString());
                } else if (_index == 5) {
                  setState(() => _index++);
                  await _questionAndAnswer("1", _excercise);
                }else if (_index == 6) {
                  setState(() => _index = 0);
                } else {
                  setState(() => _index++);
                }
              },
              onStepCancel: () {
                registrationCompleted == true;
                if (_index == 0) {
                  setState(() => _index = 0);
                } else {
                  setState(() => _index--);
                }
              },
              onStepTapped: (int index) {
                if (registrationCompleted && index == 0) {
                  return;
                }
                setState(() => _index = index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
