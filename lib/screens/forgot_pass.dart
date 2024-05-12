import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/constants.dart';
import 'package:flutter_application_1/screens/landing_page.dart';
import 'package:flutter_application_1/screens/login_page.dart';
import 'package:flutter_application_1/screens/register_user.dart';
import 'package:flutter_application_1/screens/main_homepage.dart';
import 'package:flutter_application_1/widgets/big_texts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../utilities/build_routes.dart';


void main() => runApp(ForgotPassPage());

class ForgotPassPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, size: 30,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: 500,
        child: Stack(
          children: [
            Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      //height: 200,
                      padding: EdgeInsets.only(left: 40, right: 40, top: 60, bottom: 30),
                      child: Column(
                        children: [
                          Text('Change Password'),
                          Text('Please fill in the details below'),
                          SizedBox(height: 20,),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Your email address",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14
                              )
                            ),
                          ),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 45,
                                  decoration: ShapeDecoration(
                                    color: kBlueColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: BigText(
                                      text: "Submit",
                                      color: Colors.white,
                                      size: 16,

                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                          
                        ],
                      ),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: CircleAvatar(
                      radius: 30.w,
                        backgroundColor: kBlueColor,
                        child: Icon(Icons.alternate_email_outlined, color: Colors.white,)
                    )
                ),
              ],
            ),

          ],
        ),

      ),
    );
  }
}


// class ForgotPassPage extends StatelessWidget {
//
//   final logInControllerTemp = Get.put(LogInControllers());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//       child: Container(
//         color: kBlueColor,
//           height: getDynamicSize.getHeight(context),
//           child: Stack(
//             children: [
//               Container(
//                   margin: EdgeInsets.only(top: 40.h, left: 10.w),
//                   child: Row(
//                       children: [
//                         Container(
//                             width: 45.h,
//                             height: 45.h,
//                             child: TextButton(
//                               onPressed: (){
//                                 Navigator.of(context).push(createRouteBack(MyApp()));
//                               },
//                               clipBehavior: Clip.antiAlias,
//                               style: TextButton.styleFrom(
//                                 backgroundColor: kBlueColor,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                 ),
//                                 padding: EdgeInsets.zero, // <--add this
//                               ),
//                               child: Image.asset('images/Back.png'),
//
//                             )
//                         ),
//                         SizedBox(width: 25),
//                         Container(
//                           child: BigText(text: 'Forgot Password', color: Colors.white, size: 19.sp,
//                               fontWeight: FontWeight.w600, textAlign: TextAlign.left),
//                         )
//                       ]
//                   )
//
//               ),
//               Positioned(
//                   top: getDynamicSize.getHeight(context)*0.28,
//                   child: Container(
//                     height: getDynamicSize.getHeight(context),
//                     width:getDynamicSize.getWidth(context),
//                     decoration: ShapeDecoration(
//                       color: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                   )
//               ),
//
//               Positioned(
//                   top: getDynamicSize.getHeight(context)*0.15,
//                   child: Column(
//                     children: [
//                       Container(
//                           width: getDynamicSize.getWidth(context),
//                           child: Center(
//                             child: Image.asset('images/fgt_password.png'),
//
//                           )
//                       ),
//                       SizedBox(height: 45.h,),
//                       Container(
//                         width: getDynamicSize.getWidth(context)*0.8,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             BigText(text: 'Enter the email address you used to log-in.', color: Colors.black.withOpacity(0.8500000238418579), size: 15.sp,
//                               fontWeight: FontWeight.w300, maxLines: 5, textAlign: TextAlign.left,),
//
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 30.h,),
//                       Container(
//                         height: getDynamicSize.getHeight(context)*0.04,
//                         width: getDynamicSize.getWidth(context)*0.8,
//                         child: Align(
//                           alignment: Alignment.topLeft,
//                           child: Opacity(
//                               opacity: 0.6,
//                               child: BigText(text: 'E-mail Address', size: 13.sp, fontWeight: FontWeight.w500,)
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: getDynamicSize.getHeight(context)*0.1,
//                         width: getDynamicSize.getWidth(context)*0.8,
//                         child: Align(
//                           alignment: Alignment.topLeft,
//                           child: Column(
//                             children: [
//                               Stack(
//                                 children: [
//                                   Container(
//                                     height: getDynamicSize.getHeight(context)*0.06,
//                                     width: getDynamicSize.getWidth(context)*0.8,
//                                     decoration: ShapeDecoration(
//                                       color: Colors.white.withOpacity(0.8500000238418579),
//                                       shape: RoundedRectangleBorder(
//                                         side: BorderSide(width: 1, color: Color(0xFF1A43BF)),
//                                         borderRadius: BorderRadius.circular(15),
//                                       ),
//                                       shadows: [
//                                         BoxShadow(
//                                           color: Color(0x3F000000),
//                                           blurRadius: 3,
//                                           offset: Offset(0, 0),
//                                           spreadRadius: 0,
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   Positioned(
//                                     child: Container(
//                                       padding: EdgeInsets.only(top: 0.h, left: 10.h, right: 10.h),
//                                       child: Obx(() =>TextFormField(
//                                         controller: logInControllerTemp.passwordController,
//                                         cursorColor: kBlueColor,
//                                         onChanged: (_){
//                                           logInControllerTemp.passwordWrongController.text = '';
//                                           logInControllerTemp..updateInputs();
//                                         },
//                                         autovalidateMode: AutovalidateMode.onUserInteraction,
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             logInControllerTemp.passwordWrongController.text = '';
//                                             return 'This field is required' ;
//                                           }
//                                           return null;
//                                         },
//                                         decoration: InputDecoration(
//                                           errorText: (logInControllerTemp.hasPasswordError.value) ? 'This field is required' :
//                                           logInControllerTemp.passwordWrongControllerText.value,
//
//                                           //errorStyle: TextStyle(fontSize: 2),
//                                           border: InputBorder.none,
//
//                                         ),
//
//                                       )),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 10.h,),
//                       Container(
//                           width: 300.w,
//                           height: 47.h,
//                           decoration: ShapeDecoration(
//                             color: Color(0xFF1A43BF),
//                             shape: RoundedRectangleBorder(
//                               side: BorderSide(width: 1, color: Color(0xFF1A43BF)),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             shadows: [
//                               BoxShadow(
//                                 color: Color(0x3F000000),
//                                 blurRadius: 3,
//                                 offset: Offset(0, 0),
//                                 spreadRadius: 0,
//                               )
//                             ],
//
//                           ),
//                           child: TextButton(
//                             onPressed: (){
//                               Navigator.of(context).push(createRouteGo(MainHomePage()));
//                             },
//                               child: Center(
//                                 child: BigText(text:'Request Resend', color: Colors.white, fontWeight: FontWeight.w700,),
//                               )
//                           ),
//                       ),
//                     ],
//                   )
//               ),
//             ],
//           )
//       ),
//       ),
//     );
//   }
//
//
// }
