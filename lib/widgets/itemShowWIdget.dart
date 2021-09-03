import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/category.dart';
import 'package:parinaya/models/colors.dart';
import 'package:parinaya/models/item.dart';
import 'package:parinaya/models/subcategory.dart';
import 'package:parinaya/providers/dataPro.dart';
import 'package:parinaya/widgets/addButton.dart';
import 'package:parinaya/widgets/addFile.dart';
import 'package:provider/provider.dart';

class ItemshowWidget extends StatefulWidget {
  ItemshowWidget({Key? key}) : super(key: key);

  @override
  _ItemshowWidgetState createState() => _ItemshowWidgetState();
}

class _ItemshowWidgetState extends State<ItemshowWidget> {
  bool? ch = true;
  bool? ip = false;
  Category? selectedc;
  Subcategory? selectedsc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Subcategorypro subcatpro =
    //     Provider.of<Subcategorypro>(context, listen: false);
    // CategoryPro catpro = Provider.of<CategoryPro>(context, listen: false);
    // selectedc = catpro.getSelectedcat;
    // selectedsc = subcatpro.getSelectedsubcat;
    // var itempro = Provider.of<ItemPro>(context, listen: false);
    // getItems(itempro);
    // Future.delayed(Duration(seconds: 10)).then((value) {
    //   setState(() {
    //     print("doing");
    //   });
    // });
  }

  Future<bool> getItems(ItemPro itempro) async {
    print("ha");
    // print(selectedc!.name);
    // print(selectedsc!.name);
    print(itempro.getItemList(selectedc!, selectedsc!).length);
    if (itempro.getItemList(selectedc!, selectedsc!).isNotEmpty) {
      print("uss");
      return Future.value(true);
    }
    QuerySnapshot<Map<String, dynamic>> value = await FirebaseFirestore.instance
        .collection('/facilities')
        .doc(selectedc!.name)
        .collection(selectedsc!.name!)
        .get();
    if (value.docs.first.id == 'init') {
      return Future.value(false);
    } else {
      print("ioo");
      print(value.docs[0].data());
      // for (var e in value.docs) {
      //   l!.add(new Item(
      //       id: e.id,
      //       name: e.data()['name'],
      //       detail: e.data()['details'],
      //       imageFolderLink: e.data()['imageFolderLink']));
      // }
      itempro.setItemList(
          selectedc!,
          selectedsc!,
          (value.docs
              .map((e) => new Item(
                  id: e.id,
                  name: e.data()['name'],
                  detail: e.data()['details'],
                  imageFolderLink: e.data()['imageFolderLink']))
              .toList()));
      // l = value.docs.map((e) {
      //   print(e.data());
      //   return;
      // }).toList();
      print("kell");
      // print(l!.map((e) => e.name).toList());
      // itempro.setItemList(selectedc!, selectedsc!, l!);
      // print(itempro
      //     .getItemList(selectedc!, selectedsc!)
      //     .map((e) => e.name)
      //     .toList());
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // CarouselController crctr = new CarouselController();
    int onpage = 0;
    var itempro = Provider.of<ItemPro>(context);
    print("item page");
    // l = itempro.getItemList(selectedc!, selectedsc!);
    Subcategorypro subcatpro =
        Provider.of<Subcategorypro>(context, listen: false);
    CategoryPro catpro = Provider.of<CategoryPro>(context, listen: false);
    selectedc = catpro.getSelectedcat;
    selectedsc = subcatpro.getSelectedsubcat(selectedc);
    return Stack(children: [
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
      // Center(child: Text("klll")),
      Container(
        height: getScreenHeight,
        width: getScreenWidth,
        // color: Colors.green,

        child: FutureBuilder(
          future: getItems(itempro),
          builder: (context, snapshot) {
            print(1);
            if (snapshot.hasData) {
              print(2);
              if (snapshot.data == true) {
                print(3);
                return Stack(children: [
                  CarouselSlider(
                    // carouselController: crctr,
                    options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      autoPlay: false,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: false,
                      height: getScreenHeight,
                      initialPage: 0,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        print(index);
                        onpage = index;
                      },
                    ),
                    items:
                        itempro.getItemList(selectedc!, selectedsc!).map((e) {
                      return Container(
                        height: getScreenHeight,
                        width: getScreenWidth,
                        // color: Colors.blue,
                        child: Column(
                          children: [
                            Container(
                              height: getScreenHeight / 3,
                              width: getScreenWidth,
                              color: Colors.black,
                              child: CarouselSlider(
                                items: e.imageFolderLink!.map((ee) {
                                  return Container(
                                    height: getScreenHeight / 3,
                                    width: getScreenWidth,
                                    child: Image.network(
                                      ee,
                                      fit: BoxFit.fill,
                                    ),
                                  );
                                }).toList(),
                                options: CarouselOptions(
                                  onPageChanged: (index, reason) {},
                                  aspectRatio: 16 / 9,
                                  autoPlay: false,
                                  enableInfiniteScroll: true,
                                  enlargeCenterPage: false,
                                  height: getScreenHeight / 3,
                                  initialPage: 0,
                                  viewportFraction: 1,
                                ),
                              ),
                              // child: Image.network(e.itemImages![0],
                              //     fit: BoxFit.cover)),
                            ),
                            Container(
                                height: getScreenHeight / 2.5,
                                width: getScreenWidth,
                                // color: Colors.red,
                                // color: Colors.green,
                                child: Column(
                                  children: [
                                    Container(
                                      // color: Colors.brown,
                                      height: getScreenHeight / 15,
                                      alignment: Alignment.center,
                                      child: Text(
                                        e.name!,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Container(
                                      color: Theme.of(context).primaryColor,
                                      height: 3,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      // height: getScreenHeight / 2,
                                      alignment: Alignment.topLeft,
                                      child: Text(e.detail!),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  Positioned(
                    bottom: (getScreenHeight / 10) + 5,
                    child: Container(),
                  ),
                  // Positioned(
                  //   bottom: 10,
                  //   child:
                  // ),
                ]);
              } else {
                print(4);
                return Center(child: Text("No Items"));
              }
            } else {
              print(5);
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        // child: ch!
        //     ? Center(child: CircularProgressIndicator())
        //     : (ip!
        // ? Stack(children: [
        //     CarouselSlider(
        //       options: CarouselOptions(
        //         aspectRatio: 16 / 9,
        //         autoPlay: false,
        //         enableInfiniteScroll: true,
        //         enlargeCenterPage: false,
        //         height: getScreenHeight,
        //         initialPage: 0,
        //         viewportFraction: 1,
        //       ),
        //       items: l!.map((e) {
        //         return Container(
        //           height: getScreenHeight,
        //           width: getScreenWidth,
        //           // color: Colors.blue,
        //           child: Column(
        //             children: [
        //               Container(
        //                 height: getScreenHeight / 3,
        //                 width: getScreenWidth,
        //                 // color: Colors.red,
        //                 // child: Image.network(e.itemImages![0],
        //                 //     fit: BoxFit.cover)),
        //               ),
        //               Container(
        //                   height: getScreenHeight / 2.5,
        //                   width: getScreenWidth,
        //                   // color: Colors.green,
        //                   child: Column(
        //                     children: [
        //                       Container(
        //                         // color: Colors.brown,
        //                         height: getScreenHeight / 15,
        //                         alignment: Alignment.center,
        //                         child: Text(
        //                           e.name!,
        //                           style: TextStyle(fontSize: 20),
        //                         ),
        //                       ),
        //                       Container(
        //                         color: Theme.of(context).primaryColor,
        //                         height: 3,
        //                       ),
        //                       Container(
        //                         padding: EdgeInsets.all(10),
        //                         height: getScreenHeight / 15,
        //                         alignment: Alignment.topLeft,
        //                         child: Text(e.detail!),
        //                       ),
        //                     ],
        //                   )),
        //             ],
        //           ),
        //         );
        //       }).toList(),
        //     ),
        //     Positioned(
        //       bottom: (getScreenHeight / 10) + 5,
        //       child: Container(),
        //     ),
        //     Positioned(
        //       bottom: 10,
        //       child: Container(
        //         height: getScreenHeight / 10,
        //         width: getScreenWidth,
        //         // color: Colors.white,
        //         child: CarouselSlider(
        //           items: l!.map((e) {
        //             return Container(
        //               height: getScreenHeight / 10,
        //               width: getScreenWidth / 4,
        //               // child: Image.network(e.itemImages![0],
        //               //     fit: BoxFit.cover),
        //             );
        //           }).toList(),
        //           options: CarouselOptions(
        //             onPageChanged: (index, reason) {},
        //             aspectRatio: 16 / 9,
        //             autoPlay: false,
        //             enableInfiniteScroll: true,
        //             enlargeCenterPage: false,
        //             height: getScreenHeight / 10,
        //             initialPage: 0,
        //             viewportFraction: 0.3,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ])
        //         : Center(child: Text("No Items"))),

        // child: FutureBuilder(
        // future: getItems(itempro),
        // builder: (context, snapshot) {
        //   print("1");
        //   if (snapshot.hasData) {
        //     print("2");
        //     print(snapshot.hasData);
        //     if (snapshot.data == false) {
        //       print("3");
        //       return Center(child: Text("No Items"));
        //     } else {
        //       print("4");
        //   return Stack(children: [
        //     CarouselSlider(
        //       options: CarouselOptions(
        //         aspectRatio: 16 / 9,
        //         autoPlay: false,
        //         enableInfiniteScroll: true,
        //         enlargeCenterPage: false,
        //         height: getScreenHeight,
        //         initialPage: 0,
        //         viewportFraction: 1,
        //       ),
        //       items: l!.map((e) {
        //         return Container(
        //           height: getScreenHeight,
        //           width: getScreenWidth,
        //           // color: Colors.blue,
        //           child: Column(
        //             children: [
        //               Container(
        //                 height: getScreenHeight / 3,
        //                 width: getScreenWidth,
        //                 // color: Colors.red,
        //                 // child: Image.network(e.itemImages![0],
        //                 //     fit: BoxFit.cover)),
        //               ),
        //               Container(
        //                   height: getScreenHeight / 2.5,
        //                   width: getScreenWidth,
        //                   // color: Colors.green,
        //                   child: Column(
        //                     children: [
        //                       Container(
        //                         // color: Colors.brown,
        //                         height: getScreenHeight / 15,
        //                         alignment: Alignment.center,
        //                         child: Text(
        //                           e.name!,
        //                           style: TextStyle(fontSize: 20),
        //                         ),
        //                       ),
        //                       Container(
        //                         color: Theme.of(context).primaryColor,
        //                         height: 3,
        //                       ),
        //                       Container(
        //                         padding: EdgeInsets.all(10),
        //                         height: getScreenHeight / 15,
        //                         alignment: Alignment.topLeft,
        //                         child: Text(e.detail!),
        //                       ),
        //                     ],
        //                   )),
        //             ],
        //           ),
        //         );
        //       }).toList(),
        //     ),
        //     Positioned(
        //       bottom: (getScreenHeight / 10) + 5,
        //       child: Container(),
        //     ),
        //     Positioned(
        //       bottom: 10,
        //       child: Container(
        //         height: getScreenHeight / 10,
        //         width: getScreenWidth,
        //         // color: Colors.white,
        //         child: CarouselSlider(
        //           items: l!.map((e) {
        //             return Container(
        //               height: getScreenHeight / 10,
        //               width: getScreenWidth / 4,
        //               // child: Image.network(e.itemImages![0],
        //               //     fit: BoxFit.cover),
        //             );
        //           }).toList(),
        //           options: CarouselOptions(
        //             onPageChanged: (index, reason) {},
        //             aspectRatio: 16 / 9,
        //             autoPlay: false,
        //             enableInfiniteScroll: true,
        //             enlargeCenterPage: false,
        //             height: getScreenHeight / 10,
        //             initialPage: 0,
        //             viewportFraction: 0.3,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ]);
        // }
        //   } else {
        //     return Center(child: CircularProgressIndicator());
        //   }
        // },
      ),
      AnimatedPositioned(
          duration: Duration(milliseconds: 5),
          curve: Curves.easeInOut,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          right: 10,
          child: AddButton(
            typee: 'item',
          )),
      AnimatedPositioned(
          duration: Duration(milliseconds: 5),
          curve: Curves.easeInOut,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
          left: 10,
          child: (FirebaseAuth.instance.currentUser!.uid !=
                  "Vbkg3H0EGfWmC7gCRgQVjcJwzmZ2")
              ? Container()
              : FloatingActionButton(
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                  onPressed: () async {
                    await delItem(
                        selectedc!,
                        selectedsc!,
                        itempro
                            .getItemList(selectedc!, selectedsc!)
                            .elementAt(onpage));
                    itempro.delItem(
                        selectedc!,
                        selectedsc!,
                        itempro
                            .getItemList(selectedc!, selectedsc!)
                            .elementAt(onpage));
                  }))
    ]);
  }
}
