import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:lottie/lottie.dart';



class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Color(kLight.value),
        child: Column(
          children: [
            const HeightSpacer(size: 20),
            Lottie.asset('assets/Animation - 1736431574667.json'),
            const HeightSpacer(size: 20),
            Column(
              children: [
                ReusableText(text: "Simplified Job Search", style:appStyle(25, Color(kDark.value), FontWeight.bold)),
                const HeightSpacer(size: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                  child: Text(
                    "Get hired for your next job at ease through the use of Hirelane",
                    textAlign: TextAlign.center,
                    style: appStyle(14, Color(kDark.value),FontWeight.normal),
                  ),
                  )
              ],
            )
          ],
        ),
      ),
    ); 
  }
}