import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/category.dart';
import 'package:parinaya/models/colors.dart';
import 'package:parinaya/models/subcategory.dart';
import 'package:parinaya/providers/dataPro.dart';
import 'package:parinaya/widgets/addButton.dart';
import 'package:parinaya/widgets/subcatBox.dart';

import 'package:provider/provider.dart';
import 'package:parinaya/widgets/capitalize.dart';

class SubcategoryPage extends StatefulWidget {
  // final Category? c;
  const SubcategoryPage({Key? key}) : super(key: key);

  @override
  _SubcategoryPageState createState() => _SubcategoryPageState();
}

class _SubcategoryPageState extends State<SubcategoryPage> {
  Category? selectedc;
  // Subcategory? selectedsc;
  List<String> sc = [];
  List<String> scl = [];
  bool? scexist = false;
  bool? cpi = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<bool> checkifsubcategories(Subcategorypro subcatpro) async {
    print("dddddss");
    print("dss ${subcatpro.getsubcat(selectedc!).isNotEmpty}");
    if (subcatpro.getsubcat(selectedc!).isNotEmpty) {
      return Future.value(true);
    } else {
      print('tt ${selectedc!.name}');
      DocumentSnapshot<Map<String, dynamic>> value = await FirebaseFirestore
          .instance
          .collection('/facilities')
          .doc(selectedc!.name)
          .get();
      print("iddss");
      print(value.data());
      if (value.data() != null) {
        if (value.data()!.containsKey('subcollections')) {
          sc = List.from(value.data()!['subcollections']);
          scl = List.from(value.data()!['scimglink']);
          print(scl[0]);
          print("sdsds");
          print(sc);
          // print("h");
          // print(sc);
          if (sc.isEmpty) {
            print("no collections");
            return Future.value(false);
          } else {
            print("collectionss");
            List<Subcategory> slist = sc.map((e) {
              print("jjjjjjj");
              print(scl[sc.indexOf(e)]);
              return new Subcategory(
                  scimglink: scl[sc.indexOf(e)], items: [], name: e);
            }).toList();
            print(slist);
            subcatpro.lofsubcat(selectedc!, slist, notify: false);
            print(selectedc!.subcategories![0].scimglink);
            // subcatpro.getsubcat(selectedc!).forEach((element) {
            //   print(element.name);
            // });
            return Future.value(true);
          }
        } else {
          print("udid");
          return Future.value(false);
        }
      } else {
        print("hhjj");
        return Future.value(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print("kj");
    var subcatpro = Provider.of<Subcategorypro>(context, listen: false);
    CategoryPro catpro = Provider.of<CategoryPro>(context, listen: false);
    selectedc = catpro.getSelectedcat;
    // subcatpro.getsubcat(selectedc!).forEach((element) {
    //   print(element.name);
    // });
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(selectedc!.name!.capitalize()),
          bottom: PreferredSize(
              child: Container(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              preferredSize: Size(getScreenWidth, getScreenWidth / 100)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Stack(children: [
          Container(
            height: getScreenHeight,
            width: getScreenWidth,
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.fill,
              color: MyColors().backgroundtouch,
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Container(
            height: getScreenHeight,
            width: getScreenWidth,
            child: Stack(children: [
              Positioned(
                top: getScreenHeight / 9,
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
            ]),
          ),
          Positioned(
            bottom: getScreenHeight / 40,
            child: Container(
              // color: Colors.red,
              height: getScreenHeight / 2,
              width: getScreenWidth,
              child: FutureBuilder(
                future: checkifsubcategories(subcatpro),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == true) {
                      print("ooooooo");
                      print(selectedc!.subcategories![0].scimglink);
                      return SubcatBox();
                    } else {
                      return Container(
                          height: getScreenHeight / 1.5,
                          width: getScreenWidth,
                          child: Center(
                            child: SubcatBox(),
                          ));
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),

          // child: (cpi!)
          //     ? Center(child: CircularProgressIndicator())
          //     : ((scexist!)
          //         ? SubcatBox()
          // : Container(
          //     height: getScreenHeight / 1.5,
          //     width: getScreenWidth,
          //     child: Center(
          //       child: Text("No Collections"),
          //     )))
          // // color: Colors.red,
          // // child: (subcatpro.getsubcat(selectedc!).isEmpty)
          // //     ? FutureBuilder(
          // //         future: checkifsubcategories(),
          // //         builder: (context, snapshot) {
          // //           if (snapshot.hasData) {
          // //             print('oooo');
          // //             print(snapshot.hasData);
          // //             if (snapshot.data == true) {
          // //               subcatpro.lofsubcat(
          // //                   selectedc!,
          // //                   sc
          // //                       .map((e) =>
          // //                           Subcategory(name: e, items: []))
          // //                       .toList(),
          // //                   notify: false);
          // //               print(subcatpro.getsubcat(selectedc!).length);
          // //               return Stack(
          // //                 children: [
          // //                   SubcatBox(),
          // //                 ],
          // //               );
          // //             } else {
          // //               return Stack(
          // //                 children: [
          // // Container(
          // //     height: getScreenHeight / 1.5,
          // //     width: getScreenWidth,
          // //     child: Center(
          // //       child: Text("No Collections"),
          // //     )),
          // //                 ],
          // //               );
          // //             }
          // //           } else {
          // //             return Center(child: CircularProgressIndicator());
          // //           }
          // //         },
          // //       )
          // // : Stack(
          // //     children: [
          // //       SubcatBox(),
          // //     ],
          // //   )
          // // color: Colors.red,
          // // child: (cc!.subcategories!.isNotEmpty)
          // // ? Container(
          // //     child: SingleChildScrollView(
          // //       child: Wrap(
          // //           alignment: WrapAlignment.spaceAround,
          // //           runAlignment: WrapAlignment.spaceAround,
          // //           children: cc!.subcategories!.map((e) {
          // //             return SubcategoryBlock(
          // //               e: e,
          // //             );
          // //           }).toList()),
          // //     ),
          // //   )
          // //     : Center(
          // //         child: Text("noo"),
          // //       )),
          // ),

          AnimatedPositioned(
              duration: Duration(milliseconds: 5),
              curve: Curves.easeInOut,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              right: 10,
              child: AddButton(
                typee: 'subcategory',
              ))
          // Positioned(bottom: 10, right: 10, child: Text("jskks"))
        ]));
  }
}
