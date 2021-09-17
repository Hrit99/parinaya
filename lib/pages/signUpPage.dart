import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/colors.dart';
import 'package:parinaya/widgets/signUpBox.dart';

class SignUppage extends StatefulWidget {
  @override
  _SignUppageState createState() => _SignUppageState();
}

class _SignUppageState extends State<SignUppage> {
  bool? _keyboardVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();
    // Query
    print(
        'Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');

    // Subscribe
    keyboardVisibilityController.onChange.listen((bool visible) {
      print("jk");
      setState(() {
        _keyboardVisible = visible;
      });
      print('Keyboard visibility update. Is visible: ${visible}');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final _key =
    //     ModalRoute.of(context)!.settings.arguments as GlobalKey<StartPageState>;

    return Container(
      height: getScreenHeight,
      width: getScreenWidth,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  MyColors().backgroundtouch!, BlendMode.darken))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "Sign up",
            style: TextStyle(
                fontFamily: 'Abhaya_Libre', fontWeight: FontWeight.bold),
          ),
          bottom: PreferredSize(
              child: Container(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
              preferredSize: Size(getScreenWidth, getScreenWidth / 100)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Stack(
          children: [
            Positioned(
              top: getScreenHeight / 30,
              left: (getScreenWidth / 2) - (getScreenWidth / 6),
              child: _keyboardVisible!
                  ? Container()
                  : Center(
                      child: Container(
                        width: getScreenWidth / 3,
                        height: getScreenWidth / 3,
                        decoration: BoxDecoration(
                            color: Colors.transparent, shape: BoxShape.circle),
                        child: Center(
                          child: Image.asset(
                            'assets/icons/icon.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
            ),
            AnimatedPositioned(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              top: _keyboardVisible!
                  ? getScreenHeight / 20
                  : (getScreenHeight / 8) + (getScreenWidth / 3),
              left: 0,
              child: Container(
                height: getScreenHeight / 3,
                width: getScreenWidth,
                color: Colors.black.withOpacity(0.3),
                child: Center(
                    child: Container(
                  width: getScreenWidth / 1.3,
                  child: SignUpBox(),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
