import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<Map<String, dynamic>> signinUser(email, password) async {
  print(email);
  print(password);
  try {
    print(email);
    print(password);
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return Future.value({
      "user": userCredential.user,
      "status": "successful",
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
      return Future.value({
        "user": null,
        "status": "user-not-found",
      });
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      return Future.value({
        "user": null,
        "status": "wrong-password",
      });
    }
    return Future.value({
      "user": null,
      "status": "failed",
    });
  }
}

Future<Map<String, dynamic>> signUpUserUsingEmailPw(email, pw) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pw);
    return Future.value({
      "user": userCredential.user,
      "status": "successful",
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
      return Future.value({
        "user": null,
        "status": "weak-password",
      });
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
      return Future.value({
        "user": null,
        "status": "email-already-in-use",
      });
    }
    return Future.value({
      "user": null,
      "status": "failed",
    });
  } catch (e) {
    print(e);
    return Future.value({
      "user": null,
      "status": "failed",
    });
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  // FirebaseAuth.instance.signOut();
  await GoogleSignIn().signOut();
  GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  var credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  print(googleUser.email);

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
