import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parinaya/constants/screendimensions.dart';

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
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/startPage', (route) => false);
            },
            child: Text("Signout")),
      ),
    );
  }
}
