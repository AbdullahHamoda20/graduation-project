import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pcos_app/core/constants/app_strings.dart';
import 'package:pcos_app/core/shared/custom_text_field.dart';
import 'package:pcos_app/core/shared/screen_size.dart';
import 'package:pcos_app/features/clinical_data/widget/reuseable_check_box.dart';
import '../../../core/constants/app_colors.dart';
import '../data/clinical_data_model.dart';
import 'menstrual_cycle_screen.dart';


class DemographicInfoScreen extends StatefulWidget {
   DemographicInfoScreen({super.key});

  @override
  State<DemographicInfoScreen> createState() => _DemographicInfoScreenState();
}

class _DemographicInfoScreenState extends State<DemographicInfoScreen> {
  final ClinicalDataModel data = ClinicalDataModel();
  final TextEditingController controller = TextEditingController();
  bool  regularCycle = false;

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        color: Colors.white,
        child: SafeArea(
          maintainBottomViewPadding: true,
          child: Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              leading: GestureDetector(onTap:(){Navigator.pop(context);},child: Icon(Icons.arrow_back,color: Colors.black),),
              title: Text("Clinical Data Input",style: TextStyle(color: Color(0xffDA5F71),fontWeight: FontWeight.w700,fontSize: 20),),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(AppStrings.demographicInfo,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 16),),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: ScreenSize(context).width,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      border: BoxBorder.all(width: 2),
                    ),
                    child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xffE8B6C1),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                          ),
                          child: Text("Age",style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500
                          ),),

                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                          ),
                          child:TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter age",
                              hintStyle: TextStyle(
                                color: Color(0xff656565),
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ) ,
                          ),
                      )

                    ],
                  ),
                  ),
                  Gap(ScreenSize(context).height*.02),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: ScreenSize(context).width,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                            border: BoxBorder.all(width: 2),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Color(0xffE8B6C1),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                  ),
                                  child: Text("Weight",style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500
                                  ),),

                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  alignment: Alignment.center,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                                  ),
                                  child:TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "70 Kg",
                                      hintStyle: TextStyle(
                                          color: Color(0xff656565),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ) ,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Gap(ScreenSize(context).width*.02),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: ScreenSize(context).width,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                            border: BoxBorder.all(width: 2),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Color(0xffE8B6C1),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                  ),
                                  child: Text("Height",style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500
                                  ),),

                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  alignment: Alignment.center,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                                  ),
                                  child:TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "170 cm",
                                      hintStyle: TextStyle(
                                          color: Color(0xff656565),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ) ,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(ScreenSize(context).height*.02),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: ScreenSize(context).width,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      border: BoxBorder.all(width: 2),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xffE8B6C1),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                            ),
                            child: Text("Age",style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                            ),),

                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                            ),
                            child:TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter age",
                                hintStyle: TextStyle(
                                    color: Color(0xff656565),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ) ,
                          ),
                        )

                      ],
                    ),
                  ),
                  Gap(ScreenSize(context).height*.05),
                  Text(AppStrings.menstrualCycle,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 16),),
                  Gap(ScreenSize(context).height*.02),
                  Text(AppStrings.isCycleRegular,style: TextStyle(color: Color(0xffD63F67),fontWeight: FontWeight.w500,fontSize: 16),),
                  Row(
                    children: [
                      Expanded(
                        child: buildCheckItem(
                          title: "Yes",
                          value: regularCycle,
                          onChanged: (value) {
                            setState(() {
                              regularCycle = true;
                            });
                          },
                        ),
                      ),

                      Expanded(
                        child: buildCheckItem(
                          title: "No",
                          value: !regularCycle,
                          onChanged: (value) {
                            setState(() {
                              regularCycle = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Text(AppStrings.averageCycleLength,style: TextStyle(color: Color(0xffD63F67),fontWeight: FontWeight.w500,fontSize: 16),),
                  Gap(ScreenSize(context).height*.02),
                  TextFormField(
                    decoration: InputDecoration(
                      disabledBorder:OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffD63F67)),
                      ) ,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffD63F67)),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: Color(0xffD63F67)),),
                      hintText: "Enter average cycle length",
                    )
                  )



                ],
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
                            builder: (_) =>  MenstrualCycleScreen(),
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
      ),
    );
  }

}
