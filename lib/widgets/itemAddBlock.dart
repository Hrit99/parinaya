import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/category.dart';
import 'package:parinaya/models/item.dart';
import 'package:parinaya/models/subcategory.dart';
import 'package:parinaya/providers/dataPro.dart';
import 'package:parinaya/widgets/addFile.dart';
import 'package:parinaya/widgets/imageUploadWidget.dart';
import 'package:provider/provider.dart';

class ItemAddBlock extends StatefulWidget {
  const ItemAddBlock({Key? key}) : super(key: key);

  @override
  _ItemAddBlockState createState() => _ItemAddBlockState();
}

class _ItemAddBlockState extends State<ItemAddBlock> {
  final ScrollController _scrollController = new ScrollController();
  TextEditingController inamectr = new TextEditingController();
  TextEditingController idetailsctr = new TextEditingController();
  bool? cpi = false;
  // Category? selectedc;
  // Subcategory? selectedsc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Subcategorypro subcatpro =
    //     Provider.of<Subcategorypro>(context, listen: false);
    // CategoryPro catpro = Provider.of<CategoryPro>(context, listen: false);
    // selectedc = catpro.getSelectedcat;
    // selectedsc = subcatpro.getSelectedsubcat;
  }

  @override
  Widget build(BuildContext context) {
    Subcategorypro subcatpro =
        Provider.of<Subcategorypro>(context, listen: false);
    CategoryPro catpro = Provider.of<CategoryPro>(context, listen: false);
    ItemPro itempro = Provider.of<ItemPro>(context, listen: false);
    return Container(
        height: getScreenHeight / 5,
        width: getScreenWidth / 1.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: cpi!
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RawScrollbar(
                isAlwaysShown: true,
                radius: Radius.circular(20),
                controller: _scrollController,
                thickness: 10,
                thumbColor: Theme.of(context).primaryColor,
                child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.spaceAround,
                        children: [
                          ListTile(
                            title: Container(
                              height: getScreenHeight / 15,
                              // decoration: BoxDecoration(
                              //   // color: Colors.red,
                              //   border: Border(
                              //       bottom: BorderSide(
                              //           color: Colors.grey, width: 2)),
                              // ),
                              child: TextFormField(
                                // style: TextStyle(textBaseline: TextBas),
                                keyboardType: TextInputType.name,
                                controller: inamectr,
                                cursorColor: Colors.grey,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    hintText: "Item Name",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            // decoration: BoxDecoration(
                            //   // color: Colors.red,
                            //   border: Border(
                            //       bottom:
                            //           BorderSide(color: Colors.grey, width: 2)),
                            // ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              reverse: true,
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                // expands: true,
                                // style: TextStyle(textBaseline: TextBas),
                                // keyboardType: TextInputType.name,
                                controller: idetailsctr,
                                cursorColor: Colors.grey,
                                textAlign: TextAlign.justify,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    hintText: "Detils",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                            ),
                          ),
                          Container(
                              height: getScreenHeight / 7,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Upload Images",
                                      style: TextStyle(color: Colors.grey)),
                                  ImgUploadWidget(
                                    single: false,
                                    wid: 0,
                                  ),
                                ],
                              )),
                          Container(
                              height: getScreenHeight / 15,
                              child: ElevatedButton(
                                child: Text(
                                  'Done',
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  addItem(
                                      catpro.getSelectedcat!,
                                      subcatpro.getSelectedsubcat(
                                          catpro.getSelectedcat!)!,
                                      Item(
                                          id: " ",
                                          name: inamectr.value.text,
                                          detail: idetailsctr.value.text,
                                          imageFolderLink: [])).then((value) {
                                    itempro.addItem(
                                        catpro.getSelectedcat!,
                                        subcatpro.getSelectedsubcat(
                                            catpro.getSelectedcat!)!,
                                        Item(
                                            id: " ",
                                            name: inamectr.value.text,
                                            detail: idetailsctr.value.text,
                                            imageFolderLink:
                                                (value.isEmpty) ? [] : value));
                                    setState(() {
                                      cpi = false;
                                    });
                                  });
                                  setState(() {
                                    cpi = true;
                                  });
                                },
                              )),
                        ])),
              ));
  }
}
