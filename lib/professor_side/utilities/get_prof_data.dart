

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

import '../../screens/notification_page.dart';
import '../../utilities/constants.dart';

class ProfDataControllers extends GetxController{
  late List<DocumentSnapshot> _subjectSnapshot;
  late List<DocumentSnapshot> _studentsSnapshot;
  late List<DocumentSnapshot> _roomSnapshot;
  late List<DocumentSnapshot> _bldgSnapshot;
  late List<DocumentSnapshot> _scheduleSnapshot;
  late List<DocumentSnapshot> _attendanceSnapshot;
  late List<DocumentSnapshot> _professorSnapshot;

  RxInt tappedSchedSubject = 0.obs;
  RxBool fetchStudentData = false.obs;


  List<DocumentSnapshot> get subjectSnapshot => _subjectSnapshot;
  List<DocumentSnapshot> get studentsSnapshot => _studentsSnapshot;
  List<DocumentSnapshot> get roomSnapshot => _roomSnapshot;
  List<DocumentSnapshot> get bldgSnapshot => _bldgSnapshot;
  List<DocumentSnapshot> get scheduleSnapshot => _scheduleSnapshot;
  List<DocumentSnapshot> get attendanceSnapshot => _attendanceSnapshot;
  List<DocumentSnapshot> get professorSnapshot => _professorSnapshot;


  void setSubjectSnapshot(List<DocumentSnapshot> docs) {
    _subjectSnapshot = docs;
    update(); // Updates UI dependent on this controller
  }
  void setStudentsSnapshot(List<DocumentSnapshot> docs) {
    _studentsSnapshot = docs;
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

  void setProfesssorSnapshot(List<DocumentSnapshot> docs){
    _professorSnapshot = docs;
    update();
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

class GetProfessorFirebaseInfo{

  //gets all the data from firebase specific to the user
  final String? userid = FirebaseAuth.instance.currentUser?.uid; //user uid

  final CollectionReference professorTable = FirebaseFirestore.instance.collection('professor');
  final CollectionReference subjectsTable = FirebaseFirestore.instance.collection('subjects');
  final CollectionReference schedSubjectTable = FirebaseFirestore.instance.collection('subject_sched');
  final CollectionReference studentSubjectTable = FirebaseFirestore.instance.collection('student_subject');
  final CollectionReference studentTable = FirebaseFirestore.instance.collection('students');
  final CollectionReference roomTable = FirebaseFirestore.instance.collection('room');
  final CollectionReference bldgTable = FirebaseFirestore.instance.collection('bldg');

  final profDataControllers = Get.put(ProfDataControllers());
  final StatisticsMethods statisticsMethods = StatisticsMethods();

  late final List<DocumentSnapshot> getProfessorID;
  late final List<DocumentSnapshot> getProfessorSubject;
  late final List<DocumentSnapshot> getStudents;
  late final List<DocumentSnapshot> getSubjects;
  late final List<DocumentSnapshot> getSchedSubject;
  late final List<DocumentSnapshot> getProfessors;
  late final List<DocumentSnapshot> getRooms;
  late final List<DocumentSnapshot> getBldg;
  late final List<DocumentSnapshot> getAttendance;
  late final List<DocumentSnapshot> getBlock;


  Future<List<DocumentSnapshot>> fetchProfessor() async{
    final String? userid = FirebaseAuth.instance.currentUser?.uid;
    QuerySnapshot profSnapshot = await professorTable.where('user_uid', isEqualTo: userid).get();
    profDataControllers.setProfesssorSnapshot(profSnapshot.docs);
    return profSnapshot.docs;

  }

  Future<void> fetchStudentFirebaseInfos() async{
    getProfessorID = await fetchProfessor();

    QuerySnapshot professorSubjectSnapshot = await subjectsTable.where('professor_id', isEqualTo: getProfessorID[0]['professor_id']).get();
    getProfessorSubject = professorSubjectSnapshot.docs;  //subject of the professor

    profDataControllers.setSubjectSnapshot(getProfessorSubject);

    ChatNotification.subscribeToTopic(getProfessorID[0]['professor_id'].toString()); //notification for the specific user

    QuerySnapshot students = await studentSubjectTable.where('subject_id', isEqualTo: getProfessorSubject[0]['subject_id']).get();

    final studentIDs = students.docs.map((docs) => docs['student_id']).toList();  //list of students

    List<List<dynamic>> sublist_student_id = [];
    for (int i = 0; i < studentIDs.length; i += 30) {

      sublist_student_id.add(studentIDs.sublist(i, i + 30 > studentIDs.length ? studentIDs.length : i + 30));
    }

    List<DocumentSnapshot<Object?>> getStudents = [];
    for(int i=0; i<sublist_student_id.length;i++){
      QuerySnapshot studentsSnapshot = await studentTable.where('student_ID', whereIn: sublist_student_id[i]).get();
      getStudents.addAll(studentsSnapshot.docs);
    }



    profDataControllers.setStudentsSnapshot(getStudents);
    //get the schedule_subject table
    QuerySnapshot schedSubjectSnapshot = await schedSubjectTable.where('subject_id', isEqualTo: getProfessorSubject[0]['subject_id']).get();
    getSchedSubject = schedSubjectSnapshot.docs;

    profDataControllers.setScheduleSnapshot(getSchedSubject);

    final roomIDs = getSchedSubject.map((docs) => docs['room_id']).toList();


    //get the room table
    QuerySnapshot roomSnapshot = await roomTable.where('room_id', whereIn: roomIDs).get();
    getRooms = roomSnapshot.docs;

    profDataControllers.setRoomSnapshot(getRooms);
    final bldgIDs = getRooms.map((docs) => docs['bldg_id']).toList();

    //get the bldg table
    QuerySnapshot bldgSnapshot = await bldgTable.where('bldg_id', whereIn: bldgIDs).get();
    getBldg = bldgSnapshot.docs;

    profDataControllers.setBldgSnapshot(getBldg);

  }
}