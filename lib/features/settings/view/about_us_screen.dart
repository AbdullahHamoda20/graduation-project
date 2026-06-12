import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pcos_app/core/constants/app_assets.dart';
import 'package:pcos_app/features/settings/view/settings_screen.dart';
import '../../../core/constants/app_strings.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SettingsScreen()),
            );
          },
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          AppStrings.aboutUs,
          style: TextStyle(
            color: Color(0xffDA5F71),
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Gap(100),
          Image.asset(AppAssets.thirdOnboardingScreenImage, fit: BoxFit.fill),
          Gap(50),
          Text(
            AppStrings.aboutUsDesc,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
