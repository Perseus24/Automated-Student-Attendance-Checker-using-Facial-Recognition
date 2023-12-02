import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GetStarted(),
      ),
    );
  }
}

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context){
      return Column(
        children: [BodyText()]
      );
  }
}


class BodyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 72,
          width: 345,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Welcome to\n ',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8500000238418579),
                    fontSize: 30,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: 'KUMIT',
                  style: TextStyle(
                    color: Color(0xFF1A43BF),
                    fontSize: 30,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                TextSpan(
                  text: ' App',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8500000238418579),
                    fontSize: 30,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Positioned(
          top: 30,
          child: SizedBox(
            width: 264,
            height: 63,
            child: Text(
              'Your intelligent attendance monitoring companion!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8500000238418579),
                fontSize: 20,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}