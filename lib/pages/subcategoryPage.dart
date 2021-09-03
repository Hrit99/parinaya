import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/category.dart';
import 'package:parinaya/models/colors.dart';
import 'package:parinaya/models/subcategory.dart';
import 'package:parinaya/providers/dataPro.dart';
import 'package:parinaya/widgets/addButton.dart';
import 'package:parinaya/widgets/subcatBox.dart';
import 'package:parinaya/widgets/subcategoryblock.dart';
import 'package:provider/provider.dart';

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
  bool? scexist = false;
  bool? cpi = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // subcatpro =
    //     Provider.of<Subcategorypro>(context, listen: false)
    // selectedsc = subcatpro.getSelectedsubcat;
    // var subcatpro = Provider.of<Subcategorypro>(context, listen: false);
    // var catpro = Provider.of<CategoryPro>(context, listen: false);
    // cc = catpro.getSelectedcat!;

    // checkifsubcategories().then((value) {
    //   print(value);
    //   if (value) {
    //     // catpro.getlofCat
    //     //     .where((element) => element.name == selectedc!.name)
    //     //     .first
    //     //     .subcategories = sc.map((e) => new Subcategory(name: e)).toList();
    //     cpi = false;
    //     scexist = true;
    //     subcatpro.lofsubcat(
    //         cc!, sc.map((e) => new Subcategory(name: e)).toList());
    //   } else {
    //     setState(() {
    //       cpi = false;
    //       scexist = false;
    //     });
    //   }
    // });

    // checkifsubcategories(subcatpro, catpro);
  }

  Future<bool> checkifsubcategories(Subcategorypro subcatpro) async {
    if (subcatpro.getsubcat(selectedc!).isNotEmpty) {
      return Future.value(true);
    } else {
      DocumentSnapshot<Map<String, dynamic>> value = await FirebaseFirestore
          .instance
          .collection('/facilities')
          .doc(selectedc!.name)
          .get();

      if (value.data() != null) {
        if (value.data()!.isNotEmpty) {
          sc = List.from(value.data()!['subcollections']);
          // print("h");
          // print(sc);
          if (sc.isEmpty) {
            print("no collections");
            return Future.value(false);
          } else {
            print("collectionss");
            subcatpro.lofsubcat(selectedc!,
                sc.map((e) => new Subcategory(items: [], name: e)).toList(),
                notify: false);
            // subcatpro.getsubcat(selectedc!).forEach((element) {
            //   print(element.name);
            // });
            return Future.value(true);
          }
        } else {
          return Future.value(false);
        }
      } else {
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
          title: Text(selectedc!.name!),
          bottom: PreferredSize(
              child: Container(
                color: Theme.of(context).primaryColor,
                height: 3,
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
            ]),
          ),
          Positioned(
            bottom: getScreenHeight / 40,
            child: Container(
              height: getScreenHeight / 2,
              width: getScreenWidth,
              child: FutureBuilder(
                future: checkifsubcategories(subcatpro),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == true) {
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
