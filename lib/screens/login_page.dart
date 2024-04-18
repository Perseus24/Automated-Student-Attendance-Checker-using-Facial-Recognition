import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/forgot_pass.dart';
import 'package:flutter_application_1/screens/main_homepage.dart';
import 'package:flutter_application_1/widgets/big_texts.dart';
import '../utilities/build_routes.dart';
import '../utilities/get_user_data.dart';
import 'register_user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'landing_page.dart';
import '../utilities/constants.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/screens/loading_screen.dart';

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

  final AuthService authService = AuthService();
  final LogInControllers logInController = LogInControllers();
  final logInControllerTemp = Get.put(LogInControllers());
  bool notshowPass = true;
  bool? isChecked = false;
  @override
  void initState() {
    super.initState();
    // Initialize the controller outside the build method
    Get.put(logInController);
  }
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LogInControllers>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
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
                                  Navigator.of(context).push(createRouteBack(MyApp()));
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
                  height: getDynamicSize.getHeight(context)*0.03,
                  width: getDynamicSize.getWidth(context)*0.8,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: BigText(text: 'Email', size: 13.sp, fontWeight: FontWeight.w500,)),
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
                            Positioned(
                              child: Container(
                                padding: EdgeInsets.only(top: 0.h, left: 10.h, right: 10.h),
                                child: Obx(() =>TextFormField(
                                  controller: logInControllerTemp.emailController,
                                  cursorColor: kBlueColor,
                                  onChanged: (_){
                                    logInControllerTemp.emailNotFoundController.text = '';
                                    logInControllerTemp.updateInputs();
                                  },

                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      logInControllerTemp.emailNotFoundController.text = '';
                                      return 'This field is required' ;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    errorText: (logInControllerTemp.hasEmailError.value) ? 'This field is required' :
                                    logInControllerTemp.emailNotFoundControllerText.value,

                                    //errorStyle: TextStyle(fontSize: 2),
                                    border: InputBorder.none,

                                  ),

                                )),
                              ),
                            ),



                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 19.h,),
                Container(
                  height: getDynamicSize.getHeight(context)*0.03,
                  width: getDynamicSize.getWidth(context)*0.8,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: BigText(text: 'Password', size: 13.sp, fontWeight: FontWeight.w500,)),
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
                            Positioned(
                              child: Container(
                                padding: EdgeInsets.only(top: 0.h, left: 10.h, right: 10.h),
                                child: Obx(() =>TextFormField(
                                  obscureText: notshowPass,
                                  controller: logInControllerTemp.passwordController,
                                  cursorColor: kBlueColor,
                                  onChanged: (_){
                                    logInControllerTemp.passwordWrongController.text = '';
                                    logInControllerTemp..updateInputs();
                                  },
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      logInControllerTemp.passwordWrongController.text = '';
                                      return 'This field is required' ;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    errorText: (logInControllerTemp.hasPasswordError.value) ? 'This field is required' :
                                    logInControllerTemp.passwordWrongControllerText.value,

                                    //errorStyle: TextStyle(fontSize: 2),
                                    border: InputBorder.none,

                                  ),

                                )),
                              ),
                            ),
                            Positioned(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: 40.w,
                                  margin: EdgeInsets.only(right: 20.w),
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
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30.h,),
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
                        onPressed: () async {
                          if(!controller.hasEmailError.value ){
                            User? user;
                            logInControllerTemp.loading.value = true;
                            try{
                              user = await authService.signInWithEmailAndPassword(controller.emailControllerText.value, controller.passwordControllerText.value);
                              GetUserFirebaseInfo getUserFirebaseInfo = GetUserFirebaseInfo();    //note that  new users are not able to log in
                              await getUserFirebaseInfo.fetchStudentFirebaseInfos();
                            }catch (e){

                            }finally{
                              logInControllerTemp.loading.value = false;
                            }
                            logInControllerTemp.updateInputs();
                            if(user != null){
                              controller.emailController.text = '';
                              controller.passwordController.text = '';
                              controller.emailNotFoundController.text = '';
                              controller.passwordWrongController.text = '';
                              controller.hasPasswordError = false.obs;
                              controller.hasEmailError = false.obs;
                              Navigator.of(context).push(createRouteGo(MainHomePage()));

                            }
                          }
                        },
                        child: BigText(text:'Log In', color: Colors.white, fontWeight: FontWeight.w700,)
                    )
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  width: 287.w,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white
                    ),
                    onPressed: (){
                      Navigator.of(context).push(createRouteGo(ForgotPassPage()));
                    },
                    child: Center(
                      child: BigText(text: 'Forgot Password?', size: 15.sp, color: kBlueColor,),
                    ),
                  ),
                ),
                SizedBox(height: 10.h,)
              ],
            ),
            Obx(()=>Positioned.fill(
              child: logInControllerTemp.loading.value ? buildLoading(context) : Container()
            ))
          ],
        )
      ),
    );
  }

  Widget buildLoading(BuildContext context){
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: kBlueColor,
            strokeWidth: 5.w,
          ),
          SizedBox(height: 10.h,),
          BigText(text: 'Preparing...', color: Colors.white,)
        ],
      ),
    );
  }
}





