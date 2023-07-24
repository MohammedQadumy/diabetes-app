import 'package:flutter/cupertino.dart';

class AppBigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overflow;


  AppBigText(
      {Key? key,
      this.color,
      required this.text,
      this.overflow = TextOverflow.ellipsis,
      this.size = 22})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');

    String fontFamily;
    if (arabicRegex.hasMatch(text)) {
      fontFamily = 'Arabic';
    } else {
      fontFamily = 'Lato';
    }
    return Center(
      child: Text(
        text,
        style: TextStyle(
          overflow: overflow,
          color: color,
          fontSize: size,
          fontWeight: FontWeight.w400,
          fontFamily: fontFamily,

        ),
      ),
    );
  }
}
