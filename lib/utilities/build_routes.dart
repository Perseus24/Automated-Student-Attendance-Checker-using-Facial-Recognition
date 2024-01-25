



import 'package:flutter/cupertino.dart';

Route createRouteGo(Widget widget){

  return PageRouteBuilder(
    pageBuilder:(context, animation, secondaryAnimation) => widget,
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

Route createRouteBack(Widget widget){

  return PageRouteBuilder(

    pageBuilder:(context, animation, secondaryAnimation) => widget,
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