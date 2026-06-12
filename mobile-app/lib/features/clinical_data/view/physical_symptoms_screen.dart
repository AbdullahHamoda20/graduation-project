import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/shared/screen_size.dart';
import '../data/ClinicalDataProvider.dart';
import '../data/pcos_data_models.dart';
import 'demographic_info_screen.dart';

class PhysicalSymptomsScreen extends StatelessWidget {
  const PhysicalSymptomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ClinicalDataProvider>();

    ClinicalDataModel data = provider.data;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        provider.reset();
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          leading: GestureDetector(
            onTap: () {
              provider.reset();
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: const Text(
            "Clinical Data Input",
            style: TextStyle(
              color: Color(0xffDA5F71),
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),

        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(right: 5, left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Gap(ScreenSize(context).height * .025),

                const Text(
                  AppStrings.physicalSymptoms,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff464646),
                  ),
                ),

                Gap(ScreenSize(context).height * .02),

                const Text(
                  AppStrings.selectAllApply,
                  style: TextStyle(
                    color: Color(0xffD63F67),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Gap(ScreenSize(context).height * .02),

                /// Hair Growth
                const Text(
                  AppStrings.hairGrowth,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xff5C5C5C),
                  ),
                ),

                CheckboxListTile(
                  title: const Text(
                    AppStrings.hairGrowthDesc,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  value: data.hairGrowth ?? false,
                  onChanged: (value) {
                    provider.setHairGrowth(value ?? false);
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                /// Skin Changes
                const Text(
                  AppStrings.skinChanges,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xff5C5C5C),
                  ),
                ),

                CheckboxListTile(
                  title: const Text(
                    AppStrings.skinChangesDesc,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  value: data.skinDarkening ?? false,
                  onChanged: (value) {
                    provider.setSkinDarkening(value ?? false);
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                /// Weight Changes
                const Text(
                  AppStrings.weightChanges,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xff5C5C5C),
                  ),
                ),

                CheckboxListTile(
                  title: const Text(
                    AppStrings.weightChangesDesc1,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  value: data.weightGain ?? false,
                  onChanged: (value) {
                    provider.setWeightGain(value ?? false);
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                CheckboxListTile(
                  title: const Text(
                    AppStrings.weightChangesDesc2,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  value: data.difficultyLosingWeight ?? false,
                  onChanged: (value) {
                    provider.setDifficultyLosingWeight(value ?? false);
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                /// Acne
                const Text(
                  AppStrings.acnePimples,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xff5C5C5C),
                  ),
                ),

                CheckboxListTile(
                  title: const Text(
                    AppStrings.acneDesc,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  value: data.pimples ?? false,
                  onChanged: (value) {
                    provider.setPimples(value ?? false);
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                /// Hair Loss
                const Text(
                  AppStrings.hairLoss,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xff5C5C5C),
                  ),
                ),

                CheckboxListTile(
                  title: const Text(
                    AppStrings.hairLossDesc,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  value: data.hairLoss ?? false,
                  onChanged: (value) {
                    provider.setHairLoss(value ?? false);
                    log(data.toApiJson().toString());
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                Gap(ScreenSize(context).height * .14),
              ],
            ),
          ),
        ),

        bottomSheet: Container(
          width: double.infinity,
          color: Colors.white,
          child: Container(
            color: Colors.transparent,
            margin: EdgeInsets.only(
              bottom: 25,
              right: ScreenSize(context).width * 0.25,
              left: ScreenSize(context).width * 0.25,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DemographicInfoScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xffE56D83),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      AppStrings.next,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Gap(ScreenSize(context).width * .02),
                    const Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
