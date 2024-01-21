
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/thirdPage.dart';
import 'package:flutter_application_1/widgets/big_texts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'build_routes.dart';
import 'getStringsDate.dart';
import 'main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/appColors.dart';

class CalendarHome extends StatelessWidget {
  const CalendarHome({super.key});

  @override
  Widget build(BuildContext context){
    DateTime now = DateTime(2024, 1, DateTime.now().day);
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
        body: CalendarPage(),
        drawer: drawerPage(),
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

  @override
  Widget build(BuildContext context) {
    days.clear();
    buildCalendarBlocks();
    int index = daysNum.firstWhere((element) => element == DateTime.now().day);
    index = (index/7).floor();

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
                height: 60.h,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                  ),
                ),
                child: PageView.builder(
                  itemCount: 5 - (index-1),
                  itemBuilder: (context, position){ //position starts at 1
                    return buildScrollableCalendar(context, position+(index ));
                  }
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
  List<Widget> days = [];
  List<int> daysNum = [];
  void buildCalendarBlocks(){

    int pos = 1;
    DateTime nextMonthFirst = DateTime(DateTime.now().year, DateTime.now().month + 1, 1);
    DateTime lastDayOfMonth = nextMonthFirst.subtract(Duration(days: 1));

      for(int i=0; i<7; i++){

        DateTime now = DateTime(2024, 1, pos);
        String dayOfWeek = getDayOfWeek(now.weekday);

        if(pos>lastDayOfMonth.day){
          days.add(Container(
            padding: EdgeInsets.only(top:5.h, bottom: 5.h),
            width: 45.w,
            child: Column(
              children: [
                BigText(text: dayOfWeek[0], color: Color(0xFFBCC1CD), size: 15.sp, fontWeight: FontWeight.w500,),
                BigText(text: ' '.toString(), color: Colors.black, size: 15.sp, fontWeight: FontWeight.w600,),
              ],
            ),
          ));
          daysNum.add(0);
          pos++;

        }
        else if((now.weekday != ((i==0)?7:i))){
          dayOfWeek = getDayOfWeek(((i==0)?7:i));
          days.add(Container(
            padding: EdgeInsets.only(top:5.h, bottom: 5.h),
            width: 45.w,
            child: Column(
              children: [
                BigText(text: dayOfWeek[0], color: Color(0xFFBCC1CD), size: 15.sp, fontWeight: FontWeight.w500,),
                BigText(text: ' '.toString(), color: Colors.black, size: 15.sp, fontWeight: FontWeight.w600,),
              ],
            ),
          ));
          daysNum.add(0);
        }
        else{
          days.add(Container(
            padding: EdgeInsets.only(top:5.h, bottom: 5.h),
            width: 45.w,
            decoration: ShapeDecoration(
              color: (DateTime.now().day == pos)?Color(0xFFFF7648):Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Column(
              children: [
                BigText(text: dayOfWeek[0], color: (DateTime.now().day == pos)?Colors.white:Color(0xFFBCC1CD), size: 15.sp, fontWeight: FontWeight.w500,),
                BigText(text: (pos).toString(), color: (DateTime.now().day == pos)?Colors.white:Colors.black, size: 15.sp, fontWeight: FontWeight.w600,),
              ],
            ),
          ));
          daysNum.add(pos);
          pos++;
        }
        if(i==6){
          i = -1;
        }
        if(pos==35){
          break;
        }
      }
  }

  Widget buildScrollableCalendar(BuildContext context, int position){
    
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:days.skip(position*7).take(7).toList()
      ),
    );
  }

  int temporary = 0;

  Widget buildSchedules(){
    final CollectionReference subjectsTable = FirebaseFirestore.instance.collection('subjects');
    final CollectionReference professorsTable = FirebaseFirestore.instance.collection('professor');
    final CollectionReference schedSubjectTable = FirebaseFirestore.instance.collection('subject_sched');
    final CollectionReference roomTable = FirebaseFirestore.instance.collection('room');
    final CollectionReference bldgTable = FirebaseFirestore.instance.collection('bldg');

    List<DocumentSnapshot<Object?>> getSchedule(List<DocumentSnapshot> sched, bool swtch){

      final now = DateTime.now();
      final dayOfWeek = now.weekday; // This is an integer representing the day of the week (1=Monday, 2=Tuesday, etc.)
      List<DocumentSnapshot> filteredSched = sched.where((doc) =>
      doc['day_of_week'] == 1).toList();
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


    return StreamBuilder<QuerySnapshot>(                                            //get the subject schedule table
        stream: schedSubjectTable.snapshots(),
        builder: (context, schedSubjectSnapshot) {
          if (!schedSubjectSnapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            final List<DocumentSnapshot> schedSubjectDocs = schedSubjectSnapshot.data!.docs;
            List<DocumentSnapshot> schedule = getSchedule(schedSubjectDocs, true);

            final subjectIDs = schedule.map((docs) => docs['subject_id']).toList();
            final roomIDs = schedule.map((docs) => docs['room_id']).toList();

            if (schedule.isEmpty) {
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
                  child: Center(child: BigText(text: 'You have no classes today!', size: 15.sp, color: Colors.black,
                      fontWeight: FontWeight.w700))
              );
            } else {

              return StreamBuilder<QuerySnapshot>(                                                  //get the professors table
                  stream: subjectsTable.where('subject_id', whereIn: subjectIDs).snapshots(),
                  builder: (context, subjectSnapshot) {
                    if (!subjectSnapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      final List<DocumentSnapshot> subjectDocs = subjectSnapshot.data!.docs;
                      final professorIDs = subjectDocs.map((docs) => docs['professor_id']).toList();


                      return StreamBuilder<QuerySnapshot>(                                              //get the subjects table
                        stream: professorsTable.where('professor_id', whereIn: professorIDs).snapshots(),
                        builder: (context, professorSnapshot) {
                          if (!professorSnapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            final List<DocumentSnapshot> professorDocs = professorSnapshot.data!.docs;


                            return StreamBuilder<QuerySnapshot>(                                            // get the room table
                              stream: roomTable.where('room_id', whereIn: roomIDs).snapshots(),
                              builder: (context, roomSnapshot) {
                                if (!roomSnapshot.hasData) {
                                  return Center(child: CircularProgressIndicator());
                                } else {
                                  final List<DocumentSnapshot> roomDocs = roomSnapshot.data!.docs;
                                  final bldgIDs = roomDocs.map((docs) =>  docs['bldg_id']).toList();


                                  return StreamBuilder<QuerySnapshot>(                                      //get the bldg table
                                    stream: bldgTable.where('bldg_id', whereIn: bldgIDs).snapshots(),
                                    builder: (context, bldgSnapshot) {
                                      if (!bldgSnapshot.hasData) {
                                        return Center(child: CircularProgressIndicator());
                                      } else {
                                        final List<DocumentSnapshot> bldgDocs = bldgSnapshot.data!.docs;

                                        return Container(
                                          height: 450.h,
                                          child: PageView.builder(
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
                                    },
                                  );
                                }
                              },
                            );
                          }
                        },
                      );
                    }
                  }
              );


            }
            //filtered schedule table
          }
        }
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
