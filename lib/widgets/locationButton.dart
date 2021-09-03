import 'package:flutter/material.dart';
import 'package:parinaya/models/userDetailMap.dart';
import 'package:parinaya/providers/dataPro.dart';
import 'package:parinaya/widgets/selectionButton.dart';
import 'package:provider/provider.dart';

class LocationButton extends StatelessWidget {
  final String? s;
  const LocationButton({Key? key, this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<LocationPro>(context);
    return SelectionButton(
      col: (userDetailMap['location'] == s)
          ? Theme.of(context).primaryColor
          : Colors.transparent,
      s: s,
    );
  }
}
