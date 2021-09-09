import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';

class SelectionButton extends StatelessWidget {
  final String? s;
  final Color? col;
  const SelectionButton({Key? key, this.s, this.col}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getScreenHeight / 20,
      width: getScreenWidth / 4,
      decoration: BoxDecoration(
        color: col,
        border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 2,
            style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          s!,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: (col == Theme.of(context).primaryColor)
                  ? Colors.black
                  : Colors.white),
        ),
      ),
    );
  }
}
