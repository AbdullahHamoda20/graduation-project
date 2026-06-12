import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pcos_app/core/constants/app_strings.dart';
import 'package:pcos_app/core/shared/custom_button.dart';
import 'package:pcos_app/core/shared/screen_size.dart';
import 'package:pcos_app/features/clinical_data/data/ClinicalDataProvider.dart';
import 'package:pcos_app/features/clinical_data/view/physical_symptoms_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_assets.dart';
import '../../settings/view/settings_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: Image.asset(AppAssets.appBarLeadingIcon),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingsScreen()),
              );
            },
            icon: Image.asset(AppAssets.appBarActionIcon),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 45.0, right: 16, left: 16),

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
                        image: DecorationImage(
                          image: AssetImage("assets/images/start_1.png"),
                          fit: BoxFit.fill,
                        ),
                        color: Color(0xffFAF5F6),
                        borderRadius: BorderRadius.circular(20),
                        border: BoxBorder.all(
                          color: Colors.pink.shade200,
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  // Expanded(child:Container(
                  //   padding: EdgeInsets.symmetric(vertical: 30,horizontal: 5),
                  //   width: double.infinity,
                  //   height: 250,
                  //   decoration: BoxDecoration(
                  //     color: Color(0xffFAF5F6),
                  //     borderRadius: BorderRadius.circular(20),
                  //     border: BoxBorder.all(color: Colors.pink.shade200, width: 2),
                  //   )
                  //     ,child:Column(
                  //       children: [
                  //         Icon(CupertinoIcons.doc_on_clipboard_fill,color: Colors.pink.shade200,size: 50,),
                  //         Gap(ScreenSize(context).height*0.03),
                  //         Text(AppStrings.clinicalDataInput,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color(0xffDA5F71)),),
                  //         Gap(ScreenSize(context).height*0.03),
                  //         Text(AppStrings.clinicalDataDesc,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Color(0xff5C5E5E)),textAlign: TextAlign.center,maxLines: 3)
                  //
                  //       ],
                  //     ),
                  // )),
                  Gap(20),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/start_2.png"),
                          fit: BoxFit.fill,
                        ),
                        color: Color(0xffFAF5F6),
                        borderRadius: BorderRadius.circular(20),
                        border: BoxBorder.all(
                          color: Colors.pink.shade200,
                          width: 2,
                        ),
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
                        image: DecorationImage(
                          image: AssetImage("assets/images/start_3.png"),
                          fit: BoxFit.fill,
                        ),
                        color: Color(0xffFAF5F6),
                        borderRadius: BorderRadius.circular(20),
                        border: BoxBorder.all(
                          color: Colors.pink.shade200,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  Gap(20),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/start_4.png"),
                          fit: BoxFit.fill,
                        ),
                        color: Color(0xffFAF5F6),
                        borderRadius: BorderRadius.circular(20),
                        border: BoxBorder.all(
                          color: Colors.pink.shade200,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(30),
              CustomButton(
                text: "Start Flow",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => PhysicalSymptomsScreen()),
                  );
                },
              ),
              Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}
