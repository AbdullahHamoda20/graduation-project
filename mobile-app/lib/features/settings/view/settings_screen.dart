import 'package:flutter/material.dart';
import 'package:pcos_app/core/constants/app_colors.dart';
import 'package:pcos_app/core/network/perf_helper.dart';
import 'package:pcos_app/features/auth/view/login_screen.dart';
import 'package:pcos_app/features/home/view/root.dart';
import '../../../core/constants/app_strings.dart';
import '../../auth/view/profile_screen.dart';
import 'about_us_screen.dart';
import 'contact_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color primaryPink = Color(0xFFE96677);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffDA5F71),
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (c) => RootScreen()),
            );
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          AppStrings.settings,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),

              buildItem(
                context,
                Icons.person,
                "Your Profile",
                primaryPink,
                ProfileScreen(),
              ),

              buildItem(
                context,
                Icons.info_outline,
                "About Us",
                primaryPink,
                AboutUsScreen(),
              ),

              buildItem(
                context,
                Icons.email,
                "Contact Us",
                primaryPink,
                ContactUsScreen(),
              ),

              ListTile(
                // Padding
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                leading: Icon(
                  Icons.logout,
                  color: AppColors.buttoColor,
                  size: 30,
                ),
                title: Text(
                  AppStrings.logout,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  PrefHelper.clearToken();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (c) => LoginScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
    Widget? page,
  ) {
    return ListTile(
      // Padding
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      leading: Icon(icon, color: color, size: 30),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.grey[700],
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        }
      },
    );
  }
}
