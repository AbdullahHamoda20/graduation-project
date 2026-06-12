import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pcos_app/core/shared/AppValidations.dart';
import 'package:pcos_app/core/shared/custom_text_field.dart';
import 'package:pcos_app/core/shared/screen_size.dart';
import 'package:pcos_app/features/auth/view/profile_screen.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/network/api_error.dart';
import '../data/auth_repository.dart';

class ChangePasswordScreen extends StatefulWidget {

  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordObscure = true;
  bool isConfirmObscure = true;
  bool isCurrentObscure = true;
  bool isLoading =false;

   TextEditingController currentPass  =TextEditingController();
   TextEditingController newPass =TextEditingController();
   TextEditingController confirmPass=TextEditingController() ;

  AuthRepo authRepo = AuthRepo();
  Future<void> updatePass() async {
    setState(() => isLoading = true);

    try {
      final user = await authRepo.changePass(
        currentPass: currentPass.text.trim(),
        newPass: newPass.text.trim(),
        confirmPass: confirmPass.text.trim(),
      );

      setState(() => isLoading = false);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text(
                "Password changed successfully",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
        ),
      );
    } catch (e) {
      setState(() => isLoading = false);

      String errorMsg = "Unhandled Error";

      if (e is ApiError) {
        errorMsg = e.message;
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
          backgroundColor: const Color(0xffc65d90),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          content: Row(
            children: [
              const Icon(Icons.info, color: Colors.white),
              const SizedBox(width: 10),
              Text(
                errorMsg,
                style: const TextStyle(color: Colors.white,fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          leading: GestureDetector(onTap:(){Navigator.push(context, MaterialPageRoute(builder:(c)=> ProfileScreen()));},child: Icon(Icons.arrow_back,color: Colors.black),),
          title: Text("Update Password",style: TextStyle(color: Color(0xffDA5F71),fontWeight: FontWeight.w700,fontSize: 20),),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  AppAssets.authBackgroundImage,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Gap(50),
                      // Current Password
                      CustomTextField(
                        controller: currentPass,
                        prefixIcon: CupertinoIcons.lock_fill,
                        isPassword: true,
                        isObscure: isCurrentObscure,
                        toggleObscure: () {
                          setState(() {
                            isCurrentObscure = !isCurrentObscure;
                          });
                        },
                        validator: AppValidations.validatePassword,
                        isHint: true,
                        isLabel: true,
                        label: "Current Password",
                        hint: "Enter Current Password",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),
                      ),
                  
                      Gap(40),
                  
                      // New Password
                      CustomTextField(
                        controller: newPass,
                        prefixIcon: CupertinoIcons.lock_fill,
                        isPassword: true,
                        isObscure: isPasswordObscure,
                        toggleObscure: () {
                          setState(() {
                            isPasswordObscure = !isPasswordObscure;
                          });
                        },
                        validator: AppValidations.validatePassword,
                        isHint: true,
                        isLabel: true,
                        label: "New Password",
                        hint: "Enter New Password",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),
                      ),
                  
                      Gap(40),
                  
                      // Confirm Password
                      CustomTextField(
                        controller: confirmPass,
                        prefixIcon: CupertinoIcons.lock_fill,
                        isPassword: true,
                        isObscure: isConfirmObscure,
                        toggleObscure: () {
                          setState(() {
                            isConfirmObscure = !isConfirmObscure;
                          });
                        },
                        validator: (value) =>
                            AppValidations.validateConfirmPassword(
                              newPass.text,
                              value,
                            ),
                        isHint: true,
                        isLabel: true,
                        label: "Confirm New Password",
                        hint: "Enter Confirm Password",
                        labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      Gap(40),

                      isLoading
                          ? Center(
                            child: CupertinoActivityIndicator(),
                          )
                          : InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            updatePass();
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          height: ScreenSize(context).height * .08,
                          // width: ScreenSize(context).width * .914,
                          decoration: BoxDecoration(
                            color: const Color(0xffE56D83),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Text(
                            AppStrings.changePassword,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )

              // CustomButton(text: "Change Your Password",
              //
              //   onTap: () {
              //   if (_formKey.currentState!.validate()) {
              //     updatePass();
              //   }
              // },)
            ],
          )
        ),
      ),
    );
  }
}
