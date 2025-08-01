import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hirelane/CONSTANTS/app_bar.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/custom_button_round.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';


class InfoArExperience extends StatelessWidget {
  const InfoArExperience({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:const PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: CustomAppBar(text: "Ar", child: SizedBox() ,)
      ),
      body: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    Get.back();
                  }, icon: const Icon(Icons.chevron_left , color: Colors.black,) ,style: IconButton.styleFrom(backgroundColor: Colors.grey.shade200),
                  ),
                  IconButton(onPressed: (){
                    Get.back();
                  }, icon:const  Icon(CupertinoIcons.cloud_download_fill , color: Colors.black,) ,style: IconButton.styleFrom(backgroundColor: Colors.grey.shade200),
                  )
                ],
              ),
              const HeightSpacer(size: 10),
              ReusableText(text: "Get Insights", style: appStyle(14, Colors.black, FontWeight.normal)),
              const HeightSpacer(size: 10),
              Text("AR Travel Experience",style: appStyle(22, Colors.black, FontWeight.w500)),
              const HeightSpacer(size: 10),
              Container(
                height: height*0.3,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image:AssetImage('lib/assets/arPhone.PNG'),
                    fit: BoxFit.fill
                  )
                ),
              ),
              const HeightSpacer(size: 10),
              ReusableText( text:"Brings you augmented reality experience for numerous" , style: appStyle(12, kDark, FontWeight.normal),),
              ReusableText( text:"locations around the globe. Get live interactions with" , style: appStyle(12, kDark, FontWeight.normal),),
              ReusableText( text:"your current location and get the best way to navigate" , style: appStyle(12, kDark, FontWeight.normal),),
              const HeightSpacer(size: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 30, ),
                    height: 60,
                    width: width*0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey.shade200
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: (){},
                          icon: Icon(Icons.timer , color: Colors.black,),style: IconButton.styleFrom(backgroundColor: Colors.white),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const HeightSpacer(size: 7),
                            ReusableText(text: "Duration", style: appStyle(14, kDark,FontWeight.bold)),
                            ReusableText(text: "From 1min", style: appStyle(14, kDarkGrey,FontWeight.normal))
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 30, ),
                    height: 60,
                    width: width*0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey.shade200
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: (){},
                          icon: Icon(Icons.people, color: Colors.black,),style: IconButton.styleFrom(backgroundColor: Colors.white),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const HeightSpacer(size: 7),
                            ReusableText(text: "Size", style: appStyle(14, kDark,FontWeight.bold)),
                            ReusableText(text: "1 Gadget", style: appStyle(14, kDarkGrey,FontWeight.normal))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              const HeightSpacer(size: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReusableText(text: "From ", style: appStyle(14, Colors.grey.shade600, FontWeight.normal)),
                  ReusableText(text: "\$5.00", style: appStyle(30, kDark, FontWeight.bold)),
                  ReusableText(text: " Per Tour", style: appStyle(14, Colors.grey.shade600, FontWeight.normal)),
                ],
              ),
              CustomOutlineBtnRound(
                text: "Try It Out",
                color: Color(kLight.value),
                color2: Color(kLightBlue.value),
                height: 50,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shadowColor: Colors.black,
        color: Colors.white,
        child: Container(
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomOutlineBtnRound(
                text: "Preview",
                color: Colors.white,
                color2: kLightBlue,
                width: width*0.43,
              ),
              CustomOutlineBtnRound(
                text: "Enquire More",
                color: kLightBlue,
                color2: Colors.white,
                width: width*0.43,
              )
            ],
          ),
        ),
      ),
    );
  }
}