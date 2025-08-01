import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:hirelane/UI/onboarding/widgets/page_one.dart';
import 'package:hirelane/UI/onboarding/widgets/page_three.dart';
import 'package:hirelane/UI/onboarding/widgets/page_two.dart';
import 'package:hirelane/controllers/onboarding_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();

  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OnBoardNotifier>(
        builder: (context , onBoardNotifier , child){
          return Stack(
        children: [
          PageView(
            physics: onBoardNotifier.isLastPage
                  ? const NeverScrollableScrollPhysics()
                  :const AlwaysScrollableScrollPhysics() ,
                  controller: pageController,
            onPageChanged: (page){
              onBoardNotifier.isLastPage = page == 2;
            } ,
            children: const [
              PageOne(),
              PageTwo(),
              PageThree(),
            ],
          ),
          Positioned(
            bottom: height*0.12,
            left: 0,
            right: 0,
            child: onBoardNotifier.isLastPage? SizedBox.shrink() : Center(
              child: SmoothPageIndicator(
                count: 3,
                controller: pageController,
                effect: WormEffect(
                  dotHeight: 12,
                  dotWidth: 12,
                  spacing: 10,
                  dotColor: Color(kDarkGrey.value).withOpacity(0.5),
                  activeDotColor: Color(kLightBlue.value)
                ), 
              ),
            )
          ),

          Positioned(
            child: onBoardNotifier.isLastPage? const SizedBox.shrink() 
            : Align(
              alignment: Alignment.bottomCenter,
              child: Padding(padding: EdgeInsets.symmetric(
                horizontal: 20.w , vertical: 30.h
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      pageController.jumpToPage(2);
                    }
                    ,
                    child: ReusableText(text: "Skip",
                     style: appStyle(16, Color(kDark.value), FontWeight.w500)),
                  ),

                  GestureDetector(
                    onTap: (){
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300), 
                        curve: Curves.ease
                      );
                    },
                    child: ReusableText(text: "Next",
                     style: appStyle(16, Color(kDark.value), FontWeight.w500)),
                  ),

                ],
              ) ,
              ),
            )
          )

        ],
      );
        }
        )
    );
  }
}
