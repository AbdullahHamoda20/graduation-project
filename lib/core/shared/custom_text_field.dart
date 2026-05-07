import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String ? hint;
  final IconData ?prefixIcon;
  final bool isPassword;
  final bool isObscure;
  final VoidCallback? toggleObscure;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final double borderRadius;
  final bool isHint;
  final bool isLabel;
  final bool enabled;
  final String label;
  final TextStyle? labelStyle;
  final FloatingLabelBehavior? floatingLabelBehavior;

   CustomTextField({
    super.key,
    required this.controller,
     this.hint,
     this.prefixIcon,
    this.isPassword = false,
    this.isObscure = false,
    this.toggleObscure,
    this.borderRadius=30,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.isHint= true ,
    this.isLabel=false,
    this.label="",
    this.labelStyle,
     this.floatingLabelBehavior,
      this.enabled = true

  });

  @override
  Widget build(BuildContext context) {
    return Container(
     decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Color(0xffFFD9EB),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: isPassword ? isObscure : false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          enabled: enabled,
            floatingLabelBehavior: floatingLabelBehavior,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              isObscure ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: toggleObscure,
          )
              : null,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Color(0xffE5E5E5)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(width: 2, color: Color(0xffE5E5E5)),
          ),
          hintText: isHint?hint:null,
          filled: true,
          fillColor: Colors.white,
          labelText: isLabel?label:null,
          labelStyle: isLabel?labelStyle:null
        ),
      ),
    );
  }
}