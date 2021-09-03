import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parinaya/models/category.dart';
import 'package:parinaya/models/item.dart';
import 'package:parinaya/models/subcategory.dart';

List<XFile>? imageFiles;

Future<bool> addCategory(String s) async {
  print("jlll");
  try {
    await FirebaseFirestore.instance.collection('/facilities').doc(s).set({});
    await FirebaseFirestore.instance
        .collection('/facilities')
        .doc(s)
        .collection('directItem')
        .doc('initc')
        .set({});
    return Future.value(true);
  } catch (e) {
    return Future.value(false);
  }
}

Future<bool> delCategory(String s) async {
  try {
    await FirebaseFirestore.instance.collection('/facilities').doc(s).delete();
    return Future.value(true);
  } catch (e) {
    return Future.value(false);
  }
}

Future<bool> addsubcategory(Category? c, String s) async {
  try {
    await FirebaseFirestore.instance
        .collection('/facilities')
        .doc(c!.name)
        .collection(s)
        .doc("init")
        .set({});
    print("jdssl");
    DocumentSnapshot<Map<String, dynamic>> value = await FirebaseFirestore
        .instance
        .collection('/facilities')
        .doc(c.name)
        .get();
    print("assa");
    print(value.data()!['subcollections']);
    List psc = value.data()!['subcollections'];
    print("uuu");
    print(psc);
    if (psc == null) {
      psc = [];
    }
    psc.add(s);
    print("jkkk");
    print(psc);
    await FirebaseFirestore.instance
        .collection('/facilities')
        .doc(c.name)
        .set({'subcollections': psc});
    return Future.value(true);
  } catch (e) {
    return Future.value(false);
  }
}

Future<bool> delsubCategory(Category? c, String s) async {
  try {
    await FirebaseFirestore.instance
        .collection('/facilities')
        .doc(c!.name)
        .collection(s)
        .get()
        .then((value) {
      for (var item in value.docs) {
        item.reference.delete();
      }
    });
    DocumentSnapshot<Map<String, dynamic>> value = await FirebaseFirestore
        .instance
        .collection('/facilities')
        .doc(c.name)
        .get();
    print("assa");
    print(value.data()!['subcollections']);
    List psc = value.data()!['subcollections'];
    psc.remove(s);
    await FirebaseFirestore.instance
        .collection('/facilities')
        .doc(c.name)
        .set({'subcollections': psc});
    return Future.value(true);
  } catch (e) {
    return Future.value(false);
  }
}

Future<List<String>> addItem(Category c, Subcategory s, Item i) async {
  print("jlll");
  try {
    await FirebaseFirestore.instance
        .collection('/facilities')
        .doc(c.name)
        .collection(s.name!)
        .doc('init')
        .delete();
    DocumentReference<Map<String, dynamic>> ref = await FirebaseFirestore
        .instance
        .collection('/facilities')
        .doc(c.name)
        .collection(s.name!)
        .add({
      'name': i.name,
      'details': i.detail,
      'imageFolderLink': i.imageFolderLink,
    });
    File? imgFile;
    List<String>? links = [];
    for (var item in imageFiles!) {
      imgFile = File(item.path);
      if (imgFile != null) {
        await FirebaseStorage.instance
            .ref()
            .child('${c.name!}/${s.name!}/${ref.id}/${item.name}.jpeg')
            .putFile(imgFile);
        links.add(await FirebaseStorage.instance
            .ref()
            .child('${c.name!}/${s.name!}/${ref.id}/${item.name}.jpeg')
            .getDownloadURL());
      }
    }
    print("donee");

    await ref.set({
      'name': i.name,
      'details': i.detail,
      'imageFolderLink': links,
    });

    return Future.value(links);
  } catch (e) {
    return Future.value([]);
  }
}

Future<bool> delItem(Category c, Subcategory s, Item i) async {
  print("jlll");
  try {
    await FirebaseFirestore.instance
        .collection('/facilities')
        .doc(c.name)
        .collection(s.name!)
        .doc(i.id)
        .delete();
    return Future.value(true);
  } catch (e) {
    return Future.value(false);
  }
}
