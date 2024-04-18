import "package:flutter/material.dart";
import "package:get/get.dart";


const Color kBlueColor = Color(0xFF1A43BF);
const Color kDrawerPagesColor = Color(0x661A43BF);
const Color kGreyColor = Color(0xFFA5A5A5);

enum AppPages {Dashboard, Statistics, Calendar, Profile, logout}

const List<String> notifications = ["Today", "Yesterday" "3 days ago", "4 days ago", "Long time ago"];

class StatisticsController extends GetxController{

  RxInt groupValue = 1.obs;

  RxBool pieChartTapped = false.obs;
  RxDouble pieChartContainerH = 0.0.obs;
  RxDouble pieChartContainerW = 0.0.obs;

  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;

  void expandContainer(){
    pieChartContainerH.value = 30.0;
    pieChartContainerW.value = 60.0;
    update();
  }
}


class HomepageController extends GetxController{

  RxBool notifButtonTapped = false.obs;
  RxDouble notifContainer = 0.0.obs;

  void expandNotifContainer(){
    if(notifButtonTapped.value){
      notifContainer.value = 300.0;
    }else{
      notifContainer.value = 0.0;
    }
    update();
  }
}
