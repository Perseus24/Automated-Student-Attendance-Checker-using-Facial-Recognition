import "dart:ffi";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_application_1/utilities/get_user_data.dart";
import "package:get/get.dart";



const Color kBlueColor = Color(0xFF1A43BF);
const Color kDrawerPagesColor = Color(0x661A43BF);
const Color kGreyColor = Color(0xFFA5A5A5);

const Color kVlack = Colors.black;
const Color kWhite = Colors.white;


enum AppPages {Dashboard, Statistics, Calendar, Profile, logout}

const List<String> notifications = ["Today", "Yesterday" "3 days ago", "4 days ago", "Long time ago"];

class StatisticsController extends GetxController{

  final UserDataControllers userDataControllers = Get.put(UserDataControllers());

  RxInt groupValue = 0.obs;

  RxInt weekChoice = 0.obs;
  RxBool weekChoiceTapped = true.obs;

  RxInt monthChoice = 0.obs;
  RxBool monthChoiceTapped = false.obs;

  RxBool allTimeChoiceTapped = false.obs;

  RxBool pieChartTapped = false.obs;
  RxDouble pieChartContainerH = 0.0.obs;
  RxDouble pieChartContainerW = 0.0.obs;

  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;

  RxString selectedSubject = 'Software Engineering 2'.obs;


  StatisticsMethods statisticsMethods = StatisticsMethods();

  RxList<List<DocumentSnapshot>> attendance = RxList<List<DocumentSnapshot>>();
  RxList<List<DocumentSnapshot>> originalAttendance = RxList<List<DocumentSnapshot>>();

  late RxMap<String, int>  listSubjects = RxMap<String, int>();

  RxList<int> barchartWeeklyData = [0,0,0,0,0,0].obs;
  RxList<int> barchartMonthlyData = [0,0,0,0,0,0,0,0,0,0,0,0].obs;

  List<DocumentSnapshot> merge(){
    List<DocumentSnapshot> att = [];
    for(int i=0; i<3; i++){
      for(var docs in attendance[i]){
       att.add(docs);
      }
    }
    return att;
  }

  void getSubjects(){
    userDataControllers.subjectSnapshot.forEach((element) {
      listSubjects[element['subject_name']] = element['subject_id'];
    });
  }

  void updateAttendance(){

    if(weekChoiceTapped.value){
      switch(weekChoice.value){
        case 0: attendance.value = statisticsMethods.getTotalAttendance(statisticsMethods.getThisWeekStatsNumber(userDataControllers.attendanceSnapshot),listSubjects[selectedSubject.value]!);
                break;
        case 1: attendance.value = statisticsMethods.getTotalAttendance(statisticsMethods.getLastWeekStatsNumber(userDataControllers.attendanceSnapshot),listSubjects[selectedSubject.value]!);
                break;
        case 2: attendance.value = statisticsMethods.getTotalAttendance(statisticsMethods.getLongTimeStatsNumber(userDataControllers.attendanceSnapshot),listSubjects[selectedSubject.value]!);
                break;
        case 3: attendance.value = statisticsMethods.getTotalAttendance(statisticsMethods.getAllTimeStatsNumber(userDataControllers.attendanceSnapshot),listSubjects[selectedSubject.value]!);
                break;

      }
    }else if(monthChoiceTapped.value){
      attendance.value = statisticsMethods.getTotalAttendance(statisticsMethods.getMonthlyStatsNumber(userDataControllers.attendanceSnapshot, monthChoice.value+1), listSubjects[selectedSubject.value]!);
    }else{
      attendance.value = statisticsMethods.getTotalAttendance(statisticsMethods.getAllTimeStatsNumber(userDataControllers.attendanceSnapshot),listSubjects[selectedSubject.value]!);
    }

    update();
  }

  void initAttendance(){
    getSubjects();

    originalAttendance.value = statisticsMethods.getTotalAttendance(statisticsMethods.getThisWeekStatsNumber(userDataControllers.attendanceSnapshot),listSubjects.entries.elementAt(0).value);
    attendance.value = originalAttendance;

    update();
  }

  void resetAttendance() {
    attendance.value = [];
    originalAttendance.value = [];
    barchartWeeklyData.value = [0,0,0,0,0];
    selectedSubject.value = 'Software Engineering 2';

    update();
  }

  void updateBarChart(){
    if(weekChoiceTapped.value){
      barchartWeeklyData.value = statisticsMethods.getBarChartWeekly(merge());
    }else if(monthChoiceTapped.value){
      if(monthChoice.value==5){
        barchartMonthlyData.value = statisticsMethods.getBarChartMonthly(merge());
      }else{
        barchartWeeklyData.value = statisticsMethods.getBarChartWeekly(merge());
      }

    }
    update();
  }

  void updateSelectedSubject(String subj){
    selectedSubject.value = subj;
    update();
  }

  void expandContainer(){
    pieChartContainerH.value = 30.0;
    pieChartContainerW.value = 60.0;
    update();
  }
}


class HomepageController extends GetxController{

  RxBool notifButtonTapped = false.obs;
  RxBool showLoading = false.obs;
  RxDouble notifContainer = 0.0.obs;


  void expandNotifContainer(){
    if(notifButtonTapped.value){
      notifContainer.value = 300.0;
    }else{
      notifContainer.value = 0.0;
    }
    update();
  }
}

class StatisticsMethods{

  StatisticsMethods();

  final UserDataControllers userDataControllers = Get.put(UserDataControllers());

  List<DocumentSnapshot> sortDates(dynamic listAttendance){
    listAttendance.sort((a, b) {
      // Assuming 'time' is a string in HH:mm aa format
      Timestamp tsA = a['date'];
      Timestamp tsB = b['date'];

      DateTime dtA = tsA.toDate();
      DateTime dtB = tsB.toDate();

      // Comparing DateTime objects
      return dtB.compareTo(dtA);
    });

    return listAttendance;
  }

  List<List<DocumentSnapshot<Object?>>> getTotalAttendance(List<DocumentSnapshot> attendance, int subject_id){

    List<String> attendanceStatus = ["Present", "Absent", "Late"];
    List<List<DocumentSnapshot>> attendanceList = [];
    List<int> schedule_subject = [];

    userDataControllers.scheduleSnapshot.forEach((element) {  //gets only the schedule of the certain subject
      if(element['subject_id'] == subject_id){
        schedule_subject.add(element['subject_sched_id']);
      }
    });

    schedule_subject.forEach((element) {    // adds the attendance status for the certain subject
      for(String status in attendanceStatus){
        attendanceList.add(attendance.where((doc) => doc['attendance_status'] == status && doc['subject_sched_id'] == element).toList());
      }
    });

    return attendanceList;

  }



  List<List<DocumentSnapshot<Object?>>> getTotalAttendanceAll(){

    List<String> attendanceStatus = ["Present", "Absent", "Late"];
    List<List<DocumentSnapshot>> attendanceList = [];
    List<int> schedule_subject = [];


      for(String status in attendanceStatus){
        attendanceList.add( userDataControllers.attendanceSnapshot.where((doc) => doc['attendance_status'] == status).toList());
      }



    return attendanceList;

  }

  List<DateTime> getDatesForPresent(List<DocumentSnapshot> attendanceList){
    List<DateTime> dates = [];

    for (dynamic datesTemp in attendanceList){
      Timestamp ts = datesTemp['date'];
      dates.add(ts.toDate());
    }
    return dates;
  }

  List<DocumentSnapshot> getThisDayNotif(List<DocumentSnapshot> attendance){
    List<DocumentSnapshot> thisDayNotifs = [];

    for(dynamic weekDates in attendance){
      Timestamp ts = weekDates['date'];
      DateTime dm = ts.toDate();

      if(DateTime.now().difference(dm).inHours <= 24){
        thisDayNotifs.add(weekDates);
      }
    }

    return thisDayNotifs;
  }

  List<DocumentSnapshot> getYesterdayNotif(List<DocumentSnapshot> attendance){
    List<DocumentSnapshot> yesterdayNotifs= [];

    for(dynamic weekDates in attendance){
      Timestamp ts = weekDates['date'];
      DateTime dm = ts.toDate();

      if(DateTime.now().difference(dm).inHours <=48 && DateTime.now().difference(dm).inHours > 24){
        yesterdayNotifs.add(weekDates);
      }
    }

    sortDates(yesterdayNotifs);

    return yesterdayNotifs;
  }

  List<DocumentSnapshot> getThisWeekNotif(List<DocumentSnapshot> attendance){
    List<DocumentSnapshot> thisWeekNotifs = [];

    for(dynamic weekDates in attendance){
      Timestamp ts = weekDates['date'];
      DateTime dm = ts.toDate();

      if(DateTime.now().difference(dm).inHours <= 168 && DateTime.now().difference(dm).inHours > 48){
        thisWeekNotifs.add(weekDates);
      }
    }

    sortDates(thisWeekNotifs);

    return thisWeekNotifs;
  }

  List<DocumentSnapshot> getLongTimeNotif(List<DocumentSnapshot> attendance){
    List<DocumentSnapshot> thisWeekNotifs = [];

    for(dynamic weekDates in attendance){
      Timestamp ts = weekDates['date'];
      DateTime dm = ts.toDate();

      if(DateTime.now().difference(dm).inHours >168){
        thisWeekNotifs.add(weekDates);
      }
    }

    sortDates(thisWeekNotifs);
    return thisWeekNotifs;
  }



  List<int> getBarChartWeekly(List<DocumentSnapshot> attendance){
    List<int> weeklyData = [0,0,0,0,0,0];

    print('debug');


    for (var element in attendance) {
      for(int i=1; i<7; i++){

        Timestamp dt = element['date'];
        DateTime st = dt.toDate();

        if(i==st.weekday){
          weeklyData[i-1] = weeklyData[i-1]+1;
          break;
        }
      }
    }



    print(weeklyData.toString());
    return weeklyData;
  }
  List<int> getBarChartMonthly(List<DocumentSnapshot> attendance){
    List<int> weeklyData = [0,0,0,0,0,0,0,0,0,0,0,0];

    for (var element in attendance) {
      for(int i=1; i<=12; i++){

        Timestamp dt = element['date'];
        DateTime st = dt.toDate();

        if(i==st.month){
          weeklyData[i-1] = weeklyData[i-1]+1;
          break;
        }
      }
    }
    print(weeklyData.toString());
    return weeklyData;
  }

  List<List<DocumentSnapshot<Object?>>> getTemporary(List<DocumentSnapshot> attendance, int subject_id){

    List<String> attendanceStatus = ["Present", "Absent", "Late"];
    List<List<DocumentSnapshot>> attendanceList = [];
    List<int> schedule_subject = [];


    for(String words in attendanceStatus){
      attendanceList.add(attendance.where((element) => element['attendance_status'] == words).toList());
    }


    return attendanceList;

  }

  List<DocumentSnapshot> getThisWeekStatsNumber(List<DocumentSnapshot> attendance){
    List<DocumentSnapshot> thisWeekNotifs = [];

    for(dynamic weekDates in attendance){
      Timestamp ts = weekDates['date'];
      DateTime dm = ts.toDate();

      if(DateTime.now().difference(dm).inHours <= 168 && DateTime.now().difference(dm).inSeconds > 1){
        thisWeekNotifs.add(weekDates);
      }
    }

    sortDates(thisWeekNotifs);

    return thisWeekNotifs;
  }

  List<DocumentSnapshot> getLastWeekStatsNumber(List<DocumentSnapshot> attendance){
    List<DocumentSnapshot> thisWeekNotifs = [];

    for(dynamic weekDates in attendance){
      Timestamp ts = weekDates['date'];
      DateTime dm = ts.toDate();

      if(DateTime.now().difference(dm).inHours <= 336 && DateTime.now().difference(dm).inHours > 168){
        thisWeekNotifs.add(weekDates);
      }
    }

    sortDates(thisWeekNotifs);

    return thisWeekNotifs;
  }

  List<DocumentSnapshot> getLongTimeStatsNumber(List<DocumentSnapshot> attendance){
    List<DocumentSnapshot> thisWeekNotifs = [];

    for(dynamic weekDates in attendance){
      Timestamp ts = weekDates['date'];
      DateTime dm = ts.toDate();

      if(DateTime.now().difference(dm).inHours > 336){
        thisWeekNotifs.add(weekDates);
      }
    }

    sortDates(thisWeekNotifs);

    return thisWeekNotifs;
  }

  List<DocumentSnapshot> getAllTimeStatsNumber(List<DocumentSnapshot> attendance){
    List<DocumentSnapshot> thisWeekNotifs = [];

    for(dynamic weekDates in attendance){
      Timestamp ts = weekDates['date'];
      DateTime dm = ts.toDate();

      if(DateTime.now().difference(dm).inSeconds > 1){
        thisWeekNotifs.add(weekDates);
      }
    }

    sortDates(thisWeekNotifs);

    return thisWeekNotifs;
  }

  List<DocumentSnapshot> getMonthlyStatsNumber(List<DocumentSnapshot> attendance, int month){

    //January == 1 ...

    List<DocumentSnapshot> thisWeekNotifs = [];

    for(dynamic weekDates in attendance){
      Timestamp ts = weekDates['date'];
      DateTime dm = ts.toDate();

      if(dm.month == month+1 && month!=6){
        thisWeekNotifs.add(weekDates);
      }else if(month==6){
        thisWeekNotifs.add(weekDates);
      }
    }

    sortDates(thisWeekNotifs);

    return thisWeekNotifs;
  }
}

class Notifications extends GetxController {

  UserDataControllers userDataControllers = Get.put(UserDataControllers());

  late RxList<DocumentSnapshot> thisDayAttendance;
  late RxList<DocumentSnapshot> yesterdayAttendance;
  late RxList<DocumentSnapshot> thisWeekAttendance;
  late RxList<DocumentSnapshot> longTimeAttendance;

  late RxInt numAttendanceList;
  late RxInt originalTotalAttendance;

  RxDouble popupHeight = 0.0.obs;
  RxDouble popupWidth = 0.0.obs;

  RxString notifClassSubject = ''.obs;
  RxString notifAttendanceStatus = ''.obs;
  RxInt notifHour = 0.obs;
  Rx<DateTime> notifDateTime = DateTime.now().obs;

  void updateNotifVariables(String subj, String status, DateTime date){

    if(status == "Present"){
      notifAttendanceStatus.value = "On Time";
    }else {
      notifAttendanceStatus.value = status;
    }
    notifClassSubject.value = subj;
    notifDateTime.value = date;
    notifHour.value = notifDateTime.value.hour + 8;


    update();
  }

  void updateLists() {
    thisDayAttendance = userDataControllers.thisDayAttendance.obs;
    yesterdayAttendance = userDataControllers.yesterdayAttendance.obs;
    thisWeekAttendance = userDataControllers.thisWeekAttendance.obs;
    longTimeAttendance = userDataControllers.longTimeAttendance.obs;

    originalTotalAttendance = userDataControllers.attendanceSnapshot.length.obs;
    numAttendanceList = originalTotalAttendance;

    update();
  }

  void expandPopUp() {
    popupHeight.value = 350;
    popupWidth.value = 300;
    update();
  }

  bool checkNewNotifications() {
    return originalTotalAttendance.value < numAttendanceList.value;
  }


}


