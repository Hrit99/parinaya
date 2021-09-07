import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parinaya/models/category.dart';
import 'package:parinaya/models/item.dart';
import 'package:parinaya/models/subcategory.dart';

List<XFile>? imageFiles;
XFile? imgFile;

Future<Map<String, dynamic>> addCategory(String s) async {
  print("jlll");
  try {
    await FirebaseStorage.instance
        .ref()
        .child('${s}/${s}-img.jpeg')
        .putFile(File(imgFile!.path));
    String slink = await FirebaseStorage.instance
        .ref()
        .child('${s}/${s}-img.jpeg')
        .getDownloadURL();
    await FirebaseFirestore.instance
        .collection('/facilities')
        .doc(s)
        .set({'imgstr': slink});
    await FirebaseFirestore.instance
        .collection('/facilities')
        .doc(s)
        .collection('directItem')
        .doc('initc')
        .set({});
    return Future.value({'status': true, 'ilink': slink});
  } catch (e) {
    return Future.value({
      'status': false,
      'ilink': "",
    });
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

Future<Map<String, dynamic>> addsubcategory(Category? c, String s) async {
  try {
    await FirebaseStorage.instance
        .ref()
        .child('${c}/${s}/${s}-img.jpeg')
        .putFile(File(imgFile!.path));
    String slink = await FirebaseStorage.instance
        .ref()
        .child('${c}/${s}/${s}-img.jpeg')
        .getDownloadURL();
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
    List pscimg = value.data()!['scimglink'];
    print("uuu");
    print(psc);
    if (psc == null) {
      psc = [];
      pscimg = [];
    }
    psc.add(s);
    pscimg.add(slink);
    print("jkkk");
    print(psc);
    await FirebaseFirestore.instance
        .collection('/facilities')
        .doc(c.name)
        .update({'subcollections': psc, 'scimglink': pscimg});
    return Future.value({'status': true, 'ilink': slink});
  } catch (e) {
    return Future.value({'status': false, 'ilink': ""});
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
    List pscimg = value.data()!['scimglink'];
    psc.remove(s);
    pscimg.remove(c.subcategories!
        .firstWhere((element) => (element.name == s))
        .scimglink);
    await FirebaseFirestore.instance
        .collection('/facilities')
        .doc(c.name)
        .update({'subcollections': psc, 'scimglink': pscimg});
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
