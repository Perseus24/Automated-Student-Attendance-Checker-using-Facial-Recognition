import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/constants.dart';

import 'package:flutter_application_1/web/LandingPage.dart';
import 'package:flutter_application_1/web/Navbar.dart';
import 'package:flutter_application_1/widgets/big_texts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';


void main() {
  Get.put(MenuController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        leadingWidth: (MediaQuery.of(context).size.width>=628)?300:0,
        leading: (MediaQuery.of(context).size.width>=628)?Container(
          width: 100,
          height: 30,
          margin: EdgeInsets.only(top: 25, left: 0),
          child: Image.asset(
            'images/logo.png',
            fit: BoxFit.contain,

          ),
        ):null,
        title: (MediaQuery.of(context).size.width>=628)?Container(
          margin: EdgeInsets.only(top: 25),
          width: 300,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF3E4F63),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "About Us",
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF3E4F63),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "FAQs",
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF3E4F63),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2
                  ),
                ),
              ),
            ],
          ),
        ):Container(
          width: 100,
          height: 30,
          margin: EdgeInsets.only(left: 30),
          child: Image.asset(
            'images/logo.png',
            fit: BoxFit.contain,

          ),
        ),
      ),
      drawer: (MediaQuery.of(context).size.width>=628)?null:Container(),
      body: (MediaQuery.of(context).size.width>785)?BodyWeb():(MediaQuery.of(context).size.width>530)?MediumResponsive():SmallResponsive(),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFF3E4F63),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Automated Student Attendance Checker using Facial Recognition",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    wordSpacing: 5
                ),
              )
            ),
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Bicol University, College of Science, Computer Science and Information Technology Department",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      wordSpacing: 5
                  ),
                )
            ),
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                child: Text(
                  "We were here. (May, 2024)",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      wordSpacing: 5
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavBarMid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFF3E4F63),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Automated Student Attendance Checker using Facial Recognition",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      wordSpacing: 5
                  ),
                )
            ),
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(

                  children: [
                    Text(
                      "Bicol University, College of Science, Computer Science and Information Technology Department",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          wordSpacing: 5,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "We were here. (May, 2024)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          wordSpacing: 5
                      ),
                    )
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavBarOne extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: Color(0xFF3E4F63),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      "Automated Student Attendance Checker using Facial Recognition",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          wordSpacing: 5
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "Bicol University, College of Science, Computer Science and Information Technology Department",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        wordSpacing: 5,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "We were here. (May, 2024)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          wordSpacing: 5
                      ),
                    )
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }
}


class BodyWeb extends StatefulWidget {
  const BodyWeb({super.key});

  @override
  State<BodyWeb> createState() => _BodyWebState();
}

class _BodyWebState extends State<BodyWeb> {

  bool getAppTapped = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        color: Color(0xFFFEFEFE),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(left: 70, right: (MediaQuery.of(context).size.width >= 894)?160:100, top: 110),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(text: "The Simplest Automated Student Attendance Checker.", size: 50, fontWeight: FontWeight.w900, maxLines: 6, color: Color(0xFF3E4F63),),
                        SizedBox(height: 30,),
                        Text(
                          "The system aims to redefine the attendance management by using Artificial Intelligence that harnesses "
                              "the use of facial recognition to record attendance.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            wordSpacing: 5
                          ),
                        ),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            SvgPicture.asset("images/android-svgrepo-com.svg", height: 40, width: 40,),
                            SizedBox(width: 15,),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    getAppTapped = true;
                                  });
                                },
                                child: Text(
                                  "Get App",
                                  style: TextStyle(
                                      color: Color(0xFF3E4F63),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      wordSpacing: 5
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 30,),
                        Visibility(
                          visible: getAppTapped,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: ()=>launchUrl(Uri.parse("https://firebasestorage.googleapis.com/v0/b/kumit-4cd27.appspot.com/o/t.dart?alt=media&token=ddf11e66-0bde-423a-91ff-d71406429923")),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                                color: Colors.grey[200],
                                child: Text(
                                  "KUMIT android appplication - Version 1.0",
                                  style: TextStyle(
                                      color: Color(0xFF3E4F63),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      wordSpacing: 5
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'images/web_pic.png',
                    fit: BoxFit.contain,

                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            BottomNavBar(),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}

class MediumResponsive extends StatefulWidget {
  const MediumResponsive({super.key});

  @override
  State<MediumResponsive> createState() => _MediumResponsiveState();
}

class _MediumResponsiveState extends State<MediumResponsive> {

  bool getAppTapped = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        color: Color(0xFFFEFEFE),
        child: Column(
          children: [
            SizedBox(height: 30,),
            Container(
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                  'images/web_pic.png',
                  fit: BoxFit.contain,
                ),
            ),
            Container(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: "The Simplest Automated Student Attendance Checker.", size: 50, fontWeight: FontWeight.w900, maxLines: 6, color: Color(0xFF3E4F63),),
                  SizedBox(height: 30,),
                  Text(
                    "The system aims to redefine the attendance management by using Artificial Intelligence that harnesses "
                        "the use of facial recognition to record attendance.",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        wordSpacing: 5
                    ),
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      SvgPicture.asset("images/android-svgrepo-com.svg", height: 40, width: 40,),
                      SizedBox(width: 15,),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              getAppTapped = true;
                            });
                          },
                          child: Text(
                            "Get App",
                            style: TextStyle(
                                color: Color(0xFF3E4F63),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                wordSpacing: 5
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30,),
                  Visibility(
                    visible: getAppTapped,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: ()=>launchUrl(Uri.parse("https://firebasestorage.googleapis.com/v0/b/kumit-4cd27.appspot.com/o/t.dart?alt=media&token=ddf11e66-0bde-423a-91ff-d71406429923")),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                          color: Colors.grey[200],
                          child: Text(
                            "KUMIT android appplication - Version 1.0",
                            style: TextStyle(
                                color: Color(0xFF3E4F63),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                wordSpacing: 5
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            BottomNavBarMid(),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}

class SmallResponsive extends StatefulWidget {
  const SmallResponsive({super.key});

  @override
  State<SmallResponsive> createState() => _SmallResponsiveState();
}

class _SmallResponsiveState extends State<SmallResponsive> {
  bool getAppTapped = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Color(0xFFFEFEFE),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Container(
              height: 300,
              child: Image.asset(
                'images/web_pic.png',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: "The Simplest Automated Student Attendance Checker.", size: 30, fontWeight: FontWeight.w900, maxLines: 6, color: Color(0xFF3E4F63),),
                  SizedBox(height: 20,),
                  Text(
                    "The system aims to redefine the attendance management by using Artificial Intelligence that harnesses "
                        "the use of facial recognition to record attendance.",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        wordSpacing: 5
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      SvgPicture.asset("images/android-svgrepo-com.svg", height: 30, width: 30,),
                      SizedBox(width: 15,),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              getAppTapped = true;
                            });
                          },
                          child: Text(
                            "Get App",
                            style: TextStyle(
                                color: Color(0xFF3E4F63),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                wordSpacing: 5
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Visibility(
                    visible: getAppTapped,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: ()=>launchUrl(Uri.parse("https://gyraobelctnlakdsymyu.supabase.co/storage/v1/object/public/kumit%20application/kumit_v_0-1-0.apk?t=2024-05-19T06%3A10%3A01.710Z")),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                          color: Colors.grey[200],
                          child: Text(
                            "KUMIT android appplication - Version 1.1",
                            style: TextStyle(
                                color: Color(0xFF3E4F63),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                wordSpacing: 5
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            BottomNavBarOne(),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(26, 67, 191, 1.0),
                Color.fromRGBO(0, 228, 243, 1.0)
              ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Navbar(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 95.0, horizontal: 95.0),
                child: LandingPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
