import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/get_user_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/utilities/constants.dart';

import '../utilities/build_routes.dart';
import '../web/web_main.dart';
import '../widgets/big_texts.dart';
import '../widgets/hamburger.dart';

class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BuildDrawer(selectedAppPage: AppPages.Profile,),
      appBar: AppBar(
        //leadingWidth: 40,
        backgroundColor: kBlueColor,
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
                            //Navigator.of(context).push(createRouteBack(MyApp()));
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
      body: ProfileBody(),
    );
  }
}

class ProfileBody extends StatelessWidget {

  final UserDataControllers userDataControllers = Get.put(UserDataControllers());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: kBlueColor,
          ),
          Positioned(
            top: 90,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width:MediaQuery.of(context).size.width,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: 60,),
                    _buildProfileItem(
                      "Name",
                      userDataControllers.studentSnapshot[0]['first_name'].toString() + " " +
                            userDataControllers.studentSnapshot[0]['last_name'].toString(),
                      CupertinoIcons.person,0
                      ),
                    SizedBox(height: 20),
                    _buildProfileItem(
                        "Course",
                        "BS Computer Science 3-"+(userDataControllers.studentSnapshot[0]['course_bloc_id']==33002?"B":"A"),
                        CupertinoIcons.person,0
                    ),
                    SizedBox(height: 20),
                    // _buildProfileItem('Address', 'abc address, xyz city',
                    //     CupertinoIcons.location),
                    _buildProfileItem(
                        'Email',
                      userDataControllers.studentSnapshot[0]['email'].toString(),
                      CupertinoIcons.mail,0),
                    SizedBox(height: 20),
                    _buildProfileItem(
                        'Total subjects',
                        userDataControllers.subjectSnapshot.length.toString(),
                        CupertinoIcons.book,0),
                    SizedBox(height: 20),
                    _buildProfileItem(
                        'Password',
                        '********',
                        CupertinoIcons.book,
                        1),
                    // SizedBox(height: 20,),
                    // Container(
                    //   width: double.infinity,
                    //   child: ElevatedButton(
                    //     onPressed: () {},
                    //     style: ElevatedButton.styleFrom(
                    //       padding: EdgeInsets.all(22),
                    //       backgroundColor: kBlueColor,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(15),
                    //       ),
                    //     ),
                    //     child: Text(
                    //       'Edit Profile',
                    //       style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 19,
                    //           fontWeight: FontWeight.w700),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: MediaQuery.of(context).size.width/2 - 60,
            child: Image.asset('images/avatar.png'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(String title, String subtitle, IconData iconData,int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Color.fromARGB(255, 105, 43, 250).withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(Icons.arrow_forward, color: index==1?Colors.grey.shade400:Colors.white), // JUST UNCOMMENT FOR ARROW AT THE RIGHT SIDE
        tileColor: Colors.white,
      ),
    );
  }
}


  class ko extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
      body: Stack(
        children: [
          Positioned(
            top: 40.h,
            left: 10.w,
            child: Container(
              width: 45.h,
              height: 45.h,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  backgroundColor: kBlueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Image.asset('images/Back.png'),
              ),
            ),
          ),
          Container(
            child: Positioned(
              top: getDynamicSize.getHeight(context) * 0.28,
              child: SingleChildScrollView(
                child: Container(
                  height: getDynamicSize.getHeight(context),
                  width: getDynamicSize.getWidth(context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: FractionalTranslation(
                            translation:
                            Offset(0.0, -0.60), // Adjust this value as needed
                            child: Container(
                              width: 120.w,
                              height: 120.h,
                              margin: EdgeInsets.only(bottom: 40),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        _buildProfileItem(
                            'Name', 'Erjay Cleofe', CupertinoIcons.person),
                        SizedBox(height: 20.h),
                        _buildProfileItem(
                            'Course', 'BSCS-3A', CupertinoIcons.pencil),
                        SizedBox(height: 20.h),
                        _buildProfileItem('Address', 'abc address, xyz city',
                            CupertinoIcons.location),
                        SizedBox(height: 20.h),
                        _buildProfileItem('Email',
                            'erjaybo.cleofe@bicol-u.edu.ph', CupertinoIcons.mail),
                        SizedBox(height: 40.h),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(22),
                              backgroundColor: kBlueColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(String title, String subtitle, IconData iconData) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Color.fromARGB(255, 105, 43, 250).withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        //trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400), // JUST UNCOMMENT FOR ARROW AT THE RIGHT SIDE
        tileColor: Colors.white,
      ),
    );
  }
}

class getDynamicSize {
  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
