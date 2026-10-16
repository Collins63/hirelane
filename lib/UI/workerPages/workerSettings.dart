import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';

class Workersettings extends StatefulWidget {
  const Workersettings({super.key});

  @override
  State<Workersettings> createState() => _WorkersettingsState();
}

class _WorkersettingsState extends State<Workersettings> {
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
            title: Text("App Settings" , style: appStyle(16, Colors.white, FontWeight.w500),),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(text: "Use location", style: appStyle(12,Colors.white, FontWeight.normal)),
                    Switch(
                      activeColor: Colors.blueAccent,
                      inactiveThumbColor: Colors.blueAccent,
                      inactiveTrackColor: Colors.white,
                      value: true, onChanged: (value){
                      if(value == true){
                        value=false;
                      }else{
                        value = true;
                      }
                    } ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(text: "Localize search", style: appStyle(12,Colors.white, FontWeight.normal)),
                    Switch(
                      activeColor: Colors.blueAccent,
                      inactiveThumbColor: Colors.blueAccent,
                      inactiveTrackColor: Colors.white,
                      value: false, onChanged: (value){
                      if(value == true){
                        value=false;
                      }else{
                        value = true;
                      }
                    } ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(text: "Socials Sync", style: appStyle(12,Colors.white, FontWeight.normal)),
                    Switch(
                      activeColor: Colors.blueAccent,
                      inactiveThumbColor: Colors.blueAccent,
                      inactiveTrackColor: Colors.white,
                      value: true, onChanged: (value){
                      if(value == true){
                        value=false;
                      }else{
                        value = true;
                      }
                    } ),
                  ],
                ),
                Divider()
              ],
            ),
          ),
        ),
      ),
    );
  }
}