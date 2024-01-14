import 'package:cloud_firestore/cloud_firestore.dart';

class Subject{

  int professorID = 0;
  String subjectCode = '';
  int subjectID = 0;
  String subjectName = '';

  Subject({ required this.professorID, required this. subjectName, required this.subjectID, required this.subjectCode});

  factory Subject.fromMap(Map data){
    return Subject(
      professorID: data['first_name'],
      subjectCode: data['subjectCode'],
      subjectID: data['subjectID'],
      subjectName: data['subjectName'],

    );
  }
}

class DatabaseService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  Future<Subject> getSubjects(String id)async{
    var snap = await _db.collection('subjects').doc(id).get();

    return Subject.fromMap(snap.data as Map);
  }

  Stream<Subject> streamSubject(String id){
    return _db.collection('subjects').doc(id).snapshots().map((snap) => Subject.fromMap(snap.data as Map));
  }
}
