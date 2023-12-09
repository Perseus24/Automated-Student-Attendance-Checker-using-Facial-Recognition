

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'firstPage.dart';
import 'thirdPage.dart';
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
                        Navigator.of(context).push(createRoute(0));
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
              SizedBox(height: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(

                    height: getDynamicSize.getHeight(context)*0.25,
                    child: PageView (
                      controller: _controller,
                      children: [
                        Container(
                          alignment: Alignment.center,
                            child: Page1()
                        ),
                        Page2(),
                        //Page3(),
                      ]

                    ),

                  ),
                ]
              ),
            Container(

              height: getDynamicSize.getHeight(context)*0.09,

                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 2,
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.blueColor,
                      dotColor: Colors.blue.shade100,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 20,
                    ),
                  ),


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

                            child: ElevatedButton(
                                clipBehavior: Clip.antiAlias,
                                style: ElevatedButton.styleFrom(
                                  primary:  Color(0xFF1A43BF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.zero,
                            ),
                            onPressed: (){
                                  Navigator.of(context).push(createRoute(1));
                                  },
                            child: BigText(text: "Sign Up", color: Colors.white, fontWeight: FontWeight.w700,)
                            )
                        ),
                      ),

                    ]
                  ),
                ]
              ),
            SizedBox(height: 10,)
            ]
          )
        
      ),
    );
  }
  
}

Route createRoute(int num){
  Widget goToPage = MyApp();

  switch(num){
    case 0: goToPage = MyApp();
            break;
    case 1: goToPage = MainHomePage();
            break;
  }
  return PageRouteBuilder(
    
    pageBuilder:(context, animation, secondaryAnimation) => goToPage,
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
  String? selectedValue;

  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  @override

  Widget build(BuildContext context){
    return Container(

          padding: EdgeInsets.only(left: 15, right: 15),
          child: Container(
            margin: EdgeInsets.only(top:20, bottom: 20),

            child: Center(
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
                    SizedBox(height: 20),

                    //SizedBox(height: 10),
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
                              child: Center(
                                child: DropdownButtonFormField2<String>(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  hint: BigText(text: "Sex", fontWeight: FontWeight.w400, size: 16),
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
                              ),
                            ),
                          ),
                        ]
                    ),
                    //SizedBox(height:30),

                  ]
              ),
            ),
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
  
  final List<String> blocItems = [
  'A',
  'B',
  'C',
  ];

  final List<String> courseItems = [
    'Biology',
    'Chemistry',
    'Computer Science',
    'Information Technology',
    'Meteorology'
  ];

  final List<String> yearLevel = [
    '1st Year',
    '2nd Year',
    '3rd Year',
    '4th Year'
  ];

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: (getDynamicSize.getWidth(context) - 10)*0.63,
              height: 50,
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
              child: DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),

                hint: BigText(text: "Select your course", fontWeight: FontWeight.w400, size: 14,),
                items: courseItems
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
            ),
            const SizedBox(height: 20),
            Container(
              width: (getDynamicSize.getWidth(context) - 10)*0.63,
              height: 50,
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
              child: DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                hint: BigText(text: "Select your year level", fontWeight: FontWeight.w400, size: 14,),
                items: yearLevel
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
                    return 'Please select your year.';
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
            ),
            const SizedBox(height: 20),
            Container(
              width: (getDynamicSize.getWidth(context) - 10)*0.63,
              height: 50,
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
              child: DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                hint: BigText(text: "Select your bloc", fontWeight: FontWeight.w400, size: 14,),
                items: blocItems
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
            ),
          ],
        ),
      ),
    ),
  );
}
}
