import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pcos_app/features/result/view/heatMap_result_screen.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/shared/screen_size.dart';
import '../../clinical_data/data/ClinicalDataProvider.dart';
import '../../home/view/root.dart';
import '../../tips/view/tips_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ClinicalDataProvider>();
    final result = provider.result;

    if (provider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (provider.error != null) {
      return Scaffold(
        body: Center(
          child: Text(
            provider.error!,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    if (result == null) {
      return const Scaffold(body: Center(child: Text("No result found")));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("assets/images/result.png", height: 250),

              Gap(ScreenSize(context).height * .02),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(32),
                height: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: AppColors.resultGradient,
                  border: Border.all(width: 1, color: const Color(0xffABA8A8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "PCOS Diagnosis : ${result.diagnosis}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    Gap(10),

                    Text(
                      "overall_risk_score : ${result.riskScore}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    Gap(10),

                    Text(
                      "Diagnostic Method : ${result.diagnosticMethod}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    Gap(10),

                    Text(
                      "clinical_risk : ${(result.clinicalRisk == null || result.clinicalRisk.toString().contains("N/A")) ? "Not Filling Data" : result.clinicalRisk}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    Gap(10),

                    Text(
                      "ultrasound_risk : ${(result.ultrasoundRisk == null || result.ultrasoundRisk.toString().contains("N/A")) ? "Not Uploaded" : result.ultrasoundRisk}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),

              Gap(ScreenSize(context).height * .02),

              provider.data.ultrasoundImage != null
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HeatmapResultScreen(),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 20,
                        ),
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE56D83),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: const Text(
                          "Show HeatMap Image",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    )
                  : Container(),

              // Gap(ScreenSize(context).height * .02),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => TipsScreen()),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE56D83),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: const Text(
                    "Tips & Self Care",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RootScreen()),
                  );
                  provider.reset();
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 150,
                    vertical: 5,
                  ),
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE56D83),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: const Icon(Icons.home, color: Colors.white, size: 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
