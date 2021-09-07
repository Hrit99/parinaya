import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/galleryPhotos.dart';

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
        title: Text("GALLERY"),
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
        child: Stack(
          children: [
            Positioned(
              top: (getScreenHeight / 20),
              child: Container(
                height: getScreenHeight / 1.2,
                width: getScreenWidth,
                // color: Colors.red,
                child: SingleChildScrollView(
                  child: Wrap(
                    runAlignment: WrapAlignment.spaceAround,
                    alignment: WrapAlignment.spaceAround,
                    children: galleryPhotos.map((e) {
                      print(galleryPhotos.length);
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
                                      child: Container(
                                    height: getScreenHeight / 4,
                                    width: getScreenWidth / 1.2,
                                  )));
                        },
                        child: AnimatedContainer(
                          onEnd: () {
                            print("ended");
                          },
                          duration: Duration(seconds: 1),
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5)),
                          height: getScreenHeight / 5,
                          width: getScreenHeight / 4.5,
                          child: e,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            // Positioned(
            //     top: (getScreenHeight / 30) + (getScreenHeight / 2.3),
            //     child: Container(
            //       height: getScreenHeight / 3,
            //       width: getScreenWidth,
            //       // color: Colors.red,
            //       child: Column(
            //         children: [
            //           Container(
            //             height: getScreenHeight / 15,
            //             decoration: BoxDecoration(
            //                 border: Border(
            //                     bottom: BorderSide(
            //                         color: Theme.of(context).primaryColor,
            //                         width: 2))),
            //             alignment: Alignment.center,
            //             child: Text("About",
            //                 style: TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 40,
            //                 )),
            //           )
            //         ],
            //       ),
            //     ))
            // Positioned(
            //   top: 0,
            //   child: Container(
            //     height: getScreenHeight / 3,
            //     width: getScreenWidth,
            //     // color: Colors.blue,
            //     child: CarouselSlider(
            //       carouselController: ctr,
            //       options: CarouselOptions(
            //         aspectRatio: 16 / 9,
            //         autoPlay: true,
            //         enableInfiniteScroll: true,
            //         enlargeCenterPage: true,
            //         height: getScreenHeight / 3,
            //         initialPage: 0,
            //         reverse: true,
            //         viewportFraction: 0.5,
            //       ),
            //       items: galleryPhotos,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
