
import 'dart:math';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/utilities/constants.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:table_calendar/table_calendar.dart';
import '../professor_side/show_class_page.dart';
import '../utilities/build_routes.dart';
import '../utilities/get_user_data.dart';
import '../widgets/big_texts.dart';
import '../widgets/hamburger.dart';
import 'landing_page.dart';
import 'notification_page.dart';

Map<LayerLink, OverlayEntry> overlays = {};


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


class StatisticsHome extends StatelessWidget {

  final homepageController = Get.put(HomepageController());
  final userDataControllers = Get.put(UserDataControllers());
  final StudentAttendance studentAttendance = Get.put(StudentAttendance());
  final String name = '';

  String setName(int index){

    if(index == 0){
     return userDataControllers.studentSnapshot[0]['first_name'].toString() + " " +
         userDataControllers.studentSnapshot[0]['last_name'].toString();
    }
    return studentAttendance.student_name.value;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        drawer: BuildDrawer(selectedAppPage: AppPages.Statistics,),
        appBar: AppBar(
          //leadingWidth: 40,
          backgroundColor: kBlueColor,
          title: Container(
            child: Row(
              children: [
                CircleAvatar(),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text:setName(userDataControllers.switchDashboardUser.value), fontWeight: FontWeight.w700, color: Color(0xFFBCC1CD), size: 15),
                    BigText(text: "BS Computer Science 3B", fontWeight: FontWeight.w400, color: Color(0xFFBCC1CD), size: 15,),
                  ],
                )
              ],
            ),
          ),
          actions: [
            Container(
                margin: EdgeInsets.only(right: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      userDataControllers.switchDashboardUser.value==0?Container(
                          width: 50,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: (){
                              homepageController.notifButtonTapped.toggle();
                              homepageController.expandNotifContainer();
                              homepageController.update();

                            },
                            clipBehavior: Clip.antiAlias,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: Image.asset('images/Bellpin.png'),
                          )
                      ):Container(),
                    ]
                )
            ),
          ],
          toolbarHeight: 90,
          iconTheme: IconThemeData(color: Colors.white, size: 25),
        ),
        body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              homepageController.notifButtonTapped.value = false;
              homepageController.expandNotifContainer();
              homepageController.update();
              hideOverlays();
            },
          child: StatisticsPage()),
        bottomNavigationBar: userDataControllers.switchDashboardUser.value==0?NotificationStream():null,
      ),
    );
  }
}

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {

  final userDataControllers = Get.put(UserDataControllers());
  StatisticsController statsController = Get.put(StatisticsController());

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'All time'
  ];
  final List<String> weeks = [
    'This week',
    'Last week',
    'Long time ago',
    'All time'
  ];

  String? selectedMonth = "May";
  String? selectedWeek = 'This week';

  LayerLink layerLink = LayerLink();
  OverlayEntry? overlayEntry;

  List<DateTime> specialDates = [
    DateTime(2024, 4, 16), // Example special date 1
    DateTime(2024, 4, 20), // Example special date 2
    // Add more special dates as needed
  ];

  void showOverlay(overlayWidgetSize, widget, layerlink, entry){
    //method for having an overlay widget that may be attached to another widget when tapped

    final overlay = Overlay.of(context)!;
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    entry = OverlayEntry(
        builder: (context) =>Positioned(
          // left: offset.dx - 150, // Adjust the position to the left of the icon
          // top: offset.dy + size.height / 2,
            width: overlayWidgetSize, //may prefer size.width
            child: CompositedTransformFollower(     //making sure that it is "attached" to the target widget
                link: layerlink,
                showWhenUnlinked: false,
                offset: Offset(0, 55),
                child: widget
            )
        )
    );
    overlay.insert(entry!);
    overlays[layerlink] = entry!;
  }

  Widget buildListSubjects(){
    return Container(
        height: 200,
        width: 200,
        decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ]
        ),
        child: ListView.builder(
          itemCount: statsController.listSubjects.length,
          itemBuilder: (context, position) {
            final studentsSubjects = statsController.listSubjects.entries.elementAt(position).key;
            return subjectSelection(studentsSubjects);
          },
        )
    );
  }

  Widget subjectSelection(String subject){
    return GestureDetector(
      onTap: (){
        statsController.updateSelectedSubject(subject);
        statsController.updateAttendance();

        statsController.updateBarChart();
        hideOverlays();

      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        height: 50,
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: BigText(
                text: subject,
                size: 14,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // I moved this function to the get_user_data
  // meaning its only initialized every restart. It won't accommodate new notifications
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   statsController.initAttendance();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 17, left: 28, right: 28),
      child: Scaffold(
        body: Column(
          children: [
             userDataControllers.switchDashboardUser.value==0?Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // BigText(
                //   text: "Subjects:",
                //   size: 14,
                //   fontWeight: FontWeight.bold,
                // ),
                //SizedBox(width: 30,),
                CompositedTransformTarget(
                  link: layerLink,
                  child: GestureDetector(
                    onTap: (){
                      showOverlay(
                          200.0,
                          buildListSubjects(),
                          layerLink,
                          overlayEntry
                      );
                    },
                    child: Obx(()=>Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      height: 50,
                      //width: 250,
                      decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ]
                      ),
                      child: Center(
                        child: BigText(
                          text: statsController.selectedSubject.value,
                          size: 14,
                        ),
                      ),
                    )),
                  ),
                )
              ],
            ):Container(),
            SizedBox(height: 20,),
            Container(
              height: 40,
              child: ListView(
                children: [
                  Obx(()=>CustomSlidingSegmentedControl<int>(
                    height: 40,
                    fixedWidth: 100,
                    initialValue: statsController.groupValue.value,
                    children: {
                      0: BigText(text: "Weekly", size: 15, color:(statsController.groupValue.value == 0)?kBlueColor:Color(0xFFA5A5A5), fontWeight: FontWeight.w700,),
                      1: BigText(text: "Monthly", size: 15, color:(statsController.groupValue.value == 1)?kBlueColor:Color(0xFFA5A5A5), fontWeight: FontWeight.w700,),
                      2: BigText(text: "All Time",size: 15,color:(statsController.groupValue.value == 2)?kBlueColor:Color(0xFFA5A5A5), fontWeight: FontWeight.w700,),
                    },
                    onValueChanged: (groupValue){
                      statsController.groupValue.value = groupValue;
                      switch(groupValue){
                        case 0: statsController.weekChoiceTapped.value = true;
                                statsController.monthChoiceTapped.value = false;
                                statsController.allTimeChoiceTapped.value = false;
                                break;
                        case 1: statsController.weekChoiceTapped.value = false;
                                statsController.monthChoiceTapped.value = true;
                                statsController.allTimeChoiceTapped.value = false;
                                break;
                        case 2: statsController.weekChoiceTapped.value = false;
                                statsController.monthChoiceTapped.value = false;
                                statsController.allTimeChoiceTapped.value = true;
                                break;

                      }
                      statsController.weekChoice.value = 0;
                      statsController.monthChoice.value = 4;
                      statsController.updateAttendance();
                      statsController.updateBarChart();
                      statsController.update();
                    },
                    decoration: BoxDecoration(
                        color: Color(0xFFE4EAF0),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    thumbDecoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  )),
                ],
              ),

            ),
            SizedBox(height: 10,),
            Obx((){
              return (statsController.groupValue.value == 0)?Stack(
                children: [
                  Container(
                    width: 120,
                    child: DropdownButtonFormField2<String>(
                      value: selectedWeek,
                      isExpanded: false,
                      items:  weeks.map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'SF Pro Display',
                              color: kGreyColor
                          ),
                        ),
                      )).toList(),
                      decoration: InputDecoration(
                          border: InputBorder.none
                      ),
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(left:0,right:0),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 24,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: 100,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 1),
                      ),
                      onSaved: (value){

                      },
                      onChanged: (String? value){
                        for(int i=0; i<weeks.length; i++){
                          if(weeks[i] == value){
                            statsController.weekChoice.value = i;
                            statsController.updateAttendance();
                            statsController.updateBarChart();
                            statsController.update();
                            break;
                          }
                        }
                      },
                    ),
                  )
                ],
              ):
              (statsController.groupValue.value == 1)?Stack(
                children: [
                  Container(
                    width: 90,
                    child: DropdownButtonFormField2<String>(
                      value: selectedMonth,
                      isExpanded: false,
                      //hint: BigText(text: "Select your sex", fontWeight: FontWeight.w400, size: 14,),
                      items:  months.map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'SF Pro Display',
                              color: kGreyColor
                          ),
                        ),
                      )).toList(),
                      decoration: InputDecoration(
                          border: InputBorder.none
                      ),
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(left:0,right:0),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 24,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: 100,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 1),
                      ),
                      onSaved: (value){

                      },
                      onChanged: (String? value){
                        for(int i=0; i<months.length; i++){
                          if(months[i] == value){
                            statsController.monthChoice.value = i;

                            statsController.updateAttendance();

                            statsController.update();
                            statsController.updateBarChart();
                            break;
                          }
                        }

                      },
                    ),
                  )
                ],
              ):Container();
            }),
            SizedBox(height: 15,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 15, left: 20, right: 30),
                            height: 110,
                            decoration: ShapeDecoration(
                                color: Color(0x3F1400FF),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1, color: Color(0xFF1A43BF)),
                                    borderRadius: BorderRadius.circular(15)
                                )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: "Total Attendance   ", fontWeight: FontWeight.w700, maxLines: 2, size: 16,),
                                Obx(()=>BigText(text: (statsController.attendance[0].length + statsController.attendance[2].length).toString(), fontWeight: FontWeight.w700, size: 25, color: Color(0xFF1400FF),))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                          child: Container(
                            height: 110,
                            padding: EdgeInsets.only(top: 15, left: 20, right: 30),
                            decoration: ShapeDecoration(
                                color: Color(0x59FF0000),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1, color: Color(0xFFFF0000)),
                                    borderRadius: BorderRadius.circular(15)
                                )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: "Total Absences   ", fontWeight: FontWeight.w700, maxLines: 2, size: 16,),
                                Obx(()=>BigText(text: statsController.attendance[1].length.toString(), fontWeight: FontWeight.w700, size: 25, color: Color(0xFFFF0000), ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    Obx(()=>Visibility(
                      visible: !statsController.allTimeChoiceTapped.value,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        height: 200,
                        width: double.infinity,
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
                            ]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: "Attendance Rate", color: kGreyColor, size: 16, fontWeight: FontWeight.w700,),
                            SizedBox(height: 20,),
                            Expanded(
                                child: BarChartAttendance())
                          ],
                        ),
                      ),
                    )),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            height: 220,
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
                                ]
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: "Punctuality", color: kGreyColor, size: 16, fontWeight: FontWeight.w700,),
                                SizedBox(height: 20,),
                                Expanded(
                                    child: Obx(()=>PieChartAttendance(
                                      numPresent: statsController.attendance[0].length,
                                      numAbsent: statsController.attendance[1].length,
                                      numLate: statsController.attendance[2].length,
                                    ))),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    PieChartLegend(color: kBlueColor, text: "Present",),
                                    PieChartLegend(color: Colors.red, text: "Absent",),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    PieChartLegend(color: Colors.yellow, text: "Late",),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.all(5),
                              height: 220,
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
                                  ]
                              ),
                              child: Center(child: Text("Show more"))
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarChartAttendance extends StatelessWidget {

  StatisticsController statsController = Get.put(StatisticsController());

  @override
  Widget build(BuildContext context) {
    return Obx(()=>BarChart(
        BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: barGroups,
          gridData: const FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: statsController.monthChoice.value==5?statsController.barchartMonthlyData.reduce(max).toDouble()+2:statsController.barchartWeeklyData.reduce(max).toDouble()+2,
        )
    ));
  }

  BarTouchData get barTouchData => BarTouchData(
      enabled: false,
      touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
              BarChartGroupData group,
              int groupIndex,
              BarChartRodData rod,
              int rodIndex,
              ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: kBlueColor,
                fontWeight: FontWeight.bold,
              ),
            );
          }
      )
  );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mon';
        break;
      case 1:
        text = 'Tue';
        break;
      case 2:
        text = 'Wed';
        break;
      case 3:
        text = 'Thu';
        break;
      case 4:
        text = 'Fri';
        break;
      case 5:
        text = 'Sat';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  Widget getTitlesForMonth(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      case 7:
        text = 'Aug';
        break;
      case 8:
        text = 'Sep';
        break;
      case 9:
        text = 'Oct';
        break;
      case 10:
        text = 'Nov';
        break;
      case 11:
        text = 'Dec';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: statsController.monthChoice.value!=5?getTitles:getTitlesForMonth,
      ),
    ),
    leftTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  LinearGradient get _barsGradient => LinearGradient(
    colors: [
      kBlueColor,
      Colors.black,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> getBarGroups(){
    List<BarChartGroupData> group = [];

    for(int i=0; i<6; i++){
      group.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            width: 15,
            toY: statsController.barchartWeeklyData[i].toDouble(),
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      ));
    }

    return group;
  }

  List<BarChartGroupData> getBarGroupsMonth(){
    List<BarChartGroupData> group = [];

    for(int i=0; i<12; i++){
      group.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            width: 15,
            toY: statsController.barchartMonthlyData[i].toDouble(),
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      ));
    }

    return group;
  }

  List<BarChartGroupData> get barGroups => statsController.monthChoice.value!=5?getBarGroups():getBarGroupsMonth();
}

class PieChartAttendance extends StatelessWidget {

  PieChartAttendance({required this.numAbsent, required this.numLate, required this.numPresent});

  final int numPresent;
  final int numAbsent;
  final int numLate;

  final StatisticsController statisticsController = Get.put(StatisticsController());

  String getValue(int num){
    int total = numPresent+numAbsent+numLate;
    double avg = num/total;
    double valNum = avg*100;
    return valNum.toStringAsFixed(2);
  }

  Widget buildAnimatedContainers(int legend){
    return Obx(()=>AnimatedContainer(
      curve: Curves.ease,
      height: statisticsController.pieChartContainerH.value,
      width: statisticsController.pieChartContainerW.value,
      duration: const Duration(milliseconds: 250),
      decoration: ShapeDecoration(
        color: Colors.white.withOpacity(0.3),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
      ),
      child: Center(
        child: Text(
          getValue(legend)+ "%",
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.bold,
            color:Colors.black,
            shadows: [Shadow(color: Colors.black, blurRadius: 2)],
          ),
        ),
      ),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            statisticsController.expandContainer();
          },
        ),
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 0,
        centerSpaceRadius: 20,
        sections: showingSections(),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final fontSize = 15.0;
      final radius = 30.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
              color: kBlueColor,
              value: double.parse(numPresent.toString()),
              //title: getValue(numPresent)+ "%",
              radius: radius,
              showTitle: false,
              badgeWidget: buildAnimatedContainers(numPresent),
              badgePositionPercentageOffset: 1,
              titlePositionPercentageOffset: 1
          );
        case 1:
          return PieChartSectionData(
              color: Colors.yellow,
              value: double.parse(numLate.toString()),
              title: getValue(numLate)+"%",
              radius: radius,
              showTitle: false,
              badgeWidget: buildAnimatedContainers(numLate),
              badgePositionPercentageOffset: 1,
              titlePositionPercentageOffset: 1
          );
        case 2:
          return PieChartSectionData(
              color: Colors.red,
              value: double.parse(numAbsent.toString()),
              title: getValue(numAbsent)+"%",
              radius: radius,
              showTitle: false,
              badgeWidget: buildAnimatedContainers(numAbsent),
              badgePositionPercentageOffset: 1,
              titlePositionPercentageOffset: 1
          );
        default:
          return PieChartSectionData(
            color: Colors.red,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );;
      }
    });
  }
}

class PieChartLegend extends StatelessWidget {

  PieChartLegend({required this.text, required this.color});

  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 10,
            width: 10,
            color: color,
          ),
          SizedBox(width: 5,),
          Text(text,
            style: TextStyle(
              fontSize: 12,
            ),)
        ],
      ),
    );
  }
}
