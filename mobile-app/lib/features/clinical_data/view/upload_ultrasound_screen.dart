import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pcos_app/core/constants/app_colors.dart';
import 'package:pcos_app/features/clinical_data/widget/demo_custom_textFeild.dart';
import 'package:pcos_app/features/home/view/root.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/shared/custom_text_field.dart';
import '../../../core/shared/screen_size.dart';
import '../../auth/widget/customTextField_contactUs.dart';
import '../data/ClinicalDataProvider.dart';
import '../data/ClinicalRepository.dart';
import '../data/pcos_data_models.dart';
import '../../result/view/result_screen.dart';

class UploadUltrasoundScreen extends StatefulWidget {
  const UploadUltrasoundScreen({super.key});

  @override
  State<UploadUltrasoundScreen> createState() => _UploadUltrasoundScreenState();
}

class _UploadUltrasoundScreenState extends State<UploadUltrasoundScreen> {
  late TextEditingController amhController;
  late TextEditingController lhController;
  late TextEditingController fshController;
  late TextEditingController tshController;

  @override
  void initState() {
    super.initState();

    final data = context.read<ClinicalDataProvider>().data;

    amhController = TextEditingController(text: data.amh?.toString() ?? '');

    lhController = TextEditingController(text: data.lh?.toString() ?? '');

    fshController = TextEditingController(text: data.fsh?.toString() ?? '');

    tshController = TextEditingController(text: data.tsh?.toString() ?? '');

    /// LISTENERS

    amhController.addListener(_updateHormones);
    lhController.addListener(_updateHormones);
    fshController.addListener(_updateHormones);
    tshController.addListener(_updateHormones);
  }

  void _updateHormones() {
    context.read<ClinicalDataProvider>().setHormones(
      amh: double.tryParse(amhController.text),
      lh: double.tryParse(lhController.text),
      fsh: double.tryParse(fshController.text),
      tsh: double.tryParse(tshController.text),
    );
  }

  @override
  void dispose() {
    amhController.dispose();
    lhController.dispose();
    fshController.dispose();
    tshController.dispose();
    super.dispose();
  }

  /// Upload image

  Future<void> _uploadImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      Navigator.pop(context);
      context.read<ClinicalDataProvider>().setImage(File(pickedImage.path));
    }
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickedImage != null) {
      Navigator.pop(context);
      context.read<ClinicalDataProvider>().setImage(File(pickedImage.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ClinicalDataProvider>();

    ClinicalDataModel data = provider.data;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          forceMaterialTransparency: true,
          scrolledUnderElevation: 0,
          leading: GestureDetector(
            onTap: () {
              if (provider.isLoading) {
                return null;
              }
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: const Text(
            "Upload Ultrasound Image",
            style: TextStyle(
              color: Color(0xffDA5F71),
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),

        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),

            child: Column(
              children: [
                /// IMAGE PICKER
                GestureDetector(
                  onTap: () {
                    if (provider.isLoading) {
                      return null;
                    }
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 150,
                          child: Column(
                            children: [
                              ListTile(
                                onTap: _uploadImage,
                                leading: const Icon(
                                  Icons.image,
                                  color: Color(0xffDA5F71),
                                ),
                                title: Text(
                                  "Upload Photo From Gallery",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              ListTile(
                                onTap: _pickImage,
                                title: Text(
                                  "Take Photo By Camera",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                leading: const Icon(
                                  Icons.camera_alt,
                                  color: Color(0xffDA5F71),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),

                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffDA5F71),
                        width: 2,
                      ),

                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Row(
                      children: [
                        Text(
                          data.ultrasoundImage == null
                              ? "Select/upload Image"
                              : "Change Image",

                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff444444),
                          ),
                        ),

                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (provider.isLoading) {
                              return null;
                            }
                            setState(() {
                              data.ultrasoundImage = null;
                            });
                          },
                          child: data.ultrasoundImage != null
                              ? const Icon(
                                  Icons.delete,
                                  color: Color(0xffDA5F71),
                                )
                              : Container(),
                        ),
                        Gap(ScreenSize(context).width * .03),
                        const Icon(Icons.camera_alt, color: Color(0xffDA5F71)),
                      ],
                    ),
                  ),
                ),

                Gap(ScreenSize(context).height * 0.03),

                /// IMAGE PREVIEW
                Container(
                  width: 250,
                  height: 218,

                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),

                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: data.ultrasoundImage == null
                      ? null
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),

                          child: Image.file(
                            data.ultrasoundImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),

                Gap(ScreenSize(context).height * 0.03),

                Text(
                  AppStrings.hasHormoneResults,

                  style: const TextStyle(
                    color: Color(0xffDA5F71),
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),

                Gap(ScreenSize(context).height * 0.03),

                /// AMH
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      // const Expanded(
                      //   flex: 1,
                      //   child: Text(
                      //     "AMH",
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.w800,
                      //       fontSize: 18,
                      //     ),
                      //   ),
                      // ),
                      //
                      // Gap(
                      //   ScreenSize(context).width *
                      //       .04,
                      // ),
                      //
                      // Expanded(
                      //   flex: 2,
                      //   child: CustomTextField(
                      //     controller: amhController,
                      //     hasPrefixIcon: false,
                      //     keyboardType:
                      //     TextInputType.number,
                      //   ),
                      // ),
                      Expanded(
                        child: demoCustomTextField(
                          label: "AMH",
                          controller: amhController,
                          readOnly: false,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ),

                Gap(ScreenSize(context).height * 0.03),

                /// LH
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      // const Expanded(
                      //   flex: 1,
                      //   child: Text(
                      //     "LH",
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.w800,
                      //       fontSize: 18,
                      //     ),
                      //   ),
                      // ),
                      //
                      // Gap(
                      //   ScreenSize(context).width *
                      //       .04,
                      // ),
                      //
                      // Expanded(
                      //   flex: 2,
                      //   child: CustomTextField(
                      //     controller: lhController,
                      //     hasPrefixIcon: false,
                      //     keyboardType:
                      //     TextInputType.number,
                      //   ),
                      // ),
                      Expanded(
                        child: demoCustomTextField(
                          label: "LH",
                          controller: lhController,
                          readOnly: false,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ),

                Gap(ScreenSize(context).height * 0.03),

                /// FSH
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      // const Expanded(
                      //   flex: 1,
                      //   child: Text(
                      //     "FSH",
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.w800,
                      //       fontSize: 18,
                      //     ),
                      //   ),
                      // ),
                      //
                      // Gap(
                      //   ScreenSize(context).width *
                      //       .04,
                      // ),
                      //
                      // Expanded(
                      //   flex: 2,
                      //   child: CustomTextField(
                      //     controller: fshController,
                      //     hasPrefixIcon: false,
                      //     keyboardType:
                      //     TextInputType.number,
                      //   ),
                      // ),
                      Expanded(
                        child: demoCustomTextField(
                          label: "FSH",
                          controller: fshController,
                          readOnly: false,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ),

                Gap(ScreenSize(context).height * 0.03),

                /// TSH
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: demoCustomTextField(
                          label: "TSH",
                          controller: tshController,
                          readOnly: false,
                          keyboardType: TextInputType.number,
                        ),
                      ),

                      // const Expanded(
                      //   flex: 1,
                      //   child: Text(
                      //     "TSH",
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.w800,
                      //       fontSize: 18,
                      //     ),
                      //   ),
                      // ),
                      //
                      // Gap(
                      //   ScreenSize(context).width *
                      //       .04,
                      // ),
                      //
                      // Expanded(
                      //   flex: 2,
                      //   child: CustomTextField(
                      //     controller: tshController,
                      //     hasPrefixIcon: false,
                      //     keyboardType:
                      //     TextInputType.number,
                      //   ),
                      // ),
                    ],
                  ),
                ),

                Gap(ScreenSize(context).height * 0.2),
              ],
            ),
          ),
        ),

        bottomSheet: GestureDetector(
          onTap: provider.isLoading
              ? null
              : () async {
                  log(data.toApiJson().toString());

                  await provider.submitData(
                    ClinicalRepository(
                      "https://mohamedyahya72-pcos-diagnostic-engine.hf.space",
                    ),
                  );

                  if (provider.error != null) {
                    if (provider.error!.contains(
                      'Provide at least clinical data',
                    )) {
                      provider.error =
                          "Please provide at least clinical data or an image.";
                    }
                    if (provider.error!.contains('ClientException')) {
                      provider.error = "Enternet Error Connection";
                    }
                    if (provider.error!.contains('Non-ultrasound')) {
                      provider.error = "Please upload a valid medical scan.";
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        behavior: SnackBarBehavior.floating,
                        clipBehavior: Clip.none,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(
                          bottom: 70,
                          right: 20,
                          left: 20,
                        ),
                        elevation: 10,
                        content: ListTile(
                          leading: Icon(
                            CupertinoIcons.info,
                            color: Colors.white,
                          ),
                          title: Text(
                            provider.error!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        backgroundColor: AppColors.header,
                      ),
                    );
                    return;
                  }

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => ResultScreen()),
                    (route) => false,
                  );
                },

          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              margin: EdgeInsets.only(
                bottom: 25,
                right: ScreenSize(context).width * 0.2,
                left: ScreenSize(context).width * 0.2,
              ),

              decoration: BoxDecoration(
                color: const Color(0xffE56D83),
                borderRadius: BorderRadius.circular(30),
              ),

              child: provider.isLoading
                  ? const CupertinoActivityIndicator(color: Colors.white)
                  : const Text(
                      AppStrings.startAnalysis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
