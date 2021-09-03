import 'package:flutter/material.dart';
import 'package:parinaya/constants/screendimensions.dart';
import 'package:parinaya/models/category.dart';
import 'package:parinaya/pages/subcategoryPage.dart';
import 'package:parinaya/providers/dataPro.dart';
import 'package:parinaya/widgets/addFile.dart';
import 'package:provider/provider.dart';

class CategoryBlock extends StatefulWidget {
  final Category? e;
  const CategoryBlock({Key? key, this.e}) : super(key: key);

  @override
  _CategoryBlockState createState() => _CategoryBlockState();
}

class _CategoryBlockState extends State<CategoryBlock> {
  bool? delform;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    delform = false;
  }

  @override
  Widget build(BuildContext context) {
    print("o");
    print(widget.e!.name);
    print(delform);
    var catpro = Provider.of<CategoryPro>(context, listen: false);
    return GestureDetector(
      onLongPress: () {
        setState(() {
          delform = !delform!;
        });
      },
      onTap: () {
        // if (e.subcategories!.length == 1) {
        //   Navigator.of(context).pushNamed('/subServiceGallery',
        //       arguments: e.subServices![0]);
        // } else if (e.subServices!.length == 0) {
        // } else {
        //   Navigator.of(context)
        //       .pushNamed('/subServicePage', arguments: e);
        // }
        catpro.setCatSelected = widget.e!;
        print("hhh");
        // print(catpro.getSelectedcat!.name);
        Navigator.of(context).push(
          PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              opaque: false,
              pageBuilder: (context, animation, secondaryAnimation) =>
                  SubcategoryPage()),
        );
      },
      child: Card(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 3)),
          height: getScreenHeight / 8,
          width: getScreenHeight / 8,
          child: Stack(
            children: [
              Center(child: Text(widget.e!.name!)),
              delform!
                  ? Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          print('j');
                          delCategory(widget.e!.name!).then((value) {
                            print(value);
                            if (value) {
                              catpro.delfromcat = widget.e!;
                            }
                          });
                        },
                        iconSize: 20,
                      ))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
