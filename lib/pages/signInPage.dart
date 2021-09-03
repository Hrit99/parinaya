import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/colors.dart';
import 'package:parinaya/pages/startPage.dart';
import 'package:parinaya/widgets/signinBoxPhone.dart';

class SignInpage extends StatefulWidget {
  // const SignInpage();
  @override
  _SignInpageState createState() => _SignInpageState();
}

class _SignInpageState extends State<SignInpage> {
  bool? _keyboardVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Query
    KeyboardVisibilityController _keyboardVisibilityController =
        KeyboardVisibilityController();
    print(
        'Keyboard visibility direct query: ${_keyboardVisibilityController.isVisible}');

    // Subscribe
    _keyboardVisibilityController.onChange.listen((bool visible) {
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
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    print("iiio");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        Container(
          height: getScreenHeight,
          width: getScreenWidth,
          child: Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: MyColors().backgroundtouch,
          appBar: AppBar(
            title: Text("Sign In"),
            bottom: PreferredSize(
                child: Container(
                  color: Theme.of(context).primaryColor,
                  height: 3,
                ),
                preferredSize: Size(getScreenWidth, getScreenWidth / 100)),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Stack(children: [
            Positioned(
              top: getScreenHeight / 20,
              left: (getScreenWidth / 2) - (getScreenWidth / 6),
              child: _keyboardVisible!
                  ? Container()
                  : Hero(
                      tag: "logo",
                      child: Center(
                        child: Container(
                          width: getScreenWidth / 3,
                          height: getScreenWidth / 3,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/icon.png',
                              fit: BoxFit.fill,
                            ),
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
                  : (getScreenHeight / 10) + (getScreenWidth / 3),
              child: Container(
                height: getScreenHeight / 2,
                width: getScreenWidth,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // print("1 ${constraints.hasBoundedHeight}");
                    // print("2 ${constraints.hasBoundedWidth}");
                    // print("3 ${constraints.hasInfiniteHeight}");
                    // print("4 ${constraints.hasInfiniteWidth}");
                    // print(constraints.hasTightHeight);
                    // print(constraints.hasTightWidth);
                    // print(constraints.maxHeight);
                    // print(constraints.maxWidth);
                    // print(constraints.minHeight);
                    // print(constraints.minWidth);
                    // print(constraints.isTight);
                    if (constraints.maxWidth > 500)
                      return SigninboxPhone(
                        isPhone: false,
                      );
                    else
                      return SigninboxPhone(
                        isPhone: true,
                      );
                  },
                ),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
