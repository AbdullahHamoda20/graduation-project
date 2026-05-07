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
import 'package:pcos_app/features/auth/view/signup_screen.dart';
import 'package:pcos_app/features/auth/widget/auth_layout.dart';
import 'package:pcos_app/features/onboarding/view/after_login.dart';
import '../../../core/shared/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  bool isLoading =false;
  bool rememberMeController = false;
  TextEditingController emailController = TextEditingController() ;
  TextEditingController passwordController = TextEditingController() ;
  AuthRepo authRepo = AuthRepo();
  Future <void> login () async {
    setState(()=> isLoading=true );
    try{
      final user = await authRepo.login(emailController.text.trim(), passwordController.text.trim());
      if(user!=null){
        Navigator.push(context, MaterialPageRoute(builder: (c)=> AfterLogin()));
      }
      setState(()=> isLoading=false );
    }catch(e){
      setState(()=> isLoading=false );

      String errorMsg = "Unhandled Error";
      if(e is ApiError){
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            clipBehavior: Clip.none,
            padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 30,right: 20,left: 20),
              elevation: 10,
              content: Row(
                children: [
                  Icon(CupertinoIcons.info,color: Colors.white ,),
                  Gap(14),
                  Text(errorMsg,style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600),),
                ],
              ),
            backgroundColor: Colors.red.shade900,
          )
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child:Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Gap(ScreenSize(context).height*0.13),
            Text(
              AppStrings.login,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.header,
                fontWeight: FontWeight.w700,
                fontSize: 40,
              ),),
            Gap(ScreenSize(context).height*.04),
            CustomTextField(
              controller: emailController,
              hint: AppStrings.email,
              prefixIcon: CupertinoIcons.mail_solid,
              keyboardType: TextInputType.emailAddress,
              validator: AppValidations.validateEmail
            ),
            Gap(ScreenSize(context).height*.03),
            CustomTextField(
              controller: passwordController,
              hint: AppStrings.password,
              prefixIcon: CupertinoIcons.lock_fill,
              isPassword: true,
              isObscure: isObscure,
              toggleObscure: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
                keyboardType: TextInputType.visiblePassword,
              validator: AppValidations.validatePassword
            ),
            Gap(ScreenSize(context).height*.04),
            Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    setState(() {
                      rememberMeController = !rememberMeController;
                    });
                  },
                  child: Row(
                    children: [
                      Checkbox(
                        value: rememberMeController,
                        onChanged: (value) {
                          setState(() {
                            rememberMeController = value!;
                          });
                        },
                        activeColor: AppColors.header,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Text(
                        AppStrings.rememberMe,
                        style: TextStyle(
                          color: Color(0xffD63F67),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                TextButton(onPressed: (){}, child: Text(AppStrings.forgotPassword,style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.header
                ),))
              ],
            ),
            Gap(ScreenSize(context).height*.03),
            isLoading ? CupertinoActivityIndicator():
            CustomButton(
              text: AppStrings.login,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  login();
                }
              },
            ),
            Gap(ScreenSize(context).height*.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.noAccount,
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xff656565)),
                ),
                TextButton(onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const SignupScreen()),
                  );
                }, child: Text(AppStrings.signup,style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.header
                ),))
              ],
            )
          ],
        ),
      ),
    );
  }
}
