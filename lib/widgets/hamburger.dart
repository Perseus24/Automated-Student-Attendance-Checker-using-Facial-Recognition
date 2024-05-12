
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/professor_side/calendar_page_prof.dart';
import 'package:flutter_application_1/professor_side/main_homepage_prof.dart';
import 'package:flutter_application_1/professor_side/class_list_page.dart';
import 'package:flutter_application_1/professor_side/profile_page_prof.dart';
import 'package:flutter_application_1/professor_side/utilities/get_prof_data.dart';
import 'package:flutter_application_1/screens/landing_page.dart';
import 'package:flutter_application_1/screens/main_homepage.dart';
import 'package:flutter_application_1/screens/statistics_page.dart';
import 'package:flutter_application_1/utilities/get_user_data.dart';
import 'package:flutter_application_1/widgets/big_texts.dart';
import 'package:flutter_application_1/widgets/hamburger_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../screens/profile_page.dart';
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

  final userDataControllers = Get.put(UserDataControllers());

  @override
  Widget build(BuildContext context) {

    return Drawer(
      backgroundColor: Colors.white,
      width: 250,
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 30, top: 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(25),
              child: Image.asset('images/logo.png'),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 22),
              child: BigText(text: "Main Menu", color: Colors.black, size: 18,fontWeight: FontWeight.w700,),
            ),
            SizedBox(height: 10),
            HamburgerPages(selectedAppPage: selectedAppPage, widget: userDataControllers.switchDashboardUser.value==0?MainHomePage():MainHomePageProf(),
              drawerPage: AppPages.Dashboard, icon: 'images/dashboard_',),
            SizedBox(height: 5),
            HamburgerPages(selectedAppPage: selectedAppPage, widget: userDataControllers.switchDashboardUser.value==0?StatisticsHome():ClassLists(),
              drawerPage: AppPages.Statistics, icon: 'images/statistics_',),
            SizedBox(height: 5),
            HamburgerPages(selectedAppPage: selectedAppPage, widget:  userDataControllers.switchDashboardUser.value==0?CalendarHome():CalendarHomeProf(),
              drawerPage: AppPages.Calendar, icon: 'images/calendar_',),
            SizedBox(height: 5),
            HamburgerPages(selectedAppPage: selectedAppPage, widget: userDataControllers.switchDashboardUser.value==0?ProfilePage():ProfilePageProf(),
              drawerPage: AppPages.Profile, icon: 'images/profile_',),
            SizedBox(height: 5),
            Container(
              height: 50,
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
                  onPressed: ()async{
                    final FirebaseAuth _auth = FirebaseAuth.instance;
                    await _auth.signOut();
                    Navigator.of(context).push(createRouteBack(LandingPage()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 7, top: 8, bottom: 8),
                    child: Row(
                      children: [
                        Image.asset('images/log_out.png'),
                        SizedBox(width: 10,),
                        BigText(text: "Log out", size: 16, color:  Color(0xFFFF0000), fontWeight: FontWeight.w700,),
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



