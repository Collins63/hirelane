import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';


class Subscriptions extends StatefulWidget {
  const Subscriptions({super.key});

  @override
  State<Subscriptions> createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
           child:AppBar(
            centerTitle: true,
          title: Text("Subscribe" , style: appStyle(14, Colors.white, FontWeight.normal),),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Color(kLightBlue.value),
          shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)
                )
              ),
      )),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeightSpacer(size: 20),
                Container(
                  height: height*0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage('lib/assets/card.jpg'),
                      fit: BoxFit.cover
                      )
                    ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          
                          const HeightSpacer(size: 60),
                          Text("Add Subscription For The Best App Experience", textAlign: TextAlign.center,style: appStyle(24, Colors.white, FontWeight.bold),),
                          const HeightSpacer(size: 35),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                  child: Align(
                                    alignment: Alignment.bottomLeft ,
                                    child:ClipRRect(
                                      borderRadius: BorderRadius.circular(50), // Match the container's radius
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.1), // Slight opacity for frosted effect
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          child:const Center(
                                            child: Icon(Icons.question_mark , color: Colors.white,),
                                          ),
                                        ),
                                      ),
                                    )
                                  ),
                              ),
                              //SizedBox(width: 10,),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10), // Match the container's radius
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                                  child: Container(
                                    height: 30,
                                    width: width*0.5,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1), // Slight opacity for frosted effect
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:Center(child: Text("Current Package: Free" ,style: appStyle(12, Colors.white, FontWeight.w500),)),
                                  ),
                                ),
                              ),
                              //const SizedBox(width: 40,),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50), // Match the container's radius
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1), // Slight opacity for frosted effect
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Center(
                                      child: IconButton(onPressed: (){
                                      },
                                       icon:const FaIcon(FontAwesomeIcons.upLong, color: Colors.white ,)
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                  ),
                ),
                const HeightSpacer(size: 20),
                Text("Available Plans" , style: appStyle(16, Colors.black, FontWeight.normal),),
                const HeightSpacer(size: 15),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                color: Color(kLight.value)
                              ),
                              child: const Center(
                                child: FaIcon(FontAwesomeIcons.creditCard , color: kLightBlue,),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(text:"Basic AR Landmark Tour", style: appStyle(12,kDark,FontWeight.w500)),
                                ReusableText(text:"One Location", style: appStyle(12,kDarkGrey,FontWeight.w500)),
                                ReusableText(text:"\$5", style: appStyle(12,kDarkGrey,FontWeight.w500))
                              ],
                            ),
                          )
                        ],
                      ),
                      IconButton(onPressed: (){}, icon:const Icon(Icons.chevron_right_rounded, color: Colors.white,size: 50,))
                    ],
                  ),
                ),
                const HeightSpacer(size: 10),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                color: Color(kLight.value)
                              ),
                              child:const Center(
                                child: FaIcon(FontAwesomeIcons.creditCard , color: kLightBlue,),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(text:"Premium City Tour", style: appStyle(12,kDark,FontWeight.w500)),
                                ReusableText(text:"Multi Location", style: appStyle(12,kDarkGrey,FontWeight.w500)),
                                ReusableText(text:"\$20", style: appStyle(12,kDarkGrey,FontWeight.w500))
                              ],
                            ),
                          )
                        ],
                      ),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.chevron_right_rounded, color: Colors.white,size: 50,))
                    ],
                  ),
                ),
                const HeightSpacer(size: 25),
                Text("Subscriptions" , style: appStyle(16, Colors.black, FontWeight.normal),),
                const HeightSpacer(size: 15),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                color: Color(kLight.value)
                              ),
                              child:const Center(
                                child: FaIcon(FontAwesomeIcons.creditCard , color: kLightBlue),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(text:"Monthly", style: appStyle(12,kDark,FontWeight.w500)),
                                ReusableText(text:"All access", style: appStyle(12,kDarkGrey,FontWeight.w500)),
                                ReusableText(text:"\$10", style: appStyle(12,kDarkGrey,FontWeight.w500))
                              ],
                            ),
                          )
                        ],
                      ),
                      IconButton(onPressed: (){}, icon:const Icon(Icons.chevron_right_rounded, color: Colors.white,size: 50,))
                    ],
                  ),
                ),
                const HeightSpacer(size: 10),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                color: Color(kLight.value)
                              ),
                              child: const Center(
                                child: FaIcon(FontAwesomeIcons.creditCard , color: kLightBlue),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(text:"Annual", style: appStyle(12,kDark,FontWeight.w500)),
                                ReusableText(text:"All access", style: appStyle(12,kDarkGrey,FontWeight.w500)),
                                ReusableText(text:"\$100", style: appStyle(12,kDarkGrey,FontWeight.w500))
                              ],
                            ),
                          )
                        ],
                      ),
                      IconButton(onPressed: (){}, icon:const Icon(Icons.chevron_right_rounded, color: Colors.white,size: 50,))
                    ],
                  ),
                )
              ],
            ),
          )
        ),
      )
    );
  }
}