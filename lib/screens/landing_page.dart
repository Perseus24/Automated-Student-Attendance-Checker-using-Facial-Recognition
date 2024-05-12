import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_page.dart';
import 'package:flutter_application_1/screens/register_user.dart';
import 'package:flutter_application_1/screens/main_homepage.dart';
import 'package:flutter_application_1/utilities/get_user_data.dart';
import 'package:flutter_application_1/widgets/big_texts.dart';
import '../utilities/build_routes.dart';
import '../utilities/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


Future <void> main() async{
  runApp(
    MyApp()
  );
}


class MyApp extends StatelessWidget {

  UserDataControllers userDataControllers = UserDataControllers();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: userDataControllers.checkLoggedIn(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if (snapshot.data == true) {
              return MainHomePage();
            } else {
              return LandingPage();
            }
          }else{
            return LandingPage();
          }
        },
      )
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(context, designSize: const Size(375, 677));
    return Scaffold(
      body: Container(
        color: kBlueColor,
        height: getDynamicSize.getHeight(context),
        child: Stack(
          children: [
            Positioned(
                top: getDynamicSize.getHeight(context)*0.28,
                child: Container(
                  height: getDynamicSize.getHeight(context),
                  width:getDynamicSize.getWidth(context),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                )
            ),
            Positioned(
                top: getDynamicSize.getHeight(context)*0.1,
                child: Column(
                  children: [
                    Container(
                        width: getDynamicSize.getWidth(context),
                        child: Align(
                            child: Image.asset('images/num1.png')
                        )
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BigText(text: "Welcome to", color: Colors.black.withOpacity(0.8500000238418579), size: 30.sp, fontWeight: FontWeight.w700,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BigText(text: "KUMIT", color: kBlueColor, size: 30.sp, fontWeight: FontWeight.w700,),
                              BigText(text: " App", color: Colors.black.withOpacity(0.8500000238418579), size: ScreenUtil().setSp(30), fontWeight: FontWeight.w700,),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top:40.h),
                      width: getDynamicSize.getWidth(context)*0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BigText(text: 'Your intelligent attendance monitoring companion!', color: Colors.black.withOpacity(0.8500000238418579), size: 20.sp,
                            fontWeight: FontWeight.w400, maxLines: 2, textAlign: TextAlign.center,),

                        ],
                      ),
                    ),
                    SizedBox(height: 50.h,),
                    Container(
                        height: 47.h,
                        width: 289.w,
                        decoration: ShapeDecoration(
                          color: kBlueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: ElevatedButton(
                          clipBehavior: Clip.antiAlias,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kBlueColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: (){
                            Navigator.of(context).push(createRouteGo(SignInWindow()));
                          },
                          child: Center(
                              child: BigText(text: 'Log In', color: Colors.white, size: 20.sp, fontWeight: FontWeight.w700,)),
                        )
                    ),
                    SizedBox(height: 12.sp,),
                    Container(
                        height: 47.h,
                        width: 289.w,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: ElevatedButton(
                          clipBehavior: Clip.antiAlias,
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                              color: kBlueColor,
                            ),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: (){
                            Navigator.of(context).push(createRouteGo(RegisterWindow()));
                          },
                          child: Center(
                              child: BigText(text: 'Register', color: Colors.black, size: 20.sp, fontWeight: FontWeight.w700,)),
                        )
                    ),
                  ],
                )
            ),

          ],
        ),
      ),
    );
  }
}

class getDynamicSize{
  static double getHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }
  static double getWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

}

