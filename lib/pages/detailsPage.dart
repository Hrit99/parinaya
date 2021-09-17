import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/colors.dart';
import 'package:parinaya/models/initDataSet.dart';
import 'package:parinaya/models/userDetailMap.dart';
import 'package:parinaya/pages/homePage.dart';
import 'package:parinaya/providers/dataPro.dart';
import 'package:parinaya/widgets/buttons.dart';
import 'package:parinaya/widgets/calendar.dart';
import 'package:parinaya/widgets/eventButton.dart';
import 'package:parinaya/widgets/imageUploadWidget.dart';
import 'package:parinaya/widgets/locationButton.dart';

import 'package:parinaya/widgets/storeUserDetails.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final ScrollController _scrollController = new ScrollController();

  TextEditingController namectr = new TextEditingController();

  bool? cpi = false;
  String? dispMes = " ";
  @override
  Widget build(BuildContext context) {
    var eventpro = Provider.of<EventPro>(context, listen: false);
    var locationpro = Provider.of<LocationPro>(context, listen: false);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            height: getScreenHeight,
            width: getScreenWidth,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        MyColors().backgroundtouch!, BlendMode.darken))),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text('Details'),
                bottom: PreferredSize(
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      height: 1,
                    ),
                    preferredSize: Size(getScreenWidth, getScreenWidth / 100)),
              ),
              backgroundColor: Colors.transparent,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        color: Colors.black.withOpacity(0.7),
                        height: getScreenHeight / 2,
                        child: Center(
                            child: cpi!
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                      Text(dispMes!),
                                    ],
                                  )
                                : Container(
                                    height: getScreenHeight / 2,
                                    width: getScreenWidth / 1.2,
                                    child: RawScrollbar(
                                      timeToFade: Duration(seconds: 1),
                                      isAlwaysShown: false,
                                      radius: Radius.circular(20),
                                      controller: _scrollController,
                                      thickness: 5,
                                      thumbColor:
                                          Theme.of(context).primaryColor,
                                      child: SingleChildScrollView(
                                        controller: _scrollController,
                                        child: Wrap(
                                            alignment: WrapAlignment.center,
                                            runAlignment:
                                                WrapAlignment.spaceAround,
                                            children: [
                                              ListTile(
                                                title: TextFormField(
                                                  // style: TextStyle(textBaseline: TextBas),
                                                  keyboardType:
                                                      TextInputType.name,
                                                  controller: namectr,
                                                  cursorColor: Theme.of(context)
                                                      .primaryColor,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  decoration: InputDecoration(
                                                    hintText: "Name",
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: getScreenHeight / 8,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  // color: Colors.red,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      "Event ?",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: events
                                                          .map(
                                                            (e) => InkWell(
                                                              onTap: () {
                                                                eventpro
                                                                    .setEvent = e;
                                                              },
                                                              child:
                                                                  EventButton(
                                                                s: e,
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                height: 1,
                                              ),
                                              Container(
                                                height: getScreenHeight / 8,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  // color: Colors.red,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      "Location ?",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: locations
                                                          .map(
                                                            (e) => InkWell(
                                                              onTap: () {
                                                                locationpro
                                                                    .setLocation = e;
                                                              },
                                                              child:
                                                                  LocationButton(
                                                                s: e,
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                height: 1,
                                              ),
                                              Container(
                                                height: getScreenHeight / 8,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  // color: Colors.red,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      "Date ?",
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    CalendarIcon()
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                height: 1,
                                              ),
                                              SizedBox(
                                                height: getScreenHeight / 20,
                                              ),
                                              Container(
                                                width: getScreenWidth,
                                                child: Center(
                                                    child: ImgUploadWidget(
                                                  single: true,
                                                  wid: getScreenWidth / 5,
                                                )),
                                              ),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    setState(() {
                                                      cpi = true;
                                                      dispMes = " ";
                                                    });
                                                    userDetailMap.update(
                                                      'name',
                                                      (value) =>
                                                          namectr.value.text,
                                                      ifAbsent: () =>
                                                          namectr.value.text,
                                                    );
                                                    if (namectr.value.text
                                                        .isNotEmpty) {
                                                      storeUserDetails()
                                                          .then((value) {
                                                        if (value) {
                                                          print("stored");
                                                          Navigator.of(context).pushAndRemoveUntil(
                                                              PageRouteBuilder(
                                                                  transitionDuration:
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                  opaque: false,
                                                                  pageBuilder: (context,
                                                                          animation,
                                                                          secondaryAnimation) =>
                                                                      HomePage()),
                                                              (Route<dynamic>
                                                                      route) =>
                                                                  false);
                                                        } else {
                                                          Future.delayed(
                                                                  Duration(
                                                                      seconds:
                                                                          3))
                                                              .then((value) {
                                                            setState(() {
                                                              cpi = false;
                                                            });
                                                          });
                                                          setState(() {
                                                            cpi = true;
                                                            dispMes =
                                                                "Include only alphabets in name or some field is missing";
                                                          });
                                                        }
                                                      });
                                                    } else {
                                                      Future.delayed(Duration(
                                                              seconds: 3))
                                                          .then((value) {
                                                        setState(() {
                                                          cpi = false;
                                                        });
                                                      });
                                                      setState(() {
                                                        cpi = true;
                                                        dispMes = "Empty Name";
                                                      });
                                                    }
                                                  },
                                                  child: LocalButton(
                                                    title: 'Done',
                                                  ))
                                            ]),
                                      ),
                                    )))),
                  ],
                ),
              ),
            )));
  }
}
