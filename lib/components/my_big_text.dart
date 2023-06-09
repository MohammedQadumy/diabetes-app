

import 'package:flutter/cupertino.dart';

class MyBigText extends StatelessWidget
{

  Color? color ;
  final String text ;
  double size ;
  TextOverflow overflow;

  // pass color
  MyBigText({Key? key , this.color   , required this.text ,
    this.size = 20 ,
    this.overflow = TextOverflow.ellipsis}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Text(text,
      overflow: overflow,
      style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight:FontWeight.w400,
      ),
    );
  }

}