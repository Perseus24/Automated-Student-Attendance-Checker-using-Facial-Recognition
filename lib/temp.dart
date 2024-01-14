import 'package:flutter/material.dart';
import 'package:flutter_application_1/firstPage.dart';
import 'temporarySecond.dart';
import 'appColors.dart';
import 'widgets/big_texts.dart';
import 'widgets/icons_and_text.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main(){
  runApp(MainHomePage());
}

class MainHomePage extends StatelessWidget{
  const MainHomePage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: BigText(text: "Dashboard", color: Colors.white, size:25, fontWeight: FontWeight.w700,),
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
                              Navigator.of(context).push(createRoute(0));
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
        body: Home1(),
        drawer: Container(
          child: drawerPage(),
        ),
      ),
    );

  }

}



class Home1 extends StatefulWidget {
  const Home1({Key? key}) : super(key:key);

  @override
  Home1State createState() => Home1State();
}

class Home1State extends State<Home1> {


  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String dayOfWeek = getDayOfWeek(now.weekday);
    String month = getMonth(now.month);
    String dateShow = "$month ${now.day}, ${now.year}";

    return Scaffold(
      body: SingleChildScrollView(
        //height: getDynamicSize.getHeight(context),
        //color: Colors.black12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: getDynamicSize.getHeight(context)*0.22,
              margin: EdgeInsets.only(top: getDynamicSize.getHeight(context)*0.03, left: getDynamicSize.getWidth(context)*0.05,
                  right: getDynamicSize.getWidth(context)*0.05),

              decoration: ShapeDecoration(
                color: AppColors.blueColor,
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

              child: Container(
                padding: EdgeInsets.only(top: getDynamicSize.getHeight(context)*0.015, left: getDynamicSize.getWidth(context)*0.04,
                    right: getDynamicSize.getWidth(context)*0.05),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(text: dateShow, size: 15, color:Color(0xFFD7D7D8), fontWeight: FontWeight.w400,
                          letterSpacing: 0.05,),
                        Container(
                            child: DigitalClock(
                              areaHeight: getDynamicSize.getHeight(context)*0.03,
                              hourMinuteDigitTextStyle: TextStyle(
                                color: Color(0xFFD7D7D8),
                                fontFamily: 'SF Pro Display',
                                fontSize: 15,
                              ),
                              secondDigitTextStyle: TextStyle(
                                color: Color(0xFFD7D7D8),
                                fontFamily: 'SF Pro Display',
                                fontSize: 10,
                              ),
                              colon: Text(
                                ":",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: Colors.white),
                              ),
                            )

                        ),
                      ],
                    ),
                    SizedBox(height: getDynamicSize.getHeight(context)*0.01,),
                    Row(
                      children: [
                        BigText(text: "Welcome back, Taylor!", color: Colors.white, size: 22, fontWeight: FontWeight.w700,
                          letterSpacing: 0.08,)
                      ],
                    ),
                    SizedBox(height: getDynamicSize.getHeight(context)*0.01,),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: 'You currently have an attendance rate of', color: Colors.white, letterSpacing: 0.06,
                              size: 16, fontWeight: FontWeight.w400,),
                            SizedBox(height: getDynamicSize.getHeight(context)*0.005,),
                            Row(
                              children: [
                                BigText(text: '60%', color: Colors.white, letterSpacing: 0.06,
                                  size: 16, fontWeight: FontWeight.w700,),
                                BigText(text: '. Keep up the good work!', color: Colors.white, letterSpacing: 0.06,
                                  size: 16, fontWeight: FontWeight.w400,),
                              ],
                            )
                          ],
                        )
                      ],

                    )
                  ],
                ),
              ),

            ),
            Container(
                height: getDynamicSize.getHeight(context)*0.05,
                margin: EdgeInsets.only(top: getDynamicSize.getHeight(context)*0.03, left: getDynamicSize.getWidth(context)*0.05,
                    right: getDynamicSize.getWidth(context)*0.05),
                child: BigText(text: "Today's schedule", fontWeight: FontWeight.w700, color: Colors.black,)
            ),
            ClassesBody(),
            Container(
                height: getDynamicSize.getHeight(context)*0.05,
                margin: EdgeInsets.only(top: getDynamicSize.getHeight(context)*0.03, left: getDynamicSize.getWidth(context)*0.05,
                    right: getDynamicSize.getWidth(context)*0.05),
                child: BigText(text: "Tomorrow's schedule", fontWeight: FontWeight.w700, color: Colors.black,)
            ),
            ClassesBody(),
            Container(
                height: getDynamicSize.getHeight(context)*0.05,
                margin: EdgeInsets.only(top: getDynamicSize.getHeight(context)*0.03, left: getDynamicSize.getWidth(context)*0.05,
                    right: getDynamicSize.getWidth(context)*0.05),
                child: BigText(text: "Websites", fontWeight: FontWeight.w700, color: Colors.black,)
            ),
            Container(
              width: getDynamicSize.getWidth(context)*1,
              height: getDynamicSize.getHeight(context)*0.15,
              margin: EdgeInsets.only(top: getDynamicSize.getHeight(context)*0.03, left: getDynamicSize.getWidth(context)*0.05,
                  right: getDynamicSize.getWidth(context)*0.05),

              decoration: ShapeDecoration(
                color: AppColors.blueColor,
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
              child: Container(
                alignment: Alignment.centerLeft,
                child:
                Image.asset('images/BU_Logo.png'),
              ),

            ),
            SizedBox(height:10)
          ],
        ),

      ),
      drawer: drawerPage(),
    );


  }
  String getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
  String getMonth(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
}

class drawerPage extends StatefulWidget {
  const drawerPage({super.key});

  @override
  State<drawerPage> createState() => _drawerPageState();
}

class _drawerPageState extends State<drawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(

              )
          )
        ],
      ),
    );
  }
}



class ClassesBody extends StatefulWidget {
  const ClassesBody({super.key});

  @override
  State<ClassesBody> createState() => _ClassesBodyState();
}

class _ClassesBodyState extends State<ClassesBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  List<String> subjectList = ["Operating Systems","Computer Architecture and Organization","Automata Theory and Formal Languages","Software Engineering 1","Artificial Intelligence","KomFil","Art Appreciation"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,

      child: PageView.builder(
          controller: pageController,
          itemCount: 7,
          itemBuilder: (context, position){
            return _buildPageItem(position);
          }
      ),
    );
  }

  Widget _buildPageItem(int index){
    return Container(
      margin: EdgeInsets.only(left: 0, right: 10, bottom: 10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
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
      child: Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Row(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: getDynamicSize.getWidth(context)*0.3,
                        child: BigText(text: "9:30", size: 39,fontWeight: FontWeight.w700, color: Color(0xFF1A43BF),)
                    ),
                    Container(
                      width: getDynamicSize.getWidth(context)*0.2,
                      child: BigText(text: "AM", size: 15, fontWeight: FontWeight.w500, color: Colors.black,),
                    ),
                  ]
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                          child: BigText(text: "Class: ", color: Colors.black, fontWeight: FontWeight.w700, size: 18,)
                      ),
                      Container(
                          child: BigText(text: "BSCS 3B", color: Colors.black, fontWeight: FontWeight.w700, size: 18,)
                      ),
                      SizedBox(width: getDynamicSize.getWidth(context)*0.03,),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          child: BigText(text: "Room: ", color: Colors.black, fontWeight: FontWeight.w700, size: 18,)
                      ),
                      Container(
                          child: BigText(text: "BSCS", color: Colors.black, fontWeight: FontWeight.w700, size: 18,)
                      ),
                      SizedBox(width: getDynamicSize.getWidth(context)*0.03,),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          child: BigText(text: "Subject: ", color: Colors.black, fontWeight: FontWeight.w700, size: 18,)
                      ),
                      Container(
                          child: BigText(text: "BSCS", color: Colors.black, fontWeight: FontWeight.w700, size: 18,)
                      ),
                      SizedBox(width: getDynamicSize.getWidth(context)*0.03,),
                    ],
                  ),

                ],
              )
            ],
          )
      ),

    );
  }

}