import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:pcos_app/core/constants/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../auth/data/auth_model.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/widget/customTextField_contactUs.dart';
import '../../../core/network/api_error.dart';

class ContactUsScreen extends StatefulWidget {
  bool leadingIcon;

  ContactUsScreen({super.key, this.leadingIcon = true});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController mail = TextEditingController();
  TextEditingController message = TextEditingController();
  TextEditingController name = TextEditingController();

  bool isLoading = true; // تحميل الداتا
  bool isSending = false; // ارسال الرسالة

  UserModel? userModel;
  AuthRepo authRepo = AuthRepo();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  // ================= GET USER =================
  Future<void> getUserData() async {
    setState(() => isLoading = true);

    try {
      final user = await authRepo.getUsername();

      if (!mounted) return;

      setState(() {
        userModel = user;
        name.text = user?.username ?? "";
        mail.text = user?.email ?? "";
      });
    } catch (e) {
      if (!mounted) return;

      String errorMsg = "Error loading user data";
      if (e is ApiError) {
        errorMsg = e.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
          content: Row(
            children: [
              const Icon(CupertinoIcons.info, color: Colors.white),
              const Gap(10),
              Expanded(child: Text(errorMsg)),
            ],
          ),
          backgroundColor: Colors.red.shade900,
        ),
      );
    } finally {
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }

  // ================= SEND MESSAGE =================
  Future<void> sendMessage() async {
    if (message.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
          content: Row(
            children: const [
              Icon(CupertinoIcons.info, color: Colors.white),
              Gap(10),
              Text("Please enter your message"),
            ],
          ),
          backgroundColor: AppColors.header,
        ),
      );
      return;
    }

    setState(() => isSending = true);

    try {
      final responseMessage = await authRepo.sendContactMessage(
        name: name.text.trim(),
        email: mail.text.trim(),
        message: message.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
          content: Row(
            children: [
              const Icon(
                CupertinoIcons.check_mark_circled,
                color: Colors.white,
              ),
              const Gap(10),
              Expanded(child: Text(responseMessage)),
            ],
          ),
          backgroundColor: Colors.green,
        ),
      );

      message.clear();
    } catch (e) {
      if (!mounted) return;

      String errorMsg = "Failed to send message";
      if (e is ApiError) {
        errorMsg = e.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(bottom: 30, right: 20, left: 20),
          content: Row(
            children: [
              const Icon(CupertinoIcons.info, color: Colors.white),
              const Gap(10),
              Expanded(child: Text(errorMsg)),
            ],
          ),
          backgroundColor: Colors.red.shade900,
        ),
      );
    } finally {
      if (!mounted) return;
      setState(() => isSending = false);
    }
  }

  @override
  void dispose() {
    mail.dispose();
    message.dispose();
    name.dispose();
    super.dispose();
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: widget.leadingIcon,
        scrolledUnderElevation: 0,
        title: const Text(
          "Contact Us",
          style: TextStyle(
            color: Color(0xffDA5F71),
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),

      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),

                  Skeletonizer(
                    enabled: isLoading,
                    child: customTextField(label: "Name", controller: name),
                  ),

                  const SizedBox(height: 15),

                  Skeletonizer(
                    enabled: isLoading,
                    child: customTextField(label: "Email", controller: mail),
                  ),

                  const SizedBox(height: 15),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFCE4EC),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFF8BBD0)),
                    ),
                    child: const Text(
                      "Message",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextFormField(
                    controller: message,
                    maxLines: 6,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.pink.shade200,
                          width: 1,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.pink.shade200),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.pink.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.pink.shade200),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: isSending
                        ? const CupertinoActivityIndicator()
                        : ElevatedButton(
                            onPressed: isLoading ? null : sendMessage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE57385),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              "Send",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
