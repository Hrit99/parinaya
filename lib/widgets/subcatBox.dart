import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/category.dart';
import 'package:parinaya/models/subcategory.dart';
import 'package:parinaya/providers/dataPro.dart';
import 'package:parinaya/widgets/subcategoryblock.dart';
import 'package:provider/provider.dart';

class SubcatBox extends StatelessWidget {
  SubcatBox({Key? key}) : super(key: key);

  Category? selectedc;
  // Subcategory? selectedsc;

  @override
  Widget build(BuildContext context) {
    Subcategorypro subcatpro = Provider.of<Subcategorypro>(context);
    CategoryPro catpro = Provider.of<CategoryPro>(context, listen: false);
    selectedc = catpro.getSelectedcat;
    // selectedsc = subcatpro.getSelectedsubcat;
    // var subcatpro = Provider.of<Subcategorypro>(context);
    print("opp");
    return Container(
      height: getScreenHeight / 1.5,
      width: getScreenWidth,
      child: SingleChildScrollView(
        child: Wrap(
            alignment: WrapAlignment.spaceAround,
            runAlignment: WrapAlignment.spaceAround,
            children: subcatpro.getsubcat(selectedc!).map((e) {
              return SubcategoryBlock(
                e: e,
              );
            }).toList()),
      ),
    );
  }
}
