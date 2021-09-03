import 'package:flutter/material.dart';
import 'package:parinaya/models/userDetailMap.dart';

class CalendarIcon extends StatefulWidget {
  const CalendarIcon({Key? key}) : super(key: key);

  @override
  _CalendarIconState createState() => _CalendarIconState();
}

class _CalendarIconState extends State<CalendarIcon> {
  var currentDate = userDetailMap["date"];

  Future<void> _selectDate(BuildContext context) async {
    await showDatePicker(
            context: context,
            initialDate: currentDate,
            firstDate: DateTime(2015),
            lastDate: DateTime(2050))
        .then((pickedDate) {
      if (pickedDate != null && pickedDate != currentDate)
        userDetailMap.update(
          "date",
          (value) {
            return pickedDate;
          },
          ifAbsent: () {
            return pickedDate;
          },
        );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          IconButton(
              icon: Icon(Icons.calendar_today_rounded),
              onPressed: () {
                _selectDate(context);
              }),
          Text(userDetailMap["date"].toString().substring(0, 10)),
        ],
      ),
    );
  }
}
