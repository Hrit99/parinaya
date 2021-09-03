import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';

class LocalButton extends StatelessWidget {
  final Widget? title;
  const LocalButton({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: getScreenHeight / 20,
      width: getScreenWidth / 5,
      child: title,
    );
  }
}
