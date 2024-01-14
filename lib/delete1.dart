// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'main.dart';
import 'appColors.dart';
import 'widgets/big_texts.dart';


void main(){
  runApp(RegisterWindow());
}

class RegisterWindow extends StatelessWidget{
  const RegisterWindow({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterPage(),
    );
  }
  
}



class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key:key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{

  bool hasMiddleName = false;
  bool isChecked = false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Column(
          
          children: [ 
            Container(
              margin: EdgeInsets.only(top: 55, bottom: 15),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
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
                          borderRadius: BorderRadius.circular(18.0), 
                        ),
                        padding: EdgeInsets.zero, // <--add this
                      ),
                      child: Image.asset('images/Back.png'),

                      )
                  ),
                ]
              )
          ),
          Center(
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
                )
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  
                  BigText(text: "Sign Up Now!", size: 22),
                  SizedBox(height: 10),
                  BigText(text: "Please enter your sign up details.", size: 15, 
                  color: Colors.black.withOpacity(0.46000000834465027), 
                  fontWeight: FontWeight.w400),
                ]
              ),
              SizedBox(height: 60),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: (getDynamicSize.getWidth(context) - 10)*0.45,
                          height: 60,
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
                          child: Container(
                            padding: EdgeInsets.only(left: 20, top: 0.0),
                            child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "First name *",
                            ),
                            
                          )

                          )
                          
                        ),
                        SizedBox(width: 15),
                        Container(
                          width: (getDynamicSize.getWidth(context) - 10)*0.45,
                          height: 60,
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
                          child: Container(
                            padding: EdgeInsets.only(left: 20),
                            child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Last name *",
                              

                            )
                          )

                          )
                          
                        ),
                      ]
                    ),
                    SizedBox(height: 10),
                    
                    Row(
                      children: [
                       Checkbox(
                          checkColor: Colors.white,
                          activeColor: AppColors.blueColor,
                          value: hasMiddleName,
                          onChanged: (bool?value){
                            setState((){
                              hasMiddleName = value!;
                            });
                          }
                        ),
                        BigText(color: Colors.black.withOpacity(0.46000000834465027), 
                        fontWeight: FontWeight.w400,text: "Do you have a middle name?", size:14),
                        

                      ]
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Visibility(
                          visible: hasMiddleName,
                          child:  Container(
                          width: (getDynamicSize.getWidth(context) - 10)*0.45,
                          height: 60,
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
                          child: Container(
                            padding: EdgeInsets.only(left: 20),
                            child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Middle name",
                              

                            )
                          )

                          )
                          
                        ),
                          
                        )
                      ]
                    )
                    
                  ]
                )
                
              )
             
            ]
          )
        
      ),
    );
  }
  
}

class CheckboxSample extends StatefulWidget {
  const CheckboxSample({super.key});

  @override
  State<CheckboxSample> createState() => _CheckboxSampleState();
}

class _CheckboxSampleState extends State<CheckboxSample>{
  bool? isChecked = false;

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Checkbox(
          checkColor: Colors.white,
          activeColor: AppColors.blueColor,
          value: isChecked,
          onChanged: (bool?value){
            setState((){
              isChecked = value!;
            });
          }
        )
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
