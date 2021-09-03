import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:parinaya/constants/screendimensions.dart';
// import 'package:parinaya/models/UserDetailMap.dart';
// import 'package:parinaya/models/appUser.dart';
import 'package:parinaya/models/colors.dart';
// import 'package:parinaya/pages/startPage.dart';
// import 'package:parinaya/widgets/calendarIcon.dart';
import 'package:parinaya/widgets/signUpBox.dart';
// import 'package:parinaya/widgets/signin.dart';
// import 'package:parinaya/widgets/verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:parinaya/widgets/whoIsUserTab.dart';

// class SignUppage extends StatefulWidget {
//   const SignUppage({Key? key}) : super(key: key);

//   @override
//   _SignUppageState createState() => _SignUppageState();
// }

class SignUppage extends StatefulWidget {
  @override
  _SignUppageState createState() => _SignUppageState();
}

class _SignUppageState extends State<SignUppage> {
  bool? _keyboardVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();
    // Query
    print(
        'Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');

    // Subscribe
    keyboardVisibilityController.onChange.listen((bool visible) {
      print("jk");
      setState(() {
        _keyboardVisible = visible;
      });
      print('Keyboard visibility update. Is visible: ${visible}');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final _key =
    //     ModalRoute.of(context)!.settings.arguments as GlobalKey<StartPageState>;

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
        appBar: AppBar(
          title: Text("Sign up"),
          bottom: PreferredSize(
              child: Container(
                color: Theme.of(context).primaryColor,
                height: 3,
              ),
              preferredSize: Size(getScreenWidth, getScreenWidth / 100)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Stack(
          children: [
            Positioned(
              top: getScreenHeight / 30,
              left: (getScreenWidth / 2) - (getScreenWidth / 6),
              child: _keyboardVisible!
                  ? Container()
                  : Hero(
                      tag: "logo",
                      child: Center(
                        child: Container(
                          width: getScreenWidth / 3,
                          height: getScreenWidth / 3,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/icon.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
            AnimatedPositioned(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              top: _keyboardVisible!
                  ? getScreenHeight / 20
                  : (getScreenHeight / 15) + (getScreenWidth / 3),
              left: 0,
              child: Container(
                height: getScreenHeight / 3,
                width: getScreenWidth,
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                child: Center(
                    child: Container(
                  width: getScreenWidth / 1.3,
                  child: SignUpBox(),
                )),
              ),
            )
          ],
        ),
        // body: Stack(children: [
        //   Positioned(
        //     top: getScreenHeight / 30,
        //     child: Container(
        //       width: getScreenWidth,
        //       height: getScreenHeight / 1.4,
        //       // color: Colors.red,
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        // Hero(
        //   tag: "logo",
        //   child: Center(
        //     child: Container(
        //       width: getScreenWidth / 3,
        //       height: getScreenWidth / 3,
        //       decoration: BoxDecoration(
        //           color: Colors.transparent, shape: BoxShape.circle),
        //       child: Center(
        //         child: Image.asset(
        //           'assets/icons/icon.png',
        //           fit: BoxFit.fill,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        //     SizedBox(
        //       height: getScreenHeight / 20,
        //     ),
        //     SignUpBox()
        //   ],
        // ),
        //     ),
        //   ),
        // ]),
      ),
    );
  }
}

//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//                 title: Text("Sign Up"),
//                 bottom: PreferredSize(
//                     child: Container(
//                       color: Theme.of(context).primaryColor,
//                       height: 3,
//                     ),
//                     preferredSize: Size(getScreenWidth, getScreenWidth / 100)),
//                 leading: IconButton(
//                   icon: Icon(Icons.arrow_back),
//                   onPressed: () {
//                     // _key.currentState!.resetCenter();
//                     // Navigator.of(context).pop();
//                   },
//                 ),
//               ),
//         body: Stack(children: [
//                 Positioned(
//                   top: (getScreenHeight / 5),
//                   left: (3 * getScreenWidth) / 26,
//                   child: Container(
//                       padding: EdgeInsets.only(right: 0),
//                       height: getScreenHeight / 2.2,
//                       width: getScreenWidth / 1.3,
//                       color: Theme.of(context).primaryColor.withOpacity(0.1),
//                       child: RawScrollbar(
//                         isAlwaysShown: true,
//                         radius: Radius.circular(20),
//                         controller: _scrollController,
//                         thickness: 10,
//                         thumbColor: Theme.of(context).primaryColor,
//                         child: SingleChildScrollView(
//                           controller: _scrollController,
//                           child: Wrap(
//                               alignment: WrapAlignment.center,
//                               runAlignment: WrapAlignment.spaceAround,
//                               children: [
//                                 ListTile(
//                                   title: TextFormField(
//                                     // style: TextStyle(textBaseline: TextBas),
//                                     keyboardType: TextInputType.name,
//                                     controller: namectr,
//                                     cursorColor: Theme.of(context).primaryColor,

//                                     style: TextStyle(
//                                         color: Theme.of(context).primaryColor),
//                                     decoration: InputDecoration(
//                                       // border: InputBorder.none,
//                                       hintText: "Name",
//                                     ),
//                                   ),
//                                 ),
//                                 ListTile(
//                                   title: TextField(
//                                     keyboardType: TextInputType.emailAddress,
//                                     // style: TextStyle(textBaseline: TextBas),
//                                     controller: emailctr,
//                                     cursorColor: Theme.of(context).primaryColor,
//                                     style: TextStyle(
//                                         color: Theme.of(context).primaryColor),
//                                     decoration: InputDecoration(
//                                       hintText: "Email",
//                                     ),
//                                   ),
//                                 ),
//                                 ListTile(
//                                   title: TextField(
//                                     keyboardType: TextInputType.visiblePassword,
//                                     // style: TextStyle(textBaseline: TextBas),
//                                     controller: pwctr,
//                                     cursorColor: Theme.of(context).primaryColor,
//                                     style: TextStyle(
//                                         color: Theme.of(context).primaryColor),
//                                     decoration: InputDecoration(
//                                       hintText: "Password",
//                                     ),
//                                   ),
//                                 ),
//                                 WhoIsUserTab(),
//                                 CalendarIcon(),
//                                 // ListTile(
//                                 //   // title: InputDatePickerFormField(
//                                 //   //   // style: TextStyle(textBaseline: TextBas),
//                                 //   //   // cursorColor: Theme.of(context).primaryColor,
//                                 //   //   // keyboardType: TextInputType.datetime,
//                                 //   //   // style: TextStyle(
//                                 //   //   //     color: Theme.of(context).primaryColor),
//                                 //   //   // decoration: InputDecoration(
//                                 //   //   //   hintText: "Wedding Date",
//                                 //   //   // ),
//                                 //   //   firstDate: DateTime.now(),
//                                 //   //   lastDate: DateTime(2050),
//                                 //   //   fieldHintText: "01/01/2020",
//                                 //   //   // initialDate: DateTime.now(),
//                                 //   //   errorInvalidText: "Invalid date",
//                                 //   //   errorFormatText: "Invalid format",
//                                 //   // ),
//                                 //   title: Center(
//                                 //     child: Icon(Icons.calendar_today_rounded),
//                                 //   ),
//                                 // ),
//                                 ListTile(
//                                   title: TextField(
//                                     controller: cityctr,
//                                     // style: TextStyle(textBaseline: TextBas),
//                                     keyboardType: TextInputType.name,
//                                     cursorColor: Theme.of(context).primaryColor,
//                                     style: TextStyle(
//                                         color: Theme.of(context).primaryColor),
//                                     decoration: InputDecoration(
//                                       hintText: "City",
//                                     ),
//                                   ),
//                                 ),
//                                 ListTile(
//                                   title: TextField(
//                                     controller: countryctr,
//                                     // style: TextStyle(textBaseline: TextBas),
//                                     cursorColor: Theme.of(context).primaryColor,
//                                     keyboardType: TextInputType.name,
//                                     style: TextStyle(
//                                         color: Theme.of(context).primaryColor),
//                                     decoration: InputDecoration(
//                                       hintText: "Country",
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: getScreenHeight / 10),
//                                 ElevatedButton(
//                                     onPressed: () {
//                                       userDetailMap.addAll({
//                                         "name": namectr.value.text,
//                                         "email": emailctr.value.text,
//                                         "password": pwctr.value.text,
//                                         "city": cityctr.value.text,
//                                         "country": countryctr.value.text,
//                                       });
//                                       _signUpUser().then((value) {
//                                         // if (value) {
//                                         //   signinUser(emailctr.value.text,
//                                         //           pwctr.value.text)
//                                         //       .then((value) {
//                                         //     if (value) {
//                                         //       verifyUser().then((value) {
//                                         //         print("helllllo");
//                                         //       });
//                                         //     } else {}
//                                         //   });
//                                         // } else {
//                                         //   namectr.clear();
//                                         //   emailctr.clear();
//                                         //   pwctr.clear();
//                                         // }
//                                         print(value);
//                                         print("going to change page");
//                                         _key.currentState!.resetCenter();
//                                         Navigator.of(context).pop();
//                                         // }
//                                       });
//                                       setState(() {
//                                         cpi = true;
//                                       });
//                                     },
//                                     child: Text('Sign Up')),
//                               ]),
//                         ),
//                       )),
//                 ),
//               ]));
//   }

//   Future<void> addUserDetails(
//       CollectionReference<Map<String, dynamic>> users, User? user) {
//     // Call the user's CollectionReference to add a new user
//     print("in");
//     userDetailMap.update(
//       "uid",
//       (value) {
//         return user!.uid;
//       },
//       ifAbsent: () {
//         return user!.uid;
//       },
//     );
//     return users
//         .add(userDetailMap)
//         .then((value) => print("User Added"))
//         .catchError((error) {
//       print("Failed to add user: $error");
//       setState(() {});
//     });
//   }

//   // Future<void> waitForEmailVerification(User user) async {
//   //   await Future.delayed(Duration(seconds: 10));
//   //   if (user.emailVerified)
//   //     return;
//   //   else
//   //     waitForEmailVerification(user);
//   // }

//   Future<bool> _signUpUser() async {
//     // CollectionReference users = FirebaseFirestore.instance.collection('users');
//     // users.add({
//     //   'name': namectr.value.text,
//     //   ''
//     // })

//     print(emailctr.value.text);
//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: emailctr.value.text, password: pwctr.value.text);
//       print("registration done");
//       await signinUser(emailctr.value.text, pwctr.value.text);

//       User? user = FirebaseAuth.instance.currentUser;
//       print(user!.email);
//       if (user != null && !user.emailVerified) {
//         await user.sendEmailVerification();
//       }
//       while (!user!.emailVerified) {
//         FirebaseAuth.instance.signOut();
//         await signinUser(emailctr.value.text, pwctr.value.text);
//         user = FirebaseAuth.instance.currentUser;
//         print(!user!.emailVerified);
//         await Future.delayed(Duration(seconds: 5));
//       }
//       FirebaseAuth.instance.signOut();

//       CollectionReference<Map<String, dynamic>> users =
//           FirebaseFirestore.instance.collection('users');
//       addUserDetails(users, user);
//       return Future.value(true);
//     } on FirebaseAuthException catch (e) {
//       print("hola");
//       if (e.code == 'weak-password') {
//         print('The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         print('The account already exists for that email.');
//       }
//       return Future.value(false);
//     } catch (e) {
//       print("hol");
//       print(e);
//       return Future.value(false);
//     }
//   }
// }
