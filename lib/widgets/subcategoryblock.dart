import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/category.dart';
import 'package:parinaya/models/subcategory.dart';
import 'package:parinaya/pages/itemPage.dart';
import 'package:parinaya/pages/subcategoryPage.dart';
import 'package:parinaya/providers/dataPro.dart';
import 'package:parinaya/widgets/addFile.dart';
import 'package:provider/provider.dart';
import 'package:parinaya/widgets/capitalize.dart';

class SubcategoryBlock extends StatefulWidget {
  final Subcategory? e;
  const SubcategoryBlock({Key? key, this.e}) : super(key: key);

  @override
  _SubcategoryBlockState createState() => _SubcategoryBlockState();
}

class _SubcategoryBlockState extends State<SubcategoryBlock> {
  bool? delform = false;
  bool? shd;
  Category? selectedc;
  // Subcategory? selectedsc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Subcategorypro subcatpro =
    //     Provider.of<Subcategorypro>(context, listen: false);

    // selectedsc = subcatpro.getSelectedsubcat;
    shd = true;
  }

  @override
  Widget build(BuildContext context) {
    CategoryPro catpro = Provider.of<CategoryPro>(context, listen: false);
    selectedc = catpro.getSelectedcat;
    var subcatpro = Provider.of<Subcategorypro>(context, listen: false);
    print(widget.e!.name);
    print(selectedc!.name);
    print(widget.e!.scimglink!);
    return Card(
      child: Container(
        height: getScreenHeight / 7,
        width: getScreenHeight / 7,
        // color: Colors.green,
        child: Stack(children: [
          Center(
            child: GestureDetector(
              onLongPress: () {
                setState(() {
                  delform = !delform!;
                });
              },
              onPanDown: (_) {
                print("pandowm");
                setState(() {
                  shd = false;
                });
              },
              onLongPressEnd: (_) {
                print("dsd");
                setState(() {
                  shd = true;
                });
              },
              onTap: () {
                setState(() {
                  shd = true;
                });
                print("yuu");
                subcatpro.setsubCatSelected(selectedc!, widget.e!);
                print(subcatpro.getSelectedsubcat(selectedc!)!.name!);
                print("yi");
                Navigator.of(context).pushNamed('/itemPage');
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: shd!
                        ? [
                            BoxShadow(
                                color: Theme.of(context).primaryColor,
                                blurRadius: 10,
                                spreadRadius: 0.5,
                                offset: Offset(5, 5))
                          ]
                        : [],
                    // color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: Theme.of(context).dividerColor, width: 2)),
                height: getScreenHeight / 8,
                width: getScreenHeight / 8,
                child: Stack(
                  children: [
                    Container(
                      height: getScreenHeight / 8,
                      width: getScreenHeight / 8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(17),
                        child: Image.network(
                          widget.e!.scimglink!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Center(
                        child: Container(
                            height: getScreenHeight / 8,
                            width: getScreenHeight / 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black.withOpacity(0.6),
                            ),
                            child: Center(
                                child: Text(
                              widget.e!.name!.capitalize(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                // backgroundColor: Colors.black.withOpacity(0.6),
                                fontSize: 20,
                              ),
                            )))),
                  ],
                ),
              ),
            ),
          ),
          delform!
              ? Positioned(
                  child: IconButton(
                  icon: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                  onPressed: () {
                    // print('j');
                    // delCategory(widget.e!.name!).then((value) {
                    //   print(value);
                    //   if (value) {
                    //     catpro.delfromcat = widget.e!;
                    //   }
                    // });
                    delsubCategory(selectedc, widget.e!.name!).then((value) {
                      subcatpro.delsubcat(selectedc!, widget.e!);
                    });
                  },
                  iconSize: 20,
                ))
              : Container()
        ]),
      ),
    );

    // return GestureDetector(
    //   onLongPress: () {
    //     setState(() {
    //       delform = !delform!;
    //     });
    //   },
    //   onTap: () {
    //     // if (e.subcategories!.length == 1) {
    //     //   Navigator.of(context).pushNamed('/subServiceGallery',
    //     //       arguments: e.subServices![0]);
    //     // } else if (e.subServices!.length == 0) {
    //     // } else {
    //     //   Navigator.of(context)
    //     //       .pushNamed('/subServicePage', arguments: e);
    //     // }
    //     // Navigator.of(context).push(
    //     //   PageRouteBuilder(
    //     //       transitionDuration: Duration(seconds: 1),
    //     //       opaque: false,
    //     //       pageBuilder: (context, animation, secondaryAnimation) =>
    //     //           SubcategoryPage(c: widget.e!)),
    //     // );
    // print("yuu");
    // subcatpro.setsubCatSelected(selectedc!, widget.e!);
    // print(subcatpro.getSelectedsubcat(selectedc!)!.name!);
    // print("yi");
    // Navigator.of(context).pushNamed('/itemPage');
    //   },
    //   child: Card(
    //     child: Container(
    //       alignment: Alignment.center,
    //       decoration: BoxDecoration(
    //           color: Colors.transparent,
    //           borderRadius: BorderRadius.circular(20),
    //           border:
    //               Border.all(color: Theme.of(context).primaryColor, width: 3)),
    //       height: getScreenHeight / 8,
    //       width: getScreenHeight / 8,
    //       child: Center(
    //         child: Stack(
    //           children: [
    //             Center(
    //                 child: Text(
    //               widget.e!.name!,
    //               textAlign: TextAlign.center,
    //             )),
    //             delform!
    //                 ? Positioned(
    //                     right: 0,
    //                     top: 0,
    //                     child: IconButton(
    //                       icon: Icon(Icons.delete),
    //                       onPressed: () {
    //                         // print('j');
    //                         // delCategory(widget.e!.name!).then((value) {
    //                         //   print(value);
    //                         //   if (value) {
    //                         //     catpro.delfromcat = widget.e!;
    //                         //   }
    //                         // });
    // delsubCategory(selectedc, widget.e!.name!)
    //     .then((value) {
    //   subcatpro.delsubcat(selectedc!, widget.e!);
    // });
    //                       },
    //                       iconSize: 20,
    //                     ))
    //                 : Container()
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
