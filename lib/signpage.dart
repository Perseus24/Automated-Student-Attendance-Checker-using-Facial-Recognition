import 'package:flutter/material.dart';

class Signproper extends StatelessWidget {
  // Define constants for percentages and positions
  static const double blueRectangleWidthPercentage = 0.9;
  static const double blueRectangleHeightPercentage = 0.3;
  static const double secondRectangleTopPercentage = 0.3;
  static const double secondRectangleWidthPercentage = 0.9;
  static const double secondRectangleHeightPercentage = 0.5;
  static const double picpicTopPercentage = 0.05;
  static const double picpicWidthPercentage = 0.9;
  static const double picpicHeightPercentage = 0.38;
  static const double textTopPercentage = 0.45;
  static const double textWidthPercentage = 0.7;
  static const double textContainerHeightPercentage = 0.2;
  static const double secondTextTopPercentage = 0.75;
  static const double secondTextWidthPercentage = 0.7;
  static const double secondTextContainerHeightPercentage = 0.1;
  static const double buttonTopPercentage = 0.9;
  static const double buttonWidthPercentage = 0.6;
  static const double buttonHeightPercentage = 0.06;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // Blue Rectangle
        Container(
          width: screenWidth * blueRectangleWidthPercentage,
          height: screenHeight * blueRectangleHeightPercentage,
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
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.02,
                    left: screenWidth * 0.02,
                  ),
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
          top: screenHeight * secondRectangleTopPercentage,
          child: Container(
            width: screenWidth * secondRectangleWidthPercentage,
            height: screenHeight * secondRectangleHeightPercentage,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        // PicPic.png positioned on top
        Positioned(
          top: screenHeight * picpicTopPercentage,
          left: screenWidth * 0.02,
          right: screenWidth * 0.02,
          child: Image(
            image: AssetImage('picpic.png'),
            width: screenWidth * picpicWidthPercentage,
            height: screenHeight * picpicHeightPercentage,
          ),
        ),

        // First Text positioned on top of everything
        Positioned(
          top: screenHeight * textTopPercentage,
          left: screenWidth * 0.15,
          right: screenWidth * 0.15,
          child: Container(
            height: screenHeight * textContainerHeightPercentage,
            width: screenWidth * textWidthPercentage,
            child: Text(
              'To register your face, please go to the administrator’s office to capture your facial images using the dedicated webcam.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: screenWidth * 0.04,
                height: 1.5,
                fontWeight: FontWeight.w900,
                decoration: TextDecoration.none,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),

        // Second Text positioned below the first text
        Positioned(
          top: screenHeight * secondTextTopPercentage,
          left: screenWidth * 0.15,
          right: screenWidth * 0.15,
          child: Container(
            height: screenHeight * secondTextContainerHeightPercentage,
            width: screenWidth * secondTextWidthPercentage,
            child: Text(
              'This is in order for all the images trained to have a consistent source.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: screenWidth * 0.03,
                height: 1.0,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.none,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),

        Positioned(
          top: screenHeight * buttonTopPercentage,
          left: screenWidth * 0.15,
          right: screenWidth * 0.15,
          child: Container(
            width: screenWidth * buttonWidthPercentage,
            height: screenHeight * buttonHeightPercentage,
            decoration: BoxDecoration(
              color: Color(0xFF1A43BF),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                'Done',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.04,
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
