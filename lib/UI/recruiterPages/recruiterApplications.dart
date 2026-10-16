import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/custom_outline_btn.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:hirelane/CONSTANTS/width_spacer.dart';
import 'package:hirelane/UI/chat/chatMain.dart';
import 'package:hirelane/UI/recruiterPages/recruiterHome.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Recruiterapplications extends StatefulWidget {
  const Recruiterapplications({super.key});

  @override
  State<Recruiterapplications> createState() => _RecruiterapplicationsState();
}

class _RecruiterapplicationsState extends State<Recruiterapplications> {
  
  List<Map<String, dynamic>> appliedJobs =[];
  //List<Map<String, dynamic>> reviews =[];
  String? firebaseImageLink;


  void initState(){
    super.initState();
    getAppliedJobs();
  }

  Future<void> getAppliedJobs() async{
    final prefs = await SharedPreferences.getInstance();
    String agentId = prefs.getString('user_id')!;
    final response = await http.get(
      Uri.parse("http://172.20.10.4:5002/api/applications/agent/$agentId"),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if(response.statusCode == 200){
      final jobs = jsonDecode(response.body);
      print(response.body);
      setState(() {
        appliedJobs = List<Map<String, dynamic>>.from(jobs);
      });
      print("jobs fetched $appliedJobs");
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

  Future<List<Map<String, dynamic>>> getUserReviews(String userId)async{
    print("getting reviews for user id in function $userId");
    final response = await http.get(
      Uri.parse("http://172.20.10.4:5002/api/reviews/employeeReviews/$userId"),
      headers: {
        "Content-Type": "application/json",
      }
    );
    if(response.statusCode == 200){
      print("your reviews a are ${response.body}");
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    }
    else{
      throw Exception("Failed to fetch reviews: ${response.body}");

    }
  }

  viewApplication(String imageLink , Map<String,dynamic> job, Map<String,dynamic> applicantData, List<Map<String, dynamic>> reviews) {
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
                    imageLink.isNotEmpty ? CircleAvatar(
                      radius: 50,
                      child: ClipOval(
                        child: Image.network(
                          imageLink,
                          width: 100,   // 2 * radius
                          height: 100,
                          fit: BoxFit.cover, // ensures it fills the circle
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.person, size: 50, color: Colors.grey),
                        ),
                      ),
                    ): CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('assets/userIcon.png'),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Iconsax.user, color: Colors.grey,),
                        const WidthSpacer(size: 10),
                        ReusableText(text: applicantData['username'], style: appStyle(14, Colors.grey, FontWeight.w500))
                      ],
                    ),
                    SizedBox(height: 10,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Iconsax.message, color: Colors.grey,),
                        const WidthSpacer(size: 10),
                        ReusableText(text: applicantData['email'], style: appStyle(14, Colors.grey, FontWeight.w500))
                      ],
                    ),
                    SizedBox(height: 10,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Iconsax.location, color: Colors.grey,),
                        const WidthSpacer(size: 10),
                        ReusableText(text: applicantData['location'], style: appStyle(14, Colors.grey, FontWeight.w500))
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(text: "Letter:", style:appStyle(14,Colors.black, FontWeight.w500)),
                            const SizedBox(height: 10,),
                            ReusableText(text: "${job['coverLetter']}", style:appStyle(12,Colors.grey.shade700, FontWeight.w500)),
                          ],
                        )),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.shade200,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(text: "Experince:", style:appStyle(14,Colors.black, FontWeight.w500)),
                            const SizedBox(height: 10,),
                            ReusableText(text: "${job['coverLetter']}", style:appStyle(12,Colors.grey.shade700, FontWeight.w500)),
                          ],
                        )),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.shade200,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.shade200,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(text: "Reviews:", style:appStyle(14,Colors.black, FontWeight.w500)),
                            const SizedBox(height: 10,),
                            Container(
                              height: 250,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: reviews.length,
                                  itemBuilder: (context, index){
                                    final review = reviews[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 250,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.grey.shade200
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ReusableText(text: review['employerId']['email'] ?? 'No Name', style: appStyle(14, Colors.black, FontWeight.w500)),
                                              SizedBox(height: 5,),
                                              Row(
                                                children: List.generate(5, (i) => Icon(
                                                  i < (review['rating'] ?? 0) ? Icons.star : Icons.star_border,
                                                  color: Colors.amber,
                                                  size: 16,
                                                )),
                                              ),
                                              SizedBox(height: 5,),
                                              ReusableText(text: review['comment'] ?? 'No Comment', style: appStyle(12, Colors.grey.shade700, FontWeight.normal)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                ),
                              ),
                            )
                          ],
                        )),
                      ),
                      
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
                            ReusableText(text: "Documents:", style:appStyle(14,Colors.black, FontWeight.w500)),
                            const SizedBox(height: 10,),
                            ReusableText(text: "${job['coverLetter']}", style:appStyle(12,Colors.grey.shade700, FontWeight.w500)),
                          ],
                        )),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.shade200,
                      ),
                    ),
                    const HeightSpacer(size: 10),
                    CustomOutlineBtn(
                      text: 'Send Message',
                      color: Colors.white,
                      color2: Colors.blueAccent,
                      height: 40,
                      onTap: ()async{
                        final prefs = await SharedPreferences.getInstance();
                        String userId = prefs.getString('user_id')!;
                        print("recruiter id is ");
                        String recipientId = applicantData['uid'];
                        String recipientName = applicantData['username'];
                        print("navigating to chat with recipient id $recipientId and name $recipientName");
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Chatmain(recipientId: recipientId, recipientName: recipientName,)));
                      },
                    ),
                    SizedBox(height: 10,),
                    CustomOutlineBtn(
                      text: 'Hire',
                      color: Colors.white,
                      color2: Colors.blueAccent,
                      height: 40,
                      onTap: ()async{
                        final prefs = await SharedPreferences.getInstance();
                        String userId = prefs.getString('user_id')!;
                        print("recruiter id is ");
                        
                      },
                    ),
                    const HeightSpacer(size: 10),
                    CustomOutlineBtn(
                      text: 'Invite for interview',
                      color: Colors.white,
                      color2: Colors.blueAccent,
                      height: 40,
                      onTap: ()async{
                        final prefs = await SharedPreferences.getInstance();
                        String userId = prefs.getString('user_id')!;
                        print("recruiter id is ");
                        
                      },
                    ),
                    const HeightSpacer(size: 10),
                    CustomOutlineBtn(
                      text: 'Decline',
                      color: Colors.white,
                      color2: Colors.amber,
                      height: 40,
                      onTap: ()async{
                        final prefs = await SharedPreferences.getInstance();
                        String userId = prefs.getString('user_id')!;
                        print("recruiter id is ");
                        
                      },
                    )
                  ],
                
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
        backgroundColor: Colors.transparent,
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> RecruiterHome()));
            }, icon: Icon(CupertinoIcons.chevron_back, color: Colors.white,),)) ,
            title: Text("Job Applications" , style: appStyle(16, Colors.white, FontWeight.w500),),
            centerTitle: true,
        ),
        body: Padding(padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Image(image: AssetImage("assets/applications.png"), width: 200,),
                ),
                const HeightSpacer(size: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.transparent
                  ),
                  child: ListView.builder(
                    itemCount: appliedJobs.length,
                    itemBuilder: (context, index){
                      final job = appliedJobs[index];
                      String userId = job['userId'];
                      print("user id is $userId");
                      return FutureBuilder(
                        future: http.get(
                          Uri.parse("http://172.20.10.4:5002/api/users/$userId"),
                          headers: {
                            "Content-Type": "application/json",
                          }
                        ),
                        builder: (context, snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Shimmer.fromColors(
                              baseColor: Colors.white30,
                              highlightColor: Colors.grey[100]!,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(height: 15, color: Colors.white30),
                                          const SizedBox(height: 5),
                                          Container(height: 15, width: 150, color: Colors.white30),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          else if(snapshot.hasError){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text("Error loading user"),
                                subtitle: Text(snapshot.error.toString()),
                              ),
                            );
                          }else if(snapshot.hasData){
                            final response = snapshot.data!;
                            final userData = jsonDecode(response.body);
                            
                            String firebaseId = userData['uid'];
                            print("firebase id is $firebaseId");
                            return FutureBuilder<QuerySnapshot>(
                              future: FirebaseFirestore.instance
                                .collection('userProfile')
                                .where('firebaseId', isEqualTo: firebaseId)
                                .limit(1)
                                .get(),
                              builder: (context, firebaseSnapshot){
                                if (firebaseSnapshot.connectionState == ConnectionState.waiting) {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.white30,
                                    highlightColor: Colors.grey[100]!,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(height: 15, color: Colors.white30),
                                                const SizedBox(height: 5),
                                                Container(height: 15, width: 150, color: Colors.white30),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else if (firebaseSnapshot.hasError) {
                                  return ListTile(
                                    title: Text("Error loading profile"),
                                    subtitle: Text(firebaseSnapshot.error.toString()),
                                  );
                                }else if(firebaseSnapshot.hasData && firebaseSnapshot.data!.docs.isNotEmpty){
                                  String imageLink = firebaseSnapshot.data!.docs.first['imageLink'];
                                  print("image link is $imageLink");                       
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      tileColor: Colors.white30,
                                      key: ValueKey(job['userId'] + job['job']['id'].toString()),
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(1.0),
                                          child: Center(
                                            child: imageLink != null ? CircleAvatar(
                                              radius: 50,
                                              backgroundImage: NetworkImage('$imageLink'),
                                            ): 
                                            CircleAvatar(
                                              radius: 50,
                                              backgroundImage: AssetImage('assets/userIcon.png'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      title: ReusableText(
                                        text: userData['username'] ?? 'No Title',
                                        style: appStyle(16, Colors.white, FontWeight.w500),
                                      ),
                                      subtitle: ReusableText(
                                        text:
                                            "${job['job']['title'] ?? 'No Location'} , ${job['job']['location'] ?? 'No Contract'}",
                                        style: appStyle(14, Colors.white60, FontWeight.normal),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(Iconsax.direct_right, color: Colors.white),
                                        onPressed: () async{
                                          print("link is $imageLink");
                                          String userId = job['userId'];
                                          print("fetching reviews for user id $userId");
                                          final reviews = await getUserReviews(userId);
                                          viewApplication(imageLink, job, userData ,reviews);
                                        },
                                      ),
                                    ),
                                  );
                                }
                                // Default return to satisfy non-nullable Widget requirement
                                return const ListTile(title: Text("No profile found"));
                              }
                            );
                          }else{
                            return SizedBox.shrink();
                          }
                        }
                      );
                    }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}