import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/custom_outline_btn.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:hirelane/UI/auth/login_page.dart';
import 'package:hirelane/UI/auth/registration_page.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Lottie.asset('assets/Animation - 1733921345194.json'),
            const HeightSpacer(size: 30),
            CustomOutlineBtn(
              text:"Login",
              color: Colors.white,
              color2: Colors.blueAccent,
              height: 50,
              width: 300,
              onTap: (){
                Navigator.pushReplacement(
                  context, MaterialPageRoute(
                    builder: (context) => const LoginPage()
                  )
                );
              },
            ),
            const HeightSpacer(size: 20),
            CustomOutlineBtn(
              text:"SignUp",
              color: Colors.white,
              color2: Colors.blueAccent,
              height: 50,
              width: 300,
            ),
            const HeightSpacer(size: 85),
            CustomOutlineBtn(
              text:"Continue As Guest",
              color: Colors.blueAccent,
              color2: Colors.white,
              height: 50,
              width: 300,
            ),
          ],
        ),
      ),
    );
  }
}