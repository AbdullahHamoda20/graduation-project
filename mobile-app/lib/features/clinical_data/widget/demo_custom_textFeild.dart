import 'package:flutter/material.dart';

Widget demoCustomTextField({
  required String label,
  required TextEditingController controller,
  Function? validator,
  void Function(String)? onChanged,
  readOnly = true,
  TextInputType? keyboardType,
  double width = 80,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFE96677).withOpacity(0.1),
          blurRadius: 50,
          spreadRadius: 3,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: width,
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFFCE4EC),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            border: Border.all(color: const Color(0xFFF8BBD0)),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xff424141),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 45,
            child: TextFormField(
              onChanged: onChanged,
              // enabled: enabled,
              keyboardType: keyboardType,
              readOnly: readOnly,
              controller: controller,
              validator: null,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  borderSide: BorderSide(color: Color(0xFFF8BBD0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  borderSide: BorderSide(color: Color(0xFFE57385)),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  borderSide: BorderSide(color: Color(0xFFE57385)),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
