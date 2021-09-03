import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:parinaya/widgets/logoAnim.dart';

class Logo extends StatelessWidget {
  final double? vcenter;
  final double? hcenter;
  final double? logoHeight;
  final double? logoWidth;
  final bool? cpi;
  const Logo(
      {Key? key,
      this.hcenter,
      this.logoHeight,
      this.logoWidth,
      this.vcenter,
      this.cpi})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("enter");
    return Positioned(
      top: (vcenter! - (logoHeight! / 2)),
      left: (hcenter! - (logoWidth! / 2)),
      child: Container(
          height: logoHeight!,
          width: logoWidth!,
          decoration: BoxDecoration(shape: BoxShape.circle),
          // padding: EdgeInsets.all((logoWidth! + logoHeight!) / 20),
          // color: Colors.blue,
          child: cpi!
              ? LogoAnim(
                  logoWidth: logoWidth!,
                )
              : Hero(
                  tag: "logo",
                  child: Center(
                    child: Container(
                      width: logoWidth!,
                      height: logoWidth!,
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
                )
          // TweenAnimationBuilder(
          //     onEnd: () {
          //       print("here");
          //       setState(() {
          //         begin = (begin == 0) ? 1 : 0;
          //         end = (end == 0) ? 1 : 0;
          //       });
          //     },
          //     tween: Tween(begin: begin, end: end),
          //     duration: Duration(seconds: 5),
          //     builder: (context, double value, child) {
          //       // percentage to show in Center Text
          //       int percentage = (value * 100).ceil();
          //       return Container(
          //         width: size,
          //         height: size,
          //         child: Stack(
          //           children: [
          //             ShaderMask(
          //               shaderCallback: (rect) {
          //                 return SweepGradient(
          //                         startAngle: 0.0,
          //                         endAngle: TWO_PI,
          //                         stops: [
          //                           value,
          //                           value
          //                         ], // value from Tween Animation Builder
          //                         // 0.0 , 0.5 , 0.5 , 1.0
          //                         center: Alignment.center,
          //                         colors: [Colors.blue, Colors.transparent])
          //                     .createShader(rect);
          //               },
          //               child: Container(
          //                 width: size,
          //                 height: size,
          //                 decoration: BoxDecoration(
          //                     shape: BoxShape.circle, color: Colors.white),
          //               ),
          //             ),
          //             // Center(
          //             //   child: Container(
          //             //     width: size - 40,
          //             //     height: size - 40,
          //             //     decoration: BoxDecoration(
          //             //         color: Colors.white, shape: BoxShape.circle),
          //             //     child: Center(
          //             //         child: Text(
          //             //       "$percentage",
          //             //       style: TextStyle(
          //             //           fontSize: 25,
          //             //           color: Colors.blue,
          //             //           fontWeight: FontWeight.bold),
          //             //     )),
          //             //   ),
          //             // )
          //           ],
          //         ),
          //       );
          //     }),
          // Center(
          //   child: Container(
          //     width: size / 1.5,
          //     height: size / 1.5,
          //     decoration: BoxDecoration(
          //         color: Colors.white, shape: BoxShape.circle),
          //     child: Center(
          //       child: Image.asset('assets/icons/icon.png'),
          //     ),
          //   ),
          // )
          //       ],
          //     ),
          //   ),
          // ),
          // Center(
          //   child: Image.asset('assets/icons/icon.png'),
          // ),

          ),
    );
  }
}
