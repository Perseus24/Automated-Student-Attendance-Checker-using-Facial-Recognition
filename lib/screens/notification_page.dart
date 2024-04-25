


import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/landing_page.dart';
import 'package:flutter_application_1/screens/main_homepage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';
import '../utilities/constants.dart';
import '../utilities/get_user_data.dart';
import '../widgets/big_texts.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {


  final HomepageController homepageController = Get.put(HomepageController());
  final userDataControllers = Get.put(UserDataControllers());


  List<DocumentSnapshot<Object?>> sortNotif(List<DocumentSnapshot> sched){


    List<DocumentSnapshot> filteredSched = sched.toList();
    filteredSched.sort((a, b) {
      // Assuming 'time' is a string in HH:mm aa format
      Timestamp tsA = a['date'];
      Timestamp tsB = b['date'];

      DateTime dtA = tsA.toDate();
      DateTime dtB = tsB.toDate();

      // Comparing DateTime objects
      return dtB.compareTo(dtA);
    });
    return filteredSched;

  }

  @override
  Widget build(BuildContext context) {

    List<DocumentSnapshot> thisDayAttendance = sortNotif(userDataControllers.thisDayAttendance);
    List<DocumentSnapshot> yesterdayAttendance = sortNotif(userDataControllers.yesterdayAttendance);
    List<DocumentSnapshot> thisWeekAttendance = sortNotif(userDataControllers.thisWeekAttendance);
    List<DocumentSnapshot> longTimeAttendance = sortNotif(userDataControllers.longTimeAttendance);


    bool thisDayEmpty = thisDayAttendance.isEmpty;
    bool yesterdayEmpty = yesterdayAttendance.isEmpty;
    bool thisWeekEmpty = thisWeekAttendance.isEmpty;
    bool longTimeEmpty = longTimeAttendance.isEmpty;

    return Obx(()=>AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
        height: homepageController.notifContainer.value,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 50,
                decoration: ShapeDecoration(
                  color: kBlueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                  ),
                ),
                child: Center(
                  child: BigText(text: "Notification", size: 15, color: Colors.white,),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      thisDayEmpty?Container():BigText(text: "Today", size: 16, color: kGreyColor,),
                      thisDayEmpty?Container():buildListViewBuilder(thisDayAttendance),
                      thisDayEmpty?Container():SizedBox(height: 10,),

                      yesterdayEmpty?Container():BigText(text: "Yesterday", size: 16, color: kGreyColor,),
                      yesterdayEmpty?Container():buildListViewBuilder(yesterdayAttendance),
                      yesterdayEmpty?Container():SizedBox(height: 10,),

                      thisWeekEmpty?Container():BigText(text: "This week", size: 16, color: kGreyColor,),
                      thisWeekEmpty?Container():buildListViewBuilder(thisWeekAttendance),
                      thisWeekEmpty?Container():SizedBox(height: 10,),

                      longTimeEmpty?Container():BigText(text: "Long time ago", size: 16, color: kGreyColor,),
                      longTimeEmpty?Container():buildListViewBuilder(longTimeAttendance),
                      longTimeEmpty?Container():SizedBox(height: 10,),

                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    ));
  }

  Widget buildListViewBuilder(List<DocumentSnapshot> attendance){

    final List<DocumentSnapshot> schedule = userDataControllers.scheduleSnapshot;
    final List<DocumentSnapshot> subject = userDataControllers.subjectSnapshot;

    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: attendance.length,
        itemBuilder: (context, position) {

          final attendanceDocs = attendance[position];
          final schedDocs = schedule.firstWhere((element) => element['subject_sched_id'] == attendanceDocs['subject_sched_id']);
          final subjectDocs = subject.firstWhere((element) => element['subject_id'] == schedDocs['subject_id']);

          Timestamp ts = attendanceDocs['date'];
          DateTime dm = ts.toDate();
          List<int> diff = [];

          List<int> calculateDifference(){
            int length = 0;
            if(DateTime.now().difference(dm).inMinutes < 60){
              diff.add(DateTime.now().difference(dm).inMinutes);
              diff.add(0);
              return diff;
            }else if(DateTime.now().difference(dm).inHours < 24){
              diff.add(DateTime.now().difference(dm).inHours);
              diff.add(1);
              return diff;
            }else if(DateTime.now().difference(dm).inDays >=1){
              diff.add(DateTime.now().difference(dm).inDays);
              diff.add(2);
              return diff;
            }
            return diff;
          }


          return buildNotifHistory(subjectDocs, attendanceDocs['attendance_status'], calculateDifference());
        }
    );
  }

  Widget buildNotifHistory(DocumentSnapshot attendance, String attendanceStatus, List<int> difference){
    return Column(
      children: [
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              child: Image.asset('images/avatar.png',),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Container(
                  child: RichText(
                    maxLines: 2,
                    text: TextSpan(
                        style: TextStyle(color: Colors.black, fontFamily: 'SF Pro Display', fontSize: 14),
                        children: [
                          TextSpan(text: "You are "),
                          TextSpan(text: attendanceStatus, style: TextStyle(fontWeight: FontWeight.w800)),
                          TextSpan(text: " for your class at " + attendance['subject_name'])
                        ]
                    ),
                  )
              ),
            ),
            SizedBox(width: 10,),
            Container(
                width: 30,
                child: BigText(text: difference[0].toString()  + ((difference[1]==0)?"m":(difference[1]==1)?"h":"d"), size: 14, color: kGreyColor,))
          ],
        ),
      ],
    );
  }
}

class ChatNotification{

  static Future<void> subscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }
  static Future<void> initializeNotification() async{
    await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelGroupKey: 'high_importance_channel',
              channelKey: 'high_importance_channel',
              channelName: 'Basic Notification',
              channelDescription: 'Test notification',
              defaultColor: Colors.white30,
              importance: NotificationImportance.Max,
              channelShowBadge: true,
              onlyAlertOnce: true,
              playSound: true,
              criticalAlerts: true
          )
        ],
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'high_importance_channel_group',
              channelGroupName: 'Group 1'
          )
        ],
        debug: true
    );

    await AwesomeNotifications().isNotificationAllowed().then(
            (isAllowed) async{
          if(!isAllowed){
            await AwesomeNotifications().requestPermissionToSendNotifications();
          }
        }
    );

    await AwesomeNotifications().setListeners(
        onActionReceivedMethod: onActionReceivedMethod,
        onNotificationCreatedMethod: onNotificationCreatedMethod,
        onDismissActionReceivedMethod: onDismissActionReceivedMethod,
        onNotificationDisplayedMethod: onNotificationDisplayedMethod
    );
  }

  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async{
    debugPrint('NotificationCreated!');
  }

  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async{
    debugPrint('NotificationDisplayed!');
  }

  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async{
    debugPrint('DismissAction!');
  }

  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async{
    final payload = receivedAction.payload ?? {};
    if(payload['navigate'] == 'true'){
      Main.navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (_) => MainHomePage(),
          )
      );
    }
  }

  static Future<void> showNotification({required final String title,
    required final String body,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final int? interval
  }) async{
    assert(!scheduled || (scheduled && interval!=null));

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: -1,
          channelKey: 'high_importance_channel',
          title: title,
          body: body,
          actionType: actionType,
          notificationLayout: notificationLayout,
          summary: summary,
          category: category,
          payload: payload,
          bigPicture: bigPicture
      ),
      actionButtons: actionButtons,
      schedule: scheduled?NotificationInterval(
        interval: interval,
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        preciseAlarm: true,
      ) : null,
    );
  }


}


class NewNotif {
  // Initialize Firebase Messaging
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Initialize Awesome Notifications
  final AwesomeNotifications _awesomeNotifications = AwesomeNotifications();

  void initializeNotifications() {
    // Initialize Awesome Notifications settings
    _awesomeNotifications.initialize(
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic notifications',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
        ),
      ],
    );
  }

  // Method to handle incoming FCM messages when the app is in the background
  Future<void> setBackgroundMessageHandler() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Background message handler function
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Handling a background message ${message.messageId}');
    showNotification(message.data['title'], message.data['body']);
  }

  // Method to handle incoming FCM messages when the app is in the foreground
  void setForegroundMessageHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Handling a foreground message ${message.messageId}');
      showNotification(message.notification?.title, message.notification?.body);
    });
  }

  // Method to show the notification using Awesome Notifications
  void showNotification(String? title, String? body) {
    _awesomeNotifications.createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: title ?? 'Notification',
        body: body ?? 'New message',

      ),
    );
  }

  // Method to send a test notification
  void sendNotification() {
    showNotification('Test Notification', 'This is a test notification');
  }
}
