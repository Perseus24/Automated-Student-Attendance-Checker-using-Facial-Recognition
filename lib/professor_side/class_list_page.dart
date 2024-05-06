

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/professor_side/show_class_page.dart';
import 'package:flutter_application_1/professor_side/statistics_page_prof.dart';
import 'package:flutter_application_1/professor_side/utilities/get_prof_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../utilities/build_routes.dart';
import '../utilities/constants.dart';
import '../widgets/big_texts.dart';
import '../widgets/hamburger.dart';

class ClassLists extends StatefulWidget {
  const ClassLists({super.key});

  @override
  State<ClassLists> createState() => _ClassListsState();
}

class _ClassListsState extends State<ClassLists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(text: "Statistics", color: Colors.white, size:25, fontWeight: FontWeight.w700,),
        backgroundColor: kBlueColor,
        toolbarHeight: 80,
        iconTheme: IconThemeData(color: Colors.white, size: 25),
      ),
      drawer: BuildDrawer(selectedAppPage: AppPages.Statistics,),
      body: StatisticsClass(),
    );
  }
}

class StatisticsClass extends StatefulWidget {
  const StatisticsClass({super.key});

  @override
  State<StatisticsClass> createState() => _StatisticsClassState();
}

class _StatisticsClassState extends State<StatisticsClass> {


  late List<List<DocumentSnapshot>> schedule = [];
  late DocumentSnapshot subject;
  late List<dynamic> classList;
  late List<dynamic> classDays;
  late List<DocumentSnapshot> students;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeData();
  }

  final ProfDataControllers profDataControllers = Get.put(ProfDataControllers());

  void initializeData(){

    //schedule = profDataControllers.scheduleSnapshot.firstWhere((element) => element['subject_sched_id'] == subject_sched_id);
    //subject = profDataControllers.subjectSnapshot.firstWhere((element) => element['subject_id'] == schedule['subject_id']);

    classDays = profDataControllers.scheduleSnapshot.map((e) => e['day_of_week']).toSet().toList();
    classList = profDataControllers.scheduleSnapshot.map((e) => e['course_bloc_id']).toSet().toList();

    //schedule = profDataControllers.scheduleSnapshot.where((element) => classList.contains(element['course_bloc_id'])).toList();

    for(int i = 0; i<classList.length;i++){
      setState(() {
        schedule.add(
            profDataControllers.scheduleSnapshot.where((element) => element['course_bloc_id'] == classList[i]).toList()
        );
      });
    }
  }

  List<String> convertWeekdays(List<dynamic> days){
    List<String> weekdays =[];

    days.forEach((element) {
      switch(element){
        case 1: weekdays.add("Monday");
        break;
        case 2: weekdays.add("Tuesday");
        break;
        case 3: weekdays.add("Wednesday");
        break;
        case 4: weekdays.add("Thursday");
        break;
        case 5: weekdays.add("Friday");
        break;
      }
    });

    return weekdays;

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15  ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: classList.length,
                itemBuilder: (context, position) {
                  final sched = schedule[position];
                  final days =sched.map((e) => e['day_of_week']).toSet().toList();
                  final students = sched.where((element) => element['course_bloc_id'] == classList[position]).toList();
                  return buildClassList(sched,days, students);
                }
            ),
          ),

        ),
      ),
    );
  }

  Widget buildClassList(List<DocumentSnapshot> sched, List<dynamic> days, List<DocumentSnapshot> students){
    return Column(
      children: [
        Container(
          height: 170,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      height: 50,
                      decoration: ShapeDecoration(
                        color: kBlueColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BigText(
                            text: "Data Mining - CS ELEC 2",
                            color: Colors.white,
                            size: 17,
                          ),
                          GestureDetector(
                            onTap: (){
                              profDataControllers.tappedSchedSubject.value = sched[0]['subject_sched_id'];
                              profDataControllers.update();
                              Navigator.of(context).push(createRouteGo(ShowClassPage()));
                            },
                            child: Container(
                              height: 50,
                              width: 80,
                              child: Icon(FontAwesomeIcons.infoCircle, color: Colors.white, size: 18,),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: BigText(text: convertWeekdays(days).join(",  "), size: 14, color: kGreyColor,),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.users,color: Colors.black, size: 15,),
                    SizedBox(width: 10,),
                    BigText(text: sched[0]['course_bloc_id'] == 33002?"BSCS 3B":"BSCS 3A", size: 14, color: Colors.black,),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.person,color: Colors.black, size: 15,),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BigText(text: "13 students", size: 14, color: Colors.black,),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(createRouteGo(StatisticsProf()));
                            },
                            child: Container(
                              height: 30,
                              width: 150,
                              decoration: ShapeDecoration(
                                color: Colors.yellow,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                )
                              ),
                              child: Center(
                                child: BigText(
                                  text: "View attendance statistics",
                                  size: 11,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 30,)
      ],
    );
  }
}





