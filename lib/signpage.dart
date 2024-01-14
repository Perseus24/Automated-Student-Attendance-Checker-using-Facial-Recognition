import 'package:flutter/material.dart';

class Signproper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blue Rectangle
        Container(
          width: 467,
          height: 229,
          decoration: ShapeDecoration(
            color: Color(0xFF1A43BF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 18, left: 18),
                  child: Image(
                    image: AssetImage('Back.png'),
                  ),
                )
              ],
            ),
          ),
        ),

        // Another Rectangle after the blue rectangle
        Positioned(
          top: 180, // Adjust the top position as needed
          child: Container(
            width: 467, // Adjust the width as needed
            height: 497, // Adjust the height as needed
            decoration: BoxDecoration(
              color: Colors.white, // Change color as needed
              borderRadius:
                  BorderRadius.circular(10), // Adjust border radius as needed
            ),
          ),
        ),

        // PicPic.png positioned on top
        Positioned(
          top: 30, // Adjust the top position as needed
          left: 10,
          right: 10, // Adjust the left position as needed
          child: Image(
            image: AssetImage('picpic.png'),
            width: 430, // Adjust the width as needed
            height: 350, // Adjust the height as needed
          ),
        ),

        // Text positioned on top of everything
        Positioned(
          top: 360, // Adjust the top position as needed
          left: 100,
          right: 100, // Adjust the left position as needed
          child: Container(
            height: 226,
            width: 300, // Adjust the width as needed
            child: Text(
              'To register your face, please go to the administrator’s office to capture your facial images using the dedicated webcam.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                height: 1.5,
                fontWeight: FontWeight.w900,
                decoration: TextDecoration.none,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
        Positioned(
          top: 530, // Adjust the top position as needed
          left: 100,
          right: 100, // Adjust the left position as needed
          child: Container(
            height: 226,
            width: 300, // Adjust the width as needed
            child: Text(
              'This is in order for all the images trained to have a consistent source.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                height: 1.0,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.none,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
        Positioned(
          top: 620,
          left: 100,
          right: 100,
          child: Container(
            width: 289,
            height: 47,
            decoration: BoxDecoration(
              color: Color(0xFF1A43BF),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                'Done',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  fontFamily: 'Inter',
                  height: 0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
