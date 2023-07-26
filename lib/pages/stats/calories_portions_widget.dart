import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../utils/app_theme.dart';
import '../../Models/Intake.dart';
import '../../components/app_big_text.dart';
import '../../API/Methods.dart';

class MediterranesnDietView extends StatefulWidget {
  final Intake intake;

  MediterranesnDietView({
    required this.intake,
  });

  @override
  State<MediterranesnDietView> createState() => _MediterranesnDietViewState();
}

class _MediterranesnDietViewState extends State<MediterranesnDietView> {
  @override
  Widget build(BuildContext context) {
    String noteText =
        (widget.intake.recommended - widget.intake.consumed) <= 300
            ? 'يجب عليك الانتباه إلى نظامك الغذائي'
            : 'المؤشرات الغذائية سليمة';
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
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 8, right: 8, top: 4),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: 48,
                                    width: 2,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF87A0E5)
                                          .withOpacity(0.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, bottom: 2),
                                          child: Text(
                                            'تم استهلاك',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 22,
                                              letterSpacing: -0.1,
                                              color: FitnessAppTheme.grey
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 28,
                                              height: 28,
                                              // child: Image.asset(
                                              //     "assets/fitness_app/eaten.png"),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, bottom: 3),
                                              child: Text(
                                                '${(widget.intake.consumed).toInt()}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontFamily:
                                                      FitnessAppTheme.fontName,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: FitnessAppTheme
                                                      .darkerText,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, bottom: 3),
                                              child: Text(
                                                'Kcal',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      FitnessAppTheme.fontName,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  letterSpacing: -0.2,
                                                  color: FitnessAppTheme.grey
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Center(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: FitnessAppTheme.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(100.0),
                                    ),
                                    border: Border.all(
                                        width: 4,
                                        color: FitnessAppTheme.nearlyDarkBlue
                                            .withOpacity(0.2)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '${(widget.intake.recommended - widget.intake.consumed).toInt()}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 24,
                                          letterSpacing: 0.0,
                                          color: FitnessAppTheme.nearlyDarkBlue,
                                        ),
                                      ),
                                      Text(
                                        'سعرات متبقية',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          letterSpacing: 0.0,
                                          color: FitnessAppTheme.grey
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CustomPaint(
                                  painter: CurvePainter(
                                      colors: [
                                        FitnessAppTheme.nearlyDarkBlue,
                                        const Color(0xFF8A98E8),
                                        const Color(0xFF8A98E8)
                                      ],
                                      angle: 140 +
                                          (360 - 140) *
                                              ((widget.intake.recommended -
                                                      widget.intake.consumed) /
                                                  (widget.intake.recommended))),
                                  child: const SizedBox(
                                    width: 108,
                                    height: 108,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
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
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 8, bottom: 16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Column(
                                children: [
                                  AppBigText(text: noteText, size: 30,),
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: FutureBuilder<double>(
                                      future: fetchTotalProtein(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (snapshot.hasData) {
                                          return Container(
                                            color: Color(0xFFDADEFF),

                                            child: Wrap(
                                              spacing: 8.0,
                                              runSpacing: 1.0,
                                              children: [
                                                AppBigText(
                                                  text: "بروتين",
                                                  size: 25,

                                                ),
                                                AppBigText(
                                                  text: "${snapshot.data}",
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
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: FutureBuilder<double>(
                                      future: fetchTotalCarbs(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (snapshot.hasData) {
                                          return Container(
                                            color: Color(0xFFDADEFF),
                                            child: Wrap(
                                              spacing: 8.0,
                                              runSpacing: 1.0,
                                              children: [
                                                AppBigText(
                                                  text: "كربوهيدرات",
                                                  size: 25,
                                                ),
                                                AppBigText(
                                                  text: "${snapshot.data}",
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
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: FutureBuilder<double>(
                                      future: fetchTotalFat(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (snapshot.hasData) {
                                          return Container(
                                            color: Color(0xFFDADEFF),
                                            child: Wrap(
                                              spacing: 8.0,
                                              runSpacing: 1.0,
                                              children: [
                                                AppBigText(
                                                  text: "دهون",
                                                  size: 25,
                                                ),
                                                AppBigText(
                                                  text: "${snapshot.data}",
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
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  final double? angle;
  final List<Color>? colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = [];
    if (colors != null) {
      colorsList = colors ?? [];
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shdowPaintCenter = Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(
        Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(
        Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.1);
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(
        Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    final rect = Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        paint);

    final gradient1 = const SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = Paint();
    cPaint.shader = gradient1.createShader(rect);
    cPaint.color = Colors.white;
    cPaint.strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle! + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}
