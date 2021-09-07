import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/widgets/addFile.dart';

class ImgUploadWidget extends StatefulWidget {
  final bool? single;
  final double? wid;
  const ImgUploadWidget({Key? key, @required this.single, @required this.wid})
      : super(key: key);

  @override
  _ImgUploadWidgetState createState() => _ImgUploadWidgetState();
}

class _ImgUploadWidgetState extends State<ImgUploadWidget> {
  final ImagePicker _picker = ImagePicker();

  // File? _storedImages;
  bool? uploaded = false;
  // XFile? img;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imgFile = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (widget.single!)
              ? Container(
                  width: widget.wid! - 10,
                  height: widget.wid! - 10,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                  child: (imgFile != null)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            File(imgFile!.path),
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container())
              : Container(),
          IconButton(
              icon: Icon(Icons.upload_rounded,
                  color: uploaded! ? Colors.green : Colors.grey),
              onPressed: () {
                _takePicture().then((value) {
                  if (value) {
                    setState(() {
                      uploaded = true;
                    });
                  }
                });
              }),
        ],
      ),
    );
  }

  Future<bool> _takePicture() async {
    if (widget.single!) {
      imgFile = await _picker.pickImage(source: ImageSource.gallery);
      if (imgFile != null) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } else {
      imageFiles = await _picker.pickMultiImage(
        maxWidth: 600,
      );
      if (imageFiles!.isEmpty) {
        return Future.value(false);
      } else {
        return Future.value(true);
      }
    }
    // final appDir = await getApplicationDocumentsDirectory();
    // final fileName = path.basename(imageFile.path);
    // print('${appDir.path}/$fileName');
    // final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    // return {"file": savedImage, "path": '${appDir.path}/$fileName'};
  }
}
