
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utilities/build_routes.dart';
import '../utilities/constants.dart';
import 'big_texts.dart';

class HamburgerPages extends StatelessWidget {
  HamburgerPages({required this.selectedAppPage, required this.widget,
    required this.drawerPage, required this.icon});

  final String icon;
  final AppPages drawerPage;
  final AppPages selectedAppPage;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(createRouteGo(widget));
      },
      child: Container(
        height: 50,
        decoration: ShapeDecoration(
          color: selectedAppPage == drawerPage? kDrawerPagesColor:Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: selectedAppPage == drawerPage? kDrawerPagesColor:Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 7, top: 8, bottom: 8),
          child: Row(
            children: [
              Image.asset('$icon${selectedAppPage == drawerPage?1:0}.png'),
              SizedBox(width: 10),
              BigText(text: drawerPage.name, size: 16, color:selectedAppPage == drawerPage?kBlueColor:Colors.black, fontWeight: FontWeight.w700,),
            ],
          ),
        ),
      ),
    );
  }
}
