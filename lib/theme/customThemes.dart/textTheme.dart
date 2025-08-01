import 'package:flutter/material.dart';

class TTextTheme{
  TTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 32.0 , fontWeight: FontWeight.bold , color: Colors.black),
    headlineMedium: const TextStyle().copyWith(fontSize: 24.0 , fontWeight: FontWeight.w600 , color: Colors.black),
    headlineSmall: const TextStyle().copyWith(fontSize: 18.0 , fontWeight: FontWeight.w600 , color: Colors.black),
  );
  static TextTheme darkTextTheme = TextTheme();
}