import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/heading_widget.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Transactionhistory extends StatefulWidget {
  const Transactionhistory({super.key});

  @override
  State<Transactionhistory> createState() => _TransactionhistoryState();
}

class _TransactionhistoryState extends State<Transactionhistory> {
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
            title: Text("Transaction history" , style: appStyle(16, Colors.white, FontWeight.w500),),
            centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HeadingWidget(headingText: "Deposits", color: Colors.grey.shade800,textColor: Colors.grey.shade800,),
                const HeightSpacer(size: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(text: "Security notifications", style: appStyle(12,Colors.white, FontWeight.normal)),
                            IconButton(onPressed: (){

                            }, icon: Icon(Iconsax.direct_right, color: Colors.white,))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(text: "Two-step verification", style: appStyle(12,Colors.white, FontWeight.normal)),
                            IconButton(onPressed: (){

                            }, icon: Icon(Iconsax.direct_right, color: Colors.white,))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(text: "Email address", style: appStyle(12,Colors.white, FontWeight.normal)),
                            IconButton(onPressed: (){

                            }, icon: Icon(Iconsax.direct_right, color: Colors.white,))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(text: "Change phone number", style: appStyle(12,Colors.white, FontWeight.normal)),
                            IconButton(onPressed: (){

                            }, icon: Icon(Iconsax.direct_right, color: Colors.white,))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(text: "Change password", style: appStyle(12,Colors.white, FontWeight.normal)),
                            IconButton(onPressed: (){

                            }, icon: Icon(Iconsax.direct_right, color: Colors.white,))
                          ],
                        ), 
                      ],
                    ),
                  ),
                ),
                const HeightSpacer(size: 20),
                HeadingWidget(headingText: "In-app transactions", color: Colors.grey.shade800, textColor: Colors.grey.shade800,),
                const HeightSpacer(size: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(text: "Get account info", style: appStyle(12,Colors.white, FontWeight.normal)),
                            IconButton(onPressed: (){

                            }, icon: Icon(Iconsax.direct_right, color: Colors.white,))
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ReusableText(text: "Delete account", style: appStyle(12,Colors.white, FontWeight.normal)),
                            IconButton(onPressed: (){

                            }, icon: Icon(Iconsax.direct_right, color: Colors.white,))
                          ],
                        ),  
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}