import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/shared/custom_text_field.dart';
import '../../../core/shared/screen_size.dart';
import '../data/ClinicalDataProvider.dart';
import '../data/pcos_data_models.dart';
import '../widget/demo_custom_textFeild.dart';
import 'menstrual_cycle_screen.dart';

class DemographicInfoScreen extends StatefulWidget {
  const DemographicInfoScreen({super.key});

  @override
  State<DemographicInfoScreen> createState() => _DemographicInfoScreenState();
}

class _DemographicInfoScreenState extends State<DemographicInfoScreen> {
  late TextEditingController age;
  late TextEditingController weight;
  late TextEditingController height;
  late TextEditingController bmi;
  late TextEditingController cycleLength;

  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<ClinicalDataProvider>(context, listen: false);

    final data = provider.data;

    age = TextEditingController(text: data.age?.toString() ?? '');

    weight = TextEditingController(text: data.weight?.toString() ?? '');

    height = TextEditingController(text: data.height?.toString() ?? '');

    bmi = TextEditingController(text: data.bmi?.toString() ?? '');

    cycleLength = TextEditingController(
      text: data.averageCycleLength?.toString() ?? '',
    );
  }

  void _onChanged(VoidCallback action) {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 300), action);
  }

  void _calculateBMI(ClinicalDataProvider provider) {
    final w = double.tryParse(weight.text);
    final h = double.tryParse(height.text);

    if (w != null && h != null && h > 0) {
      final bmiValue = w / ((h / 100) * (h / 100));

      bmi.text = bmiValue.toStringAsFixed(1);

      provider.setBMI(bmiValue);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();

    age.dispose();
    weight.dispose();
    height.dispose();
    bmi.dispose();
    cycleLength.dispose();

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
                  AppStrings.demographicInfo,

                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff464646),
                  ),
                ),

                Gap(ScreenSize(context).height * .04),

                demoCustomTextField(
                  label: "Age",
                  controller: age,
                  readOnly: false,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _onChanged(() {
                      provider.setAge(int.tryParse(value) ?? 0);
                    });
                  },
                ),

                /// AGE
                // Row(
                //   children: [
                //     const Expanded(
                //       flex: 1,
                //
                //       child: Text(
                //         "Age",
                //
                //         style: TextStyle(
                //           fontWeight: FontWeight.w800,
                //           fontSize: 18,
                //         ),
                //       ),
                //     ),
                //
                //     Expanded(
                //       flex: 6,
                //
                //       child: CustomTextField(
                //         controller: age,
                //
                //         label: "Age",
                //
                //         hint: "Enter Age",
                //
                //         hasPrefixIcon: false,
                //
                //         keyboardType: TextInputType.number,
                //
                //         onChanged: (value) {
                //           _onChanged(() {
                //             provider.setAge(int.tryParse(value) ?? 0);
                //           });
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                Gap(ScreenSize(context).height * .04),

                /// WEIGHT + HEIGHT
                Row(
                  children: [
                    // const Expanded(
                    //   flex: 1,
                    //
                    //   child: Text(
                    //     "Weight",
                    //
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.w800,
                    //       fontSize: 16,
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: demoCustomTextField(
                        label: "Weight",
                        controller: weight,
                        readOnly: false,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _onChanged(() {
                            final parsed = double.tryParse(value);

                            if (parsed != null) {
                              provider.setWeight(parsed);

                              _calculateBMI(provider);
                            }
                          });
                        },
                      ),
                    ),
                    Gap(ScreenSize(context).width * .01),

                    // Expanded(
                    //   flex: 2,
                    //
                    //   child: CustomTextField(
                    //     controller: weight,
                    //
                    //     label: "Weight",
                    //
                    //     hint: "70 Kg",
                    //
                    //     hasPrefixIcon: false,
                    //
                    //     keyboardType: TextInputType.number,
                    //
                    //     onChanged: (value) {
                    //       _onChanged(() {
                    //         final parsed = double.tryParse(value);
                    //
                    //         if (parsed != null) {
                    //           provider.setWeight(parsed);
                    //
                    //           _calculateBMI(provider);
                    //         }
                    //       });
                    //     },
                    //   ),
                    // ),
                    Gap(ScreenSize(context).width * .05),

                    // const Expanded(
                    //   flex: 1,
                    //
                    //   child: Text(
                    //     "Height",
                    //
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.w800,
                    //       fontSize: 16,
                    //     ),
                    //   ),
                    // ),

                    // Gap(ScreenSize(context).width * .01),
                    Expanded(
                      child: demoCustomTextField(
                        label: "Height",
                        controller: height,
                        readOnly: false,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _onChanged(() {
                            final parsed = double.tryParse(value);

                            if (parsed != null) {
                              provider.setHeight(parsed);

                              _calculateBMI(provider);
                            }
                          });
                        },
                      ),
                    ),
                    // Expanded(
                    //   flex: 2,
                    //
                    //   child: CustomTextField(
                    //     controller: height,
                    //
                    //     label: "Height",
                    //
                    //     hint: "170 Cm",
                    //
                    //     hasPrefixIcon: false,
                    //
                    //     keyboardType: TextInputType.number,
                    //
                    //     onChanged: (value) {
                    //       _onChanged(() {
                    //         final parsed = double.tryParse(value);
                    //
                    //         if (parsed != null) {
                    //           provider.setHeight(parsed);
                    //
                    //           _calculateBMI(provider);
                    //         }
                    //       });
                    //     },
                    //   ),
                    // ),
                  ],
                ),

                Gap(ScreenSize(context).height * .04),

                /// BMI
                Row(
                  children: [
                    // const Expanded(
                    //   flex: 1,
                    //
                    //   child: Text(
                    //     "BMI",
                    //
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.w800,
                    //       fontSize: 18,
                    //     ),
                    //   ),
                    // ),
                    //
                    // Gap(ScreenSize(context).height * .02),
                    //
                    // Expanded(
                    //   flex: 6,
                    //
                    //   child: CustomTextField(
                    //     controller: bmi,
                    //
                    //     enabled: false,
                    //
                    //     isLabel: true,
                    //   ),
                    // ),
                    Expanded(
                      child: demoCustomTextField(
                        label: "BMI",
                        controller: bmi,
                        readOnly: true,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),

                Gap(ScreenSize(context).height * .04),

                /// MENSTRUAL
                const Text(
                  AppStrings.menstrualCycle,

                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff464646),
                  ),
                ),

                Gap(ScreenSize(context).height * .02),

                const Text(
                  AppStrings.isCycleRegular,

                  style: TextStyle(
                    color: Color(0xffD63F67),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Gap(ScreenSize(context).height * .02),

                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text(
                          AppStrings.yes,
                          style: TextStyle(fontSize: 18),
                        ),
                        value: data.menstrualCycleRegular == true,

                        onChanged: (value) {
                          provider.setCycle(true);
                        },

                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),

                    Expanded(
                      child: CheckboxListTile(
                        title: const Text(
                          AppStrings.no,
                          style: TextStyle(fontSize: 18),
                        ),

                        value: data.menstrualCycleRegular == false,

                        onChanged: (value) {
                          provider.setCycle(false);
                        },

                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  ],
                ),

                Gap(ScreenSize(context).height * .02),

                const Text(
                  "Average Cycle Length",

                  style: TextStyle(
                    color: Color(0xff464646),
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),

                Gap(ScreenSize(context).height * .01),

                CustomTextField(
                  controller: cycleLength,

                  hint: "Enter Days Numbers",

                  hasPrefixIcon: false,

                  keyboardType: TextInputType.number,

                  onChanged: (value) {
                    _onChanged(() {
                      final parsed = int.tryParse(value);

                      if (parsed != null) {
                        provider.setCycleLength(parsed);
                      }
                    });
                  },
                ),

                Gap(ScreenSize(context).height * .15),
              ],
            ),
          ),
        ),

        bottomSheet: Container(
          color: Colors.white,
          width: double.infinity,
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
                    builder: (_) => const MenstrualCycleScreen(),
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
