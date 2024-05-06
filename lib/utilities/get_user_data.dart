
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/professor_side/utilities/get_prof_data.dart';
import 'package:flutter_application_1/utilities/constants.dart';
import 'package:get/get.dart';

import '../screens/notification_page.dart';



class UserDataControllers extends GetxController{

  late List<DocumentSnapshot> _studentSnapshot;
  late List<DocumentSnapshot> _subjectSnapshot;
  late List<DocumentSnapshot> _professorSnapshot;
  late List<DocumentSnapshot> _roomSnapshot;
  late List<DocumentSnapshot> _bldgSnapshot;
  late List<DocumentSnapshot> _scheduleSnapshot;
  late List<DocumentSnapshot> _attendanceSnapshot;
  late List<DocumentSnapshot> _thisDayAttendance;
  late List<DocumentSnapshot> _yesterdayAttendance;
  late List<DocumentSnapshot> _thisWeekAttendance;
  late List<DocumentSnapshot> _longTimeAttendance;

  RxInt switchDashboardUser = 0.obs;  //0 for students,1 for professors

  List<DocumentSnapshot> get studentSnapshot => _studentSnapshot;
  List<DocumentSnapshot> get subjectSnapshot => _subjectSnapshot;
  List<DocumentSnapshot> get professorSnapshot => _professorSnapshot;
  List<DocumentSnapshot> get roomSnapshot => _roomSnapshot;
  List<DocumentSnapshot> get bldgSnapshot => _bldgSnapshot;
  List<DocumentSnapshot> get scheduleSnapshot => _scheduleSnapshot;
  List<DocumentSnapshot> get attendanceSnapshot => _attendanceSnapshot;

  List<DocumentSnapshot> get thisDayAttendance => _thisDayAttendance;
  List<DocumentSnapshot> get yesterdayAttendance => _yesterdayAttendance;
  List<DocumentSnapshot> get thisWeekAttendance => _thisWeekAttendance;
  List<DocumentSnapshot> get longTimeAttendance => _longTimeAttendance;


  void setStudentSnapshot(List<DocumentSnapshot> docs) {
    _studentSnapshot = docs;
    update(); // Updates UI dependent on this controller
  }

  void setSubjectSnapshot(List<DocumentSnapshot> docs) {
    _subjectSnapshot = docs;
    update(); // Updates UI dependent on this controller
  }
  void setProfessorSnapshot(List<DocumentSnapshot> docs) {
    _professorSnapshot = docs;
    update(); // Updates UI dependent on this controller
  }
  void setRoomSnapshot(List<DocumentSnapshot> docs) {
    _roomSnapshot = docs;
    update(); // Updates UI dependent on this controller
  }
  void setBldgSnapshot(List<DocumentSnapshot> docs) {
    _bldgSnapshot = docs;
    update(); // Updates UI dependent on this controller
  }
  void setScheduleSnapshot(List<DocumentSnapshot> docs) {
    _scheduleSnapshot = docs;
    update(); // Updates UI dependent on this controller
  }

  void setAttendanceSnapshot(List<DocumentSnapshot> docs){
    _attendanceSnapshot = docs;
    update();
  }

  void setThisDayAttendance(List<DocumentSnapshot> docs) {
    _thisDayAttendance = docs;
    update(); // Updates UI dependent on this controller
  }

  void setYesterdayAttendance(List<DocumentSnapshot> docs) {
    _yesterdayAttendance = docs;
    update(); // Updates UI dependent on this controller
  }

  void setThisWeekAttendance(List<DocumentSnapshot> docs) {
    _thisWeekAttendance = docs;
    update(); // Updates UI dependent on this controller
  }

  void setLongTimeAttendance(List<DocumentSnapshot> docs) {
    _longTimeAttendance = docs;
    update(); // Updates UI dependent on this controller
  }

  Future<bool> checkLoggedIn() async{
    //check if there's a user already logged in
    Completer<bool> complete = Completer();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        return complete.complete(true);
      }else{
        return complete.complete(false);
      }
    });
    //uncomment this once all the pages before main homepage completes
    return complete.future;
    //return false;

  }

}

class GetUserFirebaseInfo{

  //gets all the data from firebase specific to the user
  final String? userid = FirebaseAuth.instance.currentUser?.uid; //user uid

  final CollectionReference studentTable = FirebaseFirestore.instance.collection('students');
  final CollectionReference studentSubjectTable = FirebaseFirestore.instance.collection('student_subject');
  final CollectionReference subjectsTable = FirebaseFirestore.instance.collection('subjects');
  final CollectionReference professorsTable = FirebaseFirestore.instance.collection('professor');
  final CollectionReference schedSubjectTable = FirebaseFirestore.instance.collection('subject_sched');
  final CollectionReference roomTable = FirebaseFirestore.instance.collection('room');
  final CollectionReference bldgTable = FirebaseFirestore.instance.collection('bldg');
  final CollectionReference attendanceTable = FirebaseFirestore.instance.collection('student_attendance');

  final userDataControllers = Get.put(UserDataControllers());
  final StatisticsMethods statisticsMethods = StatisticsMethods();
  final statsController = Get.put(StatisticsController());

  late final List<DocumentSnapshot> getStudentID;
  List<DocumentSnapshot> getStudentSubject = [];
  late final List<DocumentSnapshot> getSubjects;
  late final List<DocumentSnapshot> getSchedSubject;
  late final List<DocumentSnapshot> getProfessors;
  late final List<DocumentSnapshot> getRooms;
  late final List<DocumentSnapshot> getBldg;
  late final List<DocumentSnapshot> getAttendance;
  late final int getCourseBlock;

  late final List<DocumentSnapshot> thisDayAttendance;
  late final List<DocumentSnapshot> yesterdayAttendance;
  late final List<DocumentSnapshot> thisWeekAttendance;
  late final List<DocumentSnapshot> longTimeAttendance;

  final ProfDataControllers profDataControllers = Get.put(ProfDataControllers());
  final GetProfessorFirebaseInfo getProfessorFirebaseInfo = GetProfessorFirebaseInfo();

  Future<List<DocumentSnapshot>> fetchStudent() async{
    final String? userid = FirebaseAuth.instance.currentUser?.uid;
    QuerySnapshot studentSnapshot = await studentTable.where('user_uid', isEqualTo: userid).get();
    userDataControllers.setStudentSnapshot(studentSnapshot.docs);
    return studentSnapshot.docs;

  }

  Future<void> fetchStudentFirebaseInfos() async{
    getStudentID = await fetchStudent();

    if(getStudentID.isEmpty){
      print("HERE!");
      await getProfessorFirebaseInfo.fetchStudentFirebaseInfos();
      userDataControllers.switchDashboardUser.value = 1;
      userDataControllers.update();
    }else{
      userDataControllers.switchDashboardUser.value = 0;
      userDataControllers.update();

      getCourseBlock = getStudentID[0]['course_bloc_id']; //course

      QuerySnapshot studentSubjectSnapshot = await studentSubjectTable.where('student_id', isEqualTo: getStudentID[0]['student_ID']).get();
      getStudentSubject = studentSubjectSnapshot.docs;

      ChatNotification.subscribeToTopic(getStudentID[0]['student_ID'].toString());

      final subjectIDs = getStudentSubject.map((docs) => docs['subject_id']).toList();

      //get the subject table
      QuerySnapshot subjectSnapshot = await subjectsTable.where('subject_id', whereIn: subjectIDs).get();
      getSubjects = subjectSnapshot.docs;


      userDataControllers.setSubjectSnapshot(getSubjects);
      final professorIDs = getSubjects.map((docs) => docs['professor_id']).toList();

      //get the schedule_subject table
      QuerySnapshot schedSubjectSnapshot = await schedSubjectTable.where('subject_id', whereIn: subjectIDs).get();
      getSchedSubject = schedSubjectSnapshot.docs;

      //get only the schedule with the same block with the student
      final getSchedSubjectNew = getSchedSubject.where((element) => element['course_bloc_id'] == getCourseBlock).toList();

      userDataControllers.setScheduleSnapshot(getSchedSubjectNew);
      final roomIDs = getSchedSubjectNew.map((docs) => docs['room_id']).toList();

      //get the professors table
      QuerySnapshot professorSnapshot = await professorsTable.where('professor_id', whereIn: professorIDs).get();
      getProfessors = professorSnapshot.docs;

      userDataControllers.setProfessorSnapshot(getProfessors);

      //get the room table
      QuerySnapshot roomSnapshot = await roomTable.where('room_id', whereIn: roomIDs).get();
      getRooms = roomSnapshot.docs;

      userDataControllers.setRoomSnapshot(getRooms);
      final bldgIDs = getRooms.map((docs) => docs['bldg_id']).toList();

      //get the bldg table
      QuerySnapshot bldgSnapshot = await bldgTable.where('bldg_id', whereIn: bldgIDs).get();
      getBldg = bldgSnapshot.docs;

      userDataControllers.setBldgSnapshot(getBldg);

      //get the attendance table
      QuerySnapshot attendanceSnapshot = await attendanceTable.where('student_id', isEqualTo: getStudentID[0]['student_ID']).get();
      getAttendance = attendanceSnapshot.docs;

      userDataControllers.setAttendanceSnapshot(getAttendance);

      statsController.initAttendance();
    }



  }

  Future<void> fetchAttendance() async{
    getStudentID = await fetchStudent();
    QuerySnapshot attendanceSnapshot = await attendanceTable.where('student_id', isEqualTo: getStudentID[0]['student_ID']).get();
    getAttendance = attendanceSnapshot.docs;

    userDataControllers.setAttendanceSnapshot(getAttendance);
  }
  Future<void>  fetchNotificationHistory() async {

    userDataControllers.setThisDayAttendance(statisticsMethods.getThisDayNotif(userDataControllers.attendanceSnapshot));
    userDataControllers.setYesterdayAttendance(statisticsMethods.getYesterdayNotif(userDataControllers.attendanceSnapshot));
    userDataControllers.setThisWeekAttendance(statisticsMethods.getThisWeekNotif(userDataControllers.attendanceSnapshot));
    userDataControllers.setLongTimeAttendance(statisticsMethods.getLongTimeNotif(userDataControllers.attendanceSnapshot));

    Notifications notifications = Get.put(Notifications());

    notifications.updateLists();
  }
}