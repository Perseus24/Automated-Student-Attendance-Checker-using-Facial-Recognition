import 'package:firebase_admin/firebase_admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/screens/landing_page.dart';
import 'package:flutter_application_1/screens/main_homepage.dart';
import 'package:flutter_application_1/screens/statistics_page.dart';
import 'package:flutter_application_1/widgets/big_texts.dart';
import 'package:flutter_application_1/widgets/hamburger_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utilities/constants.dart';
import '../utilities/build_routes.dart';
import '../screens/calendar_page.dart';


class BuildDrawer extends StatelessWidget {

  BuildDrawer({required this.selectedAppPage});
  final AppPages selectedAppPage;
  int num0 = 0;
  int num1 = 0;
  int num2 = 0;
  int num3 = 0;

  @override
  Widget build(BuildContext context) {

    return Drawer(
      width: 250.w,
      child: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 30.w, top: 45.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(25.h),
              child: Image.asset('images/logo.png'),
            ),
            SizedBox(height: 20.h,),
            Padding(
              padding: EdgeInsets.only(left: 22.w),
              child: BigText(text: "Main Menu", color: Colors.black, size: 18.sp,fontWeight: FontWeight.w700,),
            ),
            SizedBox(height: 10.h),
            HamburgerPages(selectedAppPage: selectedAppPage, widget: MainHomePage(),
              drawerPage: AppPages.Dashboard, icon: 'images/dashboard_',),
            SizedBox(height: 5.h),
            HamburgerPages(selectedAppPage: selectedAppPage, widget: StatisticsHome(),
              drawerPage: AppPages.Statistics, icon: 'images/statistics_',),
            SizedBox(height: 5.h),
            HamburgerPages(selectedAppPage: selectedAppPage, widget: CalendarHome(),
              drawerPage: AppPages.Calendar, icon: 'images/calendar_',),
            SizedBox(height: 5.h),
            HamburgerPages(selectedAppPage: selectedAppPage, widget: MainHomePage(),
              drawerPage: AppPages.Profile, icon: 'images/profile_',),
            SizedBox(height: 5.h),
            Container(
              height: 50.h,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: TextButton(
                  clipBehavior: Clip.antiAlias,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: (){
                    Navigator.of(context).push(createRouteBack(LandingPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 7.w, top: 8.h, bottom: 8.h),
                    child: Row(
                      children: [
                        Image.asset('images/log_out.png'),
                        SizedBox(width: 10.w,),
                        BigText(text: "Log out", size: 16.sp, color:  Color(0xFFFF0000), fontWeight: FontWeight.w700,),
                      ],
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}


