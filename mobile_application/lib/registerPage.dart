import 'package:flutter/material.dart';
import 'anotherBG.dart';
void main(){
  runApp(SignInWind());
}

class SignInWind extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        BackgroundWhite(),
        Positioned(
          top: 0.08*getDynamicSize.getHeight(context),
          left: 0.0533*getDynamicSize.getWidth(context),
          child: BackButton(),
        ),
        Positioned(
          top: 0.2*getDynamicSize.getHeight(context),
          left: 0.25*getDynamicSize.getWidth(context),
          right: 0.29066*getDynamicSize.getWidth(context),
          child: logo(),
        ),
        Positioned(
          top: 0.40*getDynamicSize.getHeight(context),
          left: 0.1*getDynamicSize.getWidth(context),
          right: 0.1*getDynamicSize.getWidth(context),
          child: PleaseEnterYourSignUpDetails(),
        ),
        Positioned(
          top: 0.5*getDynamicSize.getHeight(context),
          left: 0.1*getDynamicSize.getWidth(context),
          right: 0.1*getDynamicSize.getWidth(context),
          child: Name(),
        ),
        Positioned(
          top: 0.59*getDynamicSize.getHeight(context),
          left: 0.1*getDynamicSize.getWidth(context),
          right: 0.1*getDynamicSize.getWidth(context),
          child: Email(),
        ),
        Positioned(
          top: 0.68*getDynamicSize.getHeight(context),
          left: 0.1*getDynamicSize.getWidth(context),
          right: 0.1*getDynamicSize.getWidth(context),
          child: Password(),
        ),
        Positioned(
          top: 0.85*getDynamicSize.getHeight(context),
          left: 0.1*getDynamicSize.getWidth(context),
          right: 0.1*getDynamicSize.getWidth(context),
          child: SignUp(),
        ),
        



      ]
      
    );
  }
}


class BackgroundWhite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getDynamicSize.getWidth(context),
      height:getDynamicSize.getHeight(context),
      decoration: ShapeDecoration(
        color: Colors.white,
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

class BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 41,
          height: 41,
          child: ElevatedButton(
            onPressed: (){
              Navigator.of(context).push(_createRoute());
            },
            clipBehavior: Clip.antiAlias,
            style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0), // <--add this
            ),
            padding: EdgeInsets.zero, // <--add this
        ),
            child: Image.asset('images/Back.png'),

            )
          )
          

          
        
      ],
    );
  }
}


class logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 159,
          height: 80,
          child: Stack(
            children: [
              Image.asset(
                'images/logo.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,

              ), 
            ]
          )
          
        ),
      ],
    );
  }
}


class PleaseEnterYourSignUpDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 207,
          height: 30,
          child: Text(
            'Sign Up Now!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        ),
        SizedBox(
          width: 300,
          height: 30,
          child: Text(
            'Please enter your sign up details.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(0.46000000834465027),
              fontSize: 15,
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



class Name extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 287,
          height: 47,
          decoration: ShapeDecoration(
            color: Colors.white.withOpacity(0.8500000238418579),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Color(0xFF1A43BF)),
              borderRadius: BorderRadius.circular(15),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 3,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
        ),
        Positioned(
          top: 0.020000*getDynamicSize.getHeight(context),
          left: 0.022120*getDynamicSize.getHeight(context),
          child: SizedBox(
            width: 130,
            height: 20,
            child: Text(
              'Name',
              style: TextStyle(
                color: Colors.black.withOpacity(0.46000000834465027),
                fontSize: 15,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0.0235*getDynamicSize.getHeight(context),
          left: 0.1*getDynamicSize.getHeight(context),
          child: Container(
            width:120,
            height: 20,
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w400,
              )
          )

          )

        )
      ]

    );
  }
}

class Email extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 287,
          height: 47,
          decoration: ShapeDecoration(
            color: Colors.white.withOpacity(0.8500000238418579),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Color(0xFF1A43BF)),
              borderRadius: BorderRadius.circular(15),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 3,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
        ),
        Positioned(
          top: 0.020000*getDynamicSize.getHeight(context),
          left: 0.022120*getDynamicSize.getHeight(context),
        child: SizedBox(
          width: 130,
          height: 20,
          child: Text(
            'Email',
            style: TextStyle(
              color: Colors.black.withOpacity(0.46000000834465027),
              fontSize: 15,
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
        ),
        Positioned(
          top: 0.0235*getDynamicSize.getHeight(context),
          left: 0.1*getDynamicSize.getHeight(context),
          child: Container(
            width:150,
            height: 20,
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w400,
              )
          )

          )

        )
      ]

    );
  }
}



class Password extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: 287,
              height: 47,
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0.85),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFF1A43BF)),
                  borderRadius: BorderRadius.circular(15),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 3,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0.015* getDynamicSize.getHeight(context),
          right: 0.02 * getDynamicSize.getHeight(context),
          child: Container(
            width: 26,
            height: 26,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(),
            child: Stack(
              children: [
                Image.asset(
                  'images/ant-design_eye-filled.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0.0235*getDynamicSize.getHeight(context),
          left: 0.14*getDynamicSize.getHeight(context),
          child: Container(
            width:120,
            height: 20,
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w400,
              )
          )

          )

        ),
        Positioned(
          top: 0.020000*getDynamicSize.getHeight(context),
          left: 0.022120*getDynamicSize.getHeight(context),
        child: SizedBox(
          width: 130,
          height: 20,
          child: Text(
            'Password',
            style: TextStyle(
              color: Colors.black.withOpacity(0.46000000834465027),
              fontSize: 15,
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

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 287,
          height: 47,
          decoration: ShapeDecoration(
            color: Color(0xFF1A43BF),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Color(0xFF1A43BF)),
              borderRadius: BorderRadius.circular(15),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 3,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
        ),
        Positioned(
          top: 0.020000*getDynamicSize.getHeight(context),
          left: 0.31*getDynamicSize.getWidth(context),
        child: SizedBox(
          width: 130,
          height: 20,
          child: Text(
            'Sign Up',
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
      ]

    );
  }
}

Route _createRoute(){
  return PageRouteBuilder(
    pageBuilder:(context, animation, secondaryAnimation) => MyApp(),
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

  );

}