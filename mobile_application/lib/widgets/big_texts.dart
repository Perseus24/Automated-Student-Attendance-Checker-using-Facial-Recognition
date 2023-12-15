import 'package:flutter/material.dart';

//void main(){
  //runApp(BigText());
//}

class BigText extends StatelessWidget {
  
  Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  FontWeight fontWeight;
  double letterSpacing;

  BigText({Key? key, this.color = Colors.black, 
  required this.text, 
  this.fontWeight = FontWeight.w400,
  this.size = 20,
  this.letterSpacing = 0.08,
  this.overFlow=TextOverflow.ellipsis}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      style: TextStyle(
        color: color,
        fontFamily: 'SF Pro Display',
        fontWeight: fontWeight,
        fontSize: size,
        letterSpacing: letterSpacing,
      ),


    );
  }
}
