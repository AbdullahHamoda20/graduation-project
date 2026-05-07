import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:io';
import 'package:pcos_app/core/constants/app_colors.dart';
import 'package:pcos_app/core/shared/screen_size.dart';
import 'package:pcos_app/features/clinical_data/data/clinical_data_model.dart';
import '../../tips/view/tips_screen.dart';

class ResultScreen extends StatefulWidget {
  final ClinicalDataModel? clinicalData;
  final File? ultrasoundImage;

  const ResultScreen({
    super.key,
    this.clinicalData,
    this.ultrasoundImage,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ClinicalDataModel data;
  bool isPcosPositive = false;

  @override
  void initState() {
    super.initState();
    data = widget.clinicalData ?? ClinicalDataModel();
    calculatePCOSDiagnosis();
  }

  void calculatePCOSDiagnosis() {
    int pcosIndicators = 0;

    // 1. Menstrual cycle
    if (data.menstrualCycleRegular == false) {
      pcosIndicators++;
    }

    // 2. Symptoms
    if ((data.hairGrowth ?? false) ||
        (data.skinDarkening ?? false) ||
        (data.weightGain ?? false) ||
        (data.pimples ?? false)) {
      pcosIndicators++;
    }

    // 3. Ultrasound
    if (widget.ultrasoundImage != null) {
      pcosIndicators++;
    }

    // 4. BMI
    if (data.bmi != null && data.bmi! > 25) {
      pcosIndicators++;
    }

    isPcosPositive = pcosIndicators >= 2;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(ScreenSize(context).height * .05),

                  // Uterus Illustration


                  Gap(ScreenSize(context).height * .04),

                  // Result Box
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xffFCE4E8),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xffDA5F71),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "PCOS Diagnosis :",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const Gap(12),

                        Text(
                          isPcosPositive ? "Positive" : "Negative",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: isPcosPositive
                                ? const Color(0xffDA5F71)
                                : const Color(0xff4CAF50),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Gap(ScreenSize(context).height * .06),

                  // Analysis Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xffF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Analysis Summary",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const Gap(12),

                        buildDetailRow(
                          "Menstrual Cycle",
                          data.menstrualCycleRegular == true
                              ? "Regular"
                              : data.menstrualCycleRegular == false
                              ? "Irregular"
                              : "Not specified",
                        ),

                        const Gap(8),

                        buildDetailRow(
                          "BMI",
                          data.bmi != null
                              ? "${data.bmi!.toStringAsFixed(1)}"
                              " (${data.bmi! > 25 ? "Overweight" : "Normal"})"
                              : "Not measured",
                        ),

                        const Gap(8),

                        buildDetailRow(
                          "Physical Symptoms",
                          "${_countSymptoms()} found",
                        ),

                        const Gap(8),

                        buildDetailRow(
                          "Ultrasound Image",
                          widget.ultrasoundImage != null
                              ? "Uploaded"
                              : "Not uploaded",
                        ),
                      ],
                    ),
                  ),

                  Gap(ScreenSize(context).height * .05),

                  // Recommendation
                  Text(
                    isPcosPositive
                        ? "Based on the analysis, you may have PCOS. Please consult a healthcare provider."
                        : "PCOS diagnosis is unlikely. Continue healthy lifestyle habits.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff5C5C5C),
                    ),
                  ),

                  Gap(ScreenSize(context).height * .08),
                ],
              ),
            ),
          ),

          bottomSheet: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TipsScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.buttoColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Tips & Self-Care',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                const Gap(12),

                InkWell(
                  onTap: () {
                    Navigator.popUntil(
                      context,
                          (route) => route.isFirst,
                    );
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppColors.buttoColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xff5C5C5C),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  int _countSymptoms() {
    int count = 0;

    if (data.hairGrowth ?? false) count++;
    if (data.skinDarkening ?? false) count++;
    if (data.weightGain ?? false) count++;
    if (data.difficultyLosingWeight ?? false) count++;
    if (data.pimples ?? false) count++;
    if (data.hairLoss ?? false) count++;

    return count;
  }
}