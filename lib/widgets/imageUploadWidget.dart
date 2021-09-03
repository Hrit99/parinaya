import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:parinaya/widgets/addFile.dart';

class ImgUploadWidget extends StatefulWidget {
  const ImgUploadWidget({Key? key}) : super(key: key);

  @override
  _ImgUploadWidgetState createState() => _ImgUploadWidgetState();
}

class _ImgUploadWidgetState extends State<ImgUploadWidget> {
  final ImagePicker _picker = ImagePicker();
  // File? _storedImages;
  bool? uploaded = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
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
        });
  }

  Future<bool> _takePicture() async {
    imageFiles = await _picker.pickMultiImage(
      maxWidth: 600,
    );
    if (imageFiles!.isEmpty) {
      return Future.value(false);
    } else {
      return Future.value(true);
    }
    // final appDir = await getApplicationDocumentsDirectory();
    // final fileName = path.basename(imageFile.path);
    // print('${appDir.path}/$fileName');
    // final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    // return {"file": savedImage, "path": '${appDir.path}/$fileName'};
  }
}
