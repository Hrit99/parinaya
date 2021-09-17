import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';

import 'package:parinaya/providers/dataPro.dart';
import 'package:parinaya/widgets/itemShowWIdget.dart';
import 'package:provider/provider.dart';
import 'package:parinaya/widgets/capitalize.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  // Category? selectedc;
  // Subcategory? selectedsc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Subcategorypro subcatpro =
    //     Provider.of<Subcategorypro>(context, listen: false);
    // CategoryPro catpro = Provider.of<CategoryPro>(context, listen: false);
    // selectedc = catpro.getSelectedcat;
    // selectedsc = subcatpro.getSelectedsubcat;
  }

  @override
  Widget build(BuildContext context) {
    Subcategorypro subcatpro =
        Provider.of<Subcategorypro>(context, listen: false);
    CategoryPro catpro = Provider.of<CategoryPro>(context, listen: false);
    print("t");
    print(catpro.getSelectedcat!.name);
    print(subcatpro.getSelectedsubcat(catpro.getSelectedcat!)!.name!);
    print("jell");
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text((subcatpro.getSelectedsubcat(catpro.getSelectedcat!)!)
            .name!
            .capitalize()),
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
      body: ItemshowWidget(),
    );
  }
}
