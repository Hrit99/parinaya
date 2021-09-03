import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
// import 'package:parinaya/models/ourServices.dart';
// import 'package:parinaya/providers/listOfServices.dart';
// import 'package:parinaya/widgets/dropDownTile.dart';
import 'package:provider/provider.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var servicespro = Provider.of<ListOfServices>(context, listen: false);
    // List<OurService> services = servicespro.getLocalOurServices;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("SERVICES"),
        bottom: PreferredSize(
            child: Container(
              color: Theme.of(context).primaryColor,
              height: 3,
            ),
            preferredSize: Size(getScreenWidth, getScreenWidth / 100)),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: getScreenHeight,
        width: getScreenWidth,
        // child: ListView.builder(
        //   itemCount: services.length,
        //   itemBuilder: (context, index) {
        //     return DropDownTile(
        //       headWidget: ListTile(
        //         title: Container(
        //             decoration: BoxDecoration(
        //               border: Border(
        //                   bottom: BorderSide(
        //                       color: Theme.of(context).primaryColor, width: 3)),
        //             ),
        //             alignment: Alignment.bottomLeft,
        //             height: getScreenHeight / 15,
        //             width: getScreenWidth / 1.2,
        //             child: Text(services[index].service!)),
        //       ),
        //       listWidgets: (services[index].subServices!.length == 0)
        //           ? []
        //           : services[index].subServices!.map((e) {
        //               return Container(
        //                 padding: EdgeInsets.only(left: 10),
        //                 alignment: Alignment.centerLeft,
        //                 height: getScreenHeight / 15,
        //                 width: getScreenWidth / 1.2,
        //                 child: ListTile(
        //                   title: Text(e.subService!),
        //                 ),
        //               );
        //             }).toList(),
        //     );
        //   },
        // ),
      ),
    );
  }
}
