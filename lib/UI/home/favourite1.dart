import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';


class Favourite1 extends StatefulWidget {
  const Favourite1({super.key});

  @override
  State<Favourite1> createState() => _Favourite1State();
}

class _Favourite1State extends State<Favourite1> {

  void showBottomModal(){
            showModalBottomSheet(
                      isDismissible: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 600,
                          color: Color(kLightGrey.value),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              children: [
                                const HeightSpacer(size:10),
                                Center(
                                  child: Container(
                                      width: 100,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Color(kDark.value),
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: GestureDetector(
                                        onTap: (){
                                          Get.back();
                                        },
                                      ),
                                    ),

                                ),
                                const HeightSpacer(size: 30),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text("Hotels" , style: appStyle(16, Colors.black, FontWeight.w500),),
                                ),
                                const HeightSpacer(size: 20),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(width: 10  ,),
                                      Container(
                                        width: width*0.8,
                                        height: height*0.42,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: width*0.8,
                                              height: height*0.28,
                                              decoration:const BoxDecoration(
                                                image: DecorationImage(image: AssetImage('lib/assets/hotel.jpeg') , fit: BoxFit.cover),
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                                            ),
                                            ),
                                            const HeightSpacer(size: 10),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Color(kLightBlue.value)
                                                    ),
                                                    child: Center(child: Text("40 USD/Night", style: appStyle(14, Colors.white, FontWeight.w500),))),
                                                  IconButton(onPressed:(){}, icon: const Icon(Icons.book))
                                                ],
                                              ),
                                            ),
                                            const HeightSpacer(size: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(Icons.star , color: Colors.yellow,),
                                                Icon(Icons.star , color:  Colors.yellow,),
                                                Icon(Icons.star, color: Colors.yellow,),
                                                Icon(Icons.star, color: Colors.yellow,),
                                                Icon(Icons.star, color: Colors.yellow,)
                                              ],

                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Container(
                                        width: width*0.8,
                                        height: height*0.42,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: width*0.8,
                                              height: height*0.28,
                                              decoration:const BoxDecoration(
                                                image: DecorationImage(image: AssetImage('lib/assets/china.jpg') , fit: BoxFit.cover),
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                                            ),
                                            ),
                                            const HeightSpacer(size: 10),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Color(kLightBlue.value)
                                                    ),
                                                    child: Center(child: Text("40 USD/Night", style: appStyle(14, Colors.white, FontWeight.w500),))),
                                                  IconButton(onPressed:(){}, icon: const Icon(Icons.book))
                                                ],
                                              ),
                                            ),
                                            const HeightSpacer(size: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(Icons.star , color: Colors.yellow,),
                                                Icon(Icons.star , color:  Colors.yellow,),
                                                Icon(Icons.star, color: Colors.yellow,),
                                                Icon(Icons.star, color: Colors.yellow,),
                                                Icon(Icons.star, color: Colors.yellow,)
                                              ],

                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const HeightSpacer(size: 25),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text("Businesses and Restaurants" , style: appStyle(16, Colors.black, FontWeight.w500),),
                                ),
                                const HeightSpacer(size: 15),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(width: 10  ,),
                                      Container(
                                        width: width*0.8,
                                        height: height*0.42,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: width*0.8,
                                              height: height*0.28,
                                              decoration:const BoxDecoration(
                                                image: DecorationImage(image: AssetImage('lib/assets/cbd.jpg') , fit: BoxFit.cover),
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                                            ),
                                            ),
                                            const HeightSpacer(size: 10),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Color(kLightBlue.value)
                                                    ),
                                                    child: Center(child: Text("Business Center", style: appStyle(14, Colors.white, FontWeight.w500),))),
                                                  IconButton(onPressed:(){}, icon: const Icon(Icons.location_on_rounded))
                                                ],
                                              ),
                                            ),
                                            const HeightSpacer(size: 10),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(Icons.star , color: Colors.yellow,),
                                                Icon(Icons.star , color:  Colors.yellow,),
                                                Icon(Icons.star, color: Colors.yellow,),
                                                Icon(Icons.star, color: Colors.yellow,),
                                                Icon(Icons.star, color: Colors.yellow,)
                                              ],

                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Container(
                                        width: width*0.8,
                                        height: height*0.42,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: width*0.8,
                                              height: height*0.28,
                                              decoration:const BoxDecoration(
                                                image: DecorationImage(image: AssetImage('lib/assets/page3.jpg') , fit: BoxFit.cover),
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                                            ),
                                            ),
                                            const HeightSpacer(size: 10),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Color(kLightBlue.value)
                                                    ),
                                                    child: Center(child: Text("VR Center", style: appStyle(14, Colors.white, FontWeight.w500),))),
                                                  IconButton(onPressed:(){}, icon: const Icon(Icons.location_on_rounded))
                                                ],
                                              ),
                                            ),
                                            const HeightSpacer(size: 10),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Icon(Icons.star , color: Colors.yellow,),
                                                  Icon(Icons.star , color:  Colors.yellow,),
                                                  Icon(Icons.star, color: Colors.yellow,),
                                                  Icon(Icons.star, color: Colors.yellow,),
                                                  Icon(Icons.star, color: Colors.yellow,)
                                                ],
                                              
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const HeightSpacer(size: 25)
                              ],
                            ),
                          ),
                        );
                      }
                    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(kLight.value),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('lib/assets/greatWall.jpg') , fit: BoxFit.cover)
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                    borderRadius: BorderRadius.circular(50), // Match the container's radius
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                      child: Container(
                        height: height*0.07,
                        width: width*0.14,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1), // Slight opacity for frosted effect
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: (){
                              Get.back();
                            },
                            icon: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white,)
                          ),
                        ),
                      )
                    )
                    )
                    ,
                    const HeightSpacer(size: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Great Wall Of China" , style: appStyle(18, Colors.white, FontWeight.bold),),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20), // Match the container's radius
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                            child: Container(
                              height: height*0.05,
                              width: width*0.22,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2), // Slight opacity for frosted effect
                                borderRadius: BorderRadius.circular(20),
                                //border: Border.all(width: 1, color: Colors.white)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    const FaIcon(FontAwesomeIcons.personWalking , color: Colors.white,),
                                    const SizedBox(width: 10,),
                                    Text(
                                      '12K',
                                      style: appStyle(16,Colors.white, FontWeight.bold),
                                    ),
                                  ]
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const HeightSpacer(size: 180),
                    
                    Container(
                  height: height*0.48,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10 ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(20), // Match the container's radius
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                                  child: Container(
                                    height: height*0.2,
                                    width: width*0.4,
                                    decoration: BoxDecoration(
                                      color: Colors.white, // Slight opacity for frosted effect
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const HeightSpacer(size: 25),
                                          Container(
                                            decoration:BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              border: Border.all(width: 1 , color: Colors.black)
                                            ),
                                            child: IconButton(onPressed: (){
                                              
                                            },
                                             icon:const FaIcon(FontAwesomeIcons.personWalking, color: Colors.black ,), 
                                            ),
                                          ),
                                          const HeightSpacer(size: 10),
                                          Text("AR Travel Experience" , textAlign: TextAlign.center, style: appStyle(16, Colors.black, FontWeight.w500),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(20), // Match the container's radius
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                                  child: Container(
                                    height: height*0.2,
                                    width: width*0.4,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1 , color: Colors.white),
                                      color: Colors.white.withOpacity(0.1), // Slight opacity for frosted effect
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const HeightSpacer(size: 25),
                                          Container(
                                            decoration:BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              border: Border.all(width: 1 , color: Colors.white)
                                            ),
                                            child: IconButton(onPressed: (){
                                              
                                            },
                                             icon:const FaIcon(FontAwesomeIcons.map, color: Colors.white ,), 
                                            ),
                                          ),
                                          const HeightSpacer(size: 10),
                                          Text("Maps & Route Suggestions" , textAlign: TextAlign.center, style: appStyle(16, Colors.white, FontWeight.w500),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                        const HeightSpacer(size: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(20), // Match the container's radius
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                                  child: Container(
                                    height: height*0.2,
                                    width: width*0.4,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white , width: 1),
                                      color: Colors.white.withOpacity(0.1), // Slight opacity for frosted effect
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const HeightSpacer(size: 25),
                                          Container(
                                            decoration:BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              border: Border.all(width: 1 , color: Colors.white)
                                            ),
                                            child: IconButton(onPressed: (){
                                              
                                            },
                                             icon:const FaIcon(FontAwesomeIcons.hotel, color: Colors.white ,), 
                                            ),
                                          ),
                                          const HeightSpacer(size: 10),
                                          Text("Bookings & Culture Links" , textAlign: TextAlign.center, style: appStyle(16, Colors.white, FontWeight.w500),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(20), // Match the container's radius
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                                  child: Container(
                                    height: height*0.2,
                                    width: width*0.4,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1 , color:  Colors.white),
                                      color: Colors.white.withOpacity(0.1), // Slight opacity for frosted effect
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const HeightSpacer(size: 25),
                                          Container(
                                            decoration:BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              border: Border.all(width: 1 , color: Colors.white)
                                            ),
                                            child: IconButton(onPressed: (){
                                              
                                            },
                                             icon:const FaIcon(FontAwesomeIcons.handshakeAngle, color: Colors.white ,), 
                                            ),
                                          ),
                                          const HeightSpacer(size: 10),
                                          Text("Local Business Support" , textAlign: TextAlign.center, style: appStyle(16, Colors.white, FontWeight.w500),)
                                        ],
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
                GestureDetector(
                  onTap: (){
                    showBottomModal();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Match the container's radius
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                      child: Container(
                        height: height*0.08,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2), // Slight opacity for frosted effect
                          borderRadius: BorderRadius.circular(20),
                          //border: Border.all(width: 1, color: Colors.white)
                        ),
                        child: Center(
                          child: Text(
                            'Places And Views',
                            style: appStyle(16,Colors.white, FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                  ],
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}