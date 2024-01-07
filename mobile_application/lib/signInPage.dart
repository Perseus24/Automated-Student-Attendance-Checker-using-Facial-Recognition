import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/big_texts.dart';
import 'temporarySecond.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'main.dart';
import 'appColors.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main(){
  runApp(SignInWindow());
}

class SignInWindow extends StatelessWidget {
  const SignInWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  bool notshowPass = true;
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 55, bottom: 15),
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
                    ]
                )
            ),
            SizedBox(height: 22.55.h,),
            Center(
                child: Container(
                    width: 150.w,
                    height: 80.h,
                    child: Stack(
                        children: [
                          Image.asset(
                            'images/logo.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ]
                    )
                )
            ),
            SizedBox(height: 40.h),
            Column(
                children: [
                  BigText(text: "Welcome Back!", size: 22.sp, fontWeight: FontWeight.w700,),
                  SizedBox(height: 10),
                  BigText(text: "Please enter your log in details.", size: 16.sp,
                      color: Colors.black.withOpacity(0.46000000834465027),
                      fontWeight: FontWeight.w400),
                ]
            ),
            SizedBox(height: 40.h,),
            Container(
                width: 287.w,
                height: 60.h,
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

                child: Container(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: TextFormField(
                      cursorColor: AppColors.blueColor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Email",
                      ),

                    )

                )

            ),
            SizedBox(height: 19.h,),
            Container(
                width: 287.w,
                height: 60.h ,
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

              child: Row(
                children: [
                  Container(
                    width: 235.w,
                    padding: EdgeInsets.only(left: 20.w, ),
                      child: TextFormField(
                        obscureText: notshowPass,
                        cursorColor: AppColors.blueColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Password",
                        ),

                      )
                  ),
                  Container(
                    width: 40.w,
                    child: Container(
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              notshowPass = !notshowPass;
                            });
                          },
                          clipBehavior: Clip.antiAlias,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero, // <--add this
                          ),
                          child: Image.asset(
                              'images/passwordIcon.png',
                            fit: BoxFit.fitWidth,
                          )
                      ),
                    ),
                  )
                ],
              ),

            ),
            SizedBox(height: 8.h,),
            Container(
                width: 287.w,
                height: 18.h,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          activeColor: AppColors.blueColor,
                          value: isChecked,
                          onChanged: (bool?value){
                            setState((){
                              isChecked = value!;
                            });
                          }
                      ),
                      BigText(text: 'Remember Me', size: 17.sp, color: Color(0xFF1A43BF), fontWeight: FontWeight.w400,)
                    ],

                ),


            ),
            SizedBox(height: 61.h,),
            Container(
                width: 287.w,
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

                child: ElevatedButton(
                    clipBehavior: Clip.antiAlias,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color(0xFF1A43BF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: (){
                      Navigator.of(context).push(createRouteGo(1));
                    },
                    child: BigText(text: "Log In", color: Colors.white, fontWeight: FontWeight.w700,)
                )
            ),
            SizedBox(height: 10,)
          ],
        )
      ),
    );
  }
}


