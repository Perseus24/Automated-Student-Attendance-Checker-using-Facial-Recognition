
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class UserDataControllers extends GetxController{
  late List<DocumentSnapshot> _subjectSnapshot;
  late List<DocumentSnapshot> _professorSnapshot;
  late List<DocumentSnapshot> _roomSnapshot;
  late List<DocumentSnapshot> _bldgSnapshot;
  late List<DocumentSnapshot> _scheduleSnapshot;


  List<DocumentSnapshot> get subjectSnapshot => _subjectSnapshot;
  List<DocumentSnapshot> get professorSnapshot => _professorSnapshot;
  List<DocumentSnapshot> get roomSnapshot => _roomSnapshot;
  List<DocumentSnapshot> get bldgSnapshot => _bldgSnapshot;
  List<DocumentSnapshot> get scheduleSnapshot => _scheduleSnapshot;

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
}