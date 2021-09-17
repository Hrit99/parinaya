import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/galleryPhotos.dart';
import 'package:parinaya/providers/dataPro.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  bool clicked = false;
  CarouselController ctr = new CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Gallery"),
          bottom: PreferredSize(
              child: Container(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              preferredSize: Size(getScreenWidth, getScreenWidth / 100)),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          height: getScreenHeight,
          width: getScreenWidth,
          color: Colors.black.withOpacity(0.8),
          child: Stack(
            children: [
              Positioned(
                top: (getScreenHeight / 20),
                left: 5,
                child: Container(
                  height: getScreenHeight / 1.3,
                  width: getScreenWidth,
                  // color: Colors.red,

                  child: FutureBuilder(
                    future: getOurImg(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<String> ll = snapshot.data as List<String>;
                        if (ll.isEmpty) {
                          return Center(child: Text("No images"));
                        } else {
                          return SingleChildScrollView(
                            child: Wrap(
                              runAlignment: WrapAlignment.spaceAround,
                              alignment: WrapAlignment.start,
                              children: ll.map((e) {
                                // print(galleryPhotos.length);
                                return GestureDetector(
                                  onDoubleTap: () {
                                    // print("dc");
                                    // setState(() {
                                    //   clicked = !clicked;
                                    // });
                                  },
                                  onTap: () {
                                    // ctr.animateToPage(galleryPhotos.indexOf(e));
                                    showDialog(
                                        context: context,
                                        builder: (_) => Dialog(
                                            backgroundColor:
                                                Colors.black.withOpacity(0.8),
                                            insetPadding: EdgeInsets.all(0),
                                            child: Container(
                                              color:
                                                  Colors.black.withOpacity(0.8),
                                              height: getScreenHeight,
                                              width: getScreenWidth,
                                              child: Center(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  height: getScreenHeight / 3,
                                                  width: getScreenWidth,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: Image.network(
                                                        e,
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                              ),
                                            )));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(5)),
                                    height: getScreenHeight / 9,
                                    width: getScreenHeight / 9,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: e,
                                        placeholder: (context, url) =>
                                            Container(),
                                        errorWidget: (context, url, error) =>
                                            Container(),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: (FirebaseAuth.instance.currentUser!.uid !=
                "Vbkg3H0EGfWmC7gCRgQVjcJwzmZ2")
            ? Container()
            : FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  storeOurImg();
                },
              ));
  }

  Future<void> storeOurImg() async {
    try {
      ImagePicker _picker = ImagePicker();
      List<XFile>? galimg = await _picker.pickMultiImage(maxWidth: 600);
      galimg!.forEach((element) async {
        await FirebaseStorage.instance
            .ref()
            .child('parinayaGallery/${element.path}.jpeg')
            .putFile(File(element.path));
        String imgurl = await FirebaseStorage.instance
            .ref()
            .child('parinayaGallery/${element.path}.jpeg')
            .getDownloadURL();
        await FirebaseFirestore.instance.collection('parinayaGallery').add({
          'imgurl': imgurl,
        });
        galleryImgs.add(imgurl);
      });

      setState(() {});
    } catch (e) {
      print('Some error occured');
    }
  }

  Future<void> delOurImg(String s) async {
    try {
      QuerySnapshot<Map<String, dynamic>> docs = await FirebaseFirestore
          .instance
          .collection('parinayaGallery')
          .where('imgurl', isEqualTo: s)
          .get();
      docs.docs[0].reference.delete();
      galleryImgs.remove(s);
      setState(() {});
    } catch (e) {
      print('Some error occured');
    }
  }

  Future<List<String>> getOurImg() async {
    if (galleryImgs.isEmpty) {
      try {
        QuerySnapshot<Map<String, dynamic>> docs = await FirebaseFirestore
            .instance
            .collection('parinayaGallery')
            .get();
        return docs.docs.map((e) => (e.data()['imgurl'] as String)).toList();
      } catch (e) {
        return [];
      }
    } else {
      return galleryImgs;
    }
  }
}
