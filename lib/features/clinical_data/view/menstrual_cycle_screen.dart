import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pcos_app/features/clinical_data/widget/demo_custom_textFeild.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/shared/custom_text_field.dart';
import '../../../core/shared/screen_size.dart';
import '../../auth/widget/customTextField_contactUs.dart';
import '../data/ClinicalDataProvider.dart';
import '../data/pcos_data_models.dart';
import 'upload_ultrasound_screen.dart';
import '../../result/view/result_screen.dart';

class MenstrualCycleScreen extends StatefulWidget {
  const MenstrualCycleScreen({super.key});

  @override
  State<MenstrualCycleScreen> createState() => _MenstrualCycleScreenState();
}

class _MenstrualCycleScreenState extends State<MenstrualCycleScreen> {
  late TextEditingController follicleNoRController;
  late TextEditingController follicleNoLController;
  late TextEditingController marriageStatusController;

  @override
  void initState() {
    super.initState();

    final data = context.read<ClinicalDataProvider>().data;

    follicleNoRController = TextEditingController(
      text: data.follicleNoR?.toString() ?? '',
    );

    follicleNoLController = TextEditingController(
      text: data.follicleNoL?.toString() ?? '',
    );

    marriageStatusController = TextEditingController(
      text: data.marriageStatus?.toString() ?? '',
    );

    /// LISTENERS

    follicleNoRController.addListener(() {
      final value = int.tryParse(follicleNoRController.text);

      context.read<ClinicalDataProvider>().setFollicles(r: value);
    });

    follicleNoLController.addListener(() {
      final value = int.tryParse(follicleNoLController.text);

      context.read<ClinicalDataProvider>().setFollicles(l: value);
    });

    marriageStatusController.addListener(() {
      final value = int.tryParse(marriageStatusController.text);

      context.read<ClinicalDataProvider>().setMarriageStatus(value ?? 0);
    });
  }

  @override
  void dispose() {
    follicleNoRController.dispose();
    follicleNoLController.dispose();
    marriageStatusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ClinicalDataProvider>();

    ClinicalDataModel data = provider.data;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          leading: GestureDetector(
            onTap: () {
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Gap(ScreenSize(context).height * .025),

                const Text(
                  AppStrings.menstrualCycle,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),

                Gap(ScreenSize(context).height * .025),

                /// FAST FOOD
                Text(
                  AppStrings.fastFoodFrequency,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffD63F67),
                  ),
                ),

                Gap(ScreenSize(context).height * .03),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),

                  margin: const EdgeInsets.symmetric(horizontal: 70),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),

                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// MINUS
                      GestureDetector(
                        onTap: () {
                          int current = data.fastFoodFrequency ?? 0;

                          if (current > 0) {
                            provider.setFastFood(current - 1);
                          }
                        },

                        child: Container(
                          padding: const EdgeInsets.all(8),

                          decoration: const BoxDecoration(
                            color: Color(0xffF3F3F3),
                            shape: BoxShape.circle,
                          ),

                          child: const Icon(Icons.remove),
                        ),
                      ),

                      Text(
                        "${data.fastFoodFrequency ?? 0}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffD63F67),
                        ),
                      ),

                      /// PLUS
                      GestureDetector(
                        onTap: () {
                          int current = data.fastFoodFrequency ?? 0;

                          if (current < 7) {
                            provider.setFastFood(current + 1);
                          }
                        },

                        child: Container(
                          padding: const EdgeInsets.all(8),

                          decoration: const BoxDecoration(
                            color: Color(0xffE56D83),
                            shape: BoxShape.circle,
                          ),

                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                Gap(ScreenSize(context).height * .04),

                /// EXERCISE
                Text(
                  AppStrings.regularExercise,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffD63F67),
                  ),
                ),

                Gap(ScreenSize(context).height * .02),

                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text(
                          AppStrings.yes,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        value: data.regularPhysicalActivity == true,

                        onChanged: (_) {
                          provider.setExercise(true);
                        },

                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),

                    Expanded(
                      child: CheckboxListTile(
                        title: const Text(
                          AppStrings.no,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        value: data.regularPhysicalActivity == false,

                        onChanged: (_) {
                          provider.setExercise(false);
                        },

                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ],
                ),

                Gap(ScreenSize(context).height * .04),

                /// FOLLICLES
                const Text(
                  "Do you have recent hormone lab results ?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffD63F67),
                  ),
                ),

                Gap(ScreenSize(context).height * .02),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: demoCustomTextField(
                          label: "Follicle_R",
                          width: 150,
                          controller: follicleNoRController,
                          readOnly: false,
                          keyboardType: TextInputType.number,
                        ),
                      ),

                      // const Expanded(
                      //   flex: 1,
                      //   child: Text(
                      //     "Follicle_No_R",
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.w800,
                      //       fontSize: 18,
                      //     ),
                      //   ),
                      // ),
                      //
                      // Gap(
                      //   ScreenSize(context).width *
                      //       .0255,
                      // ),
                      //
                      // Expanded(
                      //   flex: 2,
                      //   child: CustomTextField(
                      //     controller:
                      //     follicleNoRController,
                      //     hasPrefixIcon: false,
                      //     keyboardType:
                      //     TextInputType.number,
                      //   ),
                      // ),
                    ],
                  ),
                ),

                Gap(ScreenSize(context).height * .03),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: demoCustomTextField(
                          width: 150,
                          label: "Follicle_L",
                          controller: follicleNoLController,
                          readOnly: false,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      // const Expanded(
                      //   flex: 1,
                      //   child: Text(
                      //     "Follicle_No_L",
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.w800,
                      //       fontSize: 18,
                      //     ),
                      //   ),
                      // ),
                      //
                      // Gap(
                      //   ScreenSize(context).width * .04,
                      // ),
                      //
                      // Expanded(
                      //   flex: 2,
                      //   child: CustomTextField(
                      //     controller:
                      //     follicleNoLController,
                      //     hasPrefixIcon: false,
                      //     keyboardType:
                      //     TextInputType.number,
                      //   ),
                      // ),
                    ],
                  ),
                ),

                Gap(ScreenSize(context).height * .03),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: demoCustomTextField(
                          label: "Marriage Status",
                          width: 150,
                          controller: marriageStatusController,
                          readOnly: false,
                          keyboardType: TextInputType.number,
                        ),
                      ),

                      // const Expanded(
                      //   flex: 2,
                      //   child: Text(
                      //     "Marriage Status",
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.w800,
                      //       fontSize: 18,
                      //     ),
                      //   ),
                      // ),
                      //
                      // Expanded(
                      //   flex: 3,
                      //   child: CustomTextField(
                      //     controller:
                      //     marriageStatusController,
                      //     hasPrefixIcon: false,
                      //     keyboardType:
                      //     TextInputType.number,
                      //     hint: "Enter Years",
                      //   ),
                      // ),
                    ],
                  ),
                ),

                Gap(ScreenSize(context).height * .04),

                Gap(ScreenSize(context).height * .08),
              ],
            ),
          ),
        ),
        bottomSheet: GestureDetector(
          onTap: () {
            Navigator.push(
              context,

              MaterialPageRoute(builder: (_) => const UploadUltrasoundScreen()),
            );
          },

          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              margin: EdgeInsets.only(
                bottom: 25,

                right: ScreenSize(context).width * 0.25,

                left: ScreenSize(context).width * 0.25,
              ),
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
    );
  }
}
