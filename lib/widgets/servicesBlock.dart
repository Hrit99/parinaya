import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/category.dart';
import 'package:parinaya/providers/dataPro.dart';
import 'package:parinaya/widgets/categgoryBlock.dart';
// import 'package:parinaya/providers/listOfServices.dart';
import 'package:provider/provider.dart';

class ServicesBlock extends StatelessWidget {
  const ServicesBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var servicesProvider = Provider.of<CategoryPro>(context);
    List<Category> l = List.from(servicesProvider.getlofCat);
    return Positioned(
        top: (getScreenHeight / 9) +
            (getScreenHeight / 5) +
            (getScreenHeight / 4) +
            20,
        left: 0,
        child: Container(
          height: getScreenHeight / 3,
          width: getScreenWidth,
          // color: Colors.green,
          child: SingleChildScrollView(
            child: Wrap(
                alignment: WrapAlignment.spaceAround,
                runAlignment: WrapAlignment.spaceAround,
                children: l.map((e) {
                  return CategoryBlock(
                    e: e,
                  );
                }).toList()),
          ),
        ));
  }
}
