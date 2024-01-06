import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/big_texts.dart';
import 'dart:async';
import 'package:async/async.dart';

import '../firebase_options.dart';














class getTables{

  Stream<QuerySnapshot<Object?>> getSchedSubjectDocs() {
    final CollectionReference schedSubjectTable = FirebaseFirestore.instance.collection('subject_sched');
    return schedSubjectTable.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getProfessorDocs() {
    final CollectionReference professorsTable = FirebaseFirestore.instance.collection('professor');
    return professorsTable.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getSubjectDocs() {
    final CollectionReference subjectTable = FirebaseFirestore.instance.collection('subjects');
    return subjectTable.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getRoomDocs() {
    final CollectionReference roomTable = FirebaseFirestore.instance.collection('room');
    return roomTable.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getBldgDocs() {
    final CollectionReference bldgTable = FirebaseFirestore.instance.collection('bldg');
    return bldgTable.snapshots();
  }

}






