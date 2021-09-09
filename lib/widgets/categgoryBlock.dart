import 'dart:io';

import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/category.dart';
import 'package:parinaya/pages/subcategoryPage.dart';
import 'package:parinaya/providers/dataPro.dart';
import 'package:parinaya/widgets/addFile.dart';
import 'package:provider/provider.dart';
import "package:parinaya/widgets/capitalize.dart";
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CategoryBlock extends StatefulWidget {
  final Category? e;
  const CategoryBlock({Key? key, this.e}) : super(key: key);

  @override
  _CategoryBlockState createState() => _CategoryBlockState();
}

class _CategoryBlockState extends State<CategoryBlock> {
  bool? delform;
  bool? shd;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    delform = false;
    shd = true;
  }

  @override
  Widget build(BuildContext context) {
    print("o");
    print(widget.e!.name);
    print(delform);
    var catpro = Provider.of<CategoryPro>(context, listen: false);
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
                // if (e.subcategories!.length == 1) {
                //   Navigator.of(context).pushNamed('/subServiceGallery',
                //       arguments: e.subServices![0]);
                // } else if (e.subServices!.length == 0) {
                // } else {
                //   Navigator.of(context)
                //       .pushNamed('/subServicePage', arguments: e);
                // }
                setState(() {
                  shd = true;
                });
                catpro.setCatSelected = widget.e!;
                print("hhh");
                // print(catpro.getSelectedcat!.name);
                Navigator.of(context).push(
                  PageRouteBuilder(
                      transitionDuration: Duration(seconds: 1),
                      opaque: false,
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          SubcategoryPage()),
                );
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black,
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
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: widget.e!.cimglink!,
                          placeholder: (context, url) => Container(),
                          errorWidget: (context, url, error) => Container(),
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
                            fontWeight: FontWeight.bold,
                            // backgroundColor: Colors.black.withOpacity(0.6),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )),
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
                    print('j');
                    delCategory(widget.e!.name!).then((value) {
                      print(value);
                      if (value) {
                        catpro.delfromcat = widget.e!;
                      }
                    });
                  },
                  iconSize: 20,
                ))
              : Container()
        ]),
      ),
    );
  }
}
