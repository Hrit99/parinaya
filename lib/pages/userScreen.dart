import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/initDataSet.dart';
import 'package:parinaya/models/userDetail.dart';
import 'package:parinaya/models/userDetailMap.dart';
import 'package:parinaya/pages/startPage.dart';
import 'package:parinaya/widgets/addFile.dart';
import 'package:parinaya/widgets/buttons.dart';
import 'package:parinaya/widgets/dropDownTile.dart';
import 'package:intl/intl.dart';
import 'package:parinaya/widgets/imageUploadWidget.dart';
import 'package:parinaya/widgets/capitalize.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool? edit = false;
  bool? cpi = false;
  bool? _keyboardVisible = false;
  TextEditingController? qsctr;
  TextEditingController? nctr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nctr = new TextEditingController();
    qsctr = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    print(DateFormat('yyyy-MM-dd').format(udate!));
    // print(sdate);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('My Profile'),
        bottom: PreferredSize(
            child: Container(
              color: Theme.of(context).primaryColor,
              height: 1,
            ),
            preferredSize: Size(getScreenWidth, getScreenWidth / 100)),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
      ),
      body: Stack(children: [
        Positioned(
          bottom: 0,
          child: Container(
            height: getScreenHeight / 1.2,
            width: getScreenWidth,
            // color: Colors.green,
            child: cpi!
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: edit!
                        ? SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Text('Edit Profile'),
                                Container(
                                  height: getScreenHeight / 5,
                                ),
                                Container(
                                  height: getScreenWidth / 3,
                                  width: getScreenWidth / 3,
                                  // color: Colors.red,
                                  child: Stack(children: [
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        height: getScreenWidth / 3,
                                        width: getScreenWidth / 3,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: CircleAvatar(
                                          maxRadius: getScreenWidth / 5,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  upplink!),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: IconButton(
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.black,
                                                size: 15,
                                              ),
                                              onPressed: () {
                                                changedp();
                                                setState(() {
                                                  upplink =
                                                      "https://firebasestorage.googleapis.com/v0/b/parinaya-a8548.appspot.com/o/ppicon.png?alt=media&token=5bd13fa7-e091-452b-98ff-32f375ef0ad2";
                                                });
                                              }),
                                        ))
                                  ]),
                                ),
                                Container(
                                  height: getScreenHeight / 60,
                                ),
                                // TextButton(
                                //     onPressed: () {},
                                //     child: Text("Edit Profile",
                                //         style: TextStyle(color: Theme.of(context).primaryColor))),
                                Container(
                                  height: getScreenHeight / 20,
                                ),
                                ListTile(
                                  title: TextField(
                                    controller: nctr,
                                    keyboardType: TextInputType.emailAddress,
                                    // style: TextStyle(textBaseline: TextBas),
                                    cursorColor: Theme.of(context).primaryColor,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                    decoration: InputDecoration(
                                      hintText: "Name",
                                    ),
                                  ),
                                ),
                                DropDownTile(l: events, typ: 'events'),
                                DropDownTile(l: locations, typ: 'locations'),
                                // ListTile(
                                //   title: TextField(
                                //     controller: ectr,
                                //     keyboardType: TextInputType.emailAddress,
                                //     // style: TextStyle(textBaseline: TextBas),
                                //     cursorColor: Theme.of(context).primaryColor,
                                //     style:
                                //         TextStyle(color: Theme.of(context).primaryColor),
                                //     decoration: InputDecoration(
                                //       hintText: "event",
                                //     ),
                                //   ),
                                // ),
                                // ListTile(
                                //   title: TextField(
                                //     controller: lctr,
                                //     keyboardType: TextInputType.emailAddress,
                                //     // style: TextStyle(textBaseline: TextBas),
                                //     cursorColor: Theme.of(context).primaryColor,
                                //     style:
                                //         TextStyle(color: Theme.of(context).primaryColor),
                                //     decoration: InputDecoration(
                                //       hintText: "Location",
                                //     ),
                                //   ),
                                // ),
                                DropDownTile(
                                    l: [],
                                    typ: (FirebaseAuth
                                        .instance.currentUser!.email)),
                                SizedBox(
                                  height: getScreenHeight / 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            cpi = false;
                                            edit = false;
                                          });
                                        },
                                        child: LocalButton(title: 'Cancel')),
                                    ElevatedButton(
                                        onPressed: () {
                                          onchange(nctr).then((value) {
                                            setState(() {
                                              cpi = false;
                                              edit = false;
                                            });
                                          }).whenComplete(() {
                                            setState(() {
                                              cpi = false;
                                              edit = false;
                                            });
                                          });
                                          setState(() {
                                            cpi = true;
                                            // edit =
                                          });
                                        },
                                        child: LocalButton(title: 'Done')),
                                  ],
                                ),

                                SizedBox(
                                  height: getScreenHeight / 20,
                                ),
                              ],
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Text('Edit Profile'),
                                Container(
                                  height: getScreenHeight / 10,
                                ),
                                Container(
                                  height: getScreenWidth / 3,
                                  width: getScreenWidth / 3,
                                  // color: Colors.red,
                                  child: Stack(children: [
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        height: getScreenWidth / 3,
                                        width: getScreenWidth / 3,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black,
                                          maxRadius: getScreenWidth / 5,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  upplink!),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.8),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: IconButton(
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.black,
                                                size: 15,
                                              ),
                                              onPressed: () {
                                                changedp();
                                                setState(() {
                                                  upplink =
                                                      "https://firebasestorage.googleapis.com/v0/b/parinaya-a8548.appspot.com/o/ppicon.png?alt=media&token=5bd13fa7-e091-452b-98ff-32f375ef0ad2";
                                                });
                                              }),
                                        ))
                                  ]),
                                ),
                                // Container(
                                //   height: getScreenHeight / 60,
                                // ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        cpi = false;
                                        edit = true;
                                      });
                                    },
                                    child: Text("Edit Profile",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Abhaya_Libre',
                                            color: Theme.of(context)
                                                .primaryColor))),
                                Container(
                                  height: getScreenHeight / 20,
                                ),
                                ListTile(
                                    title: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    width: 1))),
                                        child: Text(uname!.capitalize()))),
                                ListTile(
                                    title: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    width: 1))),
                                        child: Text(ueventType!.capitalize()))),
                                ListTile(
                                    title: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    width: 1))),
                                        child: Text(ulocation!.capitalize()))),
                                ListTile(
                                    title: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    width: 1))),
                                        child: Text(FirebaseAuth
                                            .instance.currentUser!.email!))),
                                ListTile(
                                    title: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    width: 1))),
                                        child: Text(DateFormat('yyyy-MM-dd')
                                            .format(udate!)))),
                                ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) => Dialog(
                                                child: Container(
                                                  height: getScreenHeight / 5,
                                                  width: getScreenWidth / 1.5,
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        "Are you sure you want to sign out ?",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                await FirebaseAuth
                                                                    .instance
                                                                    .signOut();
                                                                await GoogleSignIn()
                                                                    .signOut();
                                                                Navigator.of(context).pushAndRemoveUntil(
                                                                    PageRouteBuilder(
                                                                        transitionDuration: Duration(
                                                                            seconds:
                                                                                1),
                                                                        opaque:
                                                                            false,
                                                                        pageBuilder: (context,
                                                                                animation,
                                                                                secondaryAnimation) =>
                                                                            StartPage()),
                                                                    (Route<dynamic>
                                                                            route) =>
                                                                        false);
                                                              },
                                                              child:
                                                                  LocalButton(
                                                                title:
                                                                    'Sign out',
                                                              )),
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child:
                                                                  LocalButton(
                                                                title: 'Cancel',
                                                              ))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ) //Your buttons here
                                                ,
                                              ));
                                    },
                                    child: LocalButton(
                                      title: 'Sign out',
                                    )),
                                SizedBox(
                                  height: getScreenHeight / 20,
                                ),
                                Container(
                                  width: getScreenWidth / 1.2,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.8),
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 2),
                                  ),
                                  alignment: Alignment.center,
                                  height: getScreenHeight / 20,
                                  child: Text(
                                    "Query Box",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(20),
                                        top: Radius.circular(0)),
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 2),
                                    color: Colors.white,
                                  ),
                                  height: getScreenHeight / 5,
                                  width: getScreenWidth / 1.2,
                                  child: TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    // expands: true,
                                    // style: TextStyle(textBaseline: TextBas),
                                    // keyboardType: TextInputType.name,
                                    controller: qsctr,
                                    cursorColor: Colors.grey,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        hintText: "Query",
                                        hintStyle:
                                            TextStyle(color: Colors.grey)),
                                  ),
                                ),
                                SizedBox(
                                  height: getScreenHeight / 40,
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('queries')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .set({
                                        'query': qsctr!.value.text
                                      }).then((value) {
                                        print('done');
                                      });
                                      qsctr!.clear();
                                    },
                                    child: LocalButton(
                                      title: 'Submit',
                                    )),
                                SizedBox(
                                  height: getScreenHeight / 20,
                                ),
                              ],
                            ),
                          ),
                  ),
          ),
        ),
      ]),
    );
  }

  Future<void> onchange(nctr) async {
    String idd = FirebaseAuth.instance.currentUser!.uid;
    // await FirebaseStorage.instance
    //     .ref()
    //     .child('users/${idd}/profilepic/${idd}pp.jpeg')
    //     .putFile(File(imgFile!.path));
    // String pplink = await FirebaseStorage.instance
    //     .ref()
    //     .child('users/${idd}/profilepic/${idd}pp.jpeg')
    //     .getDownloadURL();
    await FirebaseFirestore.instance.collection("users").doc("/${idd}").update({
      'name': nctr.value.text,
      'event': ueventType,
      'location': ulocation,
      'profilepic': upplink
    }).then((value) {
      uname = nctr.value.text;
      // upplink = pplink;
      // ueventType = ectr.value.text;
      // ulocation = lctr.value.text;
    });
  }

  Future<void> changedp() async {
    final ImagePicker _picker = ImagePicker();
    imgFile = await _picker.pickImage(source: ImageSource.gallery);
    String idd = await FirebaseAuth.instance.currentUser!.uid;
    await FirebaseStorage.instance
        .ref()
        .child('users/${idd}/profilepic/${idd}pp.jpeg')
        .putFile(File(imgFile!.path));
    String pplink = await FirebaseStorage.instance
        .ref()
        .child('users/${idd}/profilepic/${idd}pp.jpeg')
        .getDownloadURL();
    await FirebaseFirestore.instance
        .collection("users")
        .doc("/${idd}")
        .update({'profilepic': pplink}).then((value) {
      upplink = pplink;
    });
    setState(() {
      //  upplink =
    });
  }
}
