import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/colors.dart';
import 'package:parinaya/pages/signInPage.dart';
import 'package:parinaya/pages/signUpPage.dart';
import 'package:parinaya/widgets/buttons.dart';

// class StartPage extends StatefulWidget {
//   const StartPage({Key? key}) : super(key: key);

//   @override
//   StartPageState createState() => StartPageState();
// }

class StartPage extends StatelessWidget {
  // bool center = true;
  // // bool animComp = false;
  // bool signup = false;

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
            top: (getScreenHeight / 2.8) - (logoHeight / 2),
            left: 0,
            child: Container(
              width: getScreenWidth,
              height: getScreenHeight / 1.5,
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: "logo",
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
                  ),
                  // SizedBox(height: getScreenHeight / 100),
                  Container(
                    height: getScreenHeight / 10,
                    child: Column(
                      children: [
                        // Text(
                        //   "PARINAY",
                        //   style: TextStyle(
                        //       fontSize: 40, fontWeight: FontWeight.bold),
                        // ),
                        Text(
                          "Wedding Planner & Event Management Co.",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily:
                                  'assets/fonts/Abhaya_Libre/AbhayaLibre-Regular.ttf'),
                          textAlign: TextAlign.center,
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
                                Navigator.of(context).push(PageRouteBuilder(
                                  transitionDuration: Duration(seconds: 1),
                                  opaque: false,
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      SignInpage(),
                                ));
                              },
                              child: LocalButton(
                                title: Text('Sign In'),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    transitionDuration: Duration(seconds: 1),
                                    opaque: false,
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        SignUppage()));
                              },
                              child: LocalButton(
                                title: Text('Sign Up'),
                              ),
                            )
                          ])),
                ],
              ),
            ),
          ),
        ]),
      ),
    );

    // return Stack(children: [
    //   AnimatedPositioned(
    //     duration: Duration(seconds: 1),
    //     curve: Curves.easeInOut,
    //     top: center
    //         ? ((getScreenHeight / 2) - (getScreenHeight / 5))
    //         : ((getScreenHeight / 4.5) - ((getScreenHeight / 5) / 2)),
    //     left: ((getScreenWidth / 2) - (getScreenHeight / 10)),
    //     child: Container(
    //       height: getScreenHeight / 5,
    //       width: getScreenHeight / 5,
    //       // color: Colors.blue,
    //       child: Center(
    //         child: Image.asset(
    //           'assets/icons/icon.png',
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //     ),
    //   ),
    //   Positioned(
    //     bottom: ((getScreenHeight / 2) - (getScreenHeight / 5)),
    //     left: ((getScreenWidth / 2) - (getScreenWidth / 2.4)),
    //     child: AnimatedOpacity(
    //       onEnd: () {
    //         // if (!center) {
    //         //   setState(() {
    //         //     animComp = true;
    //         //   });
    //         // }
    //         if (!center) {
    //           if (signup) {
    //             Navigator.of(context)
    //                 .pushNamed('/signUpPage', arguments: widget.key);
    //           } else {
    //             Navigator.of(context)
    //                 .pushNamed('/signInPage', arguments: widget.key);
    //           }
    //         }
    //       },
    //       duration: Duration(seconds: 1),
    //       opacity: center ? 1 : 0,
    //       child: Container(
    //         height: getScreenHeight / 5,
    //         width: getScreenWidth / 1.2,
    //         // color: Colors.green,
    //         child: Center(
    //           child: Column(
    //             children: [
    // Text(
    //   "PARINAY",
    //   style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
    // ),
    //               Text("Wedding & Event Planner",
    //                   style: TextStyle(fontSize: 25)),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    //   Positioned(
    //     bottom: getScreenHeight / 10,
    // child: Container(
    //   height: getScreenHeight / 10,
    //   width: getScreenWidth,
    //   // color: Colors.red,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: [
    //       ElevatedButton(
    //         onPressed: () {
    //           setState(() {
    //             center = false;
    //             signup = false;
    //           });
    //         },
    //         child: LocalButton(
    //           title: Text('Sign In'),
    //         ),
    //       ),
    //       ElevatedButton(
    //         onPressed: () {
    //           setState(() {
    //             center = false;
    //             signup = true;
    //           });
    //         },
    //         child: LocalButton(
    //           title: Text('Sign Up'),
    //         ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // ]);
  }
}

// Stack(children: [
//   // Scaffold(
//   //     backgroundColor: Colors.transparent,
//   //     body: Stack(
//   //       children: [
// AnimatedPositioned(
//   duration: Duration(seconds: 1),
//   curve: Curves.easeInOut,
//   top: center
//       ? ((getScreenHeight / 2) - (getScreenHeight / 5))
//       : (kTextTabBarHeight + getScreenHeight / 20),
//   left: ((getScreenWidth / 2) - (getScreenWidth / 2.4)),
//   child: Container(
//     height: getScreenHeight / 5,
//     width: getScreenWidth / 1.2,
//     // color: Colors.blue,
//     child: Center(
//       child: Image.asset('assets/icons/icon.png'),
//     ),
//   ),
//   ),
// Positioned(
//   bottom: 0,
//   left: 0,
//   child: Container(
//     color: Colors.amber,
//     height: getScreenHeight / 1.4,
//     width: getScreenWidth,
//     child: Builder(
//       builder: (ctx) {
//         return Stack(
//           children: [
//             Positioned(
//               bottom: ((getScreenHeight / 2) - (getScreenHeight / 5)),
//               left: ((getScreenWidth / 2) - (getScreenWidth / 2.4)),
//               child: AnimatedOpacity(
//                 onEnd: () {
//                   // if (!center) {
//                   //   setState(() {
//                   //     animComp = true;
//                   //   });
//                   // }
//                   if (!center) {
//                     if (signup) {
//                       Scaffold.of(context).
//                       Navigator.of(ctx).pushNamed('/signUpPage',
//                           arguments: widget.key);
//                     } else {
//                       Navigator.of(ctx).pushNamed('/signInPage',
//                           arguments: widget.key);
//                     }
//                   }
//                 },
//                 duration: Duration(seconds: 1),
//                 opacity: center ? 1 : 0,
//                 child: Container(
//                   height: getScreenHeight / 5,
//                   width: getScreenWidth / 1.2,
//                   color: Colors.green,
//                   child: Center(
//                     child: Column(
//                       children: [
// Text(
//   "PARINAY",
//   style: TextStyle(
//       fontSize: 40, fontWeight: FontWeight.bold),
// ),
//                         Text("Wedding & Event Planner",
//                             style: TextStyle(fontSize: 25)),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: getScreenHeight / 10,
//               child: Container(
//                 height: getScreenHeight / 10,
//                 width: getScreenWidth,
//                 color: Colors.red,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           center = false;
//                           signup = false;
//                         });
//                       },
//                       child: LocalButton(
//                         title: Text('Sign In'),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           center = false;
//                           signup = true;
//                         });
//                       },
//                       child: LocalButton(
//                         title: Text('Sign Up'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     ),
//   ),
// )
//   //         Positioned(
//   // bottom: 0,
//   // left: 0,
//   //           child: Container(
//   // color: Colors.amber,
//   // height: getScreenHeight / 1.5,
//   // width: getScreenWidth,
//   //     child: Positioned(
//   //       bottom: ((getScreenHeight / 2) - (getScreenHeight / 5)),
//   //       left: ((getScreenWidth / 2) - (getScreenWidth / 2.4)),
//   //       child: AnimatedOpacity(
//   //         onEnd: () {
//   //           // if (!center) {
//   //           //   setState(() {
//   //           //     animComp = true;
//   //           //   });
//   //           // }
//   //           if (!center) {
//   //             if (signup) {
//   //               Navigator.of(context).pushNamed('/signUpPage',
//   //                   arguments: widget.key);
//   //             } else {
//   //               Navigator.of(context).pushNamed('/signInPage',
//   //                   arguments: widget.key);
//   //             }
//   //           }
//   //         },
//   //         duration: Duration(seconds: 1),
//   //         opacity: center ? 1 : 0,
//   //         child: Container(
//   //           height: getScreenHeight / 5,
//   //           width: getScreenWidth / 1.2,
//   //           color: Colors.green,
//   //           child: Center(
//   //             child: Column(
//   //               children: [
// Text(
//   "PARINAY",
//   style: TextStyle(
//       fontSize: 40, fontWeight: FontWeight.bold),
// ),
// Text("Wedding & Event planner",
//     style: TextStyle(fontSize: 25)),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       ),
//   //     ),
//   //   ),
//   // ),
//   //         // center
//   //         //     ? Container()
//   //         //     : (animComp
//   //         //         ? Builder(
//   //         //             builder: (context) {
//   //         //               animComp = false;
//   //         //               center = true;
//   //     return Container(
//   //       height: getScreenHeight,
//   //       width: getScreenWidth,
//   //       color: Colors.transparent,
//   //       child: Center(
//   //         child: signup
//   //             ? SignUppage(
//   //                 goToStartPage: () {
//   //                   print("k");
//   //                   setState(() {
//   //                     center = true;
//   //                   });
//   //                 },
//   //               )
//   //             : SignInpage(
//   //                 goToStartPage: () {
//   //                   print("k");
//   //                   setState(() {
//   //                     center = true;
//   //                   });
//   //                 },
//   //               ),
//   //       ),
//   //     );
//   //   },
//   // )
//   //         //         : Container())
//   //       ],
//   //     )),
//   // center
//   //     ? Positioned(
//   //         bottom: getScreenHeight / 10,
//   //         child: Container(
//   //           height: getScreenHeight / 10,
//   //           width: getScreenWidth,
//   //           child: Center(
//   //             child: Container(
//   //               height: getScreenHeight / 10,
//   //               width: getScreenWidth / 1.2,
//   //               // color: Colors.green,
//   //               child: Row(
//   //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                 children: [
//   // ElevatedButton(
//   //   onPressed: () {
//   //     setState(() {
//   //       center = false;
//   //       signup = false;
//   //     });
//   //   },
//   //   child: LocalButton(
//   //     title: Text('Sign In'),
//   //   ),
//   // ),
//   // ElevatedButton(
//   //   onPressed: () {
//   //     setState(() {
//   //       center = false;
//   //       signup = true;
//   //     });
//   //   },
//   //   child: LocalButton(
//   //     title: Text('Sign Up'),
//   //   ),
//   // ),
//   //                 ],
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //       )
//   //     : Container(),
// ]);
