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
                home: SplashScreen(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
