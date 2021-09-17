import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/userDetail.dart';
import 'package:parinaya/widgets/addButton.dart';
import 'package:parinaya/widgets/servicesBlock.dart';
import 'package:parinaya/widgets/capitalize.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String diff = udate!.difference(DateTime.now()).inDays.toString();
    print("ja");
    return Container(
        height: getScreenHeight,
        width: getScreenWidth,
        child: Stack(children: [
          Positioned(
            top: getScreenHeight / 8,
            left: ((getScreenWidth / 2) - (getScreenWidth / 6)),
            child: Container(
              height: getScreenWidth / 3,
              width: getScreenWidth / 3,
              // color: Colors.blue,
              child: Center(
                child: Image.asset('assets/icons/icon.png'),
              ),
            ),
          ),
          Positioned(
              top: (getScreenHeight / 9) + (getScreenHeight / 5),
              left: 0,
              child: Container(
                  height: getScreenHeight / 4,
                  width: getScreenWidth,
                  color: Colors.green,
                  child: Stack(children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        height: getScreenHeight / 4,
                        width: getScreenWidth,
                        child: Image.asset(
                          'assets/images/background.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      child: Container(
                          height: getScreenHeight / 15,
                          // color: Colors.red,
                          color: Colors.black.withOpacity(0.5),
                          width: getScreenWidth,
                          child: Center(
                            child: Text(
                              "Welcome ${uname!.capitalize()}",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                            ),
                          )),
                    ),
                    Positioned(
                      top: 20 + (getScreenHeight / 15),
                      child: Container(
                          height: getScreenHeight / 15,
                          // color: Colors.red,
                          color: Colors.black.withOpacity(0.3),
                          width: getScreenWidth,
                          child: Center(
                            child: Text(
                              "${diff} Days Left",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          )),
                    ),
                    Positioned(
                      top: 30 + (2 * (getScreenHeight / 15)),
                      left: (getScreenWidth / 2) - (getScreenWidth / 3),
                      child: Container(
                          height: getScreenHeight / 15,
                          // color: Colors.red,
                          alignment: Alignment.center,
                          width: getScreenWidth / 1.5,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Location :  ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  ulocation!.capitalize(),
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          )),
                    )
                  ]))),
          ServicesBlock(),
          Positioned(
              bottom: 10,
              right: 10,
              child: AddButton(
                typee: 'category',
              )),
        ]));
  }
}
