import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';


class CustomAppBar extends StatelessWidget {
  const CustomAppBar ({super.key, this.text, required this.child, this.actions});

  final String? text;
  final Widget child;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context){
    return AppBar(
      iconTheme: const IconThemeData(),
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: 70.w,
      leading: child,
      actions: actions,
      centerTitle: true,
      shadowColor: Colors.black.withOpacity(0.3),
      title: ReusableText(text: text??"", style: appStyle(16, Color(kDark.value), FontWeight.w400)),
    );
  }
}