import 'package:flutter/material.dart';
import 'anotherBG.dart';
import 'dart:math';
void main(){
  runApp(SignInWind());
}

class SignInWind extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(
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
          child: MyHomePage(),
        ),
        Positioned(
          top: 0.2*getDynamicSize.getHeight(context),
          left: 0.25*getDynamicSize.getWidth(context),
          right: 0.29066*getDynamicSize.getWidth(context),
          child: MyHomePage(),
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


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _hasError = false;
  bool _usernameHasError = false;
  bool _passwordHasError = false;

  _handleFormSubmission() {
    final rand = Random();

    setState(() {
      _hasError = rand.nextBool();
    });

    print('Sumbmitted');
  }

  _handleUsernameChange(String value) {
    setState(() {
      _usernameHasError = value.isEmpty;
    });
  }

  _handlePasswordChange(String value) {
    setState(() {
      _passwordHasError = value.isEmpty;
    });
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10.0).add(const EdgeInsets.only(top: 50.0)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: FractionalOffset(0.1, 0.2),
                
               child: Container(
                
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
          ),
        ),
        Align(
            alignment: FractionalOffset(0.5, 0),
                     
            child: Container(
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
        ),
        Container(
          child: Column(
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
            
          ]

            
          )
          
        
        ),
              Container(
                padding: const EdgeInsets.only(top: 0.0),
                child: Column(children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text('')),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Username',
                        errorText: _usernameHasError ? 'Invalid username' : null),
                    onChanged: _handleUsernameChange,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        errorText: _passwordHasError ? 'Invalid password' : null),
                    onChanged: _handlePasswordChange,
                  ),
                  _hasError
                      ? Container(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.error,
                                    color: Theme.of(context).errorColor),
                                Text('An error occurred!',
                                    style: TextStyle(
                                        color: Theme.of(context).errorColor))
                              ]))
                      : Container()
                ]),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(children: [
                    Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text('Submit'),
                          onPressed: _handleFormSubmission,
                        )),
                  ])),
            ]),
      ));
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