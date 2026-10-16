import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hirelane/UI/auth/login_page.dart';
import 'package:hirelane/UI/home/home_page.dart';
import 'package:provider/provider.dart';
import 'package:hirelane/CONSTANTS/app_constants.dart';
import 'package:hirelane/UI/onboarding/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CONSTANTS/exports.dart';

int isFirstTime = 0;
bool isLoggedIn = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isFirstTime = prefs.getInt('onBoard') ?? 0;
  isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(
      MultiProvider(
        providers:[
          ChangeNotifierProvider(create: (context) =>OnBoardNotifier()),
          ChangeNotifierProvider(create: (context) =>LoginNotifier()),
          ChangeNotifierProvider(create: (context) =>ZoomNotifier()),
          ChangeNotifierProvider(create: (context) =>SignUpNotifier()),
          ChangeNotifierProvider(create: (context) =>JobsNotifier()),
          ChangeNotifierProvider(create: (context) =>BookMarkNotifier()),
          ChangeNotifierProvider(create: (context) =>ImageUploader()),
          ChangeNotifierProvider(create: (context) =>ProfileNotifier()),
        ],child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375,812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "HireLane",
          theme: ThemeData(
            scaffoldBackgroundColor: Color(kLight.value),
            iconTheme: IconThemeData(color: Color(kDark.value)),
            primarySwatch: Colors.grey,
            useMaterial3: true,
          ),
          home: isFirstTime == 0 ? OnboardingScreen() : isLoggedIn ? HomePage() : LoginPage(),
        );
      },
    );
  }
}

