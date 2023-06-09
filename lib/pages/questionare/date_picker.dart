
import 'package:diabetes_app/components/app_big_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class AppDatePicker extends StatefulWidget {
  const AppDatePicker({Key? key}) : super(key: key);

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {

  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = "";
  }

  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBigText(text: "Choose Your birthday"),
        TextField(
            controller:dateController,
            decoration:const InputDecoration(
                icon: Icon(Icons.calendar_today),
              labelText: "Enter your birthday",
              ),
          readOnly: true,
          onTap: () async {
              DateTime? pickedDate = await showDatePicker(context: context,
                  initialDate: DateTime(2010),
                  firstDate: DateTime(1970) ,
                  lastDate: DateTime(2010));
              if(pickedDate!= null){

                String formattedDate = DateFormat("yyyy-mm-dd").format(pickedDate);

                setState(() {
                  dateController.text = formattedDate;
                });
              }
          }
        ),
      ],
    );

  }
}

