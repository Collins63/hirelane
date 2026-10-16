import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Workerskills extends StatefulWidget {
  const Workerskills({super.key});

  @override
  State<Workerskills> createState() => _WorkerskillsState();
}

class _WorkerskillsState extends State<Workerskills> {

  Map<String, dynamic> userData = {};
  List<String> skills = [];
  
  Future<void> getProfile() async{
    final prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id')!;
    String token = prefs.getString('auth_token')!;
    final response = await http.get(
      Uri.parse("http://172.20.10.4:5002/api/users/$userId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token" // or "Authorization" depending on your backend
      },
    );
    if(response.statusCode == 200){
      setState(() {
        userData = jsonDecode(response.body);
      });
      if(userData['skills'] is Iterable){
        skills = (userData['skills'] as Iterable)
          .map((skill) => skill.toString()).toList();
      }else{
        print('Error: "skills" field is missing or not a list.');
      }
      print(userData);
    }else{
      print("Couldnt get data");
    }
  }

  @override
  void initState(){
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){

          },
          icon: const Icon(Icons.chevron_left_rounded , color: Colors.white ,size: 30,),
        ),
        centerTitle: true,
        title: Text("My Skills" , style: appStyle(12, Colors.grey.shade500, FontWeight.w500)),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(child: Image(image: AssetImage("assets/mySkills.png"),height: 200,)),
              HeightSpacer(size: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:BorderRadius.circular(20) 
                ),
                child: ListView.builder(
                  itemCount: skills.length ,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context , index){
                    final skill = skills[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0 , horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Iconsax.direct_right_copy , color: Colors.grey.shade500,),
                          ReusableText(text: skill, style: appStyle(10, Colors.grey.shade500, FontWeight.w500)),
                          HeightSpacer(size: 10),
                        ],
                      ),
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}