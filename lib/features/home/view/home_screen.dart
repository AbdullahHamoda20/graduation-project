import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pcos_app/core/constants/app_assets.dart';
import 'package:pcos_app/core/constants/app_strings.dart';
import 'package:pcos_app/features/home/view/root.dart';
import 'package:pcos_app/features/settings/view/settings_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/network/api_error.dart';
import '../../auth/data/auth_model.dart';
import '../../auth/data/auth_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  bool isLoading= false;
  UserModel? userModel ;
  AuthRepo authRepo =AuthRepo();
String ?username;

  Future<void> getUsername() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = await authRepo.getUsername();

      if (!mounted) return;

      setState(() {
        userModel = user;
      });

    } catch (e) {
      if (!mounted) return;

      String errorMsg = "error in Profile";
      if (e is ApiError) {
        errorMsg = e.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg)),
      );
    } finally {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
  }


    @override
    void initState(){
      super.initState();
      getUsername();
    }



  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white,
          leading: Image.asset(AppAssets.appBarLeadingIcon),
          actions: [
            IconButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  SettingsScreen()),
              );
            }, icon: Image.asset(AppAssets.appBarActionIcon))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(20),
                ///Header
                Skeletonizer(enabled:isLoading ,child: Text("Hi ${userModel?.username ?? "User"}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: Color(0xffD63F67)),)),
                  Gap(15),
                  Center(child: Column(
                    children: [
                      Text("Welcome to Smart PCOS Detection,",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w800,color: Colors.black),),
                      Gap(5),
                      Text("Your Personalized Path to Understanding.",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700,color: Colors.grey.shade500),)
                    ],
                  )),
                Gap(15),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/Home_Icon_1.png"),fit: BoxFit.fill),
                      color: Color(0xffFAF5F6),
                      borderRadius: BorderRadius.only(bottomRight:Radius.circular(30),bottomLeft: Radius.circular(30)),
                      border: BoxBorder.all(color: Colors.black,width: 1)
                  ),
                ),
                Gap(15),
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/Home_Icon_2.png"),fit: BoxFit.fill),
                      color: Color(0xffFAF5F6),
                      borderRadius: BorderRadius.circular(30),
                    border: BoxBorder.all(color: Colors.black,width: 1)
                  ),
                ),
                Gap(15),
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/Home_Icon_3.png"),fit: BoxFit.fill),
                      color: Color(0xffFAF5F6),
                      borderRadius: BorderRadius.circular(30),
                      border: BoxBorder.all(color: Colors.black,width: 1)
                  ),
                ),
                Gap(15),
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/Home_Icon_4.png"),fit: BoxFit.fill),
                      color: Color(0xffFAF5F6),
                      borderRadius: BorderRadius.circular(30),
                      border: BoxBorder.all(color: Colors.black,width: 1)
                  ),
                ),
                Gap(15)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
