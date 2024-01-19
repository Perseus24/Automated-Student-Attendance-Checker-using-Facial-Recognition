import 'package:flutter/material.dart';
import 'package:flutter_application_1/appColors.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/temporarySecond.dart';
import 'package:flutter_application_1/widgets/big_texts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:flutter_application_1/signInPage.dart';


class Signproper extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: AppColors.blueColor,
        height: getDynamicSize.getHeight(context),
        child: Stack(
          children: [
            Container(
                    margin: EdgeInsets.only(top: 20, bottom: 15),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                        children: [
                          Container(
                              width: 45.h,
                              height: 45.h,
                              child: ElevatedButton(
                                onPressed: (){
                                  Navigator.of(context).push(createRouteBack(0));
                                },
                                clipBehavior: Clip.antiAlias,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  padding: EdgeInsets.zero, // <--add this
                                ),
                                child: Image.asset('images/Back.png'),

                              )
                          ),
                          SizedBox(width: 25),
                          Container(
                           child: BigText(text: 'Forgot Password', color: Colors.black, size: 19.sp,
                            fontWeight: FontWeight.w600, textAlign: TextAlign.left),
                          )
                        ]
                    )

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
                top: getDynamicSize.getHeight(context)*0.15,
                child: Column(
                  children: [
                    Container(
                        width: getDynamicSize.getWidth(context),
                      
                        child: Align(
                            child: Image.asset('images/fgt_password.png'),
                            
                        )
                    ),
                    SizedBox(height: 45.h,),
                    Container(
                      padding: EdgeInsets.only(top:45.h),
                      width: getDynamicSize.getWidth(context)*0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BigText(text: 'Please type in the email address where you want to get the instructions for resetting your password.', color: Colors.black.withOpacity(0.8500000238418579), size: 15.sp,
                            fontWeight: FontWeight.w300, maxLines: 5, textAlign: TextAlign.left,),

                        ],
                      ),
                    ),
                    SizedBox(height: 30.h,),
                    Container(
                      height: getDynamicSize.getHeight(context)*0.04,
                      width: getDynamicSize.getWidth(context)*0.8,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Opacity(
                          opacity: 0.6,
                          child: BigText(text: 'Enter your E-mail Address', size: 13.sp, fontWeight: FontWeight.w500,)
                        ),
                      ),
                ),
                
                Container(
                  height: getDynamicSize.getHeight(context)*0.1,
                  width: getDynamicSize.getWidth(context)*0.8,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: getDynamicSize.getHeight(context)*0.06,
                              width: getDynamicSize.getWidth(context)*0.8,
                              decoration: ShapeDecoration(
                                color: Colors.white.withOpacity(0.8500000238418579),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 1, color: Color(0xFF1A43BF)),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 3,
                                    offset: Offset(0, 0),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                            ),
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.h,),
                   Container(
                    width: 300.w,
                    height: 47.h,
                    decoration: ShapeDecoration(
                      color: Color(0xFF1A43BF),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFF1A43BF)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 3,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ],
                      
                    ),
                    child: Center(
                      child: BigText(text:'Request Resend', color: Colors.white, fontWeight: FontWeight.w700,),
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

