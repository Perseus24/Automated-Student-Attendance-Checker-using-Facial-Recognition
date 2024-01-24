
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:flutter_application_1/appBar.dart';
import 'package:flutter_application_1/thirdPage.dart';
import 'package:flutter_application_1/widgets/big_texts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'build_routes.dart';
import 'drawerPage.dart';
import 'getStringsDate.dart';
import 'getUserInformations.dart';
import 'main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/appColors.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarHome extends StatelessWidget {
  const CalendarHome({super.key});

  @override
  Widget build(BuildContext context){
    DateTime now = DateTime(2024, DateTime.now().month, DateTime.now().day);
    String dayOfWeek = getDayOfWeek(now.weekday);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Container(
            child: Row(
              children: [
                BigText(text: now.day.toString(), color: Color(0xFFFFC278), size: 45.sp, fontWeight: FontWeight.w500,),
                SizedBox(width: 8.w,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: dayOfWeek.toString(), color: Color(0xFFBCC1CD), size: 14.sp, fontWeight: FontWeight.w500,),
                    BigText(text: 'Jan 2024', color: Color(0xFFBCC1CD), size: 14.sp, fontWeight: FontWeight.w500,)
                  ],
                )
              ],
            ),
          ),
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
        body: AppBarPage().createState().hi(context, 2),
        drawer: buildDrawer().drawer(context, 2),
      ),
    );
  }
}


class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  DateTime nextMonthFirst = DateTime(DateTime.now().year, DateTime.now().month + 1, 1);

  final userDataControllers = Get.put(UserDataControllers());


  @override
  Widget build(BuildContext context) {
    DateTime lastDayOfMonth = nextMonthFirst.subtract(Duration(days: 1));

    return Container(
      color: AppColors.blueColor,
      child: Stack(
        children: [
          Positioned(
              child: Container(
                height: getDynamicSize.getHeight(context),
                width:getDynamicSize.getWidth(context),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                  ),
                ),
              )
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                height: 70.h,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                  ),
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2024,DateTime.now().month,1),
                  lastDay: DateTime.utc(2024,DateTime.now().month,lastDayOfMonth.day),
                  focusedDay: _focusedDay,
                  calendarFormat: CalendarFormat.week,
                  availableGestures: AvailableGestures.horizontalSwipe,
                  headerVisible: false,

                  onDaySelected: (selectedDay, focusedDay){
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      print(_selectedDay.day);
                    });
                  },

                  selectedDayPredicate: (DateTime date) {
                    return isSameDay(_selectedDay, date);
                  },

                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Color(0xFFBCC1CD), fontWeight: FontWeight.w500),
                    weekendStyle: TextStyle(color: Color(0xFFBCC1CD), fontWeight: FontWeight.w500)
                  ),


                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    selectedDecoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    todayTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                    selectedTextStyle: TextStyle(color: Colors.white),
                    defaultTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                    weekendTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                    todayDecoration: BoxDecoration(
                      //color: Colors.orange,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    defaultDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    weekendDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:10.h),
                padding: EdgeInsets.only(left: 20.w),
                height: 20.h,
                child: Row(
                  children: [
                    BigText(text: 'Time', color: Color(0xFFBCC1CD), size: 16.sp, fontWeight: FontWeight.w500,),
                    SizedBox(width: 50.w,),
                    BigText(text: 'Course', color: Color(0xFFBCC1CD), size: 16.sp, fontWeight: FontWeight.w500,),
                  ],
                ),
              ),
              buildSchedules()
            ],
          ),
        ],
      ),

    );
  }


  Widget buildSchedules(){
    final CollectionReference subjectsTable = FirebaseFirestore.instance.collection('subjects');
    final CollectionReference professorsTable = FirebaseFirestore.instance.collection('professor');
    final CollectionReference schedSubjectTable = FirebaseFirestore.instance.collection('subject_sched');
    final CollectionReference roomTable = FirebaseFirestore.instance.collection('room');
    final CollectionReference bldgTable = FirebaseFirestore.instance.collection('bldg');

    List<DocumentSnapshot<Object?>> getSchedule(List<DocumentSnapshot> sched){

      final now = DateTime(2024,1,_selectedDay.day);
      final dayOfWeek = now.weekday; // This is an integer representing the day of the week (1=Monday, 2=Tuesday, etc.)
      List<DocumentSnapshot> filteredSched = sched.where((doc) =>
      doc['day_of_week'] == dayOfWeek).toList();
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


    List<DocumentSnapshot> schedule = getSchedule(userDataControllers.scheduleSnapshot);
    List<DocumentSnapshot> subjectDocs = Get.find<UserDataControllers>().subjectSnapshot;
    List<DocumentSnapshot> professorDocs = userDataControllers.professorSnapshot;
    List<DocumentSnapshot> roomDocs = userDataControllers.roomSnapshot;
    List<DocumentSnapshot> bldgDocs = userDataControllers.bldgSnapshot;


    return Container(
      height: 450.h,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: schedule.length,
        //scrollBehavior: ScrollBehavior(),
        controller: PageController(viewportFraction: 0.2),
        itemBuilder: (context, position) {
          final schedSubjectSnapshot = schedule[position];
          final subjectSnapshot = subjectDocs.firstWhere((doc) => doc['subject_id'] == schedSubjectSnapshot['subject_id']);
          final professorSnapshot = professorDocs.firstWhere((doc) => doc['professor_id'] == subjectSnapshot['professor_id']);
          final roomSnapshot = roomDocs.firstWhere((doc) => doc['room_id'] == schedSubjectSnapshot['room_id']);
          final bldgSnapshot = bldgDocs.firstWhere((doc) => doc['bldg_id'] == roomSnapshot['bldg_id']);


          return buildSchedItems(
              schedSubjectSnapshot,
              subjectSnapshot,
              professorSnapshot,
              roomSnapshot,
              bldgSnapshot,
              position

          );
        },
      ),
    );

  }

  Widget buildSchedItems(DocumentSnapshot schedSubjectSnapshot, DocumentSnapshot subjectSnapshot, DocumentSnapshot professorSnapshot,
      DocumentSnapshot roomSnapshot, DocumentSnapshot bldgSnapshot, int position){

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
      width: getDynamicSize.getWidth(context),
      padding: EdgeInsets.only(top: 18.h, left: 24.w, right: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  child: BigText(text: startTimeString, color: Colors.black, size: 16.sp, fontWeight: FontWeight.w500,),
                ),
                SizedBox(height: 5.h,),
                Container(
                  child: BigText(text: endTimeString, color: Color(0xFFBCC1CD), size: 16.sp,),
                )
              ],
            ),
          ),
          //SizedBox(width: 50.w,),
          Container(
              height: 96.h,
              width: 265.w,
              padding: EdgeInsets.only(top: 12.h, left: 20.w, right: 20.w, bottom: 10.h),
              decoration: ShapeDecoration(
                color: (position.isOdd)?AppColors.blueColor:Color(0x771A43BF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),

              ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(text: subjectSnapshot['subject_name'].toString(), size: 16.sp, color: Colors.white,),
                Row(
                  children: [
                    Icon(Icons.meeting_room, color: Colors.white, size: 15.sp,),
                    Expanded(
                      child: BigText(text: bldgSnapshot['bldg_name'].toString() + " " + roomSnapshot['room_id'].toString(), color: Colors.white,
                        fontWeight: FontWeight.w500, size: 15.sp, maxLines: 2,),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );

  }
}
