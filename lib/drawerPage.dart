import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/big_texts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class drawerPage extends StatefulWidget {
  const drawerPage({super.key});

  @override
  State<drawerPage> createState() => _drawerPageState();
}

class _drawerPageState extends State<drawerPage> {
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
            Container(
              height: 50.h,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0x661A43BF)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: TextButton(
                  clipBehavior: Clip.antiAlias,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0x661A43BF),
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
                        Image.asset('images/dashboard_p.png'),
                        SizedBox(width: 10.w,),
                        BigText(text: "Dashboard", size: 16.sp, color: AppColors.blueColor, fontWeight: FontWeight.w700,),
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
                        Image.asset('images/statistics_notP.png'),
                        SizedBox(width: 10.w,),
                        BigText(text: "Statistics", size: 16.sp, color: Colors.black, fontWeight: FontWeight.w700,),
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
                    Navigator.of(context).push(createRouteGo(CalendarHome()));

                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 7.w, top: 8.h, bottom: 8.h),
                    child: Row(
                      children: [
                        Image.asset('images/calendar_notP.png'),
                        SizedBox(width: 10.w,),
                        BigText(text: "Calendar", size: 16.sp, color: Colors.black, fontWeight: FontWeight.w700,),
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
                        Image.asset('images/profile_notP.png'),
                        SizedBox(width: 10.w,),
                        BigText(text: "Profile", size: 16.sp, color: Colors.black, fontWeight: FontWeight.w700,),
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