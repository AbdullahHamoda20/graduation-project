
import 'package:flutter/material.dart';

Widget customTextField({required String label,required TextEditingController controller,  Function ?validator}) {
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
          width: 80,
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFFCE4EC),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            border: Border.all(color: const Color(0xFFF8BBD0)),
          ),
          child: Text(label, style: const TextStyle(color: Colors.black54)),
        ),
        Expanded(
          child: SizedBox(
            height: 45,
            child: TextFormField(
              // enabled: false,
              readOnly: true,
              controller: controller,
              validator: null,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  borderSide: BorderSide(color: Color(0xFFF8BBD0)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  borderSide: BorderSide(color: Color(0xFFE57385)),
                ),
                border: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
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
