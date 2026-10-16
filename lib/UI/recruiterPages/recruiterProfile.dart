import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/circularImageContainer.dart';
import 'package:hirelane/CONSTANTS/heading_widget.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:hirelane/CONSTANTS/width_spacer.dart';
import 'package:hirelane/UI/auth/login_page.dart';
import 'package:hirelane/UI/recruiterPages/depositFunds.dart';
import 'package:hirelane/UI/recruiterPages/recruiterHome.dart';
import 'package:hirelane/UI/recruiterPages/recruiterJobs.dart';
import 'package:hirelane/UI/recruiterPages/recruiterProfileData.dart';
import 'package:hirelane/UI/recruiterPages/recruiterSecurity.dart';
import 'package:hirelane/UI/recruiterPages/recruiterSettings.dart';
import 'package:hirelane/UI/recruiterPages/transactionHistory.dart';
import 'package:hirelane/UI/recruiterPages/transaferFunds.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Recruiterprofile extends StatefulWidget {
  const Recruiterprofile({super.key});

  @override
  State<Recruiterprofile> createState() => _RecruiterprofileState();
}

class _RecruiterprofileState extends State<Recruiterprofile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 2, 38, 68), Color.fromARGB(255, 11, 106, 144)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const HeightSpacer(size: 20),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 170,
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Circularimagecontainer(img: "assets/pageThreeWallpaper.jpg"),
                                    const WidthSpacer(size: 5),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ReusableText(text: "Xeres Technologies", style:appStyle(14,Colors.grey, FontWeight.bold)),
                                        ReusableText(text: "Chegutu Zimbabwe", style:appStyle(12,Colors.grey, FontWeight.normal)),
                                        ReusableText(text: "Saas Provider", style:appStyle(12,Colors.grey, FontWeight.normal)),
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent.shade100,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: IconButton(
                                    onPressed: (){

                                    },
                                    icon: Icon(Iconsax.user_edit, color: Colors.white,)
                                  ),
                                )
                              ],
                            ),
                      ),
                    )
                  ],
                ),
                const HeightSpacer(size: 10),
                HeadingWidget(headingText: "Account Balances", color: Colors.grey.shade800, textColor: Colors.grey.shade800,),
                const HeightSpacer(size: 20),
                Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Center(
                    child: ReusableText(text: "\$200", style: appStyle(18,Colors.grey,FontWeight.bold)),
                  ),
                ),
                const HeightSpacer(size: 20),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white30
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(text: "Upload funds", style: appStyle(12, Colors.white,FontWeight.normal)),
                        IconButton(
                          onPressed: (){
                            Get.to(()=> Depositfunds());
                          },
                          icon: Icon(Iconsax.direct_right, color: Colors.white,)
                        )
                      ],
                    ),
                  ),
                ),
                const HeightSpacer(size: 10),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white30
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(text: "Transfer funds", style: appStyle(12, Colors.white,FontWeight.normal)),
                        IconButton(
                          onPressed: (){
                            Get.to(()=> Transaferfunds());
                          },
                          icon: Icon(Iconsax.direct_right, color: Colors.white,)
                        )
                      ],
                    ),
                  ),
                ),
                const HeightSpacer(size: 10),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white30
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(text: "Transaction history", style: appStyle(12, Colors.white,FontWeight.normal)),
                        IconButton(
                          onPressed: (){
                            Get.to(()=> Transactionhistory());
                          },
                          icon: Icon(Iconsax.direct_right, color: Colors.white,)
                        )
                      ],
                    ),
                  ),
                ),
                const HeightSpacer(size: 30),
                HeadingWidget(headingText: "Profile settings", color: Colors.grey.shade800,textColor: Colors.grey.shade800,),
                const HeightSpacer(size: 10),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white30
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(text: "Profile data", style: appStyle(12, Colors.white,FontWeight.normal)),
                        IconButton(
                          onPressed: (){
                            Get.to(()=> Recruiterprofiledata());
                          },
                          icon: Icon(Iconsax.direct_right, color: Colors.white,)
                        )
                      ],
                    ),
                  ),
                ),
                const HeightSpacer(size: 10),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white30
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(text: "Security", style: appStyle(12, Colors.white,FontWeight.normal)),
                        IconButton(
                          onPressed: (){
                            Get.to(()=> Recruitersecurity());
                          },
                          icon: Icon(Iconsax.direct_right, color: Colors.white,)
                        )
                      ],
                    ),
                  ),
                ),
                const HeightSpacer(size: 10),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white30
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(text: "Settings", style: appStyle(12, Colors.white,FontWeight.normal)),
                        IconButton(
                          onPressed: (){
                            Get.to(()=> Recruitersettings());
                          },
                          icon: Icon(Iconsax.direct_right, color: Colors.white,)
                        )
                      ],
                    ),
                  ),
                ),
                const HeightSpacer(size: 10),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(text: "LogOut", style: appStyle(16, Colors.grey, FontWeight.w500)),
                        IconButton(
                          onPressed: (){
                            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> LoginPage()));
                          },
                          icon: Icon(
                            Iconsax.logout,
                            color: Colors.grey,
                          )
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          shape: CircleBorder(),
          onPressed: (){
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => RecruiterJobs()));
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
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => RecruiterHome()));
              }, icon: Icon(CupertinoIcons.home)),
              IconButton(onPressed: (){
                
              }, icon: Icon(CupertinoIcons.doc_plaintext)),
              SizedBox(width: 40,),
              IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.captions_bubble)),
              IconButton(onPressed: (){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> Recruiterprofile()));
              }, icon: Icon(CupertinoIcons.person))
            ],
          )
        ),
      ),
    );
  }
}