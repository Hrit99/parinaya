import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:parinaya/models/appUser.dart';
import 'package:parinaya/pages/homePage.dart';
import 'package:parinaya/pages/landingPage.dart';
import 'package:parinaya/widgets/signFile.dart';
// import 'package:parinaya/widgets/signin.dart';

class SigninboxPhone extends StatefulWidget {
  final bool? isPhone;
  SigninboxPhone({Key? key, this.isPhone}) : super(key: key);

  @override
  _SigninboxPhoneState createState() => _SigninboxPhoneState();
}

class _SigninboxPhoneState extends State<SigninboxPhone> {
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  // Future<UserCredential> signInAnonymous() async {
  //   UserCredential userCredential =
  //       await FirebaseAuth.instance.signInAnonymously().then((value) {
  //     print(value.credential!.token);
  //     return value;
  //   }).catchError((_) {
  //     print("err");
  //   });
  //   return Future.value(userCredential);
  // }
  // Future<void> signInWithEmailPassword(email, pw) async {
  //   try {
  //     await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(
  //       email: email,
  //       password: pw,
  //     )
  //         .then((value) {
  //       Navigator.of(context).popAndPushNamed('/homePage', arguments: value);
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       print('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       print('Wrong password provided for that user.');
  //     }
  //   }
  // }

  TextEditingController emailctr = TextEditingController();
  TextEditingController pwctr = TextEditingController();
  bool cpi = false;
  String? dispMes = "";
  @override
  Widget build(BuildContext context) {
    print(widget.isPhone);
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.2),
      height: getScreenHeight / 2,
      child: Center(
        child: Container(
          height: getScreenHeight / 2,
          width: getScreenWidth / 1.3,
          child: (cpi)
              ? Center(
                  child: (dispMes == "progress")
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              CircularProgressIndicator(),
                              Text(
                                dispMes!,
                                style: TextStyle(fontSize: 20),
                              )
                            ])
                      : Text(
                          dispMes!,
                          style: TextStyle(fontSize: 20),
                        ))
              : Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.spaceAround,
                  children: [
                    ListTile(
                      title: TextField(
                        controller: emailctr,
                        keyboardType: TextInputType.emailAddress,
                        // style: TextStyle(textBaseline: TextBas),
                        cursorColor: Theme.of(context).primaryColor,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        decoration: InputDecoration(
                          hintText: "Email",
                        ),
                      ),
                    ),
                    ListTile(
                      title: TextField(
                        controller: pwctr,
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: Theme.of(context).primaryColor,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                        // style: TextStyle(textBaseline: TextBas),
                        decoration: InputDecoration(
                          hintText: "Password",
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              signinUser(emailctr.value.text, pwctr.value.text)
                                  .then((value) {
                                print(value['status']);
                                if ((value["user"] is User) &&
                                    (value["status"] == "successful")) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      PageRouteBuilder(
                                          transitionDuration:
                                              Duration(seconds: 1),
                                          opaque: false,
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              LandingPage()),
                                      (Route<dynamic> route) => false);
                                } else {
                                  Future.delayed(Duration(seconds: 4)).then(
                                      (value) => Navigator.of(context).pop());
                                  setState(() {
                                    dispMes = value["status"];
                                  });
                                }
                              });
                              setState(() {
                                cpi = true;
                                dispMes = "progress";
                              });
                              // Navigator.of(context).popAndPushNamed('/homePage');
                              print("hello");
                              // signinUser(emailctr.value.text, pwctr.value.text)
                              //     .then((value) async {
                              //   print("s");
                              //   print(value);
                              //   if (value) {
                              //     // print(value);
                              //     // User? user =
                              //     //     FirebaseAuth.instance.currentUser;
                              //     // if (user != null && !user.emailVerified) {
                              //     //   await user.sendEmailVerification();
                              //     // }
                              //     // print(!user!.emailVerified);
                              //     // while (!user!.emailVerified) {
                              //     //   FirebaseAuth.instance.signOut();
                              //     //   await signinUser(
                              //     //       emailctr.value.text, pwctr.value.text);
                              //     //   user = FirebaseAuth.instance.currentUser;
                              //     //   print(!user!.emailVerified);
                              //     //   await Future.delayed(Duration(seconds: 5));
                              //     // }
                              //     Navigator.of(context).pushAndRemoveUntil(
                              //         PageRouteBuilder(
                              //           transitionDuration:
                              //               Duration(seconds: 3),
                              //           opaque: false,
                              //           pageBuilder: (context, animation,
                              //                   secondaryAnimation) =>
                              //               HomePage(),
                              //         ),
                              //         (Route<dynamic> route) => false);
                              //   } else {
                              //     setState(() {
                              //       cpi = false;
                              //     });
                              //   }
                              // });
                              // setState(() {
                              //   cpi = true;
                              // });
                            },
                            child: Text('Sign In')),
                        InkWell(
                          child: Container(
                              margin: EdgeInsets.all(10),
                              width: getScreenWidth / 2,
                              height: getScreenHeight / 18,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.7),
                              ),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: 30.0,
                                    width: 30.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/icons/googleLogo.png'),
                                          fit: BoxFit.cover),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Sign in with Google ',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ))),
                          onTap: () async {
                            // signInWithGoogle(model)
                            //   .then((FirebaseUser user){
                            // model.clearAllModels();
                            // Navigator.of(context).pushNamedAndRemoveUntil
                            //   (RouteName.Home, (Route<dynamic> route) => false
                            // );}
                            // ).catchError((e) => print(e));
                            signInWithGoogle().then((value) {
                              print(value.user!.email);
                              Navigator.of(context).pushAndRemoveUntil(
                                  PageRouteBuilder(
                                      transitionDuration: Duration(seconds: 1),
                                      opaque: false,
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          LandingPage()),
                                  (Route<dynamic> route) => false);
                            });
                            setState(() {
                              cpi = true;
                              dispMes = "progress";
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

//  InkWell(
//                 child: Container(
//                     width: getScreenWidth / 2,
//                     height: getScreenHeight / 18,
//                     margin: EdgeInsets.only(top: 25),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Colors.black),
//                     child: Center(
//                         child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         Container(
//                           height: 30.0,
//                           width: 30.0,
//                           // decoration: BoxDecoration(
//                           // image: DecorationImage(
//                           //       image:
//                           //           AssetImage('assets/icons/googleLogo.png'),
//                           //       fit: BoxFit.cover),
//                           //   shape: BoxShape.circle,
//                           // ),
//                         ),
//                         Text(
//                           'Sign in Anonymously',
//                           style: TextStyle(
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white),
//                         ),
//                       ],
//                     ))),
//                 onTap: () async {
//                   // signInWithGoogle(model)
//                   //   .then((FirebaseUser user){
//                   // model.clearAllModels();
//                   // Navigator.of(context).pushNamedAndRemoveUntil
//                   //   (RouteName.Home, (Route<dynamic> route) => false
//                   // );}
//                   // ).catchError((e) => print(e));
//                   signInWithGoogle().then((value) {
//                     print(value.credential!.token);
//                     if (value.additionalUserInfo!.isNewUser) {
//                       print("is new user");
//                     } else {
//                       print("is old user");
//                     }
//                   });
//                 },
//               ),