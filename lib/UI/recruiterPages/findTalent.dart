import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/circularImageContainer.dart';
import 'package:hirelane/CONSTANTS/custom_outline_btn.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:hirelane/CONSTANTS/width_spacer.dart';
import 'package:hirelane/UI/recruiterPages/recruiterHome.dart';
import 'package:hirelane/services/searchService.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lottie/lottie.dart';

class Findtalent extends StatefulWidget {
  const Findtalent({super.key});

  @override
  State<Findtalent> createState() => _FindTalentState();
}

class _FindTalentState extends State<Findtalent> {

  final Searchservice searchService = Searchservice();
  final jobFormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  List results = [];
  bool isLoading = true;

  void searchUsers() async{
    print("Searching for: ${searchController.text}");
    if(searchController.text.isEmpty) return;
    
    try {
      print("Starting search...");
      final data = await searchService.searchUsers(searchController.text.toString());
      print('Data: $data');
      setState(() {
        results = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
      Get.snackbar(
       "Error Loading" , "Soemthing went wrong, try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        icon: Icon(Icons.error, color: Colors.white,)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white ,
            title: Text("Find Talent" , style: appStyle(14, Colors.grey.shade800, FontWeight.bold),),
            centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10,),
                TextFormField(
                  style: appStyle(14,Colors.grey.shade500, FontWeight.normal),
                  controller: searchController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    fillColor: Colors.white,
                    suffixIcon: IconButton(icon: Icon(Iconsax.box_search, color: Colors.grey.shade500,),onPressed: ()=> searchUsers(),),
                    labelText: "Search by field",
                    labelStyle: appStyle(14, Colors.grey.shade500, FontWeight.normal),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                isLoading ?
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Image(image: AssetImage("assets/findTalent.jpg")),
                              const  SizedBox(height: 1,),
                              ReusableText(text: "Get talent 3x faster", style: appStyle(16, Colors.grey,FontWeight.w500))
                            ],
                          )
                        ),
                      ),
                    ):
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: results.isEmpty ? Center(child: ReusableText(text: "No results found", style: appStyle(16, Colors.grey, FontWeight.w500),)) :
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: results.length,
                            itemBuilder: (context, index){
                              final user = results[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, ),
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  child:Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                color: Colors.white
                                              ),
                                              child: Icon(Iconsax.user, color: Colors.grey,),
                                            ),
                                            const SizedBox(width: 10,),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                ReusableText(text: user['fullname'] ?? "No Name", style: appStyle(16,Colors.grey.shade500, FontWeight.w500)),
                                                const SizedBox(height: 5,),
                                                ReusableText(text: user['profession'] ?? "No Profession", style: appStyle(14, Colors.grey.shade500, FontWeight.normal))
                                              ],
                                            )
                                          ],
                                        ),
                                        IconButton(icon: Icon(Iconsax.folder_open, color: Colors.grey.shade500,), onPressed: (){
                                          List<String> skills = [];
                                          // 1. Check if the value exists and is an Iterable
                                          if (user['skills'] is Iterable) {
                                            // 2. Map each element to a String and convert the result to a List<String>
                                            skills = (user['skills'] as Iterable)
                                                .map((skill) => skill.toString())
                                                .toList();
                                          } else {
                                            // Handle the case where 'skills' is missing or not an iterable
                                            print('Error: "skills" field is missing or not a list.');
                                          }
                                          print(skills);
                                          showModalBottomSheet(
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (context){
                                              return Container(
                                                height: MediaQuery.of(context).size.height * 0.9,
                                                width: MediaQuery.of(context).size.width,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(20.0),
                                                    topRight: Radius.circular(20.0)
                                                  ),
                                                  color: Colors.white
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                    top: 16.0,
                                                    bottom: MediaQuery.of(context).viewInsets.bottom
                                                  ),
                                                  child: SingleChildScrollView(
                                                    scrollDirection: Axis.vertical,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          height: 80,
                                                          width: 80,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(50),
                                                            color: Colors.red,
                                                          ),
                                                          child: CircleAvatar(
                                                            radius: 75,
                                                            backgroundImage: AssetImage('assets/pageThreeWallpaper.jpg'),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 10,),
                                                        ReusableText(text: user['fullname'] ?? "Not Specified", style: appStyle(16,Colors.grey, FontWeight.bold)),
                                                        const SizedBox(height: 10,),
                                                        ReusableText(text: user['profession'] ?? "Not Specified", style: appStyle(16,Colors.grey, FontWeight.w500)),
                                                        const SizedBox(height: 20,),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              height: 100,
                                                              width: 120,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(20),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors.black.withOpacity(0.2),
                                                                    blurRadius: 4,
                                                                    spreadRadius: 2,
                                                                    offset: Offset(2,0)
                                                                  )
                                                                ]
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  ReusableText(text: "Jobs", style: appStyle(16, Colors.grey , FontWeight.bold)),
                                                                  Icon(Iconsax.brifecase_tick, color: Colors.black,),
                                                                  ReusableText(text: "100", style: appStyle(14, Colors.grey , FontWeight.w500)),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 100,
                                                              width: 120,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(20),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors.black.withOpacity(0.2),
                                                                    blurRadius: 4,
                                                                    spreadRadius: 2,
                                                                    offset: Offset(2,0)
                                                                  )
                                                                ]
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  ReusableText(text: "Rate", style: appStyle(16, Colors.grey , FontWeight.bold)),
                                                                  Icon(Iconsax.menu_board, color: Colors.black,),
                                                                  ReusableText(text: "0.9", style: appStyle(14, Colors.grey , FontWeight.w500)),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 100,
                                                              width: 120,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(20),
                                                                color: Colors.white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors.black.withOpacity(0.2),
                                                                    blurRadius: 4,
                                                                    spreadRadius: 2,
                                                                    offset: Offset(2,0)
                                                                  )
                                                                ]
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  ReusableText(text: "Likes", style: appStyle(16, Colors.grey , FontWeight.bold)),
                                                                  Icon(Iconsax.heart, color: Colors.black,),
                                                                  ReusableText(text: "100", style: appStyle(14, Colors.grey, FontWeight.w500)),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(height: 20,),
                                                        Stack(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                                              child: Container(
                                                                height: 220,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.lightBlueAccent,
                                                                  borderRadius: BorderRadius.circular(10.0)
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 15),
                                                              child: Container(
                                                                height: 210,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.blueAccent.shade400,
                                                                  borderRadius: BorderRadius.circular(10.0)
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 200,
                                                              decoration: BoxDecoration(
                                                                color: Colors.blueAccent,
                                                                borderRadius: BorderRadius.circular(10.0)
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(20),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        Flexible(
                                                                          child: Divider(
                                                                            color: Colors.white,
                                                                            thickness: 0.5,
                                                                            indent: 60,
                                                                            endIndent: 5,
                                                                          )
                                                                        ),
                                                                        Text("Skill set", style: appStyle(14, Colors.white, FontWeight.normal),),
                                                                        Flexible(
                                                                          child: Divider(
                                                                            color: Colors.white,
                                                                            thickness: 0.5,
                                                                            indent: 5,
                                                                            endIndent: 60,
                                                                          )
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const HeightSpacer(size: 10),
                                                                    Container(
                                                                      width: MediaQuery.of(context).size.width,
                                                                      height: 150,
                                                                      color: Colors.transparent,
                                                                      child: ListView.builder(
                                                                        itemCount: skills.length ,
                                                                        scrollDirection: Axis.vertical,
                                                                        itemBuilder: (context , index){
                                                                          final skill = skills[index];
                                                                          return Row(
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: [
                                                                              Icon(Iconsax.direct_right , color: Colors.white,),
                                                                              ReusableText(text: skill, style: appStyle(10, Colors.white, FontWeight.w500))
                                                                            ],
                                                                          );
                                                                        }
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                      
                                                          ],
                                                        ),
                                                        const SizedBox(height: 20,),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            ReusableText(text: "What people say about ", style: appStyle(22, Colors.grey.shade400, FontWeight.w500)),
                                                            ReusableText(text: "Collins", style: appStyle(18, Colors.black, FontWeight.bold)),
                                                          ],
                                                        ),
                                                        const SizedBox(height: 20,),
                                                        Container(
                                                          width: MediaQuery.of(context).size.width,
                                                          decoration: 
                                                            BoxDecoration(
                                                              color: Colors.grey.shade200,
                                                              borderRadius: BorderRadius.circular(10)
                                                            ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(15.0),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    Circularimagecontainer(img: 'assets/pageThreeWallpaper.jpg'),
                                                                    const SizedBox(width: 5,),
                                                                    Column(
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        ReusableText(text: "Collins Chimbganda", style: appStyle(16, Colors.grey.shade700, FontWeight.w500)),
                                                                        ReusableText(text: "Xeres Technologies", style: appStyle(14, Colors.grey, FontWeight.normal))
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                                const HeightSpacer(size: 10),
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: SingleChildScrollView(child: Column(
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        ReusableText(text: "Hard worker who is passionate about his code and workflows Hard worker who is passionate about his code and workflows", style:appStyle(12,Colors.grey, FontWeight.normal)),
                                                                      ],
                                                                    )),
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                                const HeightSpacer(size: 10),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    Icon(Iconsax.star_1, color: Colors.amber,),
                                                                    Icon(Iconsax.star_1, color: Colors.amber,),
                                                                    Icon(Iconsax.star_1, color: Colors.amber,),
                                                                    Icon(Iconsax.star_1, color: Colors.amber,),
                                                                    Icon(Iconsax.star_1, color: Colors.amber,),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 20,),
                                                        CustomOutlineBtn(
                                                          text: "Hire",
                                                          color: Colors.white,
                                                          color2: Colors.blueAccent,
                                                          height: 40,
                                                          onTap: (){
                      
                                                          },
                                                        ),
                                                        const HeightSpacer(size: 10)
                                                      ],
                                                    )
                                                  ),
                                                ),
                                              );
                                            }
                                          );
                                        },),
                                      ],
                                    )
                                  )
                                ),
                              );
                            }
                          ),
                      ),
                    )
              ],
            ),
        ),
      );
  }
}