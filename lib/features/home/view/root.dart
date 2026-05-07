import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcos_app/core/constants/app_colors.dart';
import 'package:pcos_app/core/constants/app_strings.dart';
import 'package:pcos_app/features/clinical_data/view/start_screen.dart';
import 'package:pcos_app/features/home/view/home_screen.dart';
import 'package:pcos_app/features/settings/view/contact_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {

  late PageController pageController;
  late List<Widget> screens;
  int currentScreen = 0;

  @override
  void initState() {
    super.initState();

    screens =  [
      HomeScreen(),
      StartScreen(),
      ContactUsScreen(leadingIcon: false,),
    ];

    pageController = PageController(initialPage: currentScreen);
  }

  @override
  void dispose() {
    pageController.dispose(); // 🔥 مهم
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ================= BODY =================
      body: PageView(
        controller: pageController,

        // 🔥 يخلي الـ nav يتغير مع الـ swipe
        onPageChanged: (index) {
          setState(() {
            currentScreen = index;
          });
        },

        children: screens,
      ),

      // ================= NAV =================
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(left:10 ,right: 10,bottom: 20),
        decoration: BoxDecoration(
          color: AppColors.header,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),

          child: BottomNavigationBar(
            currentIndex: currentScreen,

            onTap: (index) {
              setState(() => currentScreen = index);

              // 🔥 animation أحلى من jump
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },

            elevation: 0,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,

            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.white70,

            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.home,
                  size: currentScreen == 0 ? 28 : 22, // 🔥 animation بسيطة
                ),
                label: AppStrings.home,
              ),

              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.add_circled,
                  size: currentScreen == 1 ? 28 : 22,
                ),
                label: AppStrings.start,
              ),

              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.mail_solid,
                  size: currentScreen == 2 ? 28 : 22,
                ),
                label: AppStrings.contactUs,
              ),
            ],
          ),
        ),
      ),
    );
  }
}