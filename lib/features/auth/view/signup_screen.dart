import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:pcos_app/core/constants/app_colors.dart';
import 'package:pcos_app/core/constants/app_strings.dart';
import 'package:pcos_app/core/network/api_error.dart';
import 'package:pcos_app/core/shared/AppValidations.dart';
import 'package:pcos_app/core/shared/custom_button.dart';
import 'package:pcos_app/core/shared/screen_size.dart';
import 'package:pcos_app/features/auth/data/auth_repository.dart';
import 'package:pcos_app/features/auth/widget/auth_layout.dart';
import 'package:pcos_app/features/onboarding/view/after_login.dart';
import '../../../core/shared/custom_text_field.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordObscure = true;
  bool isConfirmObscure = true;
  bool rememberMeController = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
    bool isLoading = false;
  AuthRepo authRepo = AuthRepo();
  Future <void> signup() async{

    try{
      setState(()=> isLoading=true);
        final user = await authRepo.signup(usernameController.text.trim(),emailController.text.trim(), passwordController.text.trim(), confirmPassController.text.trim());
        if(user!=null){
          Navigator.push(context, MaterialPageRoute(builder: (c)=>LoginScreen()));
        }
      setState(()=> isLoading=false);
    }catch (e){
      setState(()=> isLoading=false);
      String errMs = "Error in Register";
      if(e is ApiError){
        errMs =e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            clipBehavior: Clip.none,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 30,right: 20,left: 20),
            elevation: 10,
            content: Row(
              children: [
                Icon(CupertinoIcons.info,color: Colors.white ,),
                Gap(14),
                Text(errMs,style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis),),
              ],
            ),
            backgroundColor: Colors.red.shade900,
          ));
    }
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    confirmPassController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
        child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Gap(ScreenSize(context).height * 0.12),

          Text(
            AppStrings.signup,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.header,
              fontWeight: FontWeight.w700,
              fontSize: 40,
            ),
          ),

          Gap(ScreenSize(context).height * .04),

          CustomTextField(
            controller: usernameController,
            hint: AppStrings.username,
            prefixIcon: CupertinoIcons.person_alt,
            keyboardType: TextInputType.text,
            validator: AppValidations.validateName,
          ),

          Gap(ScreenSize(context).height * .04),

          CustomTextField(
            controller: emailController,
            hint: AppStrings.email,
            prefixIcon: CupertinoIcons.mail_solid,
            keyboardType: TextInputType.emailAddress,
            validator: AppValidations.validateEmail,
          ),

          Gap(ScreenSize(context).height * .04),

          CustomTextField(
            controller: passwordController,
            hint: AppStrings.password,
            prefixIcon: CupertinoIcons.lock_fill,
            isPassword: true,
            isObscure: isPasswordObscure,
            toggleObscure: () {
              setState(() {
                isPasswordObscure = !isPasswordObscure;
              });
            },
            validator: AppValidations.validatePassword,
          ),

          Gap(ScreenSize(context).height * .04),

          CustomTextField(
            controller: confirmPassController,
            hint: AppStrings.confirmPassword,
            prefixIcon: CupertinoIcons.lock_fill,
            isPassword: true,
            isObscure: isConfirmObscure,
            toggleObscure: () {
              setState(() {
                isConfirmObscure = !isConfirmObscure;
              });
            },
            validator: (value) => AppValidations.validateConfirmPassword(
                passwordController.text,
                value ,
            ),
          ),

          Gap(ScreenSize(context).height * .04),
          isLoading? CupertinoActivityIndicator():
          CustomButton(
            text: AppStrings.signup,
            onTap: () {
                if (_formKey.currentState!.validate()) {
                  signup();
                }
            },
          ),

          Gap(ScreenSize(context).height * .01),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.haveAccount,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff656565),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: Text(
                  AppStrings.login,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: AppColors.header,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}