import 'package:flutter/material.dart';
import 'package:flutter_application_1/firstPage.dart';
import 'temporarySecond.dart';
import 'appColors.dart';
import 'widgets/big_texts.dart';
import 'widgets/icons_and_text.dart';

void main(){
  runApp(MainHomePage());
}

class MainHomePage extends StatelessWidget{
  const MainHomePage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home1(),
    );
    
  }
  
}



class Home1 extends StatefulWidget {
  const Home1({Key? key}) : super(key:key);

  @override
  Home1State createState() => Home1State();
}

class Home1State extends State<Home1>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(

        child: Column(
          children: [
            Container(
              height: getDynamicSize.getHeight(context)*0.4,
              child: Stack(
                children: [
                  Positioned(

                    child: Container(
                        width: getDynamicSize.getWidth(context),
                        height: getDynamicSize.getHeight(context)*0.3,
                        decoration: BoxDecoration(color: Color(0xFF1A43BF)),
                        child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 55, bottom: 15),
                                  padding: EdgeInsets.only(left: getDynamicSize.getWidth(context)*0.8),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(

                                            width: 50,
                                            height: 50,
                                            child: ElevatedButton(
                                              onPressed: (){
                                                Navigator.of(context).push(createRoute(0));
                                              },
                                              clipBehavior: Clip.antiAlias,
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.transparent,
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(18.0),
                                                ),
                                                padding: EdgeInsets.zero, // <--add this
                                              ),
                                              child: Image.asset('images/Bellpin.png'),

                                            )
                                        ),
                                      ]

                                  )
                              ),

                            ]


                        )
                    ),
                  ),
                  Positioned(
                    top: getDynamicSize.getHeight(context)*0.24,
                    left: getDynamicSize.getWidth(context) * 0.5 - 50,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset('images/taylor.png'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: getDynamicSize.getWidth(context)*0.8,
              height: getDynamicSize.getHeight(context)*0.1,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
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
              child: Container(
                padding: EdgeInsets.only(top: 9, bottom: 9),
                child: Column(
                  children: [

                    BigText(text: "Taylor Dimagiba D. Swift", color: Colors.black),
                    BigText(text: "BSCS 3B", color: Color(0xFFB2B2B2), fontWeight: FontWeight.w700)
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            ClassesBody(),

          ],
        )
      )
      
    );
  }

}

class ClassesBody extends StatefulWidget {
  const ClassesBody({super.key});

  @override
  State<ClassesBody> createState() => _ClassesBodyState();
}

class _ClassesBodyState extends State<ClassesBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: PageView.builder(
        controller: pageController,
          itemCount: 7,
          itemBuilder: (context, position){
            return _buildPageItem(position);
          }
      ),
    );
  }
  Widget _buildPageItem(int index){
    return Container(
      height: 220,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: index.isEven?AppColors.blueColor:Color(0x781A43BF)
      ),
      child: Container(
        padding: EdgeInsets.only(top: 20, left: 20, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(text: "Operating Systems", color: Colors.white, fontWeight: FontWeight.w500),
            SizedBox(height: 10),
            Row(
              children: [
                IconAndTextWidget(icon: Icons.person, text: "Jane Burce",
                    textColor: Colors.white, iconColor: Colors.white,
                  fontWeight: FontWeight.w400, size: 16,)
              ],
            ),
            Row(
              children: [
                Icon(Icons.not_started),
              ],
            )



          ],
        ),
      ),

    );
  }
}







