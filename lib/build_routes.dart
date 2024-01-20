



import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/signInPage.dart';
import 'package:flutter_application_1/temporarySecond.dart';
import 'package:flutter_application_1/thirdPage.dart';
import 'main.dart';
import 'registerFaceAdmin.dart';

Route createRouteGo(int num){
  Widget goToPage = MyApp();

  switch(num){
    case 0: goToPage = RegisterWindow();
    break;
    case 1: goToPage = MainHomePage();
    break;
    case 2: goToPage = SignInWindow();
    break;
    case 3: goToPage = RegisterFace();
    break;
  }
  return PageRouteBuilder(

    pageBuilder:(context, animation, secondaryAnimation) => goToPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child){
      const begin = Offset(0.0, -1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve:curve));

      return SlideTransition(
          position: animation.drive(tween),
          child:child
      );
    },
    transitionDuration: Duration(milliseconds: 500),

  );

}

Route createRouteBack(int num){
  Widget goToPage = MyApp();

  switch(num){
    case 0: goToPage = MyApp();
    break;
  }
  return PageRouteBuilder(

    pageBuilder:(context, animation, secondaryAnimation) => goToPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child){
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve:curve));

      return SlideTransition(
          position: animation.drive(tween),
          child:child
      );
    },
    transitionDuration: Duration(milliseconds: 500),

  );

}