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
                )),
    );
  }
}
