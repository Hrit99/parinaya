import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/pages/startPage.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getScreenHeight,
      width: getScreenWidth,
      child: Center(
        child: ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  PageRouteBuilder(
                      transitionDuration: Duration(seconds: 1),
                      opaque: false,
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          StartPage()),
                  (Route<dynamic> route) => false);
            },
            child: Text("Signout")),
      ),
    );
  }
}
