import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/widgets/addButton.dart';
import 'package:parinaya/widgets/servicesBlock.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("ja");
    return Container(
        height: getScreenHeight,
        width: getScreenWidth,
        child: Stack(children: [
          Positioned(
            top: getScreenHeight / 9,
            left: ((getScreenWidth / 2) - (getScreenWidth / 2.4)),
            child: Container(
              height: getScreenHeight / 5,
              width: getScreenWidth / 1.2,
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
                  color: Colors.white,
                  child: Image.asset(
                    'assets/images/background.jpg',
                    fit: BoxFit.cover,
                  ))),
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
