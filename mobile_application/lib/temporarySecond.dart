

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'firstPage.dart';
//import 'thirdPage.dart';
import 'appColors.dart';
import 'widgets/big_texts.dart';



void main(){
  runApp(RegisterWindow());
}

class RegisterWindow extends StatelessWidget{
  const RegisterWindow({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onVerticalDragUpdate: (details) {},
onHorizontalDragUpdate: (details) {
   if (details.delta.direction >= 0) {
          Navigator.of(context).push(_swipeEnterLeft());
    }
},
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterPage(),
    )
    );
  }
  
}



class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key:key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{

  final _controller = PageController();

  bool hasMiddleName = false;
  bool isChecked = false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
         
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: getDynamicSize.getHeight(context)*0.3,
                    child: PageView (
                      controller: _controller,
                      children: const[
                        Page1(),
                        Page2(),
                        //Page3(),
                      ]

                    ),
                  ),
                ]
              ),
              
              
              SizedBox(height: 30),
              Stack(
                children: [
                  Column(
                    children: [
                      Center(
                        child: Container(
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
                          child: Center(
                            child: BigText(text: "Swipe Next", color: Colors.white)
                            )
                        ),
                      ),
                    ]
                  ),
                ]
              ),
              BottomAppBar(
                  color: Colors.transparent,
                  child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: ExpandingDotsEffect(
                  activeDotColor: Colors.purple,
                  dotColor: Colors.purple.shade100,
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 20,
                ),



              ), 
                  elevation: 0
              ),
              
              
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
    transitionDuration: Duration(milliseconds: 500),

  );
  


}

Route _swipeEnterLeft(){
  return PageRouteBuilder(
  pageBuilder: (context, animation, secondaryAnimation) => MyApp(),
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    const begin = Offset(1.0, 0.0); // Starts from right
    const end = Offset(0.0, 0.0);   // Ends at the center

    var tween = Tween(begin: begin, end: end);
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  },
  transitionDuration: Duration(milliseconds: 500),
);

}

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => Page1State();
}

class Page1State extends State<Page1>{
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
                              cursorColor: AppColors.blueColor,
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
                 
                    SizedBox(height: 10),
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
                            padding: EdgeInsets.only(left: 20),
                            child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Middle name",
                              

                            )
                          )

                          )
                          
                        ),
                      ]
                    ),
                    SizedBox(height:30),
                    
                  ]
                )
                
              );
  }
}


class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => Page2State();
}

class Page2State extends State<Page2>{
  
  final List<String> genderItems = [
  'Male',
  'Female',
];

String? selectedValue;

final _formKey = GlobalKey<FormState>();

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(16),
                hintText: 'Enter Your Full Name.',
                hintStyle: const TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 30),
            DropdownButtonFormField2<String>(
              isExpanded: true,
              decoration: InputDecoration(
                // Add Horizontal padding using menuItemStyleData.padding so it matches
                // the menu padding when button's width is not specified.
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                // Add more decoration..
              ),
              hint: const Text(
                'Select Your Gender',
                style: TextStyle(fontSize: 14),
              ),
              items: genderItems
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select gender.';
                }
                return null;
              },
              onChanged: (value) {
                //Do something when selected item is changed.
              },
              onSaved: (value) {
                selectedValue = value.toString();
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.only(right: 8),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 24,
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
              },
              child: const Text('Submit Button'),
            ),
          ],
        ),
      ),
    ),
  );
}
}