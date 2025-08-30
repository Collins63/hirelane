import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/custom_outline_btn.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:hirelane/CONSTANTS/width_spacer.dart';
import 'package:hirelane/UI/recruiterPages/recruiterHome.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecruiterJobs extends StatefulWidget {
  const RecruiterJobs({super.key});

  @override
  State<RecruiterJobs> createState() => _RecruiterJobsState();
}

class _RecruiterJobsState extends State<RecruiterJobs> {

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  final jobFormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController contractController = TextEditingController();
  TextEditingController periodController = TextEditingController();
  List<String> jobRequirents = [];
  List<Map<String , dynamic>> agentJobs = [];

  String agentId ='';
  String firebaseId = '';

   clearForm(){
    titleController.clear();
    locationController.clear();
    descriptionController.clear();
    salaryController.clear();
    companyController.clear();
    imageUrlController.clear();
    contractController.clear();
    periodController.clear();
    jobRequirents.clear();
  }

  getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    setState(() {
      agentId = prefs.getString('user_id') ?? '';
      firebaseId = prefs.getString('firebase_id') ?? '';
    });
    try {
      final response = await http.get(
      Uri.parse("http://192.168.110.231:5002/api/jobs/agent/$agentId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token" // or "Authorization" depending on your backend
      },
    );
      if(response.statusCode == 200){
        final responseData = jsonDecode(response.body);
        setState(() {
          agentJobs = List<Map<String, dynamic>>.from(responseData);
        });
        print(agentJobs);
      } else {
        print("Failed to load jobs");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> createJob() async{
    try {
      final response = await http.post(
        Uri.parse("http://192.168.110.231:5002/api/jobs"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "title": titleController.text,
          'location': locationController.text,
          'company': companyController.text,
          'description': descriptionController.text,
          'salary': salaryController.text,
          'contract': contractController.text,
          'period': periodController.text,
          'imageUrl' : 'https://picsum.photos/seed/picsum/200/300',
          'agentId': agentId,
          'requirements': jobRequirents
        })
      );
      if(response.statusCode == 200){
        Get.snackbar("Success", "Job created successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white
        );
        Navigator.pop(context);
      } else {
        final responseMesage  = jsonDecode(response.body);
        Get.snackbar("Error", "${responseMesage['message']}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white
        );
        print(response.body);
      }
    } catch (e) {
      Get.snackbar("Error", "$e",
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
        );
      }
    );
  }

  addJob(){
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
                      controller: titleController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.card),
                        labelText: "Title",
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
                          return "Please enter title";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: locationController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.location),
                        labelText: "Location",
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
                          return "Please enter location";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.text),
                        labelText: "Description",
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
                          return "Please enter description";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: salaryController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.money),
                        labelText: "Salary",
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
                          return "Please enter salary";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: periodController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.clock),
                        labelText: "Period",
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
                          return "Please enter period";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: contractController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.edit),
                        labelText: "Contract",
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
                          return "Please enter contract";
                        }
                        return null;
                      },
                    ),
                    
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: companyController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Iconsax.building),
                              labelText: "Requirements",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: IconButton(
                              onPressed: (){
                                if(companyController.text.isNotEmpty){
                                  setState(() {
                                    jobRequirents.add(companyController.text);
                                    companyController.clear();
                                  });
                                }
                              }, 
                              icon: Icon(Iconsax.add, color: Colors.white,)
                            ),
                          )
                      ],
                    ),
                    SizedBox(height: 10,),
                    CustomOutlineBtn(
                      text: 'Create',
                      color: Colors.white,
                      color2: Colors.blueAccent,
                      height: 40,
                      onTap: ()async{
                        if(jobRequirents.isEmpty){
                          Get.snackbar("Error", "Please add at least one requirement",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white
                          );
                          return;
                        }else{
                          if(jobFormKey.currentState!.validate()){
                            await createJob();
                            await clearForm();
                            await getUserDetails();
                            Navigator.pop(context);
                          }
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
            title: Text("Jobs" , style: appStyle(16, Colors.white, FontWeight.w500),),
            centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomOutlineBtn(
                  text: "Post a Job",
                  color: Colors.white,
                  color2: Colors.white30,
                  height: 50,
                  onTap: (){
                    addJob();
                  },
                ),
                const HeightSpacer(size: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Divider(
                        color: Colors.white,
                        thickness: 0.5,
                        indent: 60,
                        endIndent: 5,
                      )
                    ),
                    Text("Previous Listings", style: appStyle(12, Colors.white, FontWeight.normal),),
                    Flexible(
                      child: Divider(
                        color: Colors.white,
                        thickness: 0.5,
                        indent: 5,
                        endIndent: 60,
                      )
                    ),
                  ],
                ),
                const HeightSpacer(size: 20),
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
                    itemCount: agentJobs.length,
                    itemBuilder: (context, index){
                      final job = agentJobs[index];
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
                          title: ReusableText(text: job['title'] ?? 'No Title', style: appStyle(16,Colors.white, FontWeight.w500)),
                          subtitle: ReusableText(text: "${job['location'] ?? 'No Location'} , ${job['contract'] ?? 'No Contract'}", style: appStyle(14, Colors.white60, FontWeight.normal)),
                          trailing: IconButton(icon: Icon(Iconsax.direct_right, color: Colors.white,), onPressed: (){
                            viewJob(job);
                          },),
                        ),
                      );
                    },
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