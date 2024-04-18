
import 'dart:async';

import 'package:flutter_application_1/screens/landing_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class UserDataControllers extends GetxController{
  late List<DocumentSnapshot> _subjectSnapshot;
  late List<DocumentSnapshot> _professorSnapshot;
  late List<DocumentSnapshot> _roomSnapshot;
  late List<DocumentSnapshot> _bldgSnapshot;
  late List<DocumentSnapshot> _scheduleSnapshot;
  late List<DocumentSnapshot> _attendanceSnapshot;


  List<DocumentSnapshot> get subjectSnapshot => _subjectSnapshot;
  List<DocumentSnapshot> get professorSnapshot => _professorSnapshot;
  List<DocumentSnapshot> get roomSnapshot => _roomSnapshot;
  List<DocumentSnapshot> get bldgSnapshot => _bldgSnapshot;
  List<DocumentSnapshot> get scheduleSnapshot => _scheduleSnapshot;
  List<DocumentSnapshot> get attendanceSnapshot => _attendanceSnapshot;

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

  Future<bool> checkLoggedIn() async{
    //check if there's a user already logged in
    Completer<bool> complete = Completer();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        complete.complete(true);
      }else{
        complete.complete(false);
      }
    });
    //uncomment this once all the pages before main homepage completes
    return complete.future;
    return false;

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

  late final List<DocumentSnapshot> getStudentID;
  List<DocumentSnapshot> getStudentSubject = [];
  late final List<DocumentSnapshot> getSubjects;
  late final List<DocumentSnapshot> getSchedSubject;
  late final List<DocumentSnapshot> getProfessors;
  late final List<DocumentSnapshot> getRooms;
  late final List<DocumentSnapshot> getBldg;
  late final List<DocumentSnapshot> getAttendance;


  Future<List<DocumentSnapshot>> fetchStudent() async{
    QuerySnapshot studentSnapshot = await studentTable.where('middle_name', isEqualTo: userid).get();
    return studentSnapshot.docs;

  }

  Future<void> fetchStudentFirebaseInfos() async{
    getStudentID = await fetchStudent();

    QuerySnapshot studentSubjectSnapshot = await studentSubjectTable.where('student_id', isEqualTo: getStudentID[0]['student_ID']).get();
    getStudentSubject = studentSubjectSnapshot.docs;

    final subjectIDs = getStudentSubject.map((docs) => docs['subject_id']).toList();

    //get the subject table
    QuerySnapshot subjectSnapshot = await subjectsTable.where('subject_id', whereIn: subjectIDs).get();
    getSubjects = subjectSnapshot.docs;

    userDataControllers.setSubjectSnapshot(getSubjects);
    final professorIDs = getSubjects.map((docs) => docs['professor_id']).toList();

    //get the schedule_subject table
    QuerySnapshot schedSubjectSnapshot = await schedSubjectTable.where('subject_id', whereIn: subjectIDs).get();
    getSchedSubject = schedSubjectSnapshot.docs;

    userDataControllers.setScheduleSnapshot(getSchedSubject);
    final roomIDs = getSchedSubject.map((docs) => docs['room_id']).toList();

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


  }
}