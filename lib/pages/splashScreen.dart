import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/colors.dart';
import 'package:parinaya/pages/homePage.dart';
import 'package:parinaya/pages/startPage.dart';
// import 'package:parinaya/widgets/background.dart';
// import 'package:parinaya/widgets/emailVerificationCheck.dart';
import 'package:parinaya/widgets/logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? _initialized = false;
  bool? _error = false;

  @override
  void initState() {
    // TODO: implement initState
    initializeFlutterFire();
    super.initState();
  }

  void initializeFlutterFire() async {
    await Future.delayed(Duration(seconds: 2));
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true

      await Firebase.initializeApp();
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      print("111");
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setScreenHeight = MediaQuery.of(context).size.height;
    setScreenWidth = MediaQuery.of(context).size.width;
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
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: (!_error! && _initialized!)
              ? Center(
                  child: (FirebaseAuth.instance.currentUser != null)
                      ? ((FirebaseAuth.instance.currentUser!.emailVerified)
                          ? HomePage()
                          : StartPage())
                      : StartPage(),
                )
              : Center(
                  child: Stack(children: [
                    Logo(
                      cpi: true,
                      hcenter: getScreenWidth / 2,
                      logoHeight: getScreenWidth / 3,
                      logoWidth: getScreenWidth / 3,
                      vcenter: getScreenHeight / 2,
                    ),
                  ]),
                )
          // body: Stack(children: [
          //   (!_error!)
          //       ? ((_initialized!)
          //           ? FutureBuilder(
          //               future: checkUserVerified(),
          //               builder: (context, snapshot) {
          //                 if (snapshot.hasData) {
          //                   print("jjkk");
          //                   print(snapshot.data);
          //                   if (snapshot.data == true) {
          //                     print("true");
          //                     return Logo(
          //                       cpi: false,
          //                       hcenter: getScreenWidth / 2,
          //                       logoHeight: getScreenWidth / 5,
          //                       logoWidth: getScreenWidth / 5,
          //                       vcenter: getScreenHeight / 2,
          //                     );
          //                   } else {
          //                     Future.delayed(Duration(seconds: 2)).then(
          //                         (value) =>
          //                             Navigator.of(context).pushAndRemoveUntil(
          //                                 PageRouteBuilder(
          //                                   transitionDuration:
          //                                       Duration(seconds: 3),
          //                                   opaque: false,
          //                                   pageBuilder: (context, animation,
          //                                           secondaryAnimation) =>
          //                                       StartPage(),
          //                                 ),
          //                                 (Route<dynamic> route) => false));
          //                     print("false--");
          //                     return Logo(
          //                       cpi: false,
          //                       hcenter: getScreenWidth / 2,
          //                       logoHeight: getScreenWidth / 5,
          //                       logoWidth: getScreenWidth / 5,
          //                       vcenter: getScreenHeight / 2,
          //                     );
          //                   }
          //                 } else {
          // return Logo(
          //   cpi: true,
          //   hcenter: getScreenWidth / 2,
          //   logoHeight: getScreenWidth / 5,
          //   logoWidth: getScreenWidth / 5,
          //   vcenter: getScreenHeight / 2,
          // );
          //                 }
          //               },
          //             )
          //           : Logo(
          //               cpi: true,
          //               hcenter: getScreenWidth / 2,
          //               logoHeight: getScreenWidth / 5,
          //               logoWidth: getScreenWidth / 5,
          //               vcenter: getScreenHeight / 2,
          //             ))
          //       : Center(
          //           child: Container(
          //               height: getScreenHeight / 10,
          //               width: getScreenWidth / 1.5,
          //               child: Center(child: Text("404 error")))),
          // ])
          ),
    );
  }

  Future<bool> checkUserVerified() async {
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      return Future.value(true);
    }
    return Future.value(false);
  }
}
