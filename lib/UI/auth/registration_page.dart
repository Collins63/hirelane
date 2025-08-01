import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/custom_btn.dart';
import 'package:hirelane/CONSTANTS/custom_outline_btn.dart';
import 'package:hirelane/CONSTANTS/custom_textfield.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:hirelane/CONSTANTS/signIns.dart';
import 'package:hirelane/UI/home/home_page.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:hirelane/CONSTANTS/app_bar.dart';
import 'package:hirelane/UI/auth/login_page.dart';
import 'package:hirelane/controllers/signup_provider.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage ({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
  
}

class _RegistrationPageState extends State<RegistrationPage>{

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();

  @override
  void dispose(){
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Consumer<SignUpNotifier>(
      builder: (context , signupNotifier , child){
      return Scaffold(
        body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        onPressed: (){

                        },
                        icon: Icon(Iconsax.arrow_left_3 , color: Colors.grey,)
                      ),
                    ),
                    const HeightSpacer(size: 20),
                    Text(
                          "Let's create your account",
                          textAlign: TextAlign.left,
                          style: appStyle(20, Color(kDark.value),FontWeight.bold),
                        ),
                    const HeightSpacer(size: 30),
                    Form(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    expands: false,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Iconsax.user),
                                      labelText: "First Name",
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
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: TextFormField(
                                    expands: false,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Iconsax.user),
                                      labelText: "Last Name",
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
                              ],
                            ),
                            const HeightSpacer(size: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.user_edit),
                                labelText: "Username",
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
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.message),
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
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.call),
                                labelText: "Phone Number",
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
                              children: [
                                SizedBox(width: 24,height: 24,child: Checkbox(
                                  value: true,
                                  onChanged: (value){}
                                ),),
                                const SizedBox(width: 10,),
                                Text.rich(
                                  TextSpan(children: [
                                    TextSpan(text: "I agree to " , style: TextStyle(fontSize: 12)),
                                    TextSpan(text: "Privancy Policy " , style: TextStyle(fontSize: 12).apply(
                                      color: Colors.blueAccent,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.blueAccent
                                    )),
                                    TextSpan(text: "and " , style: TextStyle(fontSize: 12)),
                                    TextSpan(text: "Terms of use." , style: TextStyle(fontSize: 12).apply(
                                      color: Colors.blueAccent,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.blueAccent
                                    )),
                                  ])
                                )
                              ]
                            ),
                            const HeightSpacer(size: 30),
                            CustomOutlineBtn(
                              text:"Creat Account",
                              color: Colors.white,
                              height: 50,
                              color2: Colors.blueAccent,
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> HomePage()));
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
                                Text("Or Sign Up With", style: appStyle(12, Colors.grey, FontWeight.normal),),
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