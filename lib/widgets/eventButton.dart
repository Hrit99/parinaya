import 'package:flutter/material.dart';
import 'package:parinaya/models/userDetailMap.dart';
import 'package:parinaya/providers/dataPro.dart';
import 'package:parinaya/widgets/selectionButton.dart';
import 'package:provider/provider.dart';
import 'package:parinaya/widgets/capitalize.dart';

class EventButton extends StatelessWidget {
  final String? s;
  const EventButton({Key? key, this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<EventPro>(context);
    return SelectionButton(
      col: (userDetailMap['event'] == s)
          ? Theme.of(context).primaryColor
          : Colors.transparent,
      s: s!.capitalize(),
    );
  }
}
