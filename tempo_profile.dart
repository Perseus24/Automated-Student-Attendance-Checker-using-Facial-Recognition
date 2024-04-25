import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_application_1/utilities/constants.dart';

class Tempo_profile extends StatelessWidget {
  const Tempo_profile({Key? key});

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
