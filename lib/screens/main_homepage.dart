import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../utilities/build_routes.dart';
import '../widgets/hamburger.dart';
import '../utilities/get_weekdays_strings.dart';
import '../utilities/get_user_data.dart';
import 'landing_page.dart';
import '../utilities/constants.dart';
import '../widgets/big_texts.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
          backgroundColor: kBlueColor,
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
        body: Home1(),
        drawer: BuildDrawer(pageIndication: 0),
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
    ScreenUtil.init(context, designSize: const Size(375, 677));
    DateTime now = DateTime.now();
    String dayOfWeek = getDayOfWeek(now.weekday);
    String month = getMonth(now.month);
    String dateShow = "$month ${now.day}, $dayOfWeek";

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140.h,
              margin: EdgeInsets.only(top: 25.h, left: 25.w, right: 25.w),
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

              child: Container(
                padding: EdgeInsets.only(top: 10.h, left:22.w, right: 22.w, bottom: 20.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(text: dateShow, size: 15.sp, color:Color(0xFFD7D7D8), fontWeight: FontWeight.w400,
                          letterSpacing: 0.05,),
                        Container(
                            child: DigitalClock(
                              areaHeight: getDynamicSize.getHeight(context)*0.03,
                              hourMinuteDigitTextStyle: TextStyle(
                                color: Color(0xFFD7D7D8),
                                fontFamily: 'SF Pro Display',
                                fontSize: 15.sp,
                              ),
                              secondDigitTextStyle: TextStyle(
                                color: Color(0xFFD7D7D8),
                                fontFamily: 'SF Pro Display',
                                fontSize: 10.sp,
                              ),
                              colon: Text(
                                  ":",

                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Color(0xFFD7D7D8),
                                  )
                              ),
                            )

                        ),
                      ],
                    ),
                    SizedBox(height: getDynamicSize.getHeight(context)*0.01,),
                    Row(
                      children: [
                        BigText(text: "Welcome back, Cy!", color: Colors.white, size: 22.sp, fontWeight: FontWeight.w700,
                          letterSpacing: 0.08,)
                      ],
                    ),
                    SizedBox(height: getDynamicSize.getHeight(context)*0.01,),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: 'You currently have an attendance rate', color: Colors.white, letterSpacing: 0.06,
                              size: 16.sp, fontWeight: FontWeight.w400,),
                            SizedBox(height: getDynamicSize.getHeight(context)*0.005,),
                            Row(
                              children: [
                                BigText(text: 'of', color: Colors.white, letterSpacing: 0.06,
                                  size: 16.sp, fontWeight: FontWeight.w400,),
                                BigText(text: ' 60%', color: Colors.white, letterSpacing: 0.06,
                                  size: 16.sp, fontWeight: FontWeight.w700,),
                                BigText(text: '. Keep up the good work!', color: Colors.white, letterSpacing: 0.06,
                                  size: 16.sp, fontWeight: FontWeight.w400,),
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
                child: BigText(text: "Today's schedule", size: 20.sp, fontWeight: FontWeight.w700, color: Colors.black,)
            ),
            ClassesBody(0),
            Container(
                height: getDynamicSize.getHeight(context)*0.05,
                margin: EdgeInsets.only(top: getDynamicSize.getHeight(context)*0.03, left: getDynamicSize.getWidth(context)*0.05,
                    right: getDynamicSize.getWidth(context)*0.05),
                child: BigText(text: "Tomorrow's schedule",size: 20.sp, fontWeight: FontWeight.w700, color: Colors.black,)
            ),
            ClassesBody(1),
            Container(
                height: getDynamicSize.getHeight(context)*0.03,
                margin: EdgeInsets.only(top: getDynamicSize.getHeight(context)*0.03, left: getDynamicSize.getWidth(context)*0.05,
                    right: getDynamicSize.getWidth(context)*0.05),
                child: BigText(text: "Related Websites", size: 20.sp, fontWeight: FontWeight.w700, color: Colors.black,)
            ),
            Container(
              width: getDynamicSize.getWidth(context)*1,
              height: getDynamicSize.getHeight(context)*0.1,
              margin: EdgeInsets.only(top: getDynamicSize.getHeight(context)*0.03, left: getDynamicSize.getWidth(context)*0.05,
                  right: getDynamicSize.getWidth(context)*0.05),

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
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: getDynamicSize.getWidth(context)*0.04),
                      child: Image.asset('images/BU_Logo.png')
                  ),
                  Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: getDynamicSize.getHeight(context)*0.02, left: getDynamicSize.getWidth(context)*0.02, right: getDynamicSize.getWidth(context)*0.02,),
                          width: getDynamicSize.getWidth(context)*0.65,
                          child: BigText(text: 'Bicol University Student Portal', color: Colors.white, fontWeight: FontWeight.w700,size: 16, maxLines: 1,)
                      ),
                      Container(
                          margin: EdgeInsets.only(top: getDynamicSize.getHeight(context)*0.0035, left: getDynamicSize.getWidth(context)*0.02, right: getDynamicSize.getWidth(context)*0.02,),
                          width: getDynamicSize.getWidth(context)*0.65,
                          child: GestureDetector(
                              onTap: () => launchUrl(Uri.parse("https://ibu.bicol-u.edu.ph")),
                              child: BigText(text: "https://ibu.bicol-u.edu.ph", color: Colors.white, fontWeight: FontWeight.w400,size: 15, maxLines: 1,)
                          )
                      ),

                    ],
                  )

                ],
              ),
            ),
            Container(
              width: getDynamicSize.getWidth(context)*1,
              height: getDynamicSize.getHeight(context)*0.1,
              margin: EdgeInsets.only(top: getDynamicSize.getHeight(context)*0.03, left: getDynamicSize.getWidth(context)*0.05,
                  right: getDynamicSize.getWidth(context)*0.05),

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
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: getDynamicSize.getWidth(context)*0.04),
                      child: Image.asset('images/BU.png')
                  ),
                  Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: getDynamicSize.getHeight(context)*0.02, left: getDynamicSize.getWidth(context)*0.02, right: getDynamicSize.getWidth(context)*0.02,),
                          width: getDynamicSize.getWidth(context)*0.65,
                          child: BigText(text: 'Bicol University Learning Management System', color: Colors.white, fontWeight: FontWeight.w700,size: 16.sp, maxLines: 1,)
                      ),
                      Container(
                          margin: EdgeInsets.only(top: getDynamicSize.getHeight(context)*0.0035, left: getDynamicSize.getWidth(context)*0.02, right: getDynamicSize.getWidth(context)*0.02,),
                          width: getDynamicSize.getWidth(context)*0.65,
                          child: GestureDetector(
                              onTap: () => launchUrl(Uri.parse("https://bulms.bicol-u.edu.ph/login/index.php")),
                              child: BigText(text: "https://bulms.bicol-u.edu.ph/login/index.php", color: Colors.white, fontWeight: FontWeight.w400,size: 16.sp, maxLines: 1,)
                          )
                      ),

                    ],
                  )

                ],
              ),
            ),
            SizedBox(height:10)
          ],
        ),
      ),
      //drawer: drawerPage(),
    );
  }
}


class ClassesBody extends StatefulWidget {
  final int i;

  const ClassesBody(this.i, {Key? key}) : super(key: key);

  @override
  State<ClassesBody> createState() => _ClassesBodyState();
}

class _ClassesBodyState extends State<ClassesBody>{


  @override
  void initState() {
    super.initState();
  }

  final userDataControllers = Get.put(UserDataControllers());

  @override
  Widget build(BuildContext context){
    int switchSched = widget.i;
    String wordToday = '';

    List<DocumentSnapshot<Object?>> getSchedule(List<DocumentSnapshot> sched, bool swtch){

      final now = DateTime.now();
      final dayOfWeek = now.weekday; // This is an integer representing the day of the week (1=Monday, 2=Tuesday, etc.)
      List<DocumentSnapshot> filteredSched = sched.where((doc) =>
      doc['day_of_week'] == (swtch? dayOfWeek: (dayOfWeek == 7)?1:dayOfWeek+1)).toList();
      filteredSched.sort((a, b) {
        // Assuming 'time' is a string in HH:mm aa format
        Timestamp tsA = a['start_time'];
        Timestamp tsB = b['start_time'];

        DateTime dtA = tsA.toDate();
        DateTime dtB = tsB.toDate();

        // Comparing DateTime objects
        return dtA.hour.compareTo(dtB.hour);
      });
      return filteredSched;
    }

    List<DocumentSnapshot> schedule = userDataControllers.scheduleSnapshot;
    List<DocumentSnapshot> subjectDocs = Get.find<UserDataControllers>().subjectSnapshot;
    List<DocumentSnapshot> professorDocs = userDataControllers.professorSnapshot;
    List<DocumentSnapshot> roomDocs = userDataControllers.roomSnapshot;
    List<DocumentSnapshot> bldgDocs = userDataControllers.bldgSnapshot;

    if (switchSched == 0) {
      wordToday = 'today';
      schedule = getSchedule(schedule, true);
    } else {
      wordToday = 'tomorrow';
      schedule = getSchedule(schedule, false);
    }

    if(schedule.isEmpty){
      return Container(
          height: getDynamicSize.getHeight(context) * 0.1,
          width: getDynamicSize.getWidth(context) * 0.8,
          margin: EdgeInsets.only(left: getDynamicSize.getWidth(context) * 0.08, right: getDynamicSize.getWidth(
              context) * 0.05),
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
          child: Center(child: BigText(text: 'You have no classes $wordToday!', size: 15.sp, color: Colors.black,
              fontWeight: FontWeight.w700))
      );
    }else{
      return Container(
        height: getDynamicSize.getHeight(context) * 0.17,
        child: PageView.builder(
          itemCount: schedule.length,
          controller: PageController(viewportFraction: 0.85),
          itemBuilder: (context, position) {
            final schedSubjectSnapshot = schedule[position];
            final subjectSnapshot = subjectDocs.firstWhere((doc) => doc['subject_id'] == schedSubjectSnapshot['subject_id']);
            final professorSnapshot = professorDocs.firstWhere((doc) => doc['professor_id'] == subjectSnapshot['professor_id']);
            final roomSnapshot = roomDocs.firstWhere((doc) => doc['room_id'] == schedSubjectSnapshot['room_id']);
            final bldgSnapshot = bldgDocs.firstWhere((doc) => doc['bldg_id'] == roomSnapshot['bldg_id']);

            return _buildPageItem(
              schedSubjectSnapshot,
              subjectSnapshot,
              professorSnapshot,
              roomSnapshot,
              bldgSnapshot,

            );
          },
        ),
      );
    }

  }






  Widget _buildPageItem(DocumentSnapshot schedSubjectSnapshot, DocumentSnapshot subjectSnapshot, DocumentSnapshot professorSnapshot,
      DocumentSnapshot roomSnapshot, DocumentSnapshot bldgSnapshot){

    Timestamp startTime = schedSubjectSnapshot['start_time'];
    Timestamp endTime = schedSubjectSnapshot['end_time'];

    DateTime startTimeCon = startTime.toDate();
    DateTime endTimeCon = endTime.toDate();

    String morningVar;
    int hour1;
    int hour2;

    if(startTimeCon.hour> 12 || endTimeCon.hour > 12){
      hour1 = startTimeCon.hour - 12;
      hour2 = endTimeCon.hour - 12;
      morningVar = 'PM';
    }else{
      hour1 = startTimeCon.hour;
      hour2 = endTimeCon.hour;
      morningVar = 'AM';
    }
    String startTimeString = hour1.toString().padLeft(1, '0') + ":" + startTimeCon.minute.toString().padLeft(2, '0');
    String endTimeString = hour2.toString().padLeft(1, '0') + ":" + endTimeCon.minute.toString().padLeft(2, '0');


    return Container(

      margin: EdgeInsets.only(left: 0, right: 10.w, bottom: 8.h),
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
          padding: EdgeInsets.only(top: getDynamicSize.getHeight(context)*0.02, left: getDynamicSize.getWidth(context)*0.05,
              right: getDynamicSize.getWidth(context)*0.05),
          child: Row(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: getDynamicSize.getWidth(context)*0.3,
                        child: BigText(text: startTimeString, size: 40.sp,fontWeight: FontWeight.w700, color: Color(0xFF1A43BF),)
                    ),
                    Container(
                      width: getDynamicSize.getWidth(context)*0.2,
                      child: BigText(text:morningVar,size: 15.sp, fontWeight: FontWeight.w500, color: Colors.black,),
                    ),
                    SizedBox(height: getDynamicSize.getHeight(context)*0.005,),
                    Row(
                      children: [
                        Icon(Icons.alarm_outlined, color: Colors.grey, size: 16.sp,),
                        Container(
                          width: getDynamicSize.getWidth(context)*0.2,
                          child: BigText(text:" " + endTimeString,size: 16.sp, fontWeight: FontWeight.w500, color: Colors.grey,),
                        ),
                      ],
                    )
                  ]
              ),
              Column(
                children: [
                  Container(
                      height: getDynamicSize.getHeight(context)*0.056,
                      width: getDynamicSize.getWidth(context)*0.39,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: BigText(text: subjectSnapshot['subject_name'].toString(), color: Colors.black,
                          fontWeight: FontWeight.w700, size: 16.sp, maxLines: 2,),
                      )
                  ),
                  SizedBox(height: getDynamicSize.getHeight(context)*0.01),
                  Container(
                    width: getDynamicSize.getWidth(context)*0.39,
                    child: Row(
                      children: [
                        Icon(Icons.person, color: Colors.black, size: 15.sp,),
                        Expanded(
                          child: BigText(text: professorSnapshot['first_name'].toString() + " " + professorSnapshot['last_name'].toString(), color: Colors.black,
                            fontWeight: FontWeight.w500, size: 15.sp, maxLines: 1,),
                        )
                      ],

                    ),
                  ),
                  SizedBox(height: getDynamicSize.getHeight(context)*0.005),
                  Container(
                    width: getDynamicSize.getWidth(context)*0.39,
                    child: Row(
                      children: [
                        Icon(Icons.meeting_room, color: Colors.black, size: 15.sp,),
                        Expanded(
                          child: BigText(text: bldgSnapshot['bldg_name'].toString() + " " + roomSnapshot['room_id'].toString(), color: Colors.black,
                            fontWeight: FontWeight.w500, size: 15.sp, maxLines: 2,),
                        )
                      ],

                    ),
                  )
                ],
              )
            ],
          )
      ),

    );
  }

}








