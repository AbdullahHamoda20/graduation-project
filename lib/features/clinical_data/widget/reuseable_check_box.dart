import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

Widget buildCheckItem({
  required String title,
  required bool? value,
  required Function(bool?) onChanged,
}) {
  return CheckboxListTile(
    title: Text(
      title,
      style: const TextStyle(
        color: Color(0xff2E2E2E),
        fontWeight: FontWeight.w500,
      ),
    ),

    value: value ?? false,

    onChanged: (val) {
      onChanged(val ?? false);
    },

    activeColor: AppColors.header,
    checkColor: Colors.white,
    controlAffinity: ListTileControlAffinity.leading,
  );
}
