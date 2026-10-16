import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/CONSTANTS/app_style.dart';
import 'package:hirelane/CONSTANTS/custom_outline_btn.dart';
import 'package:hirelane/CONSTANTS/heading_widget.dart';
import 'package:hirelane/CONSTANTS/height_spacer.dart';
import 'package:hirelane/CONSTANTS/reusable_text.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Transaferfunds extends StatefulWidget {
  const Transaferfunds({super.key});

  @override
  State<Transaferfunds> createState() => _TransferfundsState();
}

class _TransferfundsState extends State<Transaferfunds> {

  TextEditingController passwordController = TextEditingController();
  final passFormKey = GlobalKey<FormState>();

  transferModal(){
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context){
        return Container(
          height: 400,
          child: Padding(
            padding:  EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: MediaQuery.of(context).viewInsets.bottom
            ),
            child: Form(
              key: passFormKey,
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
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.lock, color: Colors.grey,),
                        labelText: "Password",
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
                          return "Field cannot be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    CustomOutlineBtn(
                      text: 'Update',
                      color: Colors.white,
                      color2: Colors.blueAccent,
                      height: 40,
                      onTap: ()async{
                        
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
            title: Text("Transfer funds" , style: appStyle(16, Colors.white, FontWeight.w500),),
            centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HeadingWidget(headingText: "Sending", color: Colors.grey.shade800, textColor: Colors.grey.shade800,),
                const HeightSpacer(size: 10),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 170,
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(text: "Amount", style:appStyle(14,Colors.grey, FontWeight.bold)),
                            const HeightSpacer(size: 5),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "\$",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey
                                  ),
                                  borderRadius: BorderRadius.circular(10.0)
                                )
                              ),
                            )
                          ],
                        )        
                      ),
                    )
                  ],
                ),
                const HeightSpacer(size: 20),
                HeadingWidget(headingText: "Receipient", color: Colors.grey.shade800, textColor: Colors.grey.shade800,),
                const HeightSpacer(size: 10),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 190,
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 170,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(text: "Phone number", style:appStyle(14,Colors.grey, FontWeight.bold)),
                            const HeightSpacer(size: 5),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey
                                  ),
                                  borderRadius: BorderRadius.circular(10.0)
                                )
                              ),
                            ),
                            const HeightSpacer(size: 10),
                            CustomOutlineBtn(
                              text: "Send",
                              color: Colors.white,
                              color2: Colors.blueAccent,
                              height: 40,
                              onTap: (){
                                transferModal();
                              },
                            )
                          ],
                        )        
                      ),
                    )
                  ],
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}