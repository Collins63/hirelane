import 'dart:ffi';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/imagePicker.dart';
import 'package:hirelane/UI/auth/login_page.dart';
import 'package:hirelane/UI/home/home_page.dart';
import 'package:hirelane/constants/app_constants.dart';
import 'package:hirelane/services/helpers/imageUploadFirebase.dart';
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
  }

  void saveProfile() async{
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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Row(
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
                                backgroundImage: NetworkImage('https://img.icons8.com/officel/80/user.png'),
                              ),
                            ),
                          ),),
                          const SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Collins Chimbganda" , style: appStyle(14, Colors.black, FontWeight.w500),),
                              Text("collinsKurai@gmail.com" , style: appStyle(14, Colors.grey, FontWeight.w500),)
                            ],
                          )
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.person, color: Colors.white,)),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(CupertinoIcons.phone, color: Colors.grey,),
                    const SizedBox(width: 5,),
                    Text("0771472798" , style: appStyle(14, Colors.grey, FontWeight.w500),),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(CupertinoIcons.location, color: Colors.grey,),
                    const SizedBox(width: 5,),
                    Text("Masvingo" , style: appStyle(14, Colors.grey, FontWeight.w500),),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(CupertinoIcons.briefcase, color: Colors.grey,),
                    const SizedBox(width: 5,),
                    Text("Programmer" , style: appStyle(14, Colors.grey, FontWeight.w500),),
                  ],
                ),
                const SizedBox(height: 20,),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10.0)
                  ) ,
                  child: 
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 90,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Center(
                            child: Icon(
                              CupertinoIcons.doc_text, color: Colors.white,size: 40,
                            ),
                          ),
                        ),
                        Icon(CupertinoIcons.add_circled,size: 30, color: Colors.white,)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 305,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 295,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade400,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    Container(
                      height: 285,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
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
                                Text("Work History" , style: appStyle(14, Colors.white, FontWeight.w500),),
                                //Icon(CupertinoIcons.right_chevron , color: Colors.grey,)
                                IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.chevron_right, color: Colors.white,))
                              ],
                            ),
                            Container(
                              height: 1,
                              color: Colors.grey.shade300,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Skills" , style: appStyle(14, Colors.white, FontWeight.w500),),
                                //Icon(CupertinoIcons.right_chevron , color: Colors.grey,)
                                IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.chevron_right, color: Colors.white,))
                              ],
                            ),
                            Container(
                              height: 1,
                              color: Colors.grey.shade300,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Security" , style: appStyle(14, Colors.white, FontWeight.w500),),
                                //Icon(CupertinoIcons.right_chevron , color: Colors.grey,)
                                IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.chevron_right, color: Colors.white,))
                              ],
                            ),
                            Container(
                              height: 1,
                              color: Colors.grey.shade300,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Settings" , style: appStyle(14, Colors.white, FontWeight.w500),),
                                //Icon(CupertinoIcons.right_chevron , color: Colors.grey,)
                                IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.chevron_right, color: Colors.white,))
                              ],
                            ),
                            Container(
                              height: 1,
                              color: Colors.grey.shade300,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Logout" , style: appStyle(14, Colors.white, FontWeight.w500),),
                                //Icon(CupertinoIcons.right_chevron , color: Colors.grey,)
                                IconButton(onPressed: (){
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Logout"),
                                        content: Text("Are you sure you want to logout?"),
                                        actions: [
                                          TextButton(
                                            child: Text("Cancel"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text("Logout"),
                                            onPressed: () async {
                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                              await prefs.clear();
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                            },
                                          ),
                                        ],
                                      );
                                    }
                                  ); 
                                }, icon: Icon(CupertinoIcons.chevron_right, color: Colors.white,))
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
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
              IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.person))
            ],
          )
        ),
      );
  }
}