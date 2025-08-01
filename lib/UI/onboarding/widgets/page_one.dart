import 'package:flutter/material.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:lottie/lottie.dart';

//import 'package:touristaar/CONSTANTS/app_style.dart';

//import 'package:touristaar/CONSTANTS/reusable_text.dart';


class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Color(kLight.value),
        child: Column(
          children: [
            const HeightSpacer(size: 170),
            //Lottie.asset('assets/Animation - 1733921630561.json'),
            Image.asset('assets/lightLogo.png'),
          ],
        ),
      ),
    );
  }
}