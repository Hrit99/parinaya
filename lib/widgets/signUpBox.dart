import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/widgets/buttons.dart';
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
                title: Container(
                  height: getScreenHeight / 20,
                  child: TextField(
                    cursorWidth: 1,
                    // obscureText: true,
                    // style: TextStyle(decoration: TextDecoration.none),
                    controller: emailctr,
                    keyboardType: TextInputType.emailAddress,
                    // style: TextStyle(textBaseline: TextBas),
                    cursorColor: Theme.of(context).primaryColor,
                    // style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
                    // style: TextStyle(color: Theme.of(context).primaryColor),
                    // style: TextStyle(textBaseline: TextBas),
                    decoration: InputDecoration(
                      hintText: "New Password",
                    ),
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
                              showDialog(
                                  context: context,
                                  builder: (_) => Dialog(
                                          child: Container(
                                        height: getScreenHeight / 5,
                                        width: getScreenWidth / 1.5,
                                        alignment: Alignment.center,
                                        color: Colors.black.withOpacity(0.6),
                                        child: Text(value["status"],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                      )));
                              setState(() {
                                dispMes = value["status"];
                                linkSent = false;
                              });
                            });
                          } else {
                            await auth.signOut();
                            await GoogleSignIn().signOut();

                            Future.delayed(Duration(seconds: 4))
                                .then((value) => Navigator.of(context).pop());
                            showDialog(
                                context: context,
                                builder: (_) => Dialog(
                                        child: Container(
                                      height: getScreenHeight / 5,
                                      width: getScreenWidth / 1.5,
                                      alignment: Alignment.center,
                                      color: Colors.black.withOpacity(0.6),
                                      child: Text('Some error occured',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                    )));
                            setState(() {
                              dispMes = "some error occured";
                              linkSent = false;
                            });
                          }
                        });
                        showDialog(
                            context: context,
                            builder: (_) => Dialog(
                                    child: Container(
                                  height: getScreenHeight / 5,
                                  width: getScreenWidth / 1.5,
                                  alignment: Alignment.center,
                                  color: Colors.black.withOpacity(0.6),
                                  child: Text(
                                      'Verification link sent to your mail \n Please wait...',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              Theme.of(context).primaryColor)),
                                )));
                        setState(() {
                          dispMes = " ";
                          linkSent = true;
                        });
                      } else {
                        Future.delayed(Duration(seconds: 4))
                            .then((value) => Navigator.of(context).pop());
                        showDialog(
                            context: context,
                            builder: (_) => Dialog(
                                    child: Container(
                                  height: getScreenHeight / 5,
                                  width: getScreenWidth / 1.5,
                                  alignment: Alignment.center,
                                  color: Colors.black.withOpacity(0.6),
                                  child: Text(value["status"],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              Theme.of(context).primaryColor)),
                                )));
                        setState(() {
                          dispMes = value["status"];
                          linkSent = false;
                        });
                      }
                    });
                    setState(() {
                      dispMes = "sending";
                      linkSent = true;
                    });
                  },
                  child: LocalButton(title: 'Done')),
            ],
          );
  }
}
