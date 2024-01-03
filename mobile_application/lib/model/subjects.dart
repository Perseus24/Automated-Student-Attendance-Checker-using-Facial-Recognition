class Subjects{
  String? key;
  SubjectsData? subjectsData;

  Subjects({this.key, this.subjectsData});
}

class SubjectsData{
  String? professorID;
  String? subjectID;
  String? subjectName;
  String? subject_code;

  SubjectsData({this.professorID, this.subjectID, this.subjectName, this.subject_code});

  SubjectsData.fromJson(Map<dynamic,dynamic>json){
    professorID = json['ProfessorID'];
    subjectID = json['SubjectID'];
    subjectName = json['SubjectName'];
    subject_code = json['subject_code'];
  }
}

class Subjects_sched{
  String? key;
  Subject_schedData? subject_schedData;

  Subjects_sched({this.key, this.subject_schedData});
}

class Subject_schedData{
  String? subjectID;
  String? dayOfWeek;
  String? endTime;
  String? roomID;
  String? startTime;
  String? subject_sched_id;

  Subject_schedData({this.subjectID, this.dayOfWeek, this.endTime, this.roomID, this.startTime, this.subject_sched_id});

  Subject_schedData.fromJson(Map<dynamic,dynamic>json){
    subjectID = json['SubjectID'];
    dayOfWeek = json['dayOfWeek'];
    endTime = json['endTime'];
    roomID = json['room_id'];
    startTime = json['startTime'];
    subject_sched_id = json['subject_sched_id'];
  }
}

class MergeSubjectSchedules{

  String? professorID;
  String? subjectID;
  String? subjectName;
  String? subject_code;
  List<Subject_schedData>schedules = [];

  MergeSubjectSchedules({
    required this.subjectID,
    required this.professorID,
    required this.subjectName,
    required this.subject_code,
    this.schedules = const [],
  });

}
