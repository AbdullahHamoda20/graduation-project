import 'package:flutter/material.dart';
import 'package:pcos_app/core/shared/screen_size.dart';

import '../constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;

   CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).width*.2),
        padding: EdgeInsets.symmetric(vertical:ScreenSize(context).height*.02),
        decoration: BoxDecoration(
          color: AppColors.buttoColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(color: Colors.white)
              : Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}