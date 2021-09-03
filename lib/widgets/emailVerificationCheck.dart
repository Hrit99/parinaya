import 'package:firebase_auth/firebase_auth.dart';

Future<Map<String, dynamic>> checkSendEmailAndKeepChecking() async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      print(user.email);
      print(user.emailVerified);
      if (user.emailVerified) {
        return Future.value({"user": user, "status": "successful"});
      } else {
        print("in");
        await user.sendEmailVerification();
        int c = 0;
        while (!user!.emailVerified) {
          await Future.delayed(Duration(seconds: 10));
          auth.currentUser!.reload();
          user = auth.currentUser;
          print(user!.emailVerified);
          if (user.emailVerified) {
            return Future.value({"user": user, "status": "successful"});
          }
          c++;
          if (c == 12) {
            return Future.value({"user": null, "status": "time out"});
          }
        }
        return Future.value({"user": null, "status": "failed"});
      }
    } else {
      print("assss");
      return Future.value({"user": null, "status": "failed"});
    }
  } catch (e) {
    print("err");
    return Future.value({"user": null, "status": "failed"});
  }
}
