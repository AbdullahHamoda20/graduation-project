import 'package:flutter/material.dart';

class AppColors {

  //Splash Screen Gradient
  static const LinearGradient  splashGradient = LinearGradient(
    colors: [
      Color(0xffF7A3A4),
      Color(0xffD63F67),
      Color(0xffF7A3A4),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.4087, 1.0],
  );

  static const LinearGradient  resultGradient = LinearGradient(
    colors: [
      Color(0xffFFF6F7),
      Color(0xffFBECEF),
      Color(0xffF7DDE2),
      Color(0xffF3C7D5),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.2, .3,1.0],
  );

  // Onboarding Screen
  static const  Color header = Color(0xffD63F67);
  static const  Color description = Color(0xffA8A8A8);
  static const Color back_skip_buttons = Color(0xff706D6D);

  // Buttons Color
  static const Color buttoColor = Color(0xffDA5F71);
  static const Color onboard4 = Color(0xff4F4F4F);


}