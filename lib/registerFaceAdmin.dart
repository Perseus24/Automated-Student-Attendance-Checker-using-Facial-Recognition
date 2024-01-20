
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/temporarySecond.dart';
import 'package:flutter_application_1/widgets/big_texts.dart';

import 'appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'build_routes.dart';

void main(){
  runApp((RegisterFace()));
}

class RegisterFace extends StatefulWidget {
  const RegisterFace({super.key});

  @override
  State<RegisterFace> createState() => _RegisterFaceState();
}

class _RegisterFaceState extends State<RegisterFace> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blueColor,
      child: Stack(
        children: [
          Positioned(
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 30.h, left: 10.w),
                    width: 45.h,
                    height: 45.h,
                    child: TextButton(
                      onPressed: (){
                        Navigator.of(context).push(createRouteBack(0));
                      },
                      clipBehavior: Clip.antiAlias,
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.blueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.zero, // <--add this
                      ),
                      child: Image.asset('images/Back.png'),

                    )
                ),
              ],
            ),
          ),
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
                  child: Center(child: Image.asset('images/registerFace.png')),
                ),
                SizedBox(height: 50.h,),
                Container(
                  width: getDynamicSize.getWidth(context)*0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BigText(text: "To register your face, please go to the administrator’s office to capture your facial images using the dedicated webcam.",
                        maxLines: 10, textAlign: TextAlign.center, fontWeight: FontWeight.w300, size: 16.sp,),
                    ],
                  ),
                ),
                SizedBox(height: 100.h),
                Container(
                  width: getDynamicSize.getWidth(context)*0.8,
                  child: BigText(text: 'This is in order for all the images trained to have a consistent source.',
                    maxLines: 3, textAlign: TextAlign.center, fontWeight: FontWeight.w700, size: 13.sp,),
                ),
                SizedBox(height: 40.h,),
                Container(
                    height: 47.h,
                    width: 289.w,
                    decoration: ShapeDecoration(
                      color: AppColors.blueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: ElevatedButton(
                      clipBehavior: Clip.antiAlias,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: (){
                        Navigator.of(context).push(createRouteGo(2));
                      },
                      child: Center(
                          child: BigText(text: 'Done', color: Colors.white, size: 20.sp, fontWeight: FontWeight.w700,)),
                    )
                ),


              ],
            ),
          )
        ],
      ),
    );
  }
}
