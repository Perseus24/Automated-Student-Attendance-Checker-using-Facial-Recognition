

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/landing_page.dart';
import 'package:flutter_application_1/screens/main_homepage.dart';
import 'package:flutter_application_1/utilities/build_routes.dart';
import 'package:flutter_application_1/utilities/constants.dart';
import 'package:flutter_application_1/utilities/get_user_data.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  UserDataControllers userDataControllers = UserDataControllers();

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
    getUserFirebaseInfo.fetchNotificationHistory();
    Navigator.push(context, createRouteGo(MainHomePage()));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.discreteCircle(
         color: kBlueColor,
         size: 60,
        secondRingColor: Colors.orange,
        thirdRingColor: Colors.white30),
      )
    );
  }
}
