import 'package:flutter/material.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';

class CustomTextfield extends StatelessWidget{
  const CustomTextfield({super.key, required this.controller, required this.hintText, required this.keyboardType, this.validator, this.suffixIcon, this.obscureText , this.prefixIcon});

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;

  @override
  Widget build(BuildContext context){
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(width: 1 , color:Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10)
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText??false,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIcon: Padding(
            padding: EdgeInsets.all(15),
            child: prefixIcon,
          ),
          hintStyle: appStyle(12, Colors.grey, FontWeight.normal),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.red , width: 0.5)
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.transparent , width: 0.5)
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.red , width: 0.5)
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Color(kDarkGrey.value) , width: 0.5)
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: Colors.transparent , width: 0.5)
          ),
          border: InputBorder.none
        ),
        controller: controller,
        cursorHeight: 25,
        style: appStyle(14, Color(kDark.value), FontWeight.w500),
        validator: validator,
      ),
    );
  }
}