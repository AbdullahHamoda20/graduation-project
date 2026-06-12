import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pcos_app/core/constants/app_colors.dart';
import 'package:pcos_app/core/constants/app_strings.dart';
import 'package:pcos_app/core/network/api_error.dart';
import 'package:pcos_app/core/shared/custom_text_field.dart';
import 'package:pcos_app/features/auth/data/auth_model.dart';
import 'package:pcos_app/features/auth/data/auth_repository.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/shared/AppValidations.dart';
import '../../settings/view/settings_screen.dart';
import 'change_password_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  UserModel? userModel;

  final AuthRepo authRepo = AuthRepo();

  // ---------------- GET PROFILE ----------------
  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();

      setState(() {
        userModel = user;

        // fill controllers مباشرة هنا
        nameController.text = user?.username ?? "";
        emailController.text = user?.email ?? "";
      });
    } catch (e) {
      String errorMsg = "Error in Profile";

      if (e is ApiError) {
        errorMsg = e.message;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMsg)));
    }
  }

  // ---------------- UPDATE PROFILE ----------------
  Future<void> updateProfile() async {
    setState(() => isLoading = true);

    try {
      final user = await authRepo.updataProfileData(
        username: nameController.text.trim(),
        email: emailController.text.trim(),
      );

      setState(() {
        userModel = user;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(CupertinoIcons.info, color: Colors.white),
              Gap(10),
              const Text("Profile updated successfully"),
            ],
          ),
          backgroundColor: const Color(0xffc65d90),
          behavior: SnackBarBehavior.floating,
          clipBehavior: Clip.none,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          margin: const EdgeInsets.only(bottom: 180, right: 20, left: 20),
        ),
      );

      // refresh data
      await getProfileData();
    } catch (e) {
      String errorMsg = "Failed to update profile";

      if (e is ApiError) {
        errorMsg = e.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg), backgroundColor: AppColors.header),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  // ---------------- INIT ----------------
  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingsScreen()),
              );
            },
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: const Text(
            AppStrings.myProfile,
            style: TextStyle(
              color: Color(0xffDA5F71),
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Center(
            child: Skeletonizer(
              enabled: userModel == null,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Gap(20),

                    CustomTextField(
                      controller: nameController,
                      prefixIcon: CupertinoIcons.person_alt,
                      borderRadius: 30,
                      isLabel: true,
                      label: "    User Name",
                      validator: AppValidations.validateName,
                    ),

                    const Gap(40),

                    CustomTextField(
                      enabled: false,
                      controller: emailController,
                      prefixIcon: CupertinoIcons.mail_solid,
                      borderRadius: 30,
                      isLabel: true,
                      label: "    Email",
                      validator: AppValidations.validateEmail,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // ---------------- BOTTOM BUTTONS ----------------
        bottomSheet: Container(
          color: Colors.white,
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: [
              // EDIT PROFILE
              InkWell(
                onTap: () {
                  if (isLoading) return;

                  if (_formKey.currentState!.validate()) {
                    updateProfile();
                  }
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.buttoColor,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Center(
                    child: isLoading
                        ? const CupertinoActivityIndicator()
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.edit_document, color: Colors.white),
                              Gap(8),
                              Text(
                                'Edit Profile',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),

              const Gap(20),

              // CHANGE PASSWORD
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ChangePasswordScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.buttoColor,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.password_outlined, color: Colors.white),
                        Gap(8),
                        Text(
                          'Update Pass',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
