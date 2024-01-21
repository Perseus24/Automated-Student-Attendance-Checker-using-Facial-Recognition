
import 'package:flutter_application_1/thirdPage.dart';
import 'package:flutter_application_1/widgets/big_texts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'build_routes.dart';
import 'main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/appColors.dart';

class CalendarHome extends StatelessWidget {
  const CalendarHome({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Container(
            child: Row(
              children: [
                BigText(text: '24', color: Color(0xFFFFC278), size: 45.sp, fontWeight: FontWeight.w500,),
                SizedBox(width: 8.w,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: 'Wed', color: Color(0xFFBCC1CD), size: 14.sp, fontWeight: FontWeight.w500,),
                    BigText(text: 'Jan 2024', color: Color(0xFFBCC1CD), size: 14.sp, fontWeight: FontWeight.w500,)
                  ],
                )
              ],
            ),
          ),
          backgroundColor: AppColors.blueColor,
          actions: [
            Container(
                margin: EdgeInsets.only(right: getDynamicSize.getWidth(context)*0.07),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.of(context).push(createRouteBack(MyApp()));
                            },
                            clipBehavior: Clip.antiAlias,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              padding: EdgeInsets.zero, // <--add this
                            ),
                            child: Image.asset('images/Bellpin.png'),
                          )
                      ),
                    ]
                )
            ),
          ],
          toolbarHeight: getDynamicSize.getHeight(context)*0.12,
          iconTheme: IconThemeData(color: Colors.white, size: 25),
        ),
        body: CalendarPage(),
        drawer: drawerPage(),
      ),
    );
  }
}


class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blueColor,
      child: Stack(
        children: [
          Positioned(
              child: Container(
                height: getDynamicSize.getHeight(context),
                width:getDynamicSize.getWidth(context),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                  ),
                ),
              )
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 15.h),
                height: 60.h,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 18.w,
                      child: Column(
                        children: [
                          BigText(text: 'S', color: Color(0xFFBCC1CD), size: 15.sp, fontWeight: FontWeight.w500,),
                          BigText(text: '21', color: Colors.black, size: 15.sp, fontWeight: FontWeight.w600,),
                        ],
                      ),
                    ),
                    //SizedBox(width: 30.w,),
                    Container(
                      width: 18.w,
                      child: Column(
                        children: [
                          BigText(text: 'M', color: Color(0xFFBCC1CD), size: 15.sp, fontWeight: FontWeight.w500,),
                          BigText(text: '22', color: Colors.black, size: 15.sp, fontWeight: FontWeight.w600,),
                        ],
                      ),
                    ),
                    //SizedBox(width: 30.w,),
                    Container(
                      width: 18.w,
                      child: Column(
                        children: [
                          BigText(text: 'T', color: Color(0xFFBCC1CD), size: 15.sp, fontWeight: FontWeight.w500,),
                          BigText(text: '23', color: Colors.black, size: 15.sp, fontWeight: FontWeight.w600,),
                        ],
                      ),
                    ),
                    //SizedBox(width: 30.w,),
                    Container(
                      width: 18.w,
                      child: Column(
                        children: [
                          BigText(text: 'W', color: Color(0xFFBCC1CD), size: 15.sp, fontWeight: FontWeight.w500,),
                          BigText(text: '24', color: Colors.black, size: 15.sp, fontWeight: FontWeight.w600,),
                        ],
                      ),
                    ),
                    //SizedBox(width: 30.w,),
                    Container(
                      width: 18.w,
                      child: Column(
                        children: [
                          BigText(text: 'Th', color: Color(0xFFBCC1CD), size: 15.sp, fontWeight: FontWeight.w500,),
                          BigText(text: '25', color: Colors.black, size: 15.sp, fontWeight: FontWeight.w600,),
                        ],
                      ),
                    ),
                    //SizedBox(width: 30.w,),
                    Container(
                      width: 18.w,
                      child: Column(
                        children: [
                          BigText(text: 'F', color: Color(0xFFBCC1CD), size: 15.sp, fontWeight: FontWeight.w500,),
                          BigText(text: '26', color: Colors.black, size: 15.sp, fontWeight: FontWeight.w600,),
                        ],
                      ),
                    ),
                    //SizedBox(width: 30.w,),
                    Container(
                      width: 18.w,
                      child: Column(
                        children: [
                          BigText(text: 'S', color: Color(0xFFBCC1CD), size: 15.sp, fontWeight: FontWeight.w500,),
                          BigText(text: '27', color: Colors.black, size: 15.sp, fontWeight: FontWeight.w600,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:10.h),
                padding: EdgeInsets.only(left: 20.w),
                height: 20.h,
                child: Row(
                  children: [
                    BigText(text: 'Time', color: Color(0xFFBCC1CD), size: 16.sp, fontWeight: FontWeight.w500,),
                    SizedBox(width: 50.w,),
                    BigText(text: 'Course', color: Color(0xFFBCC1CD), size: 16.sp, fontWeight: FontWeight.w500,),
                  ],
                ),
              )
            ],
          ),
        ],
      ),

    );
  }
}
