import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/custom_outline_btn.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:hirelane/UI/auth/login_page.dart';
import 'package:hirelane/UI/home/home_page.dart';
import 'package:hirelane/UI/recruiterPages/findTalent.dart';
import 'package:hirelane/UI/recruiterPages/inTransit.dart';
import 'package:hirelane/UI/recruiterPages/recruiterJobs.dart';
import 'package:hirelane/constants/app_constants.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart';

class RecruiterHome extends StatefulWidget {
  const RecruiterHome({super.key});

  @override
  State<RecruiterHome> createState() => _RecruiterHomeState();
}

class _RecruiterHomeState extends State<RecruiterHome> {
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
        body: Padding(padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
                const SizedBox(height: 20,),
                Text("Hiring Made" , style: appStyle(40, Colors.white, FontWeight.w500),),
                Text("Easier" , style: appStyle(40, Colors.white, FontWeight.w500),),
                const SizedBox(height: 20,),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Find talent" , style: appStyle(16, Colors.grey, FontWeight.w500),),
                                //Icon(CupertinoIcons.right_chevron , color: Colors.grey,)
                                CustomOutlineBtn(
                                  text: "Search",
                                  color: Colors.white,
                                  color2: Colors.blueAccent,
                                  height: 40,
                                  width: 100,
                                  onTap: (){
                                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Findtalent()));
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width*0.47,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.briefcase, color: Colors.white,size: 30,),
                          const SizedBox(height: 10,),
                          Text("1000" , style: appStyle(16, Colors.white, FontWeight.w500),),
                        ],
                      ),
                    ),
                    Container(
                      width: width*0.47,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.person, color: Colors.white,size: 30,),
                          const SizedBox(height: 10,),
                          Text("500" , style: appStyle(16, Colors.white, FontWeight.w500),),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage("assets/pageThreeWallpaper.jpg"),
                      fit: BoxFit.cover,
                      opacity: 0.5
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(alignment: Alignment.center,child: ReusableText(text: "Your recruitment gateway", style: appStyle(16,Colors.white,FontWeight.w500))),
                        ReusableText(text: "Fast", style: appStyle(18,Colors.white,FontWeight.bold)),
                        ReusableText(text: "Simple", style: appStyle(18,Colors.white,FontWeight.bold)),
                        ReusableText(text: "Efficient", style: appStyle(18,Colors.white,FontWeight.bold)),
                        const HeightSpacer(size: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(text: "Get Started Now", style: appStyle(12, Colors.white, FontWeight.normal)),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(50)
                              ),
                              child: Icon(Iconsax.alarm, color: Colors.white,),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const HeightSpacer(size: 10),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 370,
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 360,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    Container(
                      height: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Lottie.asset('assets/Animation - 1736431085384.json', height: 150),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 80,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: IconButton(onPressed: (){
                                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Intransit()));
                                  }, icon: Icon(Iconsax.airplane, color: Colors.white,)),
                                ),
                                Container(
                                  height: 80,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.bin_xmark, color: Colors.white,)),
                                ),
                                Container(
                                  height: 80,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.doc_on_doc, color: Colors.white,)),
                                ),
                                Container(
                                  height: 80,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.idCard, color: Colors.white,)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
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
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> LoginPage()));
              }, icon: Icon(CupertinoIcons.person))
            ],
          )
        ),
      ),
    );
  }
}