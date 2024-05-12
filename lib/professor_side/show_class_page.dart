

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/professor_side/main_homepage_prof.dart';
import 'package:flutter_application_1/professor_side/utilities/get_prof_data.dart';
import 'package:flutter_application_1/screens/statistics_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../utilities/build_routes.dart';
import '../utilities/constants.dart';
import '../utilities/get_user_data.dart';
import '../widgets/big_texts.dart';

Map<LayerLink, OverlayEntry> overlays = {};

class ShowClassPage extends StatefulWidget {
  const ShowClassPage({super.key});

  @override
  State<ShowClassPage> createState() => _ShowClassPageState();
}

class _ShowClassPageState extends State<ShowClassPage> {

  void hideOverlays(){
    var temp = Map<LayerLink, OverlayEntry>.from(overlays);
    if(temp.isNotEmpty){
      temp.forEach((LayerLink key, value) {
        OverlayEntry? entryHide = overlays[key];
        entryHide?.remove();
        overlays.remove(key);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(text: "Manage Students", color: Colors.white, size:20, fontWeight: FontWeight.w400,),
        backgroundColor: kBlueColor,

        toolbarHeight: 80,
        iconTheme: IconThemeData(color: Colors.white, size: 25),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,     //gesture detector to detect taps on the screen
        onTap:(){
          setState(() {
            hideOverlays();
          });
        },
        child: ClassSubjectInfo()),
    );
  }
}

class ClassSubjectInfo extends StatefulWidget {
  const ClassSubjectInfo({super.key});

  @override
  State<ClassSubjectInfo> createState() => _ClassSubjectInfoState();
}

class _ClassSubjectInfoState extends State<ClassSubjectInfo> {
  
  final ProfDataControllers profDataControllers = Get.put(ProfDataControllers());
  late DocumentSnapshot schedule;
  late DocumentSnapshot subject;
  late List<DocumentSnapshot> students;

  void hideOverlays(){
    var temp = Map<LayerLink, OverlayEntry>.from(overlays);
    if(temp.isNotEmpty){
      temp.forEach((LayerLink key, value) {
        OverlayEntry? entryHide = overlays[key];
        entryHide?.remove();
        overlays.remove(key);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateThisClassShow();
    studentLL = List<LayerLink>.generate(students.length, (index) => LayerLink());
  }

  void updateThisClassShow(){
    int subject_sched_id = profDataControllers.tappedSchedSubject.value;

    schedule = profDataControllers.scheduleSnapshot.firstWhere((element) => element['subject_sched_id'] == subject_sched_id);
    subject = profDataControllers.subjectSnapshot.firstWhere((element) => element['subject_id'] == schedule['subject_id']);
    students = profDataControllers.studentsSnapshot.where((element) => element['course_bloc_id'] == schedule['course_bloc_id']).toList();

    students.sort((a,b) => a['last_name'].compareTo(b['last_name']));

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [
                  kBlueColor,
                  Colors.white
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                          ),
                          children: [
                            TextSpan(
                              text: "Subject name: ",
                            ),
                            TextSpan(
                              text: subject['subject_name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              )
                            ),
                          ]
                        ),
                      ),
                      BigText(
                        text: "S.Y. 2023-2024",
                        color: Colors.white,
                        size: 16,
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                            ),
                            children: [
                              TextSpan(
                                text: "Code: ",
                              ),
                              TextSpan(
                                  text: subject['subject_code'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  )
                              ),
                            ]
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                            ),
                            children: [
                              TextSpan(
                                text: "Class: ",
                              ),
                              TextSpan(
                                  text: (schedule['course_bloc_id'] == 33002?"BSCS-3B":"BSCS-3A"),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                            ]
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 10,),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        ),
                        children: [
                          TextSpan(
                            text: "Total students: ",
                          ),
                          TextSpan(
                              text: students.length.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ]
                    ),
                  ),

                ],
              ),
            ),
          ),
          Positioned(
            top: 120,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                height: MediaQuery.of(context).size.height - 220,
                width:MediaQuery.of(context).size.width,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                  ),
                ),
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, position) {
                    final studentsProfile = students[position];

                    return buildStudentLists(studentsProfile, position);
                  }
                ),
              ),
            ),
          ),
          Obx(()=>Positioned(
              top: MediaQuery.of(context).size.height/2-100,
              left:MediaQuery.of(context).size.width/2-100,
              child: profDataControllers.fetchStudentData.value ? buildLoading(context) : Container()
          ))
        ],
      ),
    );
  }

  Widget buildStudentLists(DocumentSnapshot studentP, int position){
    return Container(
      height: 60,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            child: Image.asset('images/avatar.png',),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(text: studentP['last_name'] + ", " + studentP['first_name'], size: 17,),
                CompositedTransformTarget(
                  link: studentLL[position],
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                      setState(() {
                        hideOverlays();
                      });
                      StudentAttendance stud = Get.put(StudentAttendance());
                      stud.student_id.value = studentP['student_ID'];
                      stud.student_name.value = studentP['first_name'] + " " + studentP['last_name'];
                      showOverlay(180.0, popUp(),  studentLL[position], overlayEntry);

                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(FontAwesomeIcons.ellipsisVertical, size: 18, color: Colors.black,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<LayerLink> studentLL = [];

  OverlayEntry? overlayEntry;
  void showOverlay(overlayWidgetSize, widget, layerlink, entry){     //method for having an overlay widget that may be attached to another widget when tapped
    final overlay = Overlay.of(context)!;
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    entry = OverlayEntry(
        builder: (context) =>Positioned(
            left: offset.dx - 150, // Adjust the position to the left of the icon
            top: offset.dy + size.height / 2,
            width: overlayWidgetSize, //may prefer size.width
            child: CompositedTransformFollower(     //making sure that it is "attached" to the target widget
                link: layerlink,
                showWhenUnlinked: false,
                offset: Offset(-150, 0),
                child: widget
            )
        )
    );
    overlay.insert(entry!);
    overlays[layerlink] = entry!;
  }

  Widget popUp(){
    return GestureDetector(
      onTap: () async{
        profDataControllers.fetchStudentData.value = true;
        hideOverlays();
        await GetStudentAttendance().fetchStudentFirebaseInfos();
        Navigator.of(context).push(createRouteGo(StatisticsHome()));
        profDataControllers.fetchStudentData.value = false;
      },
      child: Container(
        height: 50,
        //width: 100,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Center(child: BigText(text: "Show attendance history", size: 14,)),
      ),
    );
  }

  Widget buildLoading(BuildContext context){
    return Container(
      height: 100,
      width: 200,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: kBlueColor,
            strokeWidth: 5,
          ),
          SizedBox(height: 10,),
          BigText(text: 'Fetching user\'s data...', color: Colors.black, size: 14,)
        ],
      ),
    );
  }
}

class StudentAttendance extends GetxController{

  RxInt student_id = 0.obs;
  RxString student_name = ''.obs;

  //needed documents for attendance statistics

  late List<DocumentSnapshot> _attendanceSnapshot;
  List<DocumentSnapshot> get attendanceSnapshot => _attendanceSnapshot;

  void setAttendanceSnapshot(List<DocumentSnapshot> docs){
    _attendanceSnapshot = docs;
    update();
  }
}

class GetStudentAttendance{
  final StudentAttendance studentAttendance = Get.put(StudentAttendance());
  final statsController = Get.put(StatisticsController());
  final userDataControllers = Get.put(UserDataControllers());

  final CollectionReference attendanceTable = FirebaseFirestore.instance.collection('student_attendance');
  final CollectionReference schedSubjectTable = FirebaseFirestore.instance.collection('subject_sched');

  late final List<DocumentSnapshot> getAttendance;
  late final List<DocumentSnapshot> getSchedSubject;



  Future<void> fetchStudentFirebaseInfos() async{
    QuerySnapshot attendanceSnapshot = await attendanceTable.where('student_id', isEqualTo: studentAttendance.student_id.value).get();
    getAttendance = attendanceSnapshot.docs;

    userDataControllers.setAttendanceSnapshot(getAttendance);

    //get the schedule_subject table
    QuerySnapshot schedSubjectSnapshot = await schedSubjectTable.where('subject_id', isEqualTo: 31012).get();
    getSchedSubject = schedSubjectSnapshot.docs;

    //get only the schedule with the same block with the student
    final getSchedSubjectNew = getSchedSubject.where((element) => element['course_bloc_id'] == 33002).toList();

    userDataControllers.setScheduleSnapshot(getSchedSubjectNew);

    statsController.initAttendanceForProf();
  }
}