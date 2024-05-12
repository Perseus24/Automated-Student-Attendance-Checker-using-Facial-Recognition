
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../utilities/constants.dart';
import '../widgets/big_texts.dart';

class StatisticsProf extends StatefulWidget {
  const StatisticsProf({super.key});

  @override
  State<StatisticsProf> createState() => _StatisticsProfState();
}

class _StatisticsProfState extends State<StatisticsProf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(text: "Class Statistics", color: Colors.white, size:20, fontWeight: FontWeight.w400,),
        backgroundColor: kBlueColor,

        toolbarHeight: 80,
        iconTheme: IconThemeData(color: Colors.white, size: 25),
      ),
      body: ClassStatistics(),
    );
  }
}


class ClassStatistics extends StatefulWidget {
  const ClassStatistics({super.key});

  @override
  State<ClassStatistics> createState() => _ClassStatisticsState();
}

class _ClassStatisticsState extends State<ClassStatistics> {


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



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.only(top: 17, left: 28, right: 28),
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
                    color: Colors.white,
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
                          color: Colors.white,
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
                          color: Colors.white,
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
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(20),
              height: 350,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(text: "Attendance Rate", color: kGreyColor, size: 14, fontWeight: FontWeight.w400,),
                      //BigText(text: "BSCS 3B", color: kGreyColor, size: 14, fontWeight: FontWeight.w400,),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Expanded(
                      child: BarChartAttendance()),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BigText(text: "BSCS 3B", color: kGreyColor, size: 14, fontWeight: FontWeight.w400,),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 25,),
            Container(
              //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              height: 70,
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
              child: Center(
                child: BigText(
                  text: "Your class achieved an average 82.96% attendance rate this week!",
                  color: Colors.black,
                  size: 15,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
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
          maxY: 15,
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
              (((rod.toY)/13)*100).toStringAsFixed(2) + "%",
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
          width: 25,
          toY: 11,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
          width: 25,
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
          width: 25,
          toY: 13,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [
        BarChartRodData(
          width: 25,
          toY: 12,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    // BarChartGroupData(
    //   x: 4,
    //   barRods: [
    //     BarChartRodData(
    //       toY: 0,
    //       gradient: _barsGradient,
    //     )
    //   ],
    //   showingTooltipIndicators: [0],
    // ),
  ];
}

