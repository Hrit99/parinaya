import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:parinaya/widgets/capitalize.dart';

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
    CarouselController crctr = new CarouselController();
    int onpage = 0;
    var itempro = Provider.of<ItemPro>(context);
    print("item page");
    // l = itempro.getItemList(selectedc!, selectedsc!);
    Subcategorypro subcatpro =
        Provider.of<Subcategorypro>(context, listen: false);
    CategoryPro catpro = Provider.of<CategoryPro>(context, listen: false);
    selectedc = catpro.getSelectedcat;
    selectedsc = subcatpro.getSelectedsubcat(selectedc);
    List<dynamic> imgshown = [];
    itempro
        .getItemList(selectedc!, selectedsc!)
        .map((e) => imgshown.addAll(e.imageFolderLink!))
        .toList();
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
                  Container(
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
                            carouselController: crctr,
                            items: imgshown.map((ee) {
                              return Container(
                                height: getScreenHeight / 3,
                                width: getScreenWidth,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: ee,
                                  placeholder: (context, url) => Container(),
                                  errorWidget: (context, url, error) =>
                                      Container(),
                                ),
                                // child: Image.network(
                                //   ee,
                                //   fit: BoxFit.fill,
                                // ),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              autoPlayInterval: Duration(seconds: 3),
                              onPageChanged: (index, reason) {},
                              aspectRatio: 16 / 9,
                              autoPlay: true,
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
                                    'Items',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Container(
                                  color: Theme.of(context).primaryColor,
                                  height: 1,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  height: getScreenHeight / 3.2,
                                  width: getScreenWidth,
                                  // color: Colors.red,
                                  alignment: Alignment.topLeft,
                                  child: ListView.separated(
                                      itemBuilder: (context, index) => Slidable(
                                          actionPane:
                                              SlidableDrawerActionPane(),
                                          actionExtentRatio: 0.25,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                crctr.animateToPage(
                                                    imgshown.indexOf(itempro
                                                        .getItemList(selectedc!,
                                                            selectedsc!)[index]
                                                        .imageFolderLink![0]));
                                              },
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.indigoAccent,
                                                  // child: Text('$3'),
                                                  foregroundColor: Colors.white,
                                                  backgroundImage:
                                                      CachedNetworkImageProvider(itempro
                                                          .getItemList(
                                                              selectedc!,
                                                              selectedsc!)[index]
                                                          .imageFolderLink![0]),
                                                  // NetworkImage(
                                                  // itempro
                                                  //     .getItemList(
                                                  //         selectedc!,
                                                  //         selectedsc!)[index]
                                                  //     .imageFolderLink![0]),
                                                ),
                                                title: Text(itempro
                                                    .getItemList(selectedc!,
                                                        selectedsc!)[index]
                                                    .name!
                                                    .capitalize()),
                                                // subtitle: Text('SlidableDrawerDelegate'),
                                              ),
                                            ),
                                          ),
                                          // actions: <Widget>[
                                          //   IconSlideAction(
                                          //     caption: 'Archive',
                                          //     color: Colors.blue,
                                          //     icon: Icons.archive,
                                          //     onTap: () {},
                                          //   ),
                                          //   // IconSlideAction(
                                          //   //   caption: 'Share',
                                          //   //   color: Colors.indigo,
                                          //   //   icon: Icons.share,
                                          //   //   onTap: () => _showSnackBar('Share'),
                                          //   // ),
                                          // ],
                                          secondaryActions: (FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid !=
                                                  "Vbkg3H0EGfWmC7gCRgQVjcJwzmZ2")
                                              ? []
                                              : <Widget>[
                                                  // IconSlideAction(
                                                  //   caption: 'More',
                                                  //   color: Colors.black45,
                                                  //   icon: Icons.more_horiz,
                                                  //   onTap: () => _showSnackBar('More'),
                                                  // ),
                                                  IconSlideAction(
                                                    caption: 'Delete',
                                                    color: Colors.red,
                                                    icon: Icons.delete,
                                                    onTap: () async {
                                                      await delItem(
                                                          selectedc!,
                                                          selectedsc!,
                                                          itempro.getItemList(
                                                                  selectedc!,
                                                                  selectedsc!)[
                                                              index]);
                                                      itempro.delItem(
                                                          selectedc!,
                                                          selectedsc!,
                                                          itempro.getItemList(
                                                                  selectedc!,
                                                                  selectedsc!)[
                                                              index]);
                                                    },
                                                  ),
                                                ]),
                                      separatorBuilder: (context, index) =>
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 0, vertical: 10),
                                            height: 1,
                                            width: getScreenWidth,
                                            color:
                                                Theme.of(context).dividerColor,
                                          ),
                                      itemCount: itempro
                                          .getItemList(selectedc!, selectedsc!)
                                          .length),
                                ),
                              ],
                            )),
                      ],
                    ),
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
      ),
      AnimatedPositioned(
          duration: Duration(milliseconds: 5),
          curve: Curves.easeInOut,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          right: 10,
          child: AddButton(
            typee: 'item',
          )),
    ]);
  }
}
