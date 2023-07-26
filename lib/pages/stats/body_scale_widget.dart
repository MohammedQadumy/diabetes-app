import 'package:flutter/material.dart';

import '../../utils/app_theme.dart';
import '../../API/Methods.dart';

class BodyMeasurementView extends StatefulWidget {
  const BodyMeasurementView({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyMeasurementView> createState() => _BodyMeasurementViewState();
}

class _BodyMeasurementViewState extends State<BodyMeasurementView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Transform(
        transform: Matrix4.translationValues(0.0, 30 * (1.0), 0.0),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
          child: Container(
            decoration: BoxDecoration(
              color: FitnessAppTheme.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topRight: Radius.circular(68.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: FitnessAppTheme.grey.withOpacity(0.2),
                    offset: const Offset(1.1, 1.1),
                    blurRadius: 10.0),
              ],
            ),
            child: Column(
              children: <Widget>[
                FutureBuilder<Map<String, double>>(
                  future: fetchWeightAndHeight(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      return Container(
                        color: Color(0xFFDADEFF),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16, left: 16, right: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 4, bottom: 8, top: 16),
                                child: Text(
                                  'الوزن',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Arabic',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22,
                                      letterSpacing: -0.1,
                                      color: FitnessAppTheme.darkText),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 4, bottom: 3),
                                        child: Text(
                                          snapshot.data!['weight'].toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 32,
                                            color:
                                                FitnessAppTheme.nearlyDarkBlue,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 8, bottom: 8),
                                        child: Text(
                                          'KG',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            letterSpacing: -0.2,
                                            color:
                                                FitnessAppTheme.nearlyDarkBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Text(
                        "Error fetching data",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 8, bottom: 8),
                  child: Container(
                    height: 2,
                    decoration: const BoxDecoration(
                      color: FitnessAppTheme.background,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                  ),
                ),
                FutureBuilder<Map<String, double>>(
                  future: fetchWeightAndHeight(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      return Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 24, right: 24, top: 8, bottom: 16),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data!['height'].toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 19,
                                          letterSpacing: -0.2,
                                          color: FitnessAppTheme.darkText,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(
                                          'الطول',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: FitnessAppTheme.grey
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                FutureBuilder<int>(
                                  future: fetchBMI(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.hasData) {
                                      final int bmi = snapshot.data!;
                                      String classification = '';

                                      // Classify BMI into different categories
                                      if (bmi < 18.5) {
                                        classification = 'نحيف';
                                      } else if (bmi >= 18.5 && bmi < 24.9) {
                                        classification = 'وزن طبيعي';
                                      } else if (bmi >= 25 && bmi < 29.9) {
                                        classification = 'وزن زائد';
                                      } else {
                                        classification = 'سمنة مفرطة';
                                      }

                                      return Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  '${snapshot.data!} BMI',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: FitnessAppTheme.fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 19,
                                                    letterSpacing: -0.2,
                                                    color: FitnessAppTheme.darkText,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 6),
                                                  child: Text(
                                                    classification,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: FitnessAppTheme.fontName,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 16,
                                                      color: FitnessAppTheme.grey.withOpacity(0.5),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        "Error fetching data",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }
                                  },
                                ),

                              ],
                            ),
                          ));
                    } else {
                      return Text(
                        "Error fetching data",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
