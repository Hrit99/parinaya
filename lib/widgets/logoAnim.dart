import 'package:flutter/material.dart';

class LogoAnim extends StatefulWidget {
  final double? logoWidth;
  const LogoAnim({Key? key, this.logoWidth}) : super(key: key);

  @override
  _LogoAnimState createState() => _LogoAnimState();
}

class _LogoAnimState extends State<LogoAnim> {
  var TWO_PI = 3.14 * 2;
  double begin = 0;
  double end = 1;
  @override
  Widget build(BuildContext context) {
    final size = widget.logoWidth!;
    print("kk");
    print(begin);
    print(end);
    return TweenAnimationBuilder(
        onEnd: () {
          print("here");
          setState(() {
            begin = (begin == 0) ? 1 : 0;
            end = (end == 0) ? 1 : 0;
          });
        },
        tween: Tween(begin: begin, end: end),
        duration: Duration(seconds: 5),
        builder: (context, double value, child) {
          // percentage to show in Center Text
          int percentage = (value * 100).ceil();
          return Container(
            width: size,
            height: size,
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return SweepGradient(
                            startAngle: 0.0,
                            endAngle: TWO_PI,
                            stops: [
                              value,
                              value
                            ], // value from Tween Animation Builder
                            // 0.0 , 0.5 , 0.5 , 1.0
                            center: Alignment.center,
                            colors: [Colors.white, Colors.transparent])
                        .createShader(rect);
                  },
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.yellow[800]),
                  ),
                ),
                // Center(
                //   child: Container(
                //     width: size - 40,
                //     height: size - 40,
                //     decoration: BoxDecoration(
                //         color: Colors.white, shape: BoxShape.circle),
                //     child: Center(
                //         child: Text(
                //       "$percentage",
                //       style: TextStyle(
                //           fontSize: 25,
                //           color: Colors.blue,
                //           fontWeight: FontWeight.bold),
                //     )),
                //   ),
                // )
                Center(
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                        color: Colors.transparent, shape: BoxShape.circle),
                    child: Center(
                      child: Image.asset('assets/icons/icon.png'),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
