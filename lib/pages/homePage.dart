import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/category.dart';
// import 'package:parinaya/models/appUser.dart';
import 'package:parinaya/models/colors.dart';
import 'package:parinaya/models/saveContext.dart';
// import 'package:parinaya/models/location.dart';
import 'package:parinaya/pages/galleryScreen.dart';
import 'package:parinaya/pages/homeScreen.dart';
import 'package:parinaya/pages/servicesScreen.dart';
import 'package:parinaya/pages/userScreen.dart';
import 'package:parinaya/providers/dataPro.dart';
// import 'package:parinaya/providers/locationProvider.dart';
import 'package:parinaya/widgets/emailVerificationCheck.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final User? user;
  const HomePage({Key? key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;
  // bool? _accessGiven = false;
  var catpro;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // AppUser userCredential =
    //     ModalRoute.of(context)!.settings.arguments as AppUser;

    // var locationpro = Provider.of<LocationPro>(context, listen: false);
    // locationpro.setLocation(
    //     Location(id: "location1", locaion: "Jhansi", ourServices: []), false);

    // if (widget.user!.emailVerified) {
    //   // getUserDetails(widget.user!.uid);
    // } else {
    //   checkSendEmailAndKeepChecking().then((value) {
    //     if (value["status"] == "successful") {
    //       // getUserDetails(widget.user!.uid);
    //     } else {}
    //     // Future.delayed(Duration(seconds: 4))
    //     //     .then((value) => Navigator.of(context).pop());
    //     // setState(() {
    //     //   dispMes = value["status"];
    //     // });
    //   });
    // }
    print("inhp");
    catpro = Provider.of<CategoryPro>(context, listen: false);
  }

  Future<bool> fetchServAndSubServ() async {
    // await Future.delayed(Duration(seconds: 5));
    //set services and subservices
    try {
      await FirebaseFirestore.instance
          .collection('/facilities')
          .get()
          .then((value) {
        catpro.setlofCat = value.docs.map((e) {
          // File file = await DefaultCacheManager().getSingleFile(e['imgstr']);

          return new Category(
            subcategories: [],
            name: e.id.toString(),
            cimglink: e['imgstr'],
          );
        }).toList();
      });
      print("uppp");
      return Future.value(true);
    } catch (e) {
      print("nuppp");
      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // cttx = context;
    print("hp");
    // var locationpro = Provider.of<LocationPro>(context);
    List<Widget> _screens = [HomeScreen(), GalleryScreen(), UserScreen()];
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              height: getScreenHeight,
              width: getScreenWidth,
              // color: Colors.black,
              child: Image.asset(
                'assets/images/background.jpg',
                fit: BoxFit.fill,
              ),
            ),
            FutureBuilder(
                future: fetchServAndSubServ(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == true) {
                      print(_screens.length);
                      return Scaffold(
                        backgroundColor: MyColors().backgroundtouch,
                        body: _screens[_selectedPage],
                        bottomNavigationBar: BottomNavigationBar(
                          items: [
                            BottomNavigationBarItem(
                                icon: Icon(Icons.home),
                                label: "Home",
                                backgroundColor: Colors.transparent),
                            BottomNavigationBarItem(
                                icon: Icon(Icons.photo_library),
                                label: "Gallery",
                                backgroundColor: Colors.transparent),
                            BottomNavigationBarItem(
                                icon: Icon(Icons.account_circle_rounded),
                                label: "User",
                                backgroundColor: Colors.transparent),
                          ],
                          currentIndex: _selectedPage,
                          onTap: (index) {
                            setState(() {
                              _selectedPage = index;
                            });
                          },
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })
          ],
        ));
  }
}
