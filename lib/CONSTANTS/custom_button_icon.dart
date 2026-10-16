import 'package:flutter/material.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';

class CustomButtonIcon extends StatelessWidget {
  const CustomButtonIcon({super.key, this.width, this.height, required this.text, this.onTap, required this.color, this.color2, this.icon});

  final double? width;
  final double? height;
  final String text;
  final void Function()? onTap;
  final Color color;
  final Color? color2;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          //boxShadow: BoxShadow(color: Color(kLightGrey.value) , blurRadius: 0.1 , offset: Offset.zero , spreadRadius: 0.3),
          color: color2,
        ),
        child:Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ReusableText(text: text,
               style: appStyle(10, color, FontWeight.normal)),
              SizedBox(width: width! *0.02,),
              Icon(icon , color: color , size: 20,)
            ],
          ),
        ),
      ),
    );
  }
}