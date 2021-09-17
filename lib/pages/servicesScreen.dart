import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/category.dart';
import 'package:parinaya/providers/dataPro.dart';
import 'package:parinaya/widgets/dropDownTile.dart';
import 'package:provider/provider.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryPro catpro = Provider.of<CategoryPro>(context);
    Subcategorypro subcatpro =
        Provider.of<Subcategorypro>(context, listen: false);
    List<Category> catl = catpro.getlofCat;
    // var servicespro = Provider.of<ListOfServices>(context, listen: false);
    // List<OurService> services = servicespro.getLocalOurServices;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("SERVICES"),
        bottom: PreferredSize(
            child: Container(
              color: Theme.of(context).primaryColor,
              height: 3,
            ),
            preferredSize: Size(getScreenWidth, getScreenWidth / 100)),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: getScreenHeight,
        width: getScreenWidth,
        child: ListView.builder(
          itemCount: catl.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Container(
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Theme.of(context).primaryColor, width: 3)),
                ),
                alignment: Alignment.bottomLeft,
                height: getScreenHeight / 15,
                width: getScreenWidth / 1.2,
                child: DropDownTile(
                    l: catl[index].subcategories!.map((e) => e.name!).toList(),
                    typ: catl[index].name),
              ),
            );
          },
        ),
      ),
    );
  }
}
