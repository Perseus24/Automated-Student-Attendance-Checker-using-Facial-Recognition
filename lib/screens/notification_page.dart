


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/landing_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utilities/constants.dart';
import '../utilities/get_user_data.dart';
import '../widgets/big_texts.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {

  //NotificationPage({ required this.thisDayAttendance, required this.yesterdayAttendance, required this.thisWeekAttendance, required this.longTimeAttendance});



  final HomepageController homepageController = Get.put(HomepageController());
  final userDataControllers = Get.put(UserDataControllers());


  @override
  Widget build(BuildContext context) {

    List<DocumentSnapshot> thisDayAttendance = userDataControllers.thisDayAttendance;
    List<DocumentSnapshot> yesterdayAttendance = userDataControllers.yesterdayAttendance;
    List<DocumentSnapshot> thisWeekAttendance = userDataControllers.thisWeekAttendance;
    List<DocumentSnapshot> longTimeAttendance = userDataControllers.longTimeAttendance;


    bool thisDayEmpty = thisDayAttendance.isEmpty;
    bool yesterdayEmpty = yesterdayAttendance.isEmpty;
    bool thisWeekEmpty = thisWeekAttendance.isEmpty;
    bool longTimeEmpty = longTimeAttendance.isEmpty;

    return Obx(()=>AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
        height: homepageController.notifContainer.value,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 50,
                decoration: ShapeDecoration(
                  color: kBlueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                  ),
                ),
                child: Center(
                  child: BigText(text: "Notification", size: 15, color: Colors.white,),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      thisDayEmpty?Container():BigText(text: "Today", size: 16, color: kGreyColor,),
                      thisDayEmpty?Container():buildListViewBuilder(thisDayAttendance),
                      thisDayEmpty?Container():SizedBox(height: 10,),

                      yesterdayEmpty?Container():BigText(text: "Yesterday", size: 16, color: kGreyColor,),
                      yesterdayEmpty?Container():buildListViewBuilder(yesterdayAttendance),
                      yesterdayEmpty?Container():SizedBox(height: 10,),

                      thisWeekEmpty?Container():BigText(text: "This week", size: 16, color: kGreyColor,),
                      thisWeekEmpty?Container():buildListViewBuilder(thisWeekAttendance),
                      thisWeekEmpty?Container():SizedBox(height: 10,),

                      longTimeEmpty?Container():BigText(text: "Long time ago", size: 16, color: kGreyColor,),
                      longTimeEmpty?Container():buildListViewBuilder(longTimeAttendance),
                      longTimeEmpty?Container():SizedBox(height: 10,),

                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    ));
  }

  Widget buildListViewBuilder(List<DocumentSnapshot> attendance){

    final List<DocumentSnapshot> schedule = userDataControllers.scheduleSnapshot;
    final List<DocumentSnapshot> subject = userDataControllers.subjectSnapshot;

    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: attendance.length,
        itemBuilder: (context, position) {

          final attendanceDocs = attendance[position];
          final schedDocs = schedule.firstWhere((element) => element['subject_sched_id'] == attendanceDocs['subject_sched_id']);
          final subjectDocs = subject.firstWhere((element) => element['subject_id'] == schedDocs['subject_id']);

          Timestamp ts = attendanceDocs['date'];
          DateTime dm = ts.toDate();
          List<int> diff = [];

          List<int> calculateDifference(){
            int length = 0;
            if(DateTime.now().difference(dm).inMinutes < 60){
              diff.add(DateTime.now().difference(dm).inMinutes);
              diff.add(0);
              return diff;
            }else if(DateTime.now().difference(dm).inHours < 24){
              diff.add(DateTime.now().difference(dm).inHours);
              diff.add(1);
              return diff;
            }else if(DateTime.now().difference(dm).inDays >=1){
              diff.add(DateTime.now().difference(dm).inDays);
              diff.add(2);
              return diff;
            }
            return diff;
          }


          return buildNotifHistory(subjectDocs, attendanceDocs['attendance_status'], calculateDifference());
        }
    );
  }

  Widget buildNotifHistory(DocumentSnapshot attendance, String attendanceStatus, List<int> difference){
    return Column(
      children: [
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              child: Image.asset('images/avatar.png',),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Container(
                  child: RichText(
                    maxLines: 2,
                    text: TextSpan(
                        style: TextStyle(color: Colors.black, fontFamily: 'SF Pro Display', fontSize: 14),
                        children: [
                          TextSpan(text: "You are "),
                          TextSpan(text: attendanceStatus, style: TextStyle(fontWeight: FontWeight.w800)),
                          TextSpan(text: " for your class at " + attendance['subject_name'])
                        ]
                    ),
                  )
              ),
            ),
            SizedBox(width: 10,),
            Container(
                width: 30,
                child: BigText(text: difference[0].toString()  + ((difference[1]==0)?"m":(difference[1]==1)?"h":"d"), size: 14, color: kGreyColor,))
          ],
        ),
      ],
    );
  }
}
