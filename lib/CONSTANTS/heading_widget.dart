import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';

class HeadingWidget extends StatelessWidget {
 const HeadingWidget({super.key, required this.headingText, required this.color , required this.textColor});
  final String headingText;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color:color ,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          )
        ),
        Text(headingText, style: appStyle(14,textColor, FontWeight.w500),),
        Flexible(
          child: Divider(
            color: color,
            thickness: 0.5,
            indent: 5,
            endIndent: 60,
          )
        ),
      ],
    );
  }
}