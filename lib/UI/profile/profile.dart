import 'dart:ffi';
import 'dart:typed_data';
import 'dart:ui';
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/imagePicker.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:hirelane/UI/auth/login_page.dart';
import 'package:hirelane/UI/home/home_page.dart';
import 'package:hirelane/UI/workerPages/workerSecurity.dart';
import 'package:hirelane/UI/workerPages/workerSettings.dart';
import 'package:hirelane/UI/workerPages/workerSkills.dart';
import 'package:hirelane/constants/app_constants.dart';
import 'package:hirelane/services/helpers/imageUploadFirebase.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  @override
  void initState() {
    super.initState();
    getUserImageLink();
  }

  Uint8List? _image;
  String? firebaseImageLink;

  void selectImage() async{
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
    saveProfile();
  }

  Future<void> saveProfile() async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String firebaseId = prefs.getString('firebase_id')!;
      String email = prefs.getString('user_email')!;
      print('$email');
      String resp = await Imageuploadfirebase().saveData(firebaseId: firebaseId, email: email, file: _image!);
      print('response is $resp');
      Get.snackbar("Succes", "Image uploaded", 
        backgroundColor: Colors.green, 
        colorText: Colors.white,
        icon: Icon(Icons.check, color: Colors.white,)
      );
    } catch (e) {
      Get.snackbar("Error uploading image", "$e", 
        backgroundColor: Colors.red, 
        colorText: Colors.white,
        icon: Icon(Icons.error, color: Colors.white,)
      );
    }
  }

  Future<void> getUserImageLink() async {
    final prefs = await SharedPreferences.getInstance();
    final String? firebaseId = prefs.getString('firebase_id');

    if (firebaseId == null) {
      print("No firebaseId found in SharedPreferences");
    }

    try {
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection('userProfile') // your collection name
          .where('firebaseId', isEqualTo: firebaseId)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        String imageLink = query.docs.first['imageLink'];
        print("Image link: $imageLink");
        setState(() {
          firebaseImageLink = imageLink;
        });
      } else {
        print("User document not found");
      }
    } catch (e) {
      print("Error fetching image link: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
      return Scaffold(
         backgroundColor: Colors.grey.shade300,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 75,
                                width: 75,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80.0),
                                  color: Colors.grey.shade200,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Center(
                                    child: _image != null ? CircleAvatar(
                                      radius: 150,
                                      backgroundImage: MemoryImage(_image!),
                                    ) : firebaseImageLink != null ?  
                                    CircleAvatar(
                                      radius: 150,
                                      backgroundImage: NetworkImage('$firebaseImageLink'),
                                    ) :
                                    CircleAvatar(
                                      radius: 150,
                                      backgroundImage:AssetImage("assets/userIcon.png"),
                                    ),
                                  ),
                                ),),
                                const SizedBox(width: 10,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Collins Chimbganda" , style: appStyle(14, Colors.grey.shade800, FontWeight.w500),),
                                    Text("collinsKurai@gmail.com" , style: appStyle(12, Colors.grey.shade500, FontWeight.w500),)
                                  ],
                                )
                            ],
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: IconButton(onPressed: ()async{
                              selectImage();
                            }, icon: Icon(CupertinoIcons.person, color: Colors.white,)),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Iconsax.call_copy, color: Colors.grey.shade500,),
                              const SizedBox(width: 10,),
                              Text("0771472798" , style: appStyle(12, Colors.grey.shade500, FontWeight.w500),),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Iconsax.location_copy, color: Colors.grey.shade500,),
                              const SizedBox(width: 10,),
                              Text("Masvingo" , style: appStyle(12, Colors.grey.shade500, FontWeight.w500),),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(CupertinoIcons.briefcase, color: Colors.grey.shade500,),
                              const SizedBox(width: 10,),
                              Text("Programmer" , style: appStyle(12, Colors.grey.shade500, FontWeight.w500),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)
                    ) ,
                    child: 
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Iconsax.document_code_copy , color: Colors.grey.shade500,),
                                  const SizedBox(width: 10,),
                                  ReusableText(text: "My files", style: appStyle(12, Colors.grey.shade500,FontWeight.normal))
                                ],
                              ),
                              IconButton(
                                onPressed: (){
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      transitionDuration: const Duration(milliseconds: 800),
                                      pageBuilder: (context , animation, secondaryAnimation) => Workerskills(),
                                      transitionsBuilder: (context, animation , secondaryAnimation, child){
                                        return SharedAxisTransition(
                                          animation: animation,
                                          secondaryAnimation: secondaryAnimation,
                                          transitionType: SharedAxisTransitionType.horizontal,
                                          child: child,
                                        );
                                      }
                                    )
                                  );
                                },
                                icon: Icon(Iconsax.direct_right_copy, color: Colors.grey,)
                              )
                            ],
                          ),
                          HeightSpacer(size: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Iconsax.star_copy , color: Colors.grey.shade500,),
                                  const SizedBox(width: 10,),
                                  ReusableText(text: "Skills", style: appStyle(12, Colors.grey.shade500,FontWeight.normal))
                                ],
                              ),
                              IconButton(
                                onPressed: (){
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      transitionDuration: const Duration(milliseconds: 800),
                                      pageBuilder: (context , animation, secondaryAnimation) => Workerskills(),
                                      transitionsBuilder: (context, animation , secondaryAnimation, child){
                                        return SharedAxisTransition(
                                          animation: animation,
                                          secondaryAnimation: secondaryAnimation,
                                          transitionType: SharedAxisTransitionType.horizontal,
                                          child: child,
                                        );
                                      }
                                    )
                                  );
                                },
                                icon: Icon(Iconsax.direct_right_copy, color: Colors.grey,)
                              )
                            ],
                          ),
                          HeightSpacer(size: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Iconsax.document_1_copy , color: Colors.grey.shade500,),
                                  const SizedBox(width: 10,),
                                  ReusableText(text: "Work History", style: appStyle(12, Colors.grey.shade500,FontWeight.normal))
                                ],
                              ),
                              IconButton(
                                onPressed: (){
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> LoginPage()));
                                },
                                icon: Icon(Iconsax.direct_right_copy, color: Colors.grey,)
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)
                    ) ,
                    child: 
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Iconsax.lock_copy , color: Colors.grey.shade500,),
                                  const SizedBox(width: 10,),
                                  ReusableText(text: "Security", style: appStyle(12, Colors.grey.shade500,FontWeight.normal))
                                ],
                              ),
                              IconButton(
                                onPressed: (){
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> LoginPage()));
                                },
                                icon: Icon(Iconsax.direct_right_copy, color: Colors.grey,)
                              )
                            ],
                          ),
                          HeightSpacer(size: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Iconsax.settings_copy , color: Colors.grey.shade500,),
                                  const SizedBox(width: 10,),
                                  ReusableText(text: "Settings", style: appStyle(12, Colors.grey.shade500,FontWeight.normal))
                                ],
                              ),
                              IconButton(
                                onPressed: (){
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> LoginPage()));
                                },
                                icon: Icon(Iconsax.direct_right_copy, color: Colors.grey,)
                              )
                            ],
                          ),
                          HeightSpacer(size: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Iconsax.message_question_copy, color: Colors.grey.shade500,),
                                  const SizedBox(width: 10,),
                                  ReusableText(text: "Get help", style: appStyle(12, Colors.grey.shade500,FontWeight.normal))
                                ],
                              ),
                              IconButton(
                                onPressed: (){
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> LoginPage()));
                                },
                                icon: Icon(Iconsax.direct_right_copy, color: Colors.grey,)
                              )
                            ],
                          ),
                          HeightSpacer(size: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Iconsax.check_copy, color: Colors.grey.shade500,),
                                  const SizedBox(width: 10,),
                                  ReusableText(text: "Terms and conditions", style: appStyle(12, Colors.grey.shade500,FontWeight.normal))
                                ],
                              ),
                              IconButton(
                                onPressed: (){
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> LoginPage()));
                                },
                                icon: Icon(Iconsax.direct_right_copy, color: Colors.grey,)
                              )
                            ],
                          ),
                          HeightSpacer(size: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Iconsax.logout_copy , color: Colors.grey.shade500,),
                                  const SizedBox(width: 10,),
                                  ReusableText(text: "Logout", style: appStyle(12, Colors.grey.shade500,FontWeight.normal))
                                ],
                              ),
                              IconButton(
                                onPressed: ()async{
                                  final prefs = await SharedPreferences.getInstance();
                                  prefs.setBool('isLoggedIn', false);
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> LoginPage()));
                                },
                                icon: Icon(Iconsax.direct_right_copy, color: Colors.grey,)
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  HeightSpacer(size: 20)
                ],
              ),
            ),
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
                IconButton(onPressed: (){}, icon: Icon(Iconsax.user_copy))
              ],
            )
          ),
        );
  }
}