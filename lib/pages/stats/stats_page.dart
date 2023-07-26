import 'package:diabetes_app/components/app_big_text.dart';
import 'package:diabetes_app/components/app_icon.dart';
import 'package:diabetes_app/components/app_return_icon_button.dart';
import 'package:diabetes_app/pages/stats/body_scale_widget.dart';
import 'package:diabetes_app/pages/stats/calories_portions_widget.dart';
import 'package:diabetes_app/utils/dimenstions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Models/Intake.dart';
import '../../API/Methods.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  late Future<Intake> _intakeFuture;

  @override
  void initState() {
    super.initState();
    _intakeFuture = fetchIntake();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          AppReturnIconButton(),
          Container(
            margin: EdgeInsets.only(left: Dimensions.height10, top: Dimensions.height10),
            child: AppBigText(text: "المؤشرات الغذائية", size: 30,),
          ),
          FutureBuilder<Intake>(
            future: _intakeFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return MediterranesnDietView(intake: snapshot.data!);
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return Text("No data available");
              }
            },
          ),
          Container(
            margin: EdgeInsets.only(left: Dimensions.height20, top: Dimensions.height30),
            child: AppBigText(text: "مؤشرات الجسم", size: 30,),
          ),
          BodyMeasurementView(),
          SizedBox(height: 60,)
        ],
      ),
    );
  }
}