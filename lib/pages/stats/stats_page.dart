

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:Center(
        child: CircularProgressIndicator(

          value: 0.7,
          color: Colors.purple,
        ),
      ),
    );
  }
}
