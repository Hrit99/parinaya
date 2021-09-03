import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/category.dart';
import 'package:parinaya/models/item.dart';
import 'package:parinaya/models/subcategory.dart';
import 'package:parinaya/providers/dataPro.dart';
import 'package:parinaya/widgets/addFile.dart';
import 'package:parinaya/widgets/imageUploadWidget.dart';
import 'package:parinaya/widgets/itemAddBlock.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class AddButton extends StatefulWidget {
  final String? typee;
  const AddButton({Key? key, @required this.typee}) : super(key: key);

  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  bool? extend = false;
  TextEditingController cnamectr = new TextEditingController();
  // Category? selectedc;
  // Subcategory? selectedsc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var catpro = Provider.of<CategoryPro>(context, listen: false);
    var subcatpro = Provider.of<Subcategorypro>(context, listen: false);
    return (FirebaseAuth.instance.currentUser!.uid !=
            "Vbkg3H0EGfWmC7gCRgQVjcJwzmZ2")
        ? Container()
        : Container(
            width: getScreenWidth,
            height: (widget.typee == 'item')
                ? getScreenHeight / 5
                : getScreenHeight / 10,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              extend!
                  ? (widget.typee == 'item')
                      ? ItemAddBlock()
                      : Container(
                          height: getScreenHeight / 14,
                          width: getScreenWidth / 1.4,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            title: TextField(
                              showCursor: true,
                              controller: cnamectr,
                              keyboardType: TextInputType.visiblePassword,
                              cursorColor: Colors.grey,
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
                              // style: TextStyle(textBaseline: TextBas),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: "${widget.typee} name",
                              ),
                              onSubmitted: (value) {
                                print("submitted");
                                String n = cnamectr.value.text;
                                print(n);
                                if (widget.typee == 'category') {
                                  print("t");
                                  addCategory(n).then((value) {
                                    print("cat");
                                    print(value);
                                    if (value) {
                                      catpro.addtoCat =
                                          Category(name: n, subcategories: []);
                                    }
                                  });
                                }
                                if (widget.typee == 'subcategory') {
                                  addsubcategory(catpro.getSelectedcat!, n)
                                      .then((value) {
                                    if (value) {
                                      subcatpro.addsubcat(
                                          catpro.getSelectedcat!,
                                          Subcategory(name: n, items: []));
                                    }
                                  });
                                }
                                setState(() {
                                  cnamectr.clear();
                                  extend = false;
                                });
                              },
                            ),
                          ),
                        )
                  : Container(),
              FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      cnamectr.clear();
                      extend = !extend!;
                    });
                  },
                  child: Icon(extend! ? Icons.arrow_forward_ios : Icons.add))
            ]),
          );
  }
}