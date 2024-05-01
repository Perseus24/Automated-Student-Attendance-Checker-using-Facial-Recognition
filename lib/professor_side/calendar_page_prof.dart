
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/professor_side/show_class_page.dart';
import 'package:flutter_application_1/professor_side/utilities/get_prof_data.dart';

import 'package:flutter_application_1/widgets/big_texts.dart';

import 'package:get/get.dart';
import '../utilities/build_routes.dart';
import '../widgets/hamburger.dart';
import '../utilities/get_weekdays_strings.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CalendarHomeProf extends StatelessWidget {

  final HomepageController homepageController = Get.put(HomepageController());

  @override
  Widget build(BuildContext context){

    DateTime now = DateTime(2024, DateTime.now().month, DateTime.now().day);
    String dayOfWeek = getDayOfWeek(now.weekday);
    String monthString = getMonth(now.month);

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
                BigText(text: now.day.toString(), color: Color(0xFFFFC278), size: 45, fontWeight: FontWeight.w500,),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: dayOfWeek.toString(), color: Color(0xFFBCC1CD), size: 15, fontWeight: FontWeight.w500,),
                    BigText(text: '${monthString} 2024', color: Color(0xFFBCC1CD), size: 15, fontWeight: FontWeight.w500,)
                  ],
                )
              ],
            ),
          ),
          backgroundColor: kBlueColor,
          actions: [
            Container(
                margin: EdgeInsets.only(right: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: (){
                              homepageController.expandNotifContainer();
                              homepageController.notifButtonTapped.toggle();
                            },
                            clipBehavior: Clip.antiAlias,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: Image.asset('images/Bellpin.png'),
                          )
                      ),
                    ]
                )
            ),
          ],
          toolbarHeight: 90,
          //leadingWidth: 40,
          iconTheme: IconThemeData(color: Colors.white, size: 25),
        ),
        body: CalendarPage(),
        drawer: BuildDrawer(selectedAppPage: AppPages.Calendar,),
        //bottomNavigationBar: NotificationStream(),
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

  final profDataControllers = Get.put(ProfDataControllers());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tempprint();
  }
  @override
  Widget build(BuildContext context) {
    DateTime lastDayOfMonth = nextMonthFirst.subtract(Duration(days: 1));

    return Container(
      color: kBlueColor,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width:MediaQuery.of(context).size.width,
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
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  height: 80,
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
                  margin: EdgeInsets.only(top:10),
                  padding: EdgeInsets.only(left: 20),
                  height: 20,
                  child: Row(
                    children: [
                      BigText(text: 'Time', color: Color(0xFFBCC1CD), size: 16, fontWeight: FontWeight.w500,),
                      SizedBox(width: 50),
                      BigText(text: 'Course', color: Color(0xFFBCC1CD), size: 16, fontWeight: FontWeight.w500,),
                    ],
                  ),
                ),
                buildSchedules()
              ],
            ),
          ],
        ),
      ),

    );
  }

  void tempprint(){
    List<dynamic> temp = profDataControllers.studentsSnapshot.map((docs) => docs['course_bloc_id']).toList();
    print(temp.toString());
  }


  Widget buildSchedules(){

    List<DocumentSnapshot<Object?>> getSchedule(List<DocumentSnapshot> sched){

      final now = DateTime(2024,DateTime.now().month,_selectedDay.day);
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


    List<DocumentSnapshot> schedule = getSchedule(profDataControllers.scheduleSnapshot);
    List<DocumentSnapshot> subjectDocs = profDataControllers.subjectSnapshot;
    List<DocumentSnapshot> roomDocs = profDataControllers.roomSnapshot;
    List<DocumentSnapshot> bldgDocs = profDataControllers.bldgSnapshot;


    return Container(
      height: 450,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: schedule.length,
        //scrollBehavior: ScrollBehavior(),
        controller: PageController(viewportFraction: 0.2),
        itemBuilder: (context, position) {
          final schedSubjectSnapshot = schedule[position];
          final subjectSnapshot = subjectDocs.firstWhere((doc) => doc['subject_id'] == schedSubjectSnapshot['subject_id']);
          final roomSnapshot = roomDocs.firstWhere((doc) => doc['room_id'] == schedSubjectSnapshot['room_id']);
          final bldgSnapshot = bldgDocs.firstWhere((doc) => doc['bldg_id'] == roomSnapshot['bldg_id']);


          return buildSchedItems(
              schedSubjectSnapshot,
              subjectSnapshot,
              roomSnapshot,
              bldgSnapshot,
              position

          );
        },
      ),
    );

  }

  Widget buildSchedItems(DocumentSnapshot schedSubjectSnapshot, DocumentSnapshot subjectSnapshot,
      DocumentSnapshot roomSnapshot, DocumentSnapshot bldgSnapshot, int position){

    Timestamp startTime = schedSubjectSnapshot['start_time'];
    Timestamp endTime = schedSubjectSnapshot['end_time'];

    DateTime startTimeCon = startTime.toDate();
    DateTime endTimeCon = endTime.toDate();

    int hour1;
    int hour2;

    if(startTimeCon.hour> 12 || endTimeCon.hour > 12){
      hour1 = startTimeCon.hour - 12;
      hour2 = endTimeCon.hour - 12;
    }else{
      hour1 = startTimeCon.hour;
      hour2 = endTimeCon.hour;
    }
    String startTimeString = hour1.toString().padLeft(1, '0') + ":" + startTimeCon.minute.toString().padLeft(2, '0');
    String endTimeString = hour2.toString().padLeft(1, '0') + ":" + endTimeCon.minute.toString().padLeft(2, '0');

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 18, left: 24, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  child: BigText(text: startTimeString, color: Colors.black, size: 16, fontWeight: FontWeight.w500,),
                ),
                SizedBox(height: 5),
                Container(
                  child: BigText(text: endTimeString, color: Color(0xFFBCC1CD), size: 16,),
                )
              ],
            ),
          ),
          //SizedBox(width: 50.w,),
          GestureDetector(
            onTap: (){
              profDataControllers.tappedSchedSubject.value = schedSubjectSnapshot['subject_sched_id'];
              profDataControllers.update();
              Navigator.of(context).push(createRouteGo(ShowClassPage()));
            },
            child: Container(
              height: 100,
              width: 265,
              padding: EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 10),
              decoration: ShapeDecoration(
                color: (position.isOdd)?kBlueColor:Color(0x771A43BF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: SizedBox(child: BigText(text: subjectSnapshot['subject_name'].toString(), size: 15, color: Colors.white, overFlow: TextOverflow.ellipsis,))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(text: "CS" + bldgSnapshot['bldg_name'].toString().substring(0,1) +
                              bldgSnapshot['bldg_name'].toString().substring(bldgSnapshot['bldg_name'].toString().length-1,bldgSnapshot['bldg_name'].toString().length) +
                              " Rm." + roomSnapshot['room_id'].toString(),
                            size: 13, color: Colors.white,),
                          SizedBox(width: 5,),
                          Icon(FontAwesomeIcons.ellipsisVertical, size: 13, color: Colors.white,)
                        ],
                      ),
                    ],
                  ),
                  BigText(text: schedSubjectSnapshot['course_bloc_id']==33002?"BSCS 3B":"BSCS 3A",color: Colors.white, size: 15,)
                ],
              ),
            ),
          )
        ],
      ),
    );

  }
}
