import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/network/perf_helper.dart';
import '../../auth/view/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  void nextPage() async {
    if (currentIndex < 3) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      await PrefHelper.setOnboardingSeen();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  void previousPage() {
    if (currentIndex > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex == index
            ? AppColors.buttoColor
            : Colors.grey.shade300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildNormalPage(
        image: AppAssets.firstOnboardingScreenImage,
        title: AppStrings.onboarding1Title,
        desc: AppStrings.onboarding1Desc,
      ),
      _buildNormalPage(
        image: AppAssets.secondOnboardingScreenImage,
        title: AppStrings.onboarding2Title,
        desc: AppStrings.onboarding2Desc,
      ),
      _buildNormalPage(
        image: AppAssets.thirdOnboardingScreenImage,
        title: AppStrings.onboarding3Title,
        desc: AppStrings.onboarding3Desc,
      ),
      _buildFourthPage(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// Top Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  currentIndex != 0
                      ? TextButton(
                          onPressed: previousPage,
                          child: const Text(
                            AppStrings.back,
                            style: TextStyle(
                              color: AppColors.back_skip_buttons,
                            ),
                          ),
                        )
                      : const SizedBox(),

                  TextButton(
                    onPressed: () async {
                      await PrefHelper.setOnboardingSeen();

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      AppStrings.skip,
                      style: TextStyle(color: AppColors.back_skip_buttons),
                    ),
                  ),
                ],
              ),
            ),

            /// Pages
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) => pages[index],
              ),
            ),

            /// Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, buildDot),
            ),

            const SizedBox(height: 30),

            /// Next Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttoColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: nextPage,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        AppStrings.next,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Gap(10),
                      const Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// First 3 Pages
  Widget _buildNormalPage({
    required String image,
    required String title,
    required String desc,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const SizedBox(height: 30),

          Image.asset(image, height: 270, fit: BoxFit.contain),

          const Spacer(),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.header,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.description,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  /// Fourth Page
  Widget _buildFourthPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const SizedBox(height: 10),
          Image.asset(
            AppAssets.lastOnboardingScreenImage,
            fit: BoxFit.cover,
            height: 150,
          ),
          const SizedBox(height: 30),
          const Text(
            AppStrings.onboarding4Title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.header,
            ),
          ),
          const SizedBox(height: 20),
          _buildPoint(AppStrings.onboarding4Point1),
          const SizedBox(height: 10),
          _buildPoint(AppStrings.onboarding4Point2),
          const SizedBox(height: 10),
          _buildPoint(AppStrings.onboarding4Point3),
          // const Spacer(),
        ],
      ),
    );
  }

  Widget _buildPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          width: 18,
          height: 18,
          decoration: const BoxDecoration(
            color: AppColors.buttoColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, size: 12, color: Colors.white),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.description,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
