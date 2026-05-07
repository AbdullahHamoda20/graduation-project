import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pcos_app/core/constants/app_strings.dart';
import 'package:pcos_app/core/shared/custom_button.dart';
import 'package:pcos_app/features/clinical_data/view/physical_symptoms_screen.dart';

import '../../../core/constants/app_assets.dart';
import '../../settings/view/settings_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  Image.asset(AppAssets.appBarLeadingIcon),
        actions:  [
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) =>  SettingsScreen()),
            );
          }, icon: Image.asset(AppAssets.appBarActionIcon))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/images/start_1.png"),fit: BoxFit.fill),
                          color: Color(0xffFAF5F6),
                          borderRadius: BorderRadius.circular(20),
                          border: BoxBorder.all(color: Colors.black,width: 2)
                      ),
                    ),
                  ),
                  Gap(20),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/images/start_2.png"),fit: BoxFit.fill),
                          color: Color(0xffFAF5F6),
                          borderRadius: BorderRadius.circular(20),
                          border: BoxBorder.all(color: Colors.black,width: 2)
                      ),
                    ),
                  ),
                ],
              ),
              Gap(20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/images/start_3.png"),fit: BoxFit.fill),
                          color: Color(0xffFAF5F6),
                          borderRadius: BorderRadius.circular(20),
                          border: BoxBorder.all(color: Colors.black,width: 2)
                      ),
                    ),
                  ),
                  Gap(20),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/images/start_4.png"),fit: BoxFit.fill),
                          color: Color(0xffFAF5F6),
                          borderRadius: BorderRadius.circular(20),
                          border: BoxBorder.all(color: Colors.black,width:2)
                      ),
                    ),
                  ),
                ],
              ),
              Gap(20),
              CustomButton(text: "Start Flow", onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (c)=> PhysicalSymptomsScreen()));
              })
            ],
          ),
        ),
      )
    );
  }
}
