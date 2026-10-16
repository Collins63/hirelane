import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/custom_button_icon.dart';
import 'package:hirelane/CONSTANTS/custom_button_round.dart';
import 'package:hirelane/CONSTANTS/custom_outline_btn.dart';
import 'package:hirelane/CONSTANTS/custom_textfield.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:hirelane/CONSTANTS/width_spacer.dart';
import 'package:hirelane/services/config.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';


class Appliedjobs extends StatefulWidget {
  const Appliedjobs({super.key});

  @override
  State<Appliedjobs> createState() => _AppliedjobsState();
}

class _AppliedjobsState extends State<Appliedjobs> {

  TextEditingController searchController = TextEditingController();
  String userId = '';
  List<Map<String, dynamic>> applications = [];

  @override
  void initState(){
    super.initState();
    getApplications();
  }

  void getApplications() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('user_id').toString();
    });

    final response = await http.get(
      Uri.parse("${Config.apiUrl}/api/applications/user/$userId"),
      headers: {
        "Content-Type": "application/json",
      }
    );
    if(response.statusCode == 200){
      print(response.body);
      final applicationsResponse = jsonDecode(response.body);
      setState(() {
        applications = (applicationsResponse as List)
        .map((e) => e as Map<String , dynamic>)
        .toList();
      });
    }else{
      Get.snackbar(
        "Error getting applications","${response.body}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white
      );
    }
  }
  
  viewApplication(Map<String, dynamic> job, Map<String, dynamic> application){
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context){
        final List<String> requirementsList = List<String>.from(job['requirements'] ?? []);
        return Container(
          height: 600,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image(
                      image: AssetImage('assets/job.jpg'),
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ),
                  const HeightSpacer(size: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(text: "Application Status", style: appStyle(14, Colors.grey.shade500, FontWeight.bold)),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          child: ReusableText(text: application['status'], style: appStyle(14, Colors.white, FontWeight.bold)),
                        ),
                      )
                    ],
                  ),
                  HeightSpacer(size: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Iconsax.user, color: Colors.grey,),
                      const WidthSpacer(size: 5),
                      ReusableText(text: job['title'], style: appStyle(14, Colors.grey, FontWeight.normal))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Iconsax.location, color: Colors.grey,),
                      const WidthSpacer(size: 5),
                      ReusableText(text: job['location'], style: appStyle(14, Colors.grey, FontWeight.normal))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Iconsax.timer_1, color: Colors.grey,),
                      const WidthSpacer(size: 5),
                      ReusableText(text: job['contract'], style: appStyle(14, Colors.grey, FontWeight.normal))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Iconsax.money_2, color: Colors.grey,),
                      const WidthSpacer(size: 5),
                      ReusableText(text: "USD${job['salary']}/${job['period']}", style: appStyle(14, Colors.grey, FontWeight.normal))
                    ],
                  ),
                  const HeightSpacer(size: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                          indent: 60,
                          endIndent: 5,
                        )
                      ),
                      Text("Job Description", style: appStyle(12, Colors.grey, FontWeight.normal),),
                      Flexible(
                        child: Divider(
                          color: Colors.grey,
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(text: job['description'], style:appStyle(12,Colors.white, FontWeight.normal)),
                        ],
                      )),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blueAccent,
                    ),
                  ),
                  const HeightSpacer(size: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                          indent: 60,
                          endIndent: 5,
                        )
                      ),
                      Text("Job Requirements", style: appStyle(12, Colors.grey, FontWeight.normal),),
                      Flexible(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0.5,
                          indent: 5,
                          endIndent: 60,
                        )
                      ),
                    ],
                  ),
                  const HeightSpacer(size: 10),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blueAccent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: requirementsList.length,
                        itemBuilder: (context, index){
                          final requirement = requirementsList[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Iconsax.direct_right, color: Colors.white,),
                              ReusableText(text: requirement, style: appStyle(12, Colors.white,FontWeight.normal))
                            ],
                          );
                        }
                      )
                    ),
                  ),
                  HeightSpacer(size: 10),
                  CustomButtonIcon(
                    text: "Withdraw Application",
                    color: Colors.white,
                    color2: Colors.red,
                    icon: Iconsax.profile_delete_copy,
                    width: MediaQuery.of(context).size.width,
                    onTap: (){
                      
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
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: ReusableText(text:"Applied Jobs" , style: appStyle(14, Colors.grey.shade800, FontWeight.bold)),
          actions: [
            IconButton(onPressed: (){

            }, icon: Icon(Iconsax.refresh_copy , color: Colors.grey.shade800,))
          ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextfield(
                    controller: searchController,
                    hintText: "Find application",
                    keyboardType: TextInputType.text,
                    prefixIcon: Icon(Iconsax.search_normal_copy,),
                )),
                //Icon(CupertinoIcons.right_chevron , color: Colors.grey,)
                const SizedBox(width: 10,),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color:Colors.white)
                  ),
                  child: IconButton(
                    onPressed: (){},
                    icon: Icon(Iconsax.search_normal_copy, color: Colors.grey.shade500)
                  ),
                )
              ],
            ),
            HeightSpacer(size: 10),
            Expanded(child:
              Container(
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white,
                    width: 1
                  )
                ),
                child: ListView.builder(
                  itemCount: applications.length,
                  itemBuilder: (context, index){
                    final job = applications[index];
                    String jobID = job['job']['_id'];
                    return FutureBuilder(
                      future: http.get(
                        Uri.parse("${Config.apiUrl}/api/jobs/$jobID"),
                        headers: {"Content-Type": "application/json"},
                      ),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor:Colors.grey.shade100,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 5),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                tileColor: Colors.grey.shade200,
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white
                                  ),
                                ),
                                title: Container(
                                  height: 10,
                                  width: 100,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 150,
                                  color: Colors.white,
                                ),
                                trailing: Container(
                                  height: 20,
                                  width: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }
                        else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData) {
                          return const Text("No data");
                        }
        
                        final response = snapshot.data as http.Response;
                        final bookmarkJob = jsonDecode(response.body);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 5),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            tileColor: Colors.grey.shade200,
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white
                              ),
                              child: Icon(Iconsax.briefcase, color: Colors.grey,),
                            ),
                            title: ReusableText(text: bookmarkJob['title'] ?? 'No Title', style: appStyle(16,Colors.grey.shade500, FontWeight.w500)),
                            subtitle: ReusableText(text: "${bookmarkJob['location'] ?? 'No Location'} , ${bookmarkJob['contract'] ?? 'No Contract'}", style: appStyle(14, Colors.grey.shade500, FontWeight.normal)),
                            trailing: IconButton(icon: Icon(Iconsax.direct_right, color: Colors.grey.shade500,), onPressed: (){
                              viewApplication(bookmarkJob, job); 
                            },),
                          ),
                        );
                      }
                    );
                  },
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}