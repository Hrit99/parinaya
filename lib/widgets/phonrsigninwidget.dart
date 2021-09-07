import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/pages/homePage.dart';
import 'package:parinaya/pages/landingPage.dart';
import 'package:parinaya/widgets/buttons.dart';

class PhoneSigninWidget extends StatefulWidget {
  const PhoneSigninWidget({Key? key}) : super(key: key);

  @override
  _PhoneSigninWidgetState createState() => _PhoneSigninWidgetState();
}

class _PhoneSigninWidgetState extends State<PhoneSigninWidget> {
  TextEditingController pctr = new TextEditingController();
  bool? cpi = false;
  bool? getCode = false;
  String? verificationIdd;
  String? vcode;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: getScreenHeight / 3,
        width: getScreenWidth,
        // color: Colors.red,
        child: Center(
          child: cpi!
              ? CircularProgressIndicator()
              : (getCode!
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: getScreenHeight / 10,
                            width: getScreenWidth / 1.2,
                            decoration: BoxDecoration(
                                // color: Colors.green,
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: OtpTextField(
                              numberOfFields: 6,
                              borderColor: Color(0xFF512DA8),
                              //set to true to show as box or false to show as dash
                              showFieldAsBox: true,
                              //runs when a code is typed in
                              onCodeChanged: (String code) {
                                //handle validation or checks here
                              },
                              //runs when every textfield is filled
                              onSubmit: (String verificationCode) {
                                vcode = verificationCode;
                                // showDialog(
                                //     context: context,
                                //     builder: (context) {
                                //       return AlertDialog(
                                //         title: Text("Verification Code"),
                                //         content: Text(
                                //             'Code entered is $verificationCode'),
                                //       );
                                //     });
                              }, // end onSubmit
                            )),
                        ElevatedButton(
                            onPressed: () async {
                              print(verificationIdd!);
                              print(vcode!);
                              await FirebaseAuth.instance.signInWithCredential(
                                  PhoneAuthProvider.credential(
                                      verificationId: verificationIdd!,
                                      smsCode: vcode!));
                              Navigator.of(context).pushAndRemoveUntil(
                                  PageRouteBuilder(
                                      transitionDuration: Duration(seconds: 1),
                                      opaque: false,
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          HomePage()),
                                  (Route<dynamic> route) => false);
                            },
                            child: Container(
                              height: 20,
                              width: getScreenWidth / 3,
                              alignment: Alignment.center,
                              child: Text("Sign in"),
                            )),
                        Container(
                            height: 20,
                            width: getScreenWidth,
                            // color: Colors.green,
                            padding: EdgeInsets.only(right: 30),
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                                onTap: () {
                                  print("resend code");
                                  verifyphone();
                                },
                                child: Text("Resend Code")))
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: getScreenHeight / 10,
                          width: getScreenWidth / 1.2,
                          decoration: BoxDecoration(
                              // color: Colors.green,
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            title: TextField(
                              maxLength: 10,
                              textAlign: TextAlign.center,
                              controller: pctr,
                              keyboardType: TextInputType.phone,
                              // style: TextStyle(textBaseline: TextBas),
                              cursorColor: Theme.of(context).primaryColor,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                              decoration: InputDecoration(
                                hintText: "Mobile No.",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getScreenHeight / 30,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              print("enrr");
                              print('+91${pctr.value.text}');
                              if (pctr.value.text.length == 10) {
                                setState(() {
                                  cpi = true;
                                });
                                await verifyphone();
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) => Dialog(
                                            child: Container(
                                          height: getScreenHeight / 5,
                                          width: getScreenWidth / 1.5,
                                          alignment: Alignment.center,
                                          color: Colors.black.withOpacity(0.6),
                                          child: Text(
                                              "Please enter a valid mobile number",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                        )));
                                setState(() {
                                  cpi = false;
                                });
                              }
                              print("uqqq");
                              print(pctr.value.text);
                            },
                            child: LocalButton(title: 'Get OTP'))
                      ],
                    )),
        ));
  }

  Future<void> verifyphone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${pctr.value.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("vccccc");
        await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.of(context).pushAndRemoveUntil(
            PageRouteBuilder(
                transitionDuration: Duration(seconds: 1),
                opaque: false,
                pageBuilder: (context, animation, secondaryAnimation) =>
                    HomePage()),
            (Route<dynamic> route) => false);
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          print("verification failed");
          cpi = false;
          getCode = false;
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        String smsCode = 'xxxx';
        print("code sent");
        verificationIdd = verificationId;
        // Create a PhoneAuthCredential with the code
        // PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
        // // Sign the user in (or link) with the credential
        // await auth.signInWithCredential(credential);
        setState(() {
          cpi = false;
          getCode = true;
        });
      },
      timeout: Duration(minutes: 2),
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          print("auto retrieval timeout");
          cpi = false;
          getCode = false;
        });
      },
    );
  }
}
