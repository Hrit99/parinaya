import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/category.dart';
import 'package:parinaya/models/userDetail.dart';
import 'package:parinaya/providers/dataPro.dart';
import 'package:provider/provider.dart';
import 'package:parinaya/widgets/capitalize.dart';

class DropDownTile extends StatefulWidget {
  final List<String>? l;
  final String? typ;
  const DropDownTile({Key? key, @required this.l, @required this.typ})
      : super(key: key);

  @override
  _DropDownTileState createState() => _DropDownTileState();
}

class _DropDownTileState extends State<DropDownTile> {
  // bool extended = false;
  // Widget? hwid;
  bool? extend;
  List<String>? ll;
  String? showwid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // hwid = widget.headWidget;
    extend = false;
    ll = List.from(widget.l!);
    // ll!.insert(0, widget.typ!);
    showwid = widget.typ!;
    print("ewew");
    print(showwid);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Container(
      // height:
      //     extend! ? (ll!.length * getScreenHeight / 20) : getScreenHeight / 20,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          // color: Colors.red,
          border: Border(
              bottom:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1))),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    print("eeqq");
                    extend = true;
                  });
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    height: getScreenHeight / 20,
                    child: Text(showwid!.capitalize()))),
            Container(
              child: Column(
                children: (extend!)
                    ? ll!
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              if (ll!.indexOf(e) != 0) {
                                setState(() {
                                  extend = false;
                                  showwid = e;
                                });
                              } else {
                                setState(() {
                                  extend = false;
                                  showwid = e;
                                });
                              }
                            },
                            child: Container(
                                padding: EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                height: getScreenHeight / 20,
                                child: Text(
                                  e.capitalize(),
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                )),
                          ),
                        )
                        .toList()
                    : [],
              ),
            )
          ]),
    )
        // : GestureDetector(
        //     onTap: () {
        //       setState(() {
        //         extend = true;
        //       });
        //     },
        //     child: Container(
        //         alignment: Alignment.centerLeft,
        //         height: getScreenHeight / 20,
        //         child: Text(showwid!)))),
        );
  }
}

// DropdownButton<String>(
//         underline: Container(
//           height: 3,
//           width: getScreenWidth,
//           color: Colors.white,
//         ),
//         dropdownColor: Colors.black.withOpacity(0.5),
//         hint: Text(
//           (widget.typ! == 'events') ? ueventType! : ulocation!,
//           style: TextStyle(color: Colors.white),
//         ),
//         items: widget.l!.map((String value) {
//           return DropdownMenuItem<String>(
//             onTap: () {
//               if (widget.typ! == 'events')
//                 ueventType = value;
//               else
//                 ulocation = value;
//               setState(() {});
//             },
//             value: value,
//             child: Text(
//               value,
//             ),
//           );
//         }).toList(),
//         onChanged: (_) {},
//       ),
