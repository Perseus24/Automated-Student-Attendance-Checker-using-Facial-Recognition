
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/main.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/professor_side/utilities/get_prof_data.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utilities/constants.dart';
import '../widgets/big_texts.dart';
import '../widgets/hamburger.dart';

class MainHomePageProf extends StatefulWidget {
  const MainHomePageProf({super.key});

  @override
  State<MainHomePageProf> createState() => _MainHomePageProfState();
}

class _MainHomePageProfState extends State<MainHomePageProf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(text: "Dashboard", color: Colors.white, size:25, fontWeight: FontWeight.w700,),
        backgroundColor: kBlueColor,
        actions: [
          Container(
              margin: EdgeInsets.only(right: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 50,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async{
                            // homepageController.notifButtonTapped.toggle();
                            //
                            // homepageController.expandNotifContainer();
                            // //homepageController.showLoading.toggle();
                            // homepageController.update();

                          },
                          clipBehavior: Clip.antiAlias,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            padding: EdgeInsets.zero, // <--add this
                          ),
                          child: Image.asset('images/Bellpin.png'),
                        )
                    ),
                  ]
              )
          ),
        ],
        toolbarHeight: 80,
        iconTheme: IconThemeData(color: Colors.white, size: 25),
      ),
      drawer: BuildDrawer(selectedAppPage: AppPages.Dashboard,),
      body: BodyPageProf()
    );
  }
}

class BodyPageProf extends StatefulWidget {
  const BodyPageProf({super.key});

  @override
  State<BodyPageProf> createState() => _BodyPageProfState();
}

class _BodyPageProfState extends State<BodyPageProf> {

  final ProfDataControllers profDataControllers = Get.put(ProfDataControllers());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      child: SingleChildScrollView(
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
                padding: const EdgeInsets.symmetric(horizontal:40),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage("images/prof_icon.png"),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: "Maria Leonor G. Robredo", color: Colors.white, size: 17,),
                            BigText(text: "Associate Professor III", color: Colors.white, size: 15,),
                          ],
                        )

                      ],
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 50, right: 0),
                      child: Container(
                        height: 80,
                        width: 300,
                        decoration: ShapeDecoration(
                          color: kBlueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        BigText(text: "Students",color: Colors.white, size: 15,),
                                        Icon(Icons.arrow_forward_ios_outlined, size: 15,)
                                      ],
                                    ),
                                    BigText(
                                      text: profDataControllers.studentsSnapshot.length.toString(),
                                      color: Colors.white,
                                      size: 18,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10,right: 15),
                                width: 1,
                                color: Colors.white,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        BigText(text: "Classes",color: Colors.white, size: 15,),
                                        Icon(Icons.arrow_forward_ios_outlined, size: 15,)
                                      ],
                                    ),
                                    BigText(
                                      text: "2",
                                      color: Colors.white,
                                      size: 18,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 180,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width:MediaQuery.of(context).size.width,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50,),
                      Container(
                          margin: EdgeInsets.only(top: 10, left: 30, right: 10),
                          child: BigText(text: "Today's schedule", size: 18, fontWeight: FontWeight.w700, color: Colors.black,)
                      ),
                      ClassesBody(0),
                      Container(
                          margin: EdgeInsets.only(top: 20, left: 30, right: 10),
                          child: BigText(text: "Tomorrow's schedule",size: 18, fontWeight: FontWeight.w700, color: Colors.black,)
                      ),
                      ClassesBody(1),
                      Container(
                          margin: EdgeInsets.only(top: 20, left: 30, right: 10),
                          child: BigText(text: "Related Websites", size: 18, fontWeight: FontWeight.w700, color: Colors.black,)
                      ),
                      Container(
                        width: 315,
                        //height: 20,
                        margin: EdgeInsets.only(top: 10, left: 30, right: 10),
                        decoration: ShapeDecoration(
                          color: kBlueColor,
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
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Image.asset('images/BU_Logo.png')
                            ),
                            Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 10, left: 10, right:10,),
                                    width: 200,
                                    child: BigText(text: 'Bicol University Student Portal', color: Colors.white, fontWeight: FontWeight.w700,size: 16, maxLines: 1,)
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 10, left: 10, right:10,bottom: 10),
                                    width: 200,
                                    child: GestureDetector(
                                        onTap: () => launchUrl(Uri.parse("https://ibu.bicol-u.edu.ph")),
                                        child: BigText(text: "https://ibu.bicol-u.edu.ph", color: Colors.white, fontWeight: FontWeight.w400,size: 15, maxLines: 1,)
                                    )
                                ),

                              ],
                            )

                          ],
                        ),
                      ),
                      Container(
                        width: 315,
                        margin: EdgeInsets.only(top: 10, left: 30, right: 10),
                        decoration: ShapeDecoration(
                          color: kBlueColor,
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
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Image.asset('images/BU.png')
                            ),
                            Column(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 10, left: 10, right: 10,),
                                    width: 200,
                                    child: BigText(text: 'Bicol University Learning Management System', color: Colors.white, fontWeight: FontWeight.w700,size: 16, maxLines: 1,)
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                                    width: 200,
                                    child: GestureDetector(
                                        onTap: () => launchUrl(Uri.parse("https://bulms.bicol-u.edu.ph/login/index.php")),
                                        child: BigText(text: "https://bulms.bicol-u.edu.ph/login/index.php", color: Colors.white, fontWeight: FontWeight.w400,size: 16, maxLines: 1,)
                                    )
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}

class ClassesBody extends StatefulWidget {
  final int i;

  const ClassesBody(this.i, {Key? key}) : super(key: key);

  @override
  State<ClassesBody> createState() => _ClassesBodyState();
}

class _ClassesBodyState extends State<ClassesBody>{


  @override
  void initState() {
    super.initState();
  }

  final profDataControllers = Get.put(ProfDataControllers());

  @override
  Widget build(BuildContext context){
    int switchSched = widget.i;
    String wordToday = '';

    List<DocumentSnapshot<Object?>> getSchedule(List<DocumentSnapshot> sched, bool swtch){

      final now = DateTime.now();
      final dayOfWeek = now.weekday; // This is an integer representing the day of the week (1=Monday, 2=Tuesday, etc.)
      List<DocumentSnapshot> filteredSched = sched.where((doc) =>
      doc['day_of_week'] == (swtch? dayOfWeek: (dayOfWeek == 7)?1:dayOfWeek+1)).toList();
      filteredSched.sort((a, b) {
        // Assuming 'time' is a string in HH:mm aa format
        Timestamp tsA = a['start_time'];
        Timestamp tsB = b['start_time'];

        DateTime dtA = tsA.toDate();
        DateTime dtB = tsB.toDate();

        // Comparing DateTime objects
        return dtA.hour.compareTo(dtB.hour);
      });
      return filteredSched;
    }

    List<DocumentSnapshot> schedule = profDataControllers.scheduleSnapshot;
    List<DocumentSnapshot> subjectDocs = profDataControllers.subjectSnapshot;
    List<DocumentSnapshot> roomDocs = profDataControllers.roomSnapshot;
    List<DocumentSnapshot> bldgDocs = profDataControllers.bldgSnapshot;

    if (switchSched == 0) {
      wordToday = 'today';
      schedule = getSchedule(schedule, true);
    } else {
      wordToday = 'tomorrow';
      schedule = getSchedule(schedule, false);
    }

    if(schedule.isEmpty){
      return Container(
          height: 100,
          width: 315,
          margin: EdgeInsets.only(left:30, right: 20),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
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
          child: Center(child: BigText(text: 'You have no classes $wordToday!', size: 15, color: Colors.black,
              fontWeight: FontWeight.w700))
      );
    }else{
      return Container(
        height: 140,
        child: PageView.builder(
          itemCount: schedule.length,
          controller: PageController(viewportFraction: 0.85),
          itemBuilder: (context, position) {
            final schedSubjectSnapshot = schedule[position];
            final subjectSnapshot = subjectDocs.firstWhere((doc) => doc['subject_id'] == schedSubjectSnapshot['subject_id']);
            final roomSnapshot = roomDocs.firstWhere((doc) => doc['room_id'] == schedSubjectSnapshot['room_id']);
            final bldgSnapshot = bldgDocs.firstWhere((doc) => doc['bldg_id'] == roomSnapshot['bldg_id']);

            return _buildPageItem(
              schedSubjectSnapshot,
              subjectSnapshot,
              roomSnapshot,
              bldgSnapshot,

            );
          },
        ),
      );
    }

  }


  Widget _buildPageItem(DocumentSnapshot schedSubjectSnapshot, DocumentSnapshot subjectSnapshot,
      DocumentSnapshot roomSnapshot, DocumentSnapshot bldgSnapshot){

    Timestamp startTime = schedSubjectSnapshot['start_time'];
    Timestamp endTime = schedSubjectSnapshot['end_time'];

    DateTime startTimeCon = startTime.toDate();
    DateTime endTimeCon = endTime.toDate();

    String morningVar;
    int hour1;
    int hour2;

    if(startTimeCon.hour> 12 || endTimeCon.hour > 12){
      hour1 = startTimeCon.hour - 12;
      hour2 = endTimeCon.hour - 12;
      morningVar = 'PM';
    }else{
      hour1 = startTimeCon.hour;
      hour2 = endTimeCon.hour;
      morningVar = 'AM';
    }
    String startTimeString = hour1.toString().padLeft(1, '0') + ":" + startTimeCon.minute.toString().padLeft(2, '0');
    String endTimeString = hour2.toString().padLeft(1, '0') + ":" + endTimeCon.minute.toString().padLeft(2, '0');


    return Container(

      margin: EdgeInsets.only(left: 0, right: 10, bottom: 8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
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
      child: Container(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: startTimeString, size: 40,fontWeight: FontWeight.w700, color: Color(0xFF1A43BF),),
                    Container(
                      child: BigText(text:morningVar,size: 15, fontWeight: FontWeight.w500, color: Colors.black,),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.alarm_outlined, color: Colors.grey, size: 16,),
                        Container(
                          child: BigText(text:" " + endTimeString,size: 16, fontWeight: FontWeight.w500, color: Colors.grey,),
                        ),
                      ],
                    )
                  ]
              ),
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top:10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: BigText(text: subjectSnapshot['subject_name'].toString(), color: Colors.black,
                        fontWeight: FontWeight.w700, size: 16, maxLines: 2,),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 150,
                    child: Row(
                      children: [
                        Icon(Icons.class_outlined, color: Colors.black, size: 15,),
                        SizedBox(width: 5,),
                        Expanded(
                          child: BigText(text:"BSCS 3B", color: Colors.black, fontWeight: FontWeight.w500, size: 15,),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 150,
                    child: Row(
                      children: [
                        Icon(Icons.meeting_room_outlined, color: Colors.black, size: 15,),
                        SizedBox(width: 5,),
                        Expanded(
                          child: BigText(text: bldgSnapshot['bldg_name'].toString() + " " + roomSnapshot['room_id'].toString(), color: Colors.black,
                            fontWeight: FontWeight.w500, size: 15, maxLines: 2,),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          )
      ),


    );
  }

}

