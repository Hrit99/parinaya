import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:parinaya/models/appUser.dart';
import 'package:parinaya/pages/homePage.dart';
import 'package:parinaya/pages/landingPage.dart';
import 'package:parinaya/pages/phoneSignin.dart';
import 'package:parinaya/widgets/buttons.dart';
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

  TextEditingController emailctr = TextEditingController();
  TextEditingController pwctr = TextEditingController();
  bool cpi = false;
  String? dispMes = "";
  @override
  Widget build(BuildContext context) {
    print(widget.isPhone);
    return Container(
      // color: Colors.red,
      height: getScreenHeight / 1.8,
      child: Center(
        child: Container(
          height: getScreenHeight / 1.8,
          width: getScreenWidth / 1.3,
          child: (cpi)
              ? Center(
                  child: (dispMes == "progress")
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              SizedBox(
                                height: (getScreenHeight / 2) -
                                    ((getScreenHeight / 10) +
                                        (getScreenWidth / 3)) -
                                    getScreenHeight / 10,
                              ),
                              CircularProgressIndicator(),
                            ])
                      : Text(
                          dispMes!,
                          style: TextStyle(fontSize: 20),
                        ))
              : Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.spaceBetween,
                  children: [
                    Container(
                      height: getScreenHeight / 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ListTile(
                            title: Container(
                              height: getScreenHeight / 20,
                              child: TextField(
                                cursorWidth: 1,
                                controller: emailctr,
                                keyboardType: TextInputType.emailAddress,
                                // style: TextStyle(textBaseline: TextBas),
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                              title: Container(
                            height: getScreenHeight / 20,
                            child: TextField(
                              cursorWidth: 1,
                              obscureText: true,
                              controller: pwctr,
                              keyboardType: TextInputType.visiblePassword,
                              cursorColor: Theme.of(context).primaryColor,
                              // style: TextStyle(textBaseline: TextBas),
                              decoration: InputDecoration(
                                hintText: "Password",
                              ),
                            ),
                          )),
                          ElevatedButton(
                              onPressed: () {
                                signinUser(
                                        emailctr.value.text, pwctr.value.text)
                                    .then((value) {
                                  print(value['status']);
                                  if ((value["user"] is User) &&
                                      (value["status"] == "successful")) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        PageTransition(
                                            curve: Curves.easeInOut,
                                            // duration: Duration(milliseconds: 400),
                                            type:
                                                PageTransitionType.leftToRight,
                                            child: LandingPage()),
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
                              },
                              child: LocalButton(title: 'Sign In')),
                        ],
                      ),
                    ),
                    Container(
                      height: getScreenHeight / 5,
                      padding: EdgeInsets.only(bottom: 30),
                      // color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            child: Container(
                                margin: EdgeInsets.all(0),
                                width: getScreenWidth / 2,
                                height: getScreenHeight / 18,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromARGB(255, 251, 175, 93),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black.withOpacity(0.7),
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
                                            color: Colors.white),
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
                                    PageTransition(
                                        curve: Curves.easeInOut,
                                        // duration: Duration(milliseconds: 400),
                                        type: PageTransitionType.leftToRight,
                                        child: LandingPage()),
                                    (Route<dynamic> route) => false);
                              });
                              setState(() {
                                cpi = true;
                                dispMes = "progress";
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            child: Container(
                                margin: EdgeInsets.all(0),
                                width: getScreenWidth / 2,
                                height: getScreenHeight / 18,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromARGB(255, 251, 175, 93),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black.withOpacity(0.7),
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
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        'Sign in with Phone ',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ))),
                            onTap: () {
                              Navigator.of(context).push(PageTransition(
                                  curve: Curves.easeInOut,
                                  // duration: Duration(milliseconds: 400),
                                  type: PageTransitionType.leftToRight,
                                  child: PhoneSignin()));
                            },
                          ),
                        ],
                      ),
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
