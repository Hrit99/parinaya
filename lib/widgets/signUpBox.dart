import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parinaya/constants/screendimensions.dart';
// import 'package:parinaya/models/UserDetailMap.dart';
// import 'package:parinaya/models/appUser.dart';
// import 'package:parinaya/widgets/calendarIcon.dart';
import 'package:parinaya/widgets/emailVerificationCheck.dart';
import 'package:parinaya/widgets/signFile.dart';
// import 'package:parinaya/widgets/whoIsUserTab.dart';

class SignUpBox extends StatefulWidget {
  const SignUpBox({Key? key}) : super(key: key);

  @override
  _SignUpBoxState createState() => _SignUpBoxState();
}

class _SignUpBoxState extends State<SignUpBox> {
  TextEditingController emailctr = new TextEditingController();
  TextEditingController pwctr = new TextEditingController();
  // WhoIsuser? whoIsUserHere;
  bool cpi = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool? linkSent = false;
  String? dispMes = " ";
  @override
  Widget build(BuildContext context) {
    return linkSent!
        ? Center(
            child: (dispMes! == "sending")
                ? Container(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Text(
                            "Sending verification link to ${emailctr.value.text}",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  )
                : Text(
                    dispMes!,
                    style: TextStyle(fontSize: 20),
                  ))
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              ElevatedButton(
                  onPressed: () {
                    // checkSendEmailAndKeepChecking(
                    //         email: emailctr.value.text, pw: pwctr.value.text)
                    //     .then((value) {
                    //       if(value != null){
                    //         value.
                    //       }
                    //     });
                    signUpUserUsingEmailPw(
                            emailctr.value.text, pwctr.value.text)
                        .then((value) {
                      if ((value["user"] is User) &&
                          (value["status"] == "successful")) {
                        signinUser(emailctr.value.text, pwctr.value.text)
                            .then((value) async {
                          if ((value["user"] is User) &&
                              (value["status"] == "successful")) {
                            checkSendEmailAndKeepChecking().then((value) async {
                              await auth.signOut();
                              await GoogleSignIn().signOut();

                              Future.delayed(Duration(seconds: 4))
                                  .then((value) => Navigator.of(context).pop());
                              setState(() {
                                dispMes = value["status"];
                              });
                            });
                          } else {
                            await auth.signOut();
                            await GoogleSignIn().signOut();

                            Future.delayed(Duration(seconds: 4))
                                .then((value) => Navigator.of(context).pop());
                            setState(() {
                              dispMes = "some error occured";
                            });
                          }
                        });
                        setState(() {
                          dispMes =
                              "Sent verification link to the email address";
                          linkSent = true;
                        });
                      } else {
                        Future.delayed(Duration(seconds: 4))
                            .then((value) => Navigator.of(context).pop());
                        setState(() {
                          dispMes = value["status"];
                        });
                      }
                    });
                    setState(() {
                      dispMes = "sending";
                      linkSent = true;
                    });
                  },
                  child: Text("Done"))
            ],
          );

    // return Container(
    //     padding: EdgeInsets.only(right: 0),
    //     height: getScreenHeight / 2.2,
    //     width: getScreenWidth / 1.3,
    //     color: Theme.of(context).primaryColor.withOpacity(0.1),
    //     child: RawScrollbar(
    //       isAlwaysShown: true,
    //       radius: Radius.circular(20),
    //       controller: _scrollController,
    //       thickness: 10,
    //       thumbColor: Theme.of(context).primaryColor,
    //       child: SingleChildScrollView(
    //         controller: _scrollController,
    //         child: Wrap(
    //             alignment: WrapAlignment.center,
    //             runAlignment: WrapAlignment.spaceAround,
    //             children: [
    //               ListTile(
    //                 title: TextFormField(
    //                   // style: TextStyle(textBaseline: TextBas),
    //                   keyboardType: TextInputType.name,
    //                   controller: namectr,
    //                   cursorColor: Theme.of(context).primaryColor,

    //                   style: TextStyle(color: Theme.of(context).primaryColor),
    //                   decoration: InputDecoration(
    //                     // border: InputBorder.none,
    //                     hintText: "Name",
    //                   ),
    //                 ),
    //               ),
    //               ListTile(
    //                 title: TextField(
    //                   keyboardType: TextInputType.emailAddress,
    //                   // style: TextStyle(textBaseline: TextBas),
    //                   controller: emailctr,
    //                   cursorColor: Theme.of(context).primaryColor,
    //                   style: TextStyle(color: Theme.of(context).primaryColor),
    //                   decoration: InputDecoration(
    //                     hintText: "Email",
    //                   ),
    //                 ),
    //               ),
    //               ListTile(
    //                 title: TextField(
    //                   keyboardType: TextInputType.visiblePassword,
    //                   // style: TextStyle(textBaseline: TextBas),
    //                   controller: pwctr,
    //                   cursorColor: Theme.of(context).primaryColor,
    //                   style: TextStyle(color: Theme.of(context).primaryColor),
    //                   decoration: InputDecoration(
    //                     hintText: "Password",
    //                   ),
    //                 ),
    //               ),
    //               WhoIsUserTab(),
    //               CalendarIcon(),
    //               // ListTile(
    //               //   // title: InputDatePickerFormField(
    //               //   //   // style: TextStyle(textBaseline: TextBas),
    //               //   //   // cursorColor: Theme.of(context).primaryColor,
    //               //   //   // keyboardType: TextInputType.datetime,
    //               //   //   // style: TextStyle(
    //               //   //   //     color: Theme.of(context).primaryColor),
    //               //   //   // decoration: InputDecoration(
    //               //   //   //   hintText: "Wedding Date",
    //               //   //   // ),
    //               //   //   firstDate: DateTime.now(),
    //               //   //   lastDate: DateTime(2050),
    //               //   //   fieldHintText: "01/01/2020",
    //               //   //   // initialDate: DateTime.now(),
    //               //   //   errorInvalidText: "Invalid date",
    //               //   //   errorFormatText: "Invalid format",
    //               //   // ),
    //               //   title: Center(
    //               //     child: Icon(Icons.calendar_today_rounded),
    //               //   ),
    //               // ),
    //               ListTile(
    //                 title: TextField(
    //                   controller: cityctr,
    //                   // style: TextStyle(textBaseline: TextBas),
    //                   keyboardType: TextInputType.name,
    //                   cursorColor: Theme.of(context).primaryColor,
    //                   style: TextStyle(color: Theme.of(context).primaryColor),
    //                   decoration: InputDecoration(
    //                     hintText: "City",
    //                   ),
    //                 ),
    //               ),
    //               ListTile(
    //                 title: TextField(
    //                   controller: countryctr,
    //                   // style: TextStyle(textBaseline: TextBas),
    //                   cursorColor: Theme.of(context).primaryColor,
    //                   keyboardType: TextInputType.name,
    //                   style: TextStyle(color: Theme.of(context).primaryColor),
    //                   decoration: InputDecoration(
    //                     hintText: "Country",
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(height: getScreenHeight / 10),
    //               ElevatedButton(
    //                   onPressed: () {
    //                     userDetailMap.addAll({
    //                       "name": namectr.value.text,
    //                       "email": emailctr.value.text,
    //                       "password": pwctr.value.text,
    //                       "city": cityctr.value.text,
    //                       "country": countryctr.value.text,
    //                     });
    //                     // _signUpUser().then((value) {
    //                     //   // if (value) {
    //                     //   //   signinUser(emailctr.value.text,
    //                     //   //           pwctr.value.text)
    //                     //   //       .then((value) {
    //                     //   //     if (value) {
    //                     //   //       verifyUser().then((value) {
    //                     //   //         print("helllllo");
    //                     //   //       });
    //                     //   //     } else {}
    //                     //   //   });
    //                     //   // } else {
    //                     //   //   namectr.clear();
    //                     //   //   emailctr.clear();
    //                     //   //   pwctr.clear();
    //                     //   // }
    //                     //   print(value);
    //                     //   print("going to change page");
    //                     //   _key.currentState!.resetCenter();
    //                     //   Navigator.of(context).pop();
    //                     //   // }
    //                     // });
    //                     setState(() {
    //                       cpi = true;
    //                     });
    //                   },
    //                   child: Text('Sign Up')),
    //             ]),
    //       ),
    //     ));
  }
}
