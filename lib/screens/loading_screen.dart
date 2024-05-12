

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/landing_page.dart';
import 'package:flutter_application_1/screens/main_homepage.dart';
import 'package:flutter_application_1/utilities/build_routes.dart';
import 'package:flutter_application_1/utilities/constants.dart';
import 'package:flutter_application_1/utilities/get_user_data.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:get/get.dart';

import '../professor_side/main_homepage_prof.dart';
import 'notification_page.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  UserDataControllers userDataControllers = Get.put(UserDataControllers());

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    ifUserExists();
  }

  void ifUserExists() async{
    await userDataControllers.checkLoggedIn()? getUserData() :
    Navigator.of(context).push(createRouteGo(LandingPage()));
  }

  void getUserData() async{
    GetUserFirebaseInfo getUserFirebaseInfo = GetUserFirebaseInfo();
    await getUserFirebaseInfo.fetchStudentFirebaseInfos();
    if(userDataControllers.switchDashboardUser.value == 0){
      getUserFirebaseInfo.fetchNotificationHistory();
      Navigator.push(context, createRouteGo(MainHomePage()));
    }else{
      Navigator.push(context, createRouteGo(MainHomePageProf()));
    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 150,
                height: 80,
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
            ),
            SizedBox(height: 40,),
            LoadingAnimationWidget.discreteCircle(
             color: kBlueColor,
             size: 60,
            secondRingColor: Colors.orange,
            thirdRingColor: Colors.white30),
          ],
        ),
      )
    );
  }
}
