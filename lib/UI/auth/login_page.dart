//import 'dart:math';

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hirelane/CONSTANTS/custom_outline_btn.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:hirelane/CONSTANTS/app_bar.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/custom_btn.dart';
import 'package:hirelane/CONSTANTS/custom_textfield.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:hirelane/CONSTANTS/signIns.dart';
import 'package:hirelane/UI/auth/registration_page.dart';
import 'package:hirelane/UI/home/home_page.dart';
import 'package:hirelane/controllers/login_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  const LoginPage ({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose(){
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<bool> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse("http://10.0.2.2:5002/api/login"), // replace with your IP or domain
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['userToken'];
      final userId = data['_id'];
      // ✅ Save token for future use
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      getProfile(userId, token);
      print(data['username']);
      return true;
    } else {
      Get.snackbar(
        "Login Failed",
        "${response.body}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print("Login failed: ${response.body}");
      return false;
    }
  }

  Future<void> getProfile(String userId, String token) async {
    final prefs = await SharedPreferences.getInstance();
    //final token = prefs.getString('auth_token');

    final response = await http.get(
      Uri.parse("http://10.0.2.2:5002/api/users/$userId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token" // or "Authorization" depending on your backend
      },
    );

    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);
      await prefs.setString('user_id', userData['_id'] );
      await prefs.setString('firebase_id', userData['uid'] );
      await prefs.setString('username', userData['username'] );
      await prefs.setString('user_email', userData['email'] );
      print("User Data: $userData");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage())
      );
      
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
  Widget build(BuildContext context){
    return Consumer<LoginNotifier>(
      builder: (context , loginNotifier , child){
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeightSpacer(size: 30),
                        Image(image: AssetImage('assets/light_Logo.png'),height: 100,),
                        HeightSpacer(size: 20),
                        Text(
                          "Welcome Back,",
                          textAlign: TextAlign.left,
                          style: appStyle(20, Color(kDark.value),FontWeight.bold),
                        ),
                        const HeightSpacer(size: 10),
                        Text(
                          "Get hired with the click on a button",
                          textAlign: TextAlign.left,
                          style: appStyle(14, Color(kDark.value),FontWeight.normal),
                        ),
                      ],
                    ),
                    const HeightSpacer(size: 30),
                    Form(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.direct_right),
                                labelText: "Email",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                              ),
                            ),
                            const HeightSpacer(size: 20),
                            TextFormField(
                              controller: password,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.password_check),
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0)
                                ),
                                suffixIcon: Icon(Iconsax.eye_slash)
                              ),
                            ),
                            const HeightSpacer(size: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: true,
                                      onChanged: (value){
                                      }
                                    ),
                                    Text(
                                      "Remember me",
                                      textAlign: TextAlign.left,
                                      style: appStyle(12, Color(kDark.value),FontWeight.normal),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: (){},
                                  child: Text(
                                    "Forgot Password",
                                    style: appStyle(12, Colors.blueAccent, FontWeight.normal),
                                  )
                                )
                              ],
                            ),
                            const HeightSpacer(size: 30),
                            CustomOutlineBtn(
                              text:"SignIn",
                              color: Colors.white,
                              height: 50,
                              color2: Colors.blueAccent,
                              onTap: (){
                                //Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> HomePage()));
                                loginUser(email.text, password.text);
                              },
                            ),
                            const SizedBox(height: 10,),
                            CustomOutlineBtn(
                              text:"Create Account",
                              color: Colors.grey,
                              height: 50,
                              color2: Colors.white,
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationPage()));
                              },
                            ),
                            const HeightSpacer(size: 20),
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
                                Text("Or SignIn With", style: appStyle(12, Colors.grey, FontWeight.normal),),
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
                            //Image(image: AssetImage('assets/googleLogo.png'),height: 100,),
                            const HeightSpacer(size: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:Colors.grey
                                    ),
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: IconButton(
                                      onPressed: (){},
                                      icon: Image(
                                        width: 20,
                                        height: 20,
                                        image: AssetImage('assets/googleLogo.png'),
                                      )
                                    ),
                                ),
                                const SizedBox(width: 15,),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:Colors.grey
                                    ),
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: IconButton(
                                      onPressed: (){},
                                      icon: Image(
                                        width: 20,
                                        height: 20,
                                        image: AssetImage('assets/googleLogo.png'),
                                      )
                                    ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    )
                  ],
                ),
              ),
            )
          );
      }
    );
  }
}