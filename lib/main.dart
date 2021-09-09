import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parinaya/pages/itemPage.dart';
// import 'package:parinaya/pages/addDetailsPage.dart';
// import 'package:parinaya/pages/buildBackground.dart';
// import 'package:parinaya/pages/homePage.dart';
// import 'package:parinaya/pages/newPage.dart';
// import 'package:parinaya/pages/sigInPage.dart';
// import 'package:parinaya/pages/signUpPage.dart';
import 'package:parinaya/pages/splashScreen.dart';
// import 'package:parinaya/pages/startPage.dart';
// import 'package:parinaya/pages/subServiceGallery.dart';
// import 'package:parinaya/pages/subServicePage.dart';
// import 'package:parinaya/providers/listOfServices.dart';
// import 'package:parinaya/providers/locationProvider.dart';
// import 'package:parinaya/widgets/background.dart';
// import 'package:parinaya/widgets/emailVerificationCheck.dart';
// import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parinaya/providers/dataPro.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventPro(),
      child: ChangeNotifierProvider(
        create: (context) => LocationPro(),
        child: ChangeNotifierProvider(
          create: (context) => CategoryPro(),
          child: ChangeNotifierProvider(
            create: (context) => Subcategorypro(),
            child: ChangeNotifierProvider(
              create: (context) => ItemPro(),
              child: MaterialApp(
                title: 'PARINAY',
                theme: ThemeData(
                    cardTheme: CardTheme(
                      color: Colors.transparent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      // shadowColor: Colors.white,
                    ),
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                        backgroundColor: Colors.black.withOpacity(0.7),
                        selectedItemColor: Color.fromARGB(255, 251, 175, 93),
                        selectedIconTheme: IconThemeData(
                          color: Color.fromARGB(255, 251, 175, 93),
                        ),
                        unselectedIconTheme: IconThemeData(
                          color: Colors.white,
                        )),
                    inputDecorationTheme: InputDecorationTheme(
                      // labelStyle:
                      //     TextStyle(color: Color.fromARGB(255, 251, 175, 93)),
                      counterStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 251, 175, 93),
                              width: 1)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 1)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    appBarTheme: AppBarTheme(
                      // color: Colors.transparent,
                      backwardsCompatibility: true,
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.transparent,
                      iconTheme: IconThemeData(
                        color: Colors.white,
                      ),
                      centerTitle: true,
                      textTheme: TextTheme(
                        headline6: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decorationColor: Colors.white,
                          fontFamily: 'Abhaya_Libre',
                          fontSize: kTextTabBarHeight / 2,
                        ),
                      ),
                    ),
                    elevatedButtonTheme: ElevatedButtonThemeData(
                        style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.black.withOpacity(0.4)),
                      side: MaterialStateProperty.all(BorderSide(
                          color: Color.fromARGB(255, 251, 175, 93),
                          width: 2,
                          style: BorderStyle.solid)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      // side: MaterialStateProperty.all(BorderSide(
                      //     color: Colors.white,
                      //     width: 2,
                      //     style: BorderStyle.solid)),
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                      // backgroundColor:
                      //     MaterialStateProperty.all(Colors.transparent),
                      // padding: MaterialStateProperty<EdgeInsetsGeometry?>,
                      alignment: Alignment.center,
                      enableFeedback: true,
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    )),
                    dividerColor: Color.fromARGB(255, 255, 228, 200),
                    primaryColor: Color.fromARGB(255, 251, 175, 93),
                    accentColor: Colors.white,
                    backgroundColor: Colors.black.withOpacity(0.7),
                    dialogBackgroundColor: Colors.grey,
                    iconTheme: IconThemeData(
                      color: Colors.white,
                    ),
                    textTheme: TextTheme(
                        bodyText1: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Abhaya_Libre',
                        ),
                        caption: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Abhaya_Libre',
                        ),
                        headline1: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Abhaya_Libre',
                        ),
                        headline2: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Abhaya_Libre',
                        ),
                        headline3: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Abhaya_Libre',
                        ),
                        headline4: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Abhaya_Libre',
                        ),
                        headline5: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Abhaya_Libre',
                        ),
                        headline6: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Abhaya_Libre',
                        ),
                        button:
                            TextStyle(color: Color.fromARGB(255, 251, 175, 93)),
                        subtitle1: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Abhaya_Libre',
                        ),
                        bodyText2: TextStyle(
                            color: Colors.white, fontFamily: 'Abhaya_Libre'))),
                routes: {
                  '/itemPage': (context) => ItemPage(),
                },
                //   '/signInPage': (context) => BackGround(
                //         cpi: false,
                //         vcenter: getScreenHeight / 4.5,
                //         hcenter: getScreenWidth / 2,
                //         child: SignInpage(),
                //         showLogo: true,
                //       ),
                //   '/signUpPage': (context) => BackGround(
                //         cpi: false,
                //         vcenter: getScreenHeight / 4.5,
                //         hcenter: getScreenWidth / 2,
                //         child: SignUppage(),
                //         showLogo: true,
                //       ),
                //   '/homePage': (context) => BackGround(
                //         child: HomePage(),
                //         showLogo: false,
                //       ),
                //   '/subServicePage': (context) => BackGround(
                //         child: SubServicePage(),
                //         showLogo: false,
                //       ),
                //   '/subServiceGallery': (context) => BackGround(
                //         child: SubServiceGallery(),
                //         showLogo: false,
                //       ),
                //   '/addDetailsPage': (context) => BackGround(
                //         child: AddDetailsPage(),
                //         showLogo: false,
                //       ),
                //   '/newPage': (context) => NewPage(),
                //   '/splashScreen': (context) => SplashScreen(),
                // },
                home: SplashScreen(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   bool _initialized = false;
//   bool _error = false;
//   bool _signedIn = false;

//   // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
//   Future<bool> fetchInitialData() async {
//     await Future.delayed(Duration(seconds: 10));
//     return Future.value(true);
//   }

//   final GlobalKey<StartPageState> _key = GlobalKey();

// @override
// void initState() {
//   // TODO: implement initState
//   initializeFlutterFire();
//   super.initState();
// }

//   Future<bool> checkSignUp() async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User? user = auth.currentUser;
//     bool val = false;
//     if (user != null) {
//       await checkSendEmailAndKeepChecking().then((value) {
//         val = value;
//         print(val);
//       });
//       print("hey");
//       return Future.value(val);
//     } else {
//       return Future.value(false);
//     }
//   }

// void initializeFlutterFire() async {
//   await Future.delayed(Duration(seconds: 10));
//   try {
//     // Wait for Firebase to initialize and set `_initialized` state to true
//     await Firebase.initializeApp();
//     // FirebaseAuth auth = FirebaseAuth.instance;
//     // auth.signOut();
//     // if (auth.currentUser != null) {
//     //   // signed in
//     //   // _userId = auth.currentUser.
//     //   _signedIn = true;
//     // } else {
//     //   _signedIn = false;
//     // }
//     setState(() {
//       _initialized = true;
//     });
//   } catch (e) {
//     // Set `_error` state to true if Firebase initialization fails
//     setState(() {
//       _error = true;
//     });
//   }
// }

//   @override
//   Widget build(BuildContext context) {
// setScreenHeight = MediaQuery.of(context).size.height;
// setScreenWidth = MediaQuery.of(context).size.width;

//     if (!_error) {
//       if (!_initialized) {
//         return BackGround(
//           cpi: true,
//           vcenter: getScreenHeight / 2,
//           hcenter: getScreenWidth / 2,
//           showLogo: true,
//           child: Center(child: Container()),
//         );
//       } else {
//         return FutureBuilder(
//           initialData: false,
//           future: checkSignUp(),
//           builder: (context, snapshot) {
//             FirebaseAuth auth = FirebaseAuth.instance;
//             if (snapshot.hasData) {
//               if (snapshot.data == true) {
//                 return BackGround(
//                   cpi: false,
//                   vcenter: getScreenHeight / 2,
//                   hcenter: getScreenWidth / 2,
//                   showLogo: false,
//                   child: HomePage(userId: auth.currentUser!.uid),
//                 );
//               } else {
//                 return BackGround(
//                   cpi: false,
//                   vcenter: getScreenHeight / 2,
//                   hcenter: getScreenWidth / 2,
//                   showLogo: false,
//                   child: Center(
//                       child: Container(
//                     child: Center(
//                       child: StartPage(
//                         key: _key,
//                       ),
//                     ),
//                   )),
//                 );
//               }
//             } else {
//               return BackGround(
//                 cpi: true,
//                 vcenter: getScreenHeight / 2,
//                 hcenter: getScreenWidth / 2,
//                 showLogo: true,
//                 child: Center(child: Container()),
//               );
//             }
//           },
//         );
//       }
//     }
//     //   else if (_signedIn) {
//     //     return BackGround(
//     //       cpi: false,
//     //       vcenter: getScreenHeight / 4.5,
//     //       hcenter: getScreenWidth / 2,
//     //       showLogo: true,
//     //       child: Center(child: HomePage()),
//     //     );
//     //   } else {
//     //     return BackGround(
//     //       cpi: false,
//     //       vcenter: getScreenHeight / 4,
//     //       hcenter: getScreenWidth / 2,
//     //       showLogo: false,
//     //       child: StartPage(
//     //         key: _key,
//     //       ),
//     //     );
//     //   }
//     // }
//     else {
//       return BackGround(
//         showLogo: true,
//         vcenter: getScreenHeight / 2,
//         hcenter: getScreenWidth / 2,
//         child: Center(
//             child: Container(
//           child: Text("404"),
//         )),
//       );
//     }
// if (_error) {
// return Scaffold(
//     body: BackGround(
//   showLogo: false,
//   child: Center(child: CircularProgressIndicator()),
// ));
// }

// // Show a loader until FlutterFire is initialized
// if (!_initialized) {
//   return Scaffold(
//       body: BackGround(
//     showLogo: false,
//     child: Center(child: CircularProgressIndicator()),
//   ));
// }

// return Scaffold(
//   body: BackGround(
//       showLogo: false,
//       child: Scaffold(
//         backgroundColor: Theme.of(context).backgroundColor,
//         body: Center(
//           child: FutureBuilder(
//             future: fetchInitialData(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 if (snapshot.data == true) {
// return StartPage(
//   key: _key,
// );
//                 } else {
//                   return Container(
//                     // color: ,
//                     height: getScreenHeight / 10,
//                     width: getScreenWidth / 1.5,
//                     color: Theme.of(context).dialogBackgroundColor,
//                     child: Center(
//                       child: Text('Could not fetch data'),
//                     ),
//                   );
//                 }
//               } else {
//                 return CircularProgressIndicator(
//                   backgroundColor: Colors.transparent,
//                 );
//               }
//             },
//           ),
//         ),
//       )),
// );
//   }
// }

// appBar: AppBar(
//   title: Text("GALLERY"),
//   bottom: PreferredSize(
//       child: Container(
//         color: Theme.of(context).primaryColor,
//         height: getScreenWidth / 100,
//       ),
//       preferredSize: Size(getScreenWidth, getScreenWidth / 100)),
//   leading: Icon(Icons.arrow_back),
// ),
