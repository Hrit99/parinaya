import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';

class LocalButton extends StatelessWidget {
  final String? title;
  const LocalButton({Key? key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: TextStyle(
          fontSize: 15, color: Colors.white, fontFamily: 'Abhaya_Libre'),
    );
  }
}
