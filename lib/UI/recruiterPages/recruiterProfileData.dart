import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/custom_outline_btn.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Recruiterprofiledata extends StatefulWidget {
  const Recruiterprofiledata({super.key});

  @override
  State<Recruiterprofiledata> createState() => _RecruiterprofiledataState();
}

class _RecruiterprofiledataState extends State<Recruiterprofiledata> {

  TextEditingController textUpdateController = TextEditingController();

  final jobFormKey = GlobalKey<FormState>();

  updateProfileData(){
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context){
        return Container(
          height: 400,
          child: Padding(
            padding:  EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: MediaQuery.of(context).viewInsets.bottom
            ),
            child: Form(
              key: jobFormKey,
              child: ListView(
                scrollDirection: Axis.vertical,
                  children: [
                    Center(
                      child: Container(
                        height: 5,
                        width: 100,
                        decoration: BoxDecoration(
                          color: kDark,
                          borderRadius: BorderRadius.circular(20), 
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    SizedBox(height: 5,),
                    Image(image: AssetImage("assets/write.jpg"), height: 200,),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: textUpdateController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.edit, color: Colors.grey,),
                        labelText: "Update",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Field cannot be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    CustomOutlineBtn(
                      text: 'Update',
                      color: Colors.white,
                      color2: Colors.blueAccent,
                      height: 40,
                      onTap: ()async{
                        
                      },
                    )
                  ],
                
              ),
            ),
          ),
        );
      }
    );
  }

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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white24
            ),
            child: IconButton(onPressed: (){
              Get.back();
            }, icon: Icon(CupertinoIcons.chevron_back, color: Colors.white,),)) ,
            title: Text("Profile Data" , style: appStyle(16, Colors.white, FontWeight.w500),),
            centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeightSpacer(size: 10),
                ReusableText(text: "Full name", style: appStyle(14,Colors.white,FontWeight.w500)),
                const HeightSpacer(size: 5),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(text: "Collins Chimbganda", style: appStyle(12,Colors.white, FontWeight.normal)),
                            IconButton(onPressed: (){
                              updateProfileData();
                            }, icon: Icon(Iconsax.direct_right, color: Colors.white,))
                          ],
                        ), 
                      ],
                    ),
                  ),
                ),
                const HeightSpacer(size: 10),
                ReusableText(text: "Username", style: appStyle(14,Colors.white,FontWeight.w500)),
                const HeightSpacer(size: 5),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(text: "xeres", style: appStyle(12,Colors.white, FontWeight.normal)),
                            IconButton(onPressed: (){
                              updateProfileData();
                            }, icon: Icon(Iconsax.direct_right, color: Colors.white,))
                          ],
                        ), 
                      ],
                    ),
                  ),
                ),
                const HeightSpacer(size: 10),
                ReusableText(text: "Email", style: appStyle(14,Colors.white,FontWeight.w500)),
                const HeightSpacer(size: 5),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(text: "collinskurai@gmail.com", style: appStyle(12,Colors.white, FontWeight.normal)),
                            IconButton(onPressed: (){
                              updateProfileData();
                            }, icon: Icon(Iconsax.direct_right, color: Colors.white,))
                          ],
                        ), 
                      ],
                    ),
                  ),
                ),
                const HeightSpacer(size: 10),
                ReusableText(text: "Location", style: appStyle(14,Colors.white,FontWeight.w500)),
                const HeightSpacer(size: 5),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(text: "Masvingo", style: appStyle(12,Colors.white, FontWeight.normal)),
                            IconButton(onPressed: (){
                              updateProfileData();
                            }, icon: Icon(Iconsax.direct_right, color: Colors.white,))
                          ],
                        ), 
                      ],
                    ),
                  ),
                ),
                const HeightSpacer(size: 10),
                ReusableText(text: "Phone number", style: appStyle(14,Colors.white,FontWeight.w500)),
                const HeightSpacer(size: 5),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(text: "0771472798", style: appStyle(12,Colors.white, FontWeight.normal)),
                            IconButton(onPressed: (){
                              updateProfileData();
                            }, icon: Icon(Iconsax.direct_right, color: Colors.white,))
                          ],
                        ), 
                      ],
                    ),
                  ),
                ),
                const HeightSpacer(size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}