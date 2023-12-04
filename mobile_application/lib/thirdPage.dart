import 'package:flutter/material.dart';
import 'firstPage.dart';
import 'appColors.dart';
import 'widgets/big_texts.dart';

void main(){
  runApp(RegisterWindow2());
}

class RegisterWindow2 extends StatelessWidget{
  const RegisterWindow2({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onVerticalDragUpdate: (details) {},
      onHorizontalDragUpdate: (details) {
        if (details.delta.direction >= 0) {
          //Navigator.of(context).push(_swipeEnterLeft());
      }
    },
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterPage2(),
    )
    );
  }
  
}



class RegisterPage2 extends StatefulWidget {
  const RegisterPage2({Key? key}) : super(key:key);

  @override
  _RegisterPageState2 createState() => _RegisterPageState2();
}

class _RegisterPageState2 extends State<RegisterPage2>{
  @override
  Widget build(BuildContext context){
    return BigText(text:"hi");
  }

}

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => Page2State();
}

class Page2State extends State<Page2>{
  bool hasMiddleName = false;
  @override

  Widget build(BuildContext context){
    return Container(
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
                              labelText: "ajfnknajb *",
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
                    ),
                    SizedBox(height:30),
                    
                  ]
                )
                
              );
  }
}