import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/colors.dart';
import 'package:parinaya/models/initDataSet.dart';
import 'package:parinaya/models/userDetail.dart';
import 'package:parinaya/pages/detailsPage.dart';
import 'package:parinaya/pages/homePage.dart';
import 'package:parinaya/pages/startPage.dart';
import 'package:parinaya/widgets/emailVerificationCheck.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("kdkdk");
    print(auth.currentUser!.email);
    checkEmailVerified().then((value) {
      print(1);
      print(value);
      if (value) {
        setState(() {
          dispMes = "Email Verified checking if details present";
        });
        checkIfDetailsPresent().then((value) async {
          await getInitdata();
          print(2);
          print(value);
          if (value.isEmpty) {
            print("getDetails");
            Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(
                    transitionDuration: Duration(seconds: 1),
                    opaque: false,
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        DetailsPage()),
                (Route<dynamic> route) => false);
          } else {
            uname = value['name'];
            ulocation = value['location'];
            ueventType = value['event'];
            upplink = value['profilepic'];
            udate = (value['date'] as Timestamp).toDate();
            print(udate);
            print("go to homepage");
            Navigator.of(context).pushAndRemoveUntil(
                PageRouteBuilder(
                    transitionDuration: Duration(seconds: 1),
                    opaque: false,
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        HomePage()),
                (Route<dynamic> route) => false);
          }
        });
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            PageRouteBuilder(
                transitionDuration: Duration(seconds: 1),
                opaque: false,
                pageBuilder: (context, animation, secondaryAnimation) =>
                    StartPage()),
            (Route<dynamic> route) => false);
      }
    });
  }

  Future<Map<String, dynamic>> checkIfDetailsPresent() async {
    print(auth.currentUser!.uid);
    try {
      DocumentSnapshot<Map<String, dynamic>> value = await firestore
          .collection("users")
          .doc("/${auth.currentUser!.uid}")
          .get();
      print(value.data());
      if (value.data() == null) {
        return Future.value({});
      }
      return Future.value(value.data());
    } catch (e) {
      return Future.value({});
    }
  }

  Future<bool> checkEmailVerified() async {
    if (auth.currentUser!.emailVerified) {
      return Future.value(true);
    } else {
      setState(() {
        dispMes = "Sent email verification link";
      });
      Map<String, dynamic> value = await checkSendEmailAndKeepChecking();
      if (value['status'] == "successful") {
        return Future.value(true);
      } else {
        setState(() {
          dispMes = value['status'];
        });
        await Future.delayed(Duration(seconds: 3));
        return Future.value(false);
      }
    }
  }

  Future<void> getInitdata() async {
    await FirebaseFirestore.instance
        .collection('/eventType')
        .get()
        .then((value) {
      events = value.docs.map((e) => e['name'].toString()).toList();
    });
    await FirebaseFirestore.instance
        .collection('/location')
        .get()
        .then((value) {
      locations = value.docs.map((e) => e['name'].toString()).toList();
    });
  }

  String? dispMes = "Verifying email";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: getScreenHeight,
        width: getScreenWidth,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    MyColors().backgroundtouch!, BlendMode.darken))),
        child: Center(
          child: Container(
            height: getScreenHeight / 5,
            width: getScreenHeight / 5,
            // color: Colors.red,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: getScreenHeight / 20,
                      width: getScreenHeight / 20,
                      child: CircularProgressIndicator()),
                  Container(
                    height: getScreenHeight / 20,
                    width: getScreenWidth / 2,
                    // color: Colors.green,
                    child: Center(
                        child: Text(
                      dispMes!,
                      textAlign: TextAlign.center,
                    )),
                  ),
                  // Text(dispMes!)
                ]),
          ),
        ),
      ),
    );
  }
}
