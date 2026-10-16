import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hirelane/CONSTANTS/app_bar.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/custom_outline_btn.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:hirelane/UI/home/home_page.dart';
import 'package:hirelane/services/config.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax_flutter/iconsax_flutter.dart';
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
  List<Map<String, dynamic>> appliedJobs =[];
  String targetUserId = '';
  String targetJobId ='';
  bool hasApplied = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController coverLetter = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async{
    await getJob();
    await getApplications();
  }

  Future<void> getJob() async {
    String jobId = widget.jobId;
    final prefs = await SharedPreferences.getInstance();
    //final token = prefs.getString('auth_token');

    final response = await http.get(
      Uri.parse("${Config.apiUrl}/api/jobs/$jobId"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final job = jsonDecode(response.body);
      print("Jobs fetched successfully: $job");
      setState(() {
        targetJobId = job['_id'] ?? "0";
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

  Future<void> getApplications() async{
    final prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id')!;
    
    final response = await http.get(
      Uri.parse("${Config.apiUrl}/api/applications/user/$userId"),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if(response.statusCode == 200){
      final jobs = jsonDecode(response.body);
      setState(() {
        appliedJobs = List<Map<String, dynamic>>.from(jobs);
        targetUserId = userId;
      });

      hasApplied = appliedJobs.any((app)=>
        app["userId"] == targetUserId && app['job']['_id'] == targetJobId
      );
    }else{
      Get.snackbar(
        "Applied jobs fetch failed",
        "${response.body}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber,
        colorText: Colors.black,
        icon: Icon(Iconsax.warning_2)
      );
    }
  }

  Future<void> addToBookmarks(String jobId) async{
    final prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id')!;
    try {
      final response = await http.post(
        Uri.parse('${Config.apiUrl}/api/bookmarks'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          'job': jobId,
          'userId': userId
        })
      );
      if(response.statusCode == 200){
        Get.snackbar("Success",
          "Bookmark created",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white
        );
      }else{
        Get.snackbar("Error saving bookmark", response.body,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white
        );
      }
    } catch (e) {
      Get.snackbar("Error saving bookmark", '$e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white
        );
    }


  }

  applyForJob(String jobId, String recruiterId){
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context){
        return Container(
          height: 600,
          child: Padding(
            padding:  EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: MediaQuery.of(context).viewInsets.bottom
            ),
            child: Form(
              key: formKey,
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
                      maxLines: 10,
                      controller: coverLetter,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                        labelText: "Letter",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 10,),
                    CustomOutlineBtn(
                      text: 'Send application',
                      color: Colors.white,
                      color2: Colors.blueAccent,
                      height: 40,
                      onTap: ()async{
                        final prefs = await SharedPreferences.getInstance();
                        String userId = prefs.getString('user_id')!;
                        print("recruiter id is $recruiterId");
                        try {
                          final response = await http.post(
                            Uri.parse("${Config.apiUrl}/api/applications/"),
                            headers: {"Content-Type": "application/json"},
                            body: jsonEncode({
                              "jobId": jobId ,
                              "userId": userId,
                              "agentId": recruiterId,
                              "coverLetter": coverLetter.text,
                            })
                          );
                          if(response.statusCode == 200){
                            Navigator.pop(context);
                            Get.snackbar("Success", "Job application has been sent ",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              colorText: Colors.white
                            );
                            getApplications();
                          }else{
                            Get.snackbar("Error applying for job",
                              "Please try again",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              icon: Icon(Iconsax.warning_2),
                              snackPosition: SnackPosition.BOTTOM
                            );
                          }
                        } catch (e) {
                          Get.snackbar("Error applying for job",
                            "$e",
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            icon: Icon(Iconsax.warning_2),
                            snackPosition: SnackPosition.BOTTOM
                          );
                        }
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
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
       appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: ReusableText(text:"Job" , style: appStyle(14, Colors.grey.shade800, FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 165,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 155,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade400,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    Container(
                      height: 145,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReusableText(text: "Apply for this job", style:appStyle(16,Colors.white, FontWeight.w500)),
                                const HeightSpacer(size: 20),
                                ReusableText(text: "Get Hired!!", style: appStyle(46, Colors.white, FontWeight.bold))
                              ],
                            ),
                            // Image(
                            //   image: AssetImage('assets/worker.png')
                            // )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child:Image(image: AssetImage("assets/worker.png"), height: 100
                      ) ,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(text: "${jobfromDB['title']}", style:appStyle(16,Colors.black, FontWeight.w500)),
                    IconButton(
                      onPressed: (){
                        String jobId = jobfromDB['_id'] ?? '0';
                        addToBookmarks(jobId);
                      },
                      icon: FaIcon(FontAwesomeIcons.heart)
                    )
                  ],
                ),
              const HeightSpacer(size: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FaIcon(FontAwesomeIcons.person, color: Colors.grey.shade700,size: 20,),
                  const SizedBox(width: 5,),
                  ReusableText(text: "${jobfromDB['company']}", style:appStyle(14,Colors.grey.shade700, FontWeight.w500)),
                ],
              ),
              const HeightSpacer(size: 10),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.locationDot, color: Colors.grey.shade700,size: 20,),
                  const SizedBox(width: 5,),
                  ReusableText(text: "${jobfromDB['location']} ", style:appStyle(14,Colors.grey.shade700, FontWeight.w500)),
                ],
              ),
              const HeightSpacer(size: 10),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.calendar, color: Colors.grey.shade700,size: 20,),
                  const SizedBox(width: 5,),
                  ReusableText(text: '${jobfromDB['contract']}', style:appStyle(14,Colors.grey.shade700, FontWeight.normal)),
                ],
              ),
              const HeightSpacer(size: 10),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.coins, color: Colors.grey.shade700,size: 20,),
                  const SizedBox(width: 5,),
                  ReusableText(text: '${jobfromDB['salary']} / ${jobfromDB['period']}', style:appStyle(14,Colors.grey.shade700, FontWeight.normal)),
                ],
              ),
              const HeightSpacer(size: 30),
              Container(
                //height: 200,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(text: "Description:", style:appStyle(16,Colors.black, FontWeight.w500)),
                      const SizedBox(height: 10,),
                      ReusableText(text: "${jobfromDB['description']}", style:appStyle(12,Colors.grey.shade700, FontWeight.w500)),
                    ],
                  )),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
              ),
              const HeightSpacer(size: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                ReusableText(text: skillSet[index], style:appStyle(12,Colors.grey.shade700, FontWeight.normal)),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ),
              
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 60,
        child: Center(
          child: hasApplied ? CustomOutlineBtn(
            height: 40,
            text: "View Progress",
            color: Colors.white,
            color2: Colors.blueAccent,
            onTap: (){},
          ) :
          CustomOutlineBtn(
            height: 40,
            text: "Apply Now",
            color: Colors.white,
            color2: Colors.blueAccent,
            onTap: (){
              String jobId = jobfromDB['_id'];
              String recruiterId = jobfromDB['agentId'];
              applyForJob(jobId, recruiterId);
            },
          )
        ),
      ),
    );
  }
}