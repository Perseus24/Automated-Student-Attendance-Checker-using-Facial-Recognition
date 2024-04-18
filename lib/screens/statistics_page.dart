import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/utilities/constants.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:table_calendar/table_calendar.dart';
import '../utilities/build_routes.dart';
import '../utilities/get_user_data.dart';
import '../widgets/big_texts.dart';
import '../widgets/hamburger.dart';
import 'landing_page.dart';

class StatisticsHome extends StatelessWidget {
  const StatisticsHome({super.key});

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
                    BigText(text: "Taylor Dimagiba Swift", fontWeight: FontWeight.w700, color: Color(0xFFBCC1CD), size: 15),
                    BigText(text: "BSCS 3B", fontWeight: FontWeight.w400, color: Color(0xFFBCC1CD), size: 15,),
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
                      Container(
                          width: 50,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.of(context).push(createRouteBack(MyApp()));
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
                      ),
                    ]
                )
            ),
          ],
          toolbarHeight: 90,
          iconTheme: IconThemeData(color: Colors.white, size: 25),
        ),
        body: StatisticsPage(),
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
    'March'
  ];
  final List<String> weeks = [
    'This week',
    'Last week',
  ];
  String? selectedMonth = "March";
  String? selectedWeek = 'This week';

  late List<List<DocumentSnapshot>> attendance;
  late List<DateTime> hi;

  List<DateTime> specialDates = [
    DateTime(2024, 4, 16), // Example special date 1
    DateTime(2024, 4, 20), // Example special date 2
    // Add more special dates as needed
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    attendance = StatisticsMethods().getTotalAttendance(userDataControllers.attendanceSnapshot);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 17, left: 28, right: 28),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                      width: 100,
                      child: DropdownButtonFormField2<String>(
                        value: selectedWeek,
                        isExpanded: false,
                        //hint: BigText(text: "Select your sex", fontWeight: FontWeight.w400, size: 14,),
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

                        },
                      ),
                    )
                  ],
                ):Container();
              }),
              SizedBox(height: 15,),
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
                          BigText(text: (attendance[0].length + attendance[2].length).toString(), fontWeight: FontWeight.w700, size: 25, color: Color(0xFF1400FF),)
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
                          BigText(text: attendance[1].length.toString(), fontWeight: FontWeight.w700, size: 25, color: Color(0xFFFF0000), )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15,),
              Container(
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
                            child: PieChartAttendance(
                              numPresent: attendance[0].length,
                              numAbsent: attendance[1].length,
                              numLate: attendance[2].length,
                                                      )),
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
                      height: 200,
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
              SizedBox(height:100),
            ],
          ),
        ),

      ),
    );
  }
}

class BarChartAttendance extends StatelessWidget {
  const BarChartAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
      )
    );
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

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: getTitles,
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

  List<BarChartGroupData> get barGroups => [
    BarChartGroupData(
      x: 0,
      barRods: [
        BarChartRodData(
          toY: 8,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
          toY: 10,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [
        BarChartRodData(
          toY: 14,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [
        BarChartRodData(
          toY: 15,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 4,
      barRods: [
        BarChartRodData(
          toY: 13,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 5,
      barRods: [
        BarChartRodData(
          toY: 10,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
  ];
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

class StatisticsMethods{

  StatisticsMethods();

  List<List<DocumentSnapshot<Object?>>> getTotalAttendance(List<DocumentSnapshot> attendance){

    List<String> attendanceStatus = ["Present", "Absent", "Late"];
    List<List<DocumentSnapshot>> attendanceList = [];

    for(String status in attendanceStatus){
      attendanceList.add(attendance.where((doc) => doc['attendance_status'] == status).toList());
    }
    return attendanceList;

  }

  List<DateTime> getDatesForPresent(List<DocumentSnapshot> attendanceList){
    List<DateTime> dates = [];

    for (dynamic datesTemp in attendanceList){
      Timestamp ts = datesTemp['date'];
      dates.add(ts.toDate());
    }
    return dates;
  }

  List<DocumentSnapshot> getThisWeekNotif(List<DocumentSnapshot> attendance){
    List<DocumentSnapshot> thisWeekNotifs = [];

    for(dynamic weekDates in attendance){
      Timestamp ts = weekDates['date'];
      DateTime dm = ts.toDate();

      if(DateTime.now().difference(dm).inDays <= 7 && DateTime.now().difference(dm).inDays > 1){
        thisWeekNotifs.add(weekDates);
      }
    }

    return thisWeekNotifs;
  }

  List<DocumentSnapshot> getLastWeekNotif(List<DocumentSnapshot> attendance){
    List<DocumentSnapshot> thisWeekNotifs = [];

    for(dynamic weekDates in attendance){
      Timestamp ts = weekDates['date'];
      DateTime dm = ts.toDate();

      if(DateTime.now().difference(dm).inDays <= 14 && DateTime.now().difference(dm).inDays > 7){
        thisWeekNotifs.add(weekDates);
      }
    }

    return thisWeekNotifs;
  }

  List<DocumentSnapshot> getLongTimeNotif(List<DocumentSnapshot> attendance){
    List<DocumentSnapshot> thisWeekNotifs = [];

    for(dynamic weekDates in attendance){
      Timestamp ts = weekDates['date'];
      DateTime dm = ts.toDate();

      if(DateTime.now().difference(dm).inDays > 14){
        thisWeekNotifs.add(weekDates);
      }
    }

    return thisWeekNotifs;
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


// class h extends StatelessWidget {
//   const h({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return TableCalendar(
//       rowHeight: 25,
//       //shouldFillViewport: true,
//       firstDay: DateTime.utc(2024,1,1),
//       lastDay: DateTime(2050),
//       focusedDay: statsController.focusedDay.value,
//       calendarFormat: CalendarFormat.month,
//       onDaySelected: (selectedDay, focusedDay){
//         statsController.selectedDay.value = selectedDay;
//         statsController.focusedDay.value = focusedDay;
//         statsController.update();
//       },
//       selectedDayPredicate: (DateTime date){
//         return specialDates.contains(date);
//       },
//       headerStyle: HeaderStyle(
//           formatButtonShowsNext: false,
//           leftChevronVisible: false,
//           rightChevronVisible: false,
//           headerPadding: EdgeInsets.all(5),
//           titleTextStyle: TextStyle(
//               fontSize: 10,
//               fontFamily: 'Poppins'
//           ),
//
//           formatButtonVisible: false,
//           titleCentered: false
//       ),
//       daysOfWeekStyle: DaysOfWeekStyle(
//           dowTextFormatter: (date, locale) => DateFormat.E(locale).format(date)[0],
//           weekdayStyle: TextStyle(
//               fontFamily: 'Poppins',
//               fontSize: 9
//           ),
//           weekendStyle: TextStyle(
//               fontFamily: 'Poppins',
//               fontSize: 9
//           )
//       ),
//
//       calendarStyle: CalendarStyle(
//         cellMargin: EdgeInsets.all(0),
//         isTodayHighlighted: true,
//         selectedDecoration: BoxDecoration(
//           color: kBlueColor,
//           shape: BoxShape.rectangle,
//           //borderRadius: BorderRadius.circular(5)
//         ),
//         selectedTextStyle: TextStyle(fontSize: 9, color: Colors.black),
//
//         todayTextStyle: TextStyle(fontSize: 9),
//         todayDecoration: BoxDecoration(
//             shape: BoxShape.rectangle
//         ),
//         weekendTextStyle: TextStyle(fontSize: 9),
//         defaultTextStyle: TextStyle(fontSize: 9),
//         outsideTextStyle: TextStyle(
//             color: kGreyColor,
//             fontSize: 9
//         ),
//
//
//       ),
//     ),;
//   }
// }
