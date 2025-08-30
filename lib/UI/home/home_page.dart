import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:hirelane/UI/forms/job.dart';
import 'package:hirelane/UI/profile/profile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  String? username;
  List<Map<String, dynamic>> jobsFromDB = [];
  

  
  @override
  void initState() {
    super.initState();
    getUserData();
    getJobs();
    // Initialize any necessary data or state here
  }

Future<void> getJobs() async {
    final prefs = await SharedPreferences.getInstance();
    //final token = prefs.getString('auth_token');

    final response = await http.get(
      Uri.parse("http://192.168.110.231:5002/api/jobs/"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final jobs = jsonDecode(response.body);
      print("Jobs fetched successfully: $jobs");
      setState(() {
        jobsFromDB = List<Map<String, dynamic>>.from(jobs) ;
      });
    } else {
      print("Unauthorized or failed: ${response.body}");
      Get.snackbar(
        "Profile Fetch Failed",
        "${response.body}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void getUserData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? "Guests";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children:[
        SingleChildScrollView(
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpacer(size: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Match the container's radius
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                      child: Container(
                        height: height*0.25,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent, // Slight opacity for frosted effect
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              HeightSpacer(size: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Align(
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: Color(kLightGrey.value),
                                        borderRadius: BorderRadius.circular(50),
                                        image: const DecorationImage(
                                          image: AssetImage('assets/lightLogo.png'),
                                          fit: BoxFit.cover
                                        )
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ReusableText(text: username.toString(), style: appStyle(16, Colors.white, FontWeight.w500)),
                                      ReusableText(text: "Your next job awaits", style: appStyle(12, Colors.white, FontWeight.w500))
                                    ],
                                  )
                                ],
                              ),
                              const HeightSpacer(size: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(width: 1 , color: Colors.white)
                                      ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                        child: TextFormField(
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: 'Find your next job',
                                            suffixIcon:Icon(CupertinoIcons.search_circle, color: Color(kDark.value)),
                                            hintStyle: appStyle(14, Color(kDark.value), FontWeight.w500),
                                            focusedBorder: const OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(color: Colors.transparent , width: 0.5)
                                            ),
                                            enabledBorder: const OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(color: Colors.transparent , width: 0.5)
                                            ),
                                            border: InputBorder.none
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20,),
                                  IconButton(onPressed: (){}, icon: const Icon(Icons.list ,color: Colors.black,), style: IconButton.styleFrom(backgroundColor: Colors.white), )     
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const HeightSpacer(size: 20),
                  Text('Quick Actions' , style: appStyle(16 , Colors.black, FontWeight.w500),),
                  const HeightSpacer(size: 10),
                  Container(
                    height: height*0.12,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade300
                    ),
                    child: 
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20), // Match the container's radius
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), // Adjust blur intensity
                            child: Container(
                              height: height*0.12,
                              //width: width*0.4,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1 , color: Colors.white),
                                color: Colors.white.withOpacity(0.1), // Slight opacity for frosted effect
                                borderRadius: BorderRadius.circular(20),
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: height*0.09,
                                        width: width*0.2,
                                        decoration:BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(width: 1 , color: Color(kLight.value)),
                                          color: Color(kLight.value)
                                        ),
                                        child: IconButton(onPressed: (){
                                          //Get.to(()=> const MapPage());
                                        },
                                        icon:FaIcon(FontAwesomeIcons.map, color:Color(kLightBlue.value),), 
                                        ),
                                      ),
                                      Container(
                                        height: height*0.09,
                                        width: width*0.2,
                                        decoration:BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(width: 1 ,color: Color(kLight.value)),
                                          color: Color(kLight.value)
                                        ),
                                        child: IconButton(onPressed: (){
                                          //Get.to(()=> Translator());
                                        },
                                                icon:FaIcon(FontAwesomeIcons.language, color:Color(kLightBlue.value)), 
                                              ),
                                      ),
                                      Container(
                                        height: height*0.09,
                                        width: width*0.2,
                                        decoration:BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(width: 1 , color: Color(kLight.value)),
                                          color: Color(kLight.value)
                                        ),
                                        child: IconButton(onPressed: (){},
                                                icon: FaIcon(FontAwesomeIcons.bookmark, color: Color(kLightBlue.value) ,), 
                                              ),
                                      ),
                                      Container(
                                        height: height*0.09,
                                        width: width*0.2,
                                        decoration:BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(width: 1 , color: Color(kLight.value)),
                                          color: Color(kLight.value)
                                        ),
                                        child: IconButton(onPressed: (){
                                          //Get.to(()=> const Subscriptions());
                                        },
                                          icon:FaIcon(FontAwesomeIcons.creditCard, color: Color(kLightBlue.value)  ,), 
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              
                            ),
                          ),
                      ),
                  ),
                  const HeightSpacer(size: 10),
                  Text('Recent Jobs' , style: appStyle(16 , Colors.black, FontWeight.w500),),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Match the container's radius
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                      child: Container(
                        height: height*0.38,
                        width: width,
                        decoration: BoxDecoration(
                          color: Color(kLightGrey.value), // Slight opacity for frosted effect
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            itemCount: jobsFromDB.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final job = jobsFromDB[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                    height: height*0.01,
                                    width: width*0.9,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(image: AssetImage('assets/pageThreeWallpaper.jpg') ,fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        HeightSpacer(size: 10),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only( bottom: 4 , left: 4),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20), // Match the container's radius
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                                                child: Container(
                                                  height: height*0.05,
                                                  width: width*0.5,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white.withOpacity(0.2), // Slight opacity for frosted effect
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          const Icon(Icons.location_on , color: Colors.white, size: 20,),
                                                          Center(child: Text(job['location'] , textAlign: TextAlign.left, style: appStyle(14, Colors.white, FontWeight.w500),)),
                                                        ],
                                                      ),                                      
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        HeightSpacer(size: 20),
                                        //Text("hEllo ", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only( bottom: 4 , left: 4),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20), // Match the container's radius
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                                                child: Container(
                                                  height: height*0.12,
                                                  width: width*0.5,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white.withOpacity(0.2), // Slight opacity for frosted effect
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child:
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                                      child: Center(
                                                        child: Text(job['title'] , textAlign: TextAlign.left, style: appStyle(14, Colors.white, FontWeight.w500),),
                                                      ),
                                                    )                                      
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        HeightSpacer(size: 19),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only( bottom: 4 , left: 4),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20), // Match the container's radius
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                                                child: Container(
                                                  height: height*0.07,
                                                  width: width*0.88,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white.withOpacity(0.2), // Slight opacity for frosted effect
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          SizedBox(width: 35,),
                                                          Align(alignment: Alignment.center, child: Text("See Job" , textAlign: TextAlign.left, style: appStyle(14, Colors.white, FontWeight.w500),)),
                                                          IconButton.filled(onPressed: (){Get.to(()=> Job(jobId: job['_id'] ,));},color: Colors.black, icon: const Icon(Icons.chevron_right ), style: IconButton.styleFrom(backgroundColor: Colors.white),)
                                                        ],
                                                      ),
                                                    ),
                                    
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              );
                            },

                          ),
                        ),
                      ),
                    ),
                  ),
                  const HeightSpacer(size: 20),
                  Text('Top Recruiters' , style: appStyle(16 , Colors.black, FontWeight.w500),),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Match the container's radius
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                      child: Container(
                        height: height*0.1,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400, // Slight opacity for frosted effect
                          borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50), // Match the container's radius
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                                child: Container(
                                  height: height*0.07,
                                  width: width*0.14,
                                  decoration: BoxDecoration(
                                    color: Colors.white, // Slight opacity for frosted effect
                                    borderRadius: BorderRadius.circular(50),
                                    image: const DecorationImage(image: AssetImage('assets/light_Logo.png') ,scale: 10)
                                  ),
                            ))),
                            const SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeightSpacer(size: 10),
                                Text('Temple Of Heaven' , style: appStyle(18, Colors.white, FontWeight.bold), ),
                                Text('Tiyugaun,China', style: appStyle(14, Color(kLight.value), FontWeight.w500),)
                              ],
                            ),
                            SizedBox(width: 49,),
                            IconButton(
                              onPressed: (){
                                //Get.to(()=> const Favourite1());
                              },
                              icon: const FaIcon(FontAwesomeIcons.arrowRight , color: Colors.white,)
                            ) ,
                            
                          ],
                        ),
                      ),
                  )
                    )
                  ),
                const HeightSpacer(size: 10),
                ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Match the container's radius
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                      child: Container(
                        height: height*0.1,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400, // Slight opacity for frosted effect
                          borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50), // Match the container's radius
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust blur intensity
                                child: Container(
                                  height: height*0.07,
                                  width: width*0.14,
                                  decoration: BoxDecoration(
                                    color: Colors.white, // Slight opacity for frosted effect
                                    borderRadius: BorderRadius.circular(50),
                                    image: const DecorationImage(image: AssetImage('assets/light_Logo.png') ,scale: 10)
                                  ),
                            ))),
                            const SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeightSpacer(size: 10),
                                Text('Great Wall of China' , style: appStyle(18, Colors.white, FontWeight.bold), ),
                                Text('China, Asia', style: appStyle(14, Color(kLight.value), FontWeight.w500),)
                              ],
                            ),
                            SizedBox(width: 39,),
                            IconButton(
                              onPressed: (){},
                              icon: const FaIcon(FontAwesomeIcons.arrowRight , color: Colors.white,)
                            ) ,
                          ],
                        ),
                      ),
                  )
                    )
                  ),
                const HeightSpacer(size: 10),
                ],
              ),
            )  
          ),
        ),

        ]
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        shape: CircleBorder(),
        onPressed: (){

        },
        child: Icon(Icons.work, color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.white,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(onPressed: (){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => HomePage()));
            }, icon: Icon(CupertinoIcons.home)),
            IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.doc_plaintext)),
            SizedBox(width: 40,),
            IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.captions_bubble)),
            IconButton(onPressed: (){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MyProfile()));
            }, icon: Icon(CupertinoIcons.person))
          ],
        )
      ),
      
    );
  }
}