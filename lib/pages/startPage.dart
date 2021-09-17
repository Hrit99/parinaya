import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/colors.dart';
import 'package:parinaya/pages/signInPage.dart';
import 'package:parinaya/pages/signUpPage.dart';
import 'package:parinaya/widgets/buttons.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double logoHeight = getScreenWidth / 3;
    double logoWidth = getScreenWidth / 3;
    return Container(
      height: getScreenHeight,
      width: getScreenWidth,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  MyColors().backgroundtouch!, BlendMode.darken))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(
            top: 0,
            child: Container(
              height: getScreenHeight / 2,
              width: getScreenWidth,
              decoration: BoxDecoration(
                // color: Colors.green,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                ),
              ),
              child: Stack(children: [
                Positioned(
                  top: 0,
                  child: Container(
                    height: getScreenHeight / 3,
                    width: getScreenWidth,
                    // color: Colors.green,
                  ),
                ),
                Positioned(
                    top: getScreenHeight / 3,
                    child: Container(
                      child: Center(
                        child: Container(
                          width: getScreenWidth,
                          height: logoHeight,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/startpagelogo.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    )),
              ]),
            ),
          ),
          Positioned(
            top: (getScreenHeight / 2) - 40,
            left: 0,
            child: Container(
              width: getScreenWidth,
              height: getScreenHeight / 3,
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // SizedBox(height: getScreenHeight / 100),
                  Container(
                    height: getScreenHeight / 10,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.white, width: 0.5))),
                          child: Text(
                            "Wedding Planner & Event Management Co.",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              // decoration: TextDecoration.,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: getScreenHeight / 10,
                      width: getScreenWidth,
                      // color: Colors.red,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(PageTransition(
                                    curve: Curves.easeInOut,
                                    // duration: Duration(milliseconds: 400),
                                    type: PageTransitionType.leftToRight,
                                    child: SignInpage()));
                              },
                              child: LocalButton(title: 'Sign in'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(PageTransition(
                                    curve: Curves.easeInOut,
                                    // duration: Duration(milliseconds: 400),
                                    type: PageTransitionType.leftToRight,
                                    child: SignUppage()));
                              },
                              child: LocalButton(title: 'Sign up'),
                            )
                          ])),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            child: Container(
                height: 14,
                width: getScreenWidth,
                child: Center(
                    child: Text("Developed by  ©2021,  Adolfo Tech World."))),
          )
        ]),
      ),
    );
  }
}
