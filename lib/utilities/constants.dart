import "package:cloud_firestore/cloud_firestore.dart";
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

  RxInt groupValue = 1.obs;

  RxBool pieChartTapped = false.obs;
  RxDouble pieChartContainerH = 0.0.obs;
  RxDouble pieChartContainerW = 0.0.obs;

  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;

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

  List<List<DocumentSnapshot<Object?>>> getTotalAttendance(List<DocumentSnapshot> attendance){

    List<String> attendanceStatus = ["Present", "Absent", "Late"];
    List<List<DocumentSnapshot>> attendanceList = [];

    for(String status in attendanceStatus){
      attendanceList.add(attendance.where((doc) => doc['attendance_status'] == status).toList());
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

      if(DateTime.now().difference(dm).inDays >7){
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


