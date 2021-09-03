import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parinaya/models/userDetailMap.dart';

Future<bool> storeUserDetails() async {
  String? id = FirebaseAuth.instance.currentUser!.uid;
  try {
    print(id);
    await FirebaseFirestore.instance
        .collection('/users')
        .doc(id)
        .set(userDetailMap);
    return Future.value(true);
  } catch (e) {
    return Future.value(false);
  }
}
