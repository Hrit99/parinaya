import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:parinaya/models/userDetail.dart';
import 'package:parinaya/models/userDetailMap.dart';
import 'package:parinaya/widgets/addFile.dart';

Future<bool> storeUserDetails() async {
  uname = userDetailMap['name'];
  ulocation = userDetailMap['location'];
  ueventType = userDetailMap['event'];
  print("ioopp");
  udate = userDetailMap['date'];
  print("uioop");
  String? id = FirebaseAuth.instance.currentUser!.uid;

  try {
    print(id);
    await FirebaseStorage.instance
        .ref()
        .child('users/${id}/profilepic/${id}pp.jpeg')
        .putFile(File(imgFile!.path));
    String pplink = await FirebaseStorage.instance
        .ref()
        .child('users/${id}/profilepic/${id}pp.jpeg')
        .getDownloadURL();
    upplink = pplink;
    userDetailMap.update(
      'profilepic',
      (value) => pplink,
      ifAbsent: () => pplink,
    );
    await FirebaseFirestore.instance
        .collection('/users')
        .doc(id)
        .set(userDetailMap);
    return Future.value(true);
  } catch (e) {
    return Future.value(false);
  }
}
