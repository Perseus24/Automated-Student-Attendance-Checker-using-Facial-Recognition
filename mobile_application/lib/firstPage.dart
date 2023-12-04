import 'package:flutter/material.dart';
import 'temporarySecond.dart';
import 'appColors.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GetStarted(),
      ),
    );
  }
}

class GetStarted extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Stack(
      children: [
        RectTop(),
        Positioned(
          top:0.2806*getDynamicSize.getHeight(context),
          child: RectBottom(),
        ),
        Positioned(
          top: 0.0901*getDynamicSize.getHeight(context),
          left: 0.15*getDynamicSize.getWidth(context),
          right: 0.15*getDynamicSize.getWidth(context),
          //bottom: 0.57016*getDynamicSize.getHeight(context),
          child: SampleImage(),
        ),
        Positioned(
          top: 0.04497*getDynamicSize.getHeight(context)+0.0901*getDynamicSize.getHeight(context)+235,
          left: 0.04*getDynamicSize.getWidth(context),
          right: 0.04*getDynamicSize.getWidth(context),
          child: BodyText(),
        ),
        Positioned(
          top:3*0.04497*getDynamicSize.getHeight(context)+0.0901*getDynamicSize.getHeight(context)+235+0.093057*getDynamicSize.getHeight(context)+0.107946*getDynamicSize.getHeight(context),
          left: 0.11466*getDynamicSize.getWidth(context),
          right: 0.11466*getDynamicSize.getWidth(context),
          child: SignInButton(),
        ),
        Positioned(
          top: 5*0.04497*getDynamicSize.getHeight(context)+0.0901*getDynamicSize.getHeight(context)+235+0.093057*getDynamicSize.getHeight(context)+0.107946*getDynamicSize.getHeight(context),
          left: 0.11466*getDynamicSize.getWidth(context),
          right: 0.11466*getDynamicSize.getWidth(context),
          child: RegisterButton(),
        )
      ]
    );
  }
}

class getDynamicSize{
  static double getHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }
  static double getWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
  
}

class RectBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getDynamicSize.getWidth(context),
      height: 0.734 * getDynamicSize.getHeight(context),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}

class RectTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getDynamicSize.getWidth(context),
      height:getDynamicSize.getHeight(context),
      decoration: ShapeDecoration(
        color: AppColors.blueColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1),
          
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
    );
  }
}

class SampleImage extends StatelessWidget {
  static double getHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }
  @override
  
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 229,
          height: 235,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(),
          child: Stack(
            children: [
              Image.asset(
                'images/num1.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,

              ), 
            ]
          ),
        ),
      ],
    );
  }
}

class BodyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 0.107946*getDynamicSize.getHeight(context),
          width: 0.92*getDynamicSize.getWidth(context),
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
        SizedBox(
          height:0.04497*getDynamicSize.getHeight(context),
        ),
        SizedBox(
          width: 0.704*getDynamicSize.getWidth(context),
          height: 0.093057*getDynamicSize.getHeight(context),
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
      ],
    );
  }
}

class SignInButton extends StatefulWidget{
  @override
  _SignButtonState createState() => _SignButtonState();
}

class _SignButtonState extends State<SignInButton> {
  bool buttonPressed = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 0.75466*getDynamicSize.getWidth(context),
          height: 0.06942*getDynamicSize.getHeight(context),
          decoration: ShapeDecoration(
            color: Color(0xFF1A43BF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary:  Color(0xFF1A43BF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: (){
              Navigator.of(context).push(_createRoute());
            },
            child: Positioned(
              top: 0.022156*getDynamicSize.getHeight(context),
              child: SizedBox(
                width: 0.75466*getDynamicSize.getWidth(context),
                height: 0.02687*getDynamicSize.getHeight(context),
                child: Text(
                  'Register',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
         )
        ),
      ],
    );
  }
}


class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 0.75466*getDynamicSize.getWidth(context),
          height: 0.06942*getDynamicSize.getHeight(context),
          decoration: ShapeDecoration(
            color: Color(0x001A43BF),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: Colors.black.withOpacity(0.46000000834465027),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        Positioned(
          top: 0.022156*getDynamicSize.getHeight(context),
          child: SizedBox(
            width: 0.75466*getDynamicSize.getWidth(context),
            height: 0.02687*getDynamicSize.getHeight(context),
            child: Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xA51E0000),
              fontSize: 18,
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w700,
              height: 0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Route _createRoute(){
  return PageRouteBuilder(
    pageBuilder:(context, animation, secondaryAnimation) => RegisterWindow(),
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

  );

}
