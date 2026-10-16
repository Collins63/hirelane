import 'dart:async';
import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/custom_textfield.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:hirelane/UI/forms/job.dart';
import 'package:hirelane/UI/home/home_page.dart';
import 'package:hirelane/services/config.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Jobs extends StatefulWidget {
  const Jobs({super.key});

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {

  TextEditingController searchProducts = TextEditingController();
  int _selectedIndex = 0;
  List<Map<String, dynamic>> allJobs = [];
  Timer? _debounce;

  Future<void> getJobs({String query = ''}) async {
    final prefs = await SharedPreferences.getInstance();
    //final token = prefs.getString('auth_token');
    String baseUrl = "${Config.apiUrl}/api/jobs/";
    String url;

    if(query.isEmpty){
      url = baseUrl;
    }else{
      url = "$baseUrl/search/$query";
    }

    try {
      final response = await http.get(
      Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final products = jsonDecode(response.body);
        print("products fetched successfully: $products");
        setState(() {
          allJobs = List<Map<String, dynamic>>.from(products) ;
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
        setState(() {
          allJobs = [];
        });
      }
    } catch (e) {
      
    }
  }

  Widget  _buildJobTile(BuildContext context, Map<String, dynamic> job) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 800),
            pageBuilder: (context , animation, secondaryAnimation) => Job(jobId: job['_id'],),
            transitionsBuilder: (context, animation , secondaryAnimation, child){
              return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                child: child,
              );
            }
          )
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              child: Center(
                child: Container(
                  width: double.infinity, // Ensure it takes full width
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                    ),
                  ),
                  child: ClipRRect( // This cuts the image to the border radius
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)
                    ),
                    child: Image.asset('assets/career.jpg', fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                    // child: Image.network(
                    //   // Safety Check: Use the first image, or an empty string if list is empty
                    //   (product['imageUrl'] != null && product['imageUrl'].length > 0) 
                    //       ? product['imageUrl'][0] 
                    //       : '', 
                    //   fit: BoxFit.cover,
                    //   // ERROR HANDLER: This prevents the crash!
                    //   errorBuilder: (context, error, stackTrace) {
                    //     return Container(
                    //       color: Colors.grey[200],
                    //       child: Icon(Icons.image_not_supported, color: Colors.grey),
                    //     );
                    //   },
                    // ),
                  ),
                ),
              ),
            ),
            HeightSpacer(size: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ReusableText(
                text: job['title']!,
                style: appStyle(12, Colors.black, FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                    text: job['location'],
                    style: appStyle(14, Colors.blue, FontWeight.bold),
                  ),
                  const SizedBox(width: 5,),
                  ReusableText(
                    text: "${job['salary']!}/${job['period']}",
                    style: appStyle(12, Colors.grey.shade500, FontWeight.normal),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: IconButton(
                    onPressed: (){},
                    icon: Icon(Iconsax.heart_copy, color: Colors.grey.shade500,)
                  ),
                ),
                IconButton(
                  onPressed: (){
                    Share.share(
                      'Check out this Job Opening for a Truck Driver on my Hiring App! https://yourapp.com/jobs/123',
                      subject: 'Great Job Opportunity',
                    );
                  },
                  icon: Icon(Iconsax.share_copy, color: Colors.grey.shade500,)
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  
  final List<Map<String, String>> jobTypes= [
    {
      'title': 'All',
      'price': '\$30.00'
    },
    {
      'title': 'Formal',
      'price': '\$200.00'
    },
    {
      'title': 'Non-Formal',
      'price': '\$200.00'
    }
  ];


  @override
  void initState(){
    super.initState();
    getJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ReusableText(text: "Jobs", style: appStyle(16, Colors.grey, FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomTextfield(
                    controller: searchProducts,
                    hintText: "Find a product",
                    keyboardType: TextInputType.text,
                    prefixIcon: Icon(Iconsax.search_normal_copy),
                  ),
                ),
                IconButton(onPressed: (){
                  String searchQuery = searchProducts.text;
                  if(_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 800),(){
                    if(searchQuery.isEmpty){
                      getJobs();
                    }else{
                      getJobs(query: searchQuery);
                    }
                  });
                }, icon: Icon(Iconsax.search_normal_copy, color: Colors.grey.shade500,))
              ],
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: jobTypes.length,
                itemBuilder: (context , index){
                  final job= jobTypes[index];
                  
                  // Check if the current index is the selected one
                  final bool isActive = index == _selectedIndex;

                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector( // Added GestureDetector for tapping
                      onTap: () {
                        setState(() { // Update the state
                          _selectedIndex = index; // Set the new active index
                        // You would also add filtering logic here later
                        });
                      },
                      child: Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          // Conditional Color: blue if active, grey otherwise
                          color: isActive ? Colors.blue : Colors.grey.shade300, 
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: ReusableText(
                            text: job['title']! , 
                            style: appStyle(
                              12, 
                              // Conditional Text Color: white if active, black if grey
                                Colors.white , 
                              FontWeight.w500
                            )
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: allJobs.length,
                  itemBuilder: (context , index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildJobTile(context, allJobs[index]),
                    );
                  }
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}