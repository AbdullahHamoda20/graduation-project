import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pcos_app/core/constants/app_colors.dart';
import 'package:pcos_app/core/shared/screen_size.dart';
import 'package:pcos_app/features/home/view/root.dart';
import 'package:provider/provider.dart';

import '../../clinical_data/data/ClinicalDataProvider.dart';

class TipsScreen extends StatefulWidget {
  TipsScreen({super.key});

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ClinicalDataProvider>();

    return Container(
      color: Colors.white,
      child: SafeArea(
        maintainBottomViewPadding: true,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
            title: Text(
              "PCOS Tips & Self-Care",
              style: TextStyle(
                color: Color(0xffDA5F71),
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Gap(ScreenSize(context).height * .02),

                    // Nutrition Section
                    buildTipCard(
                      title: "Nutrition",
                      tips: [
                        "Reduce sugar and processed foods",
                        "Eat more veggies and protein",
                        "Drink plenty of water",
                      ],
                    ),
                    Gap(ScreenSize(context).height * .02),

                    // Exercise Section
                    buildTipCard(
                      title: "Exercise",
                      tips: [
                        "Walk for 30 minutes daily",
                        "Try yoga or light workouts",
                        "Take good rest between sessions",
                      ],
                    ),
                    Gap(ScreenSize(context).height * .02),

                    // Lifestyle Section
                    buildTipCard(
                      title: "Lifestyle",
                      tips: [
                        "Sleep 7–8 hours",
                        "Manage your stress",
                        "Take time for yourself every day",
                      ],
                    ),
                    Gap(ScreenSize(context).height * .03),

                    // Additional Advice
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xffF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Check your lab results every 6 months",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff5C5C5C),
                        ),
                      ),
                    ),
                    Gap(ScreenSize(context).height * .1),
                  ],
                ),
              ),
            ),
          ),
          bottomSheet: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RootScreen(), // next screen
                  ),
                );
                provider.reset();
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.buttoColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Back to home',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Tip Card Widget
  Widget buildTipCard({required String title, required List<String> tips}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xffFCE4E8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xffDA5F71), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xffDA5F71),
            ),
          ),
          Gap(12),
          ...tips
              .asMap()
              .entries
              .map(
                (entry) => Padding(
                  padding: EdgeInsets.only(
                    bottom: entry.key != tips.length - 1 ? 10 : 0,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "• ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      Gap(8),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff5C5C5C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
