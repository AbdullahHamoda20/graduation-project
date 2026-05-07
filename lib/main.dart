import 'package:flutter/material.dart';
import 'package:pcos_app/features/auth/view/login_screen.dart';
import 'package:pcos_app/features/auth/view/profile_screen.dart';
import 'package:pcos_app/features/auth/view/signup_screen.dart';
import 'package:pcos_app/features/home/view/home_screen.dart';
import 'package:pcos_app/features/home/view/root.dart';
import 'package:pcos_app/features/onboarding/view/onBoarding_screen.dart';
import 'package:pcos_app/features/onboarding/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

