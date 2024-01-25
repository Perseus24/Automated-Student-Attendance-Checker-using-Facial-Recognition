import 'package:firebase_admin/firebase_admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main_homepage.dart';
import 'package:flutter_application_1/widgets/big_texts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utilities/constants.dart';
import '../utilities/build_routes.dart';
import '../screens/calendar_page.dart';


class BuildDrawer extends StatelessWidget {

  BuildDrawer({required this.pageIndication});
  final int pageIndication;
  int num0 = 0;
  int num1 = 0;
  int num2 = 0;
  int num3 = 0;

  @override
  Widget build(BuildContext context) {
    switch(pageIndication){
      case 0: num0 = 1;
              break;
      case 1: num1 = 1;
              break;
      case 2: num2 = 1;
              break;
      case 3: num3 = 1;
              break;
    }
    print(num0);
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
            Container(
              height: 50.h,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: pageIndication==0? Color(0x661A43BF):Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: TextButton(
                  clipBehavior: Clip.antiAlias,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: pageIndication==0? Color(0x661A43BF):Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: (){
                    Navigator.of(context).push(createRouteGo(MainHomePage()));

                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 7.w, top: 8.h, bottom: 8.h),
                    child: Row(
                      children: [
                        Image.asset('images/dashboard_$num0.png'),
                        SizedBox(width: 10.w,),
                        BigText(text: "Dashboard", size: 16.sp, color:pageIndication==0?blueColor:Colors.black, fontWeight: FontWeight.w700,),
                      ],
                    ),
                  )
              ),
            ),
            SizedBox(height: 5.h),
            Container(
              height: 50.h,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color:pageIndication==1? Color(0x661A43BF):Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: TextButton(
                  clipBehavior: Clip.antiAlias,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: pageIndication==1? Color(0x661A43BF):Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: (){

                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 7.w, top: 8.h, bottom: 8.h),
                    child: Row(
                      children: [
                        Image.asset('images/statistics_$num1.png'),
                        SizedBox(width: 10.w,),
                        BigText(text: "Statistics", size: 16.sp, color: pageIndication==1?blueColor:Colors.black, fontWeight: FontWeight.w700,),
                      ],
                    ),
                  )
              ),
            ),
            SizedBox(height: 5.h),
            Container(
              height: 50.h,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color:pageIndication==2? Color(0x661A43BF):Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: TextButton(
                  clipBehavior: Clip.antiAlias,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: pageIndication==2? Color(0x661A43BF):Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: (){
                    Navigator.of(context).push(createRouteGo(CalendarHome()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 7.w, top: 8.h, bottom: 8.h),
                    child: Row(
                      children: [
                        Image.asset('images/calendar_$num2.png'),
                        SizedBox(width: 10.w,),
                        BigText(text: "Calendar", size: 16.sp, color: pageIndication==2?blueColor:Colors.black, fontWeight: FontWeight.w700,),
                      ],
                    ),
                  )
              ),
            ),
            SizedBox(height: 5.h),
            Container(
              height: 50.h,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color:pageIndication==3? Color(0x661A43BF):Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: TextButton(
                  clipBehavior: Clip.antiAlias,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: pageIndication==3? Color(0x661A43BF):Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: (){

                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 7.w, top: 8.h, bottom: 8.h),
                    child: Row(
                      children: [
                        Image.asset('images/profile_$num3.png'),
                        SizedBox(width: 10.w,),
                        BigText(text: "Profile", size: 16.sp, color: pageIndication==3?blueColor:Colors.black, fontWeight: FontWeight.w700,),
                      ],
                    ),
                  )
              ),
            ),
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


