import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pcos_app/core/constants/app_colors.dart';
import 'package:pcos_app/core/constants/app_strings.dart';
import 'package:pcos_app/core/shared/screen_size.dart';
import 'package:pcos_app/features/clinical_data/data/clinical_data_model.dart';
import 'package:pcos_app/features/clinical_data/view/demographic_info_screen.dart';
import 'package:pcos_app/features/clinical_data/widget/reuseable_check_box.dart';

class PhysicalSymptomsScreen extends StatefulWidget {
  PhysicalSymptomsScreen({super.key});

  @override
  State<PhysicalSymptomsScreen> createState() => _PhysicalSymptomsScreenState();
}

class _PhysicalSymptomsScreenState extends State<PhysicalSymptomsScreen> {
  final ClinicalDataModel data = ClinicalDataModel();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white
        ,child: SafeArea(
        maintainBottomViewPadding: true,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              scrolledUnderElevation: 0,
              leading: GestureDetector(onTap:(){Navigator.pop(context);},child: Icon(Icons.arrow_back,color: Colors.black),),
              title: Text("Clinical Data Input",style: TextStyle(color: Color(0xffDA5F71),fontWeight: FontWeight.w700,fontSize: 20),),
              centerTitle: true,
            ),
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SafeArea(
                  // bottom: false,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                        Text(AppStrings.physicalSymptoms,textAlign: TextAlign.start,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 16),),
                      Gap(ScreenSize(context).height*.02),
                      Text(AppStrings.selectAllApply,style: TextStyle(fontSize:15,fontWeight: FontWeight.w600,color: Color(0xffD63F67) ),),
                      Gap(ScreenSize(context).height*.02),
                      Text(AppStrings.hairGrowth,style: TextStyle(fontSize:15,fontWeight: FontWeight.w600,color: Color(0xff5C5C5C) ),),
                      Gap(ScreenSize(context).height*.01),
                      buildCheckItem(title: AppStrings.hairGrowthDesc, value: data.hairGrowth, onChanged: (value) {  setState(() {data.hairGrowth = value!;});} ,),
                      Gap(ScreenSize(context).height*.01),
                      Text(AppStrings.skinChanges,style: TextStyle(fontSize:15,fontWeight: FontWeight.w600,color: Color(0xff5C5C5C) ),),
                      Gap(ScreenSize(context).height*.01),
                      buildCheckItem(title: AppStrings.skinChangesDesc, value: data.skinDarkening, onChanged: (value) {setState(() {data.skinDarkening = value!;});},),
                      Gap(ScreenSize(context).height*.01),
                      Text(AppStrings.weightChanges,style: TextStyle(fontSize:15,fontWeight: FontWeight.w600,color: Color(0xff5C5C5C) ),),
                      Gap(ScreenSize(context).height*.01),
                      buildCheckItem(title: AppStrings.weightChangesDesc1, value: data.weightGain, onChanged: (value) {  setState(() { data.weightGain = value!;});} ,),
                      Gap(ScreenSize(context).height*.012),
                      buildCheckItem(title: AppStrings.weightChangesDesc2,value: data.difficultyLosingWeight, onChanged: (value) {  setState(() {  data.difficultyLosingWeight = value!;});} ,),
                      Gap(ScreenSize(context).height*.01),
                      Text(AppStrings.acnePimples,style: TextStyle(fontSize:15,fontWeight: FontWeight.w600,color: Color(0xff5C5C5C) ),),
                      Gap(ScreenSize(context).height*.01),
                      buildCheckItem(title: AppStrings.acneDesc, value: data.pimples, onChanged: (value) {  setState(() { data.pimples = value!;});} ,),
                      Gap(ScreenSize(context).height*.01),
                          Text(AppStrings.hairLoss,style: TextStyle(fontSize:15,fontWeight: FontWeight.w600,color: Color(0xff5C5C5C) ),),
                          Gap(ScreenSize(context).height*.01),
                          buildCheckItem(title:AppStrings.hairLossDesc, value:  data.hairLoss, onChanged: (value) {  setState(() { data.hairLoss = value!;});} ,),
                          Gap(ScreenSize(context).height*.1),
                        ],
                      ),
                    ),
                ),
            ),
          bottomSheet: Container(
            color: Colors.white,
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                // EDIT PROFILE
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>  DemographicInfoScreen(),
                        ),
                      );
                      print(data.toString());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.buttoColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(12),
                            Icon(Icons.arrow_forward, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
    ),
    );
  }
}