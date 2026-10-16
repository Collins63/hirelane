import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:hirelane/CONSTANTS/width_spacer.dart';
import 'package:hirelane/services/config.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({super.key});

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {

  String userId = '';
  List<Map<String, dynamic>> bookmarks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBookmarks();
  }

  void getBookmarks() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId  = prefs.getString('user_id').toString();
    });
    final response = await http.get(
      Uri.parse("${Config.apiUrl}/api/bookmarks/$userId"),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if(response.statusCode == 200){
      print(response.body);
      final bookmarksResponse = jsonDecode(response.body);
      setState(() {
         bookmarks = (bookmarksResponse as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();
      });
    }else{
      Get.snackbar(
        "Error getting bookmarks","${response.body}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white
      );
    }
  }

  viewJob(Map<String, dynamic> job){
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
              Get.back();
            }, icon: Icon(CupertinoIcons.chevron_back, color: Colors.white,),)) ,
            title: Text("Bookmarks" , style: appStyle(16, Colors.white, FontWeight.w500),),
            centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white,
                      width: 1
                    )
                  ),
                  child: ListView.builder(
                    itemCount: bookmarks.length,
                    itemBuilder: (context, index){
                      final job = bookmarks[index];
                      String jobID = job['job'];
                      // try {
                      //   final response = http.get(
                      //     Uri.parse("http://192.168.110.4:5002/api/jobs/$jobID"),
                      //     headers: {
                      //       "Content-Type": "application/json",
                      //     },
                      //   );
                      //   if(response.toString())
                      //   final bookmarkJob = jsonDecode()
                      // } catch (e) {
                        
                      // }
                      return FutureBuilder(
                        future: http.get(
                          Uri.parse("http://172.20.10.4:5002/api/jobs/$jobID"),
                          headers: {"Content-Type": "application/json"},
                        ),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return const CircularProgressIndicator(); 
                          }
                          else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else if (!snapshot.hasData) {
                            return const Text("No data");
                          }

                          final response = snapshot.data as http.Response;
                          final bookmarkJob = jsonDecode(response.body);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              tileColor: Colors.white30,
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white
                                ),
                                child: Icon(Iconsax.briefcase, color: Colors.grey,),
                              ),
                              title: ReusableText(text: bookmarkJob['title'] ?? 'No Title', style: appStyle(16,Colors.white, FontWeight.w500)),
                              subtitle: ReusableText(text: "${bookmarkJob['location'] ?? 'No Location'} , ${bookmarkJob['contract'] ?? 'No Contract'}", style: appStyle(14, Colors.white60, FontWeight.normal)),
                              trailing: IconButton(icon: Icon(Iconsax.direct_right, color: Colors.white,), onPressed: (){
                                viewJob(bookmarkJob); 
                              },),
                            ),
                          );
                        }
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}