import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hirelane/CONSTANTS/app_bar.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:hirelane/UI/home/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Job extends StatefulWidget {
  final String jobId;
  const Job({super.key, required this.jobId} );

  @override
  State<Job> createState() => _JobState();
}

class _JobState extends State<Job> {
  Map<String, dynamic> jobfromDB = {};
  List<String> skillSet = [];

  @override
  void initState() {
    super.initState();
    getJob();
  }

  Future<void> getJob() async {
    String jobId = widget.jobId;
    final prefs = await SharedPreferences.getInstance();
    //final token = prefs.getString('auth_token');

    final response = await http.get(
      Uri.parse("http://10.0.2.2:5002/api/jobs/$jobId"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final job = jsonDecode(response.body);
      print("Jobs fetched successfully: $job");
      setState(() {
        jobfromDB = Map<String, dynamic>.from(job) ;
        skillSet = List<String>.from(job['requirements'] ?? []);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueAccent,
          leading: IconButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
            },
            icon: const Icon(Icons.chevron_left_rounded , color: Colors.white ,size: 30,),
          ),
          centerTitle: true,
          title: const Text("Job" , style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 16 , color: Colors.white),),
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
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(text: "${jobfromDB['title']}", style:appStyle(16,Colors.black, FontWeight.w500)),
                  IconButton(
                    onPressed: (){},
                    icon: FaIcon(FontAwesomeIcons.heart)
                  )
                ],
              ),
              const HeightSpacer(size: 10),
              ReusableText(text: "Recruiter: ${jobfromDB['agentName']}", style:appStyle(16,Colors.grey.shade700, FontWeight.w500)),
              const HeightSpacer(size: 10),
              ReusableText(text: "Location: ${jobfromDB['location']} ", style:appStyle(16,Colors.grey.shade700, FontWeight.w500)),
              const HeightSpacer(size: 20),
              ReusableText(text: "Description: ${jobfromDB['description']}", style:appStyle(16,Colors.grey.shade700, FontWeight.w500)),
              const HeightSpacer(size: 10),
              ReusableText(text: 'Period: ${jobfromDB['period']}', style:appStyle(16,Colors.grey.shade700, FontWeight.normal)),
              const HeightSpacer(size: 10),
              ReusableText(text: 'Contract: ${jobfromDB['contract']}', style:appStyle(16,Colors.grey.shade700, FontWeight.normal)),
              const HeightSpacer(size: 20),
              ReusableText(text: "Skill Set", style:appStyle(16,Colors.black, FontWeight.w500)),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: skillSet.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FaIcon(FontAwesomeIcons.angleRight ,size: 15, color:Colors.blueAccent,),
                        const SizedBox(width: 10,),
                        ReusableText(text: skillSet[index], style:appStyle(14,Colors.grey.shade700, FontWeight.normal)),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}