import 'package:flutter/material.dart';
import 'package:parinaya/models/item.dart';
import 'package:parinaya/models/subcategory.dart';
import 'package:parinaya/models/userDetailMap.dart';
import 'package:parinaya/models/category.dart';

// Subcategory? selectedsc;
// Category? selectedc;
List<Category> _lofCategory = [];
List<String> galleryImgs = [];

class EventPro with ChangeNotifier {
  set setEvent(String s) {
    userDetailMap.update(
      'event',
      (value) => s,
      ifAbsent: () => s,
    );
    notifyListeners();
  }
}

class LocationPro with ChangeNotifier {
  set setLocation(String s) {
    userDetailMap.update(
      'location',
      (value) => s,
      ifAbsent: () => s,
    );
    notifyListeners();
  }
}

class CategoryPro with ChangeNotifier {
  // List<Category> _lofCategory = [];
  Category? selectedc;
  set setCatSelected(Category c) {
    selectedc = _lofCategory.firstWhere((element) => element.name == c.name);
  }

  Category? get getSelectedcat {
    return _lofCategory
        .firstWhere((element) => element.name == selectedc!.name);
  }

  set setlofCat(List<Category> l) {
    _lofCategory.clear();
    _lofCategory.addAll(l);
  }

  set addtoCat(Category c) {
    _lofCategory.add(c);
    notifyListeners();
  }

  set delfromcat(Category c) {
    _lofCategory.remove(c);
    // for (var item in _lofCategory) {
    //   print(item.name);
    // }
    notifyListeners();
  }

  // List<Category> get getlofCat {
  //   return List.from(_lofCategory);
  // }

  List<Category> get getlofCat {
    return _lofCategory;
  }
}

class Subcategorypro with ChangeNotifier {
  // CategoryPro catpro = new CategoryPro();
  Subcategory? selectedsc;
  void setsubCatSelected(Category c, Subcategory s) {
    // List<Category> l = catpro.getlofCat;

    selectedsc = _lofCategory
        .firstWhere((element) => element.name == c.name)
        .subcategories!
        .firstWhere((element) => (element.name == s.name));
  }

  Subcategory? getSelectedsubcat(Category? cc) {
    // CategoryPro cc = new CategoryPro();
    print(cc!.name!);
    print(selectedsc!.name);
    print(_lofCategory
            .firstWhere((element) {
              print("ee");
              print(element.name);
              return (element.name == cc.name);
            })
            .subcategories!
            .length
        // .firstWhere((element) {
        //   print("eeee");
        //   print(element.name);
        //   return (element.name == selectedsc!.name);
        // })
        // .name);
        );
    print("f");
    return _lofCategory
        .firstWhere((element) => element.name == cc.name)
        .subcategories!
        .firstWhere((element) => (element.name == selectedsc!.name));
  }

  void lofsubcat(Category c, List<Subcategory> sclist,
      {@required bool? notify}) {
    // print(c.name);
    // for (var item in l) {
    //   print(item.name);
    // }
    // print(_lofCategory.firstWhere((element) => element.name == c.name).name!);
    // List<Category> l = catpro.getreallofCat;
    print("yeewww");
    print(sclist);
    _lofCategory
        .firstWhere((element) => element.name == c.name)
        .subcategories!
        .clear();
    _lofCategory
        .firstWhere((element) => element.name == c.name)
        .subcategories!
        .addAll(List.from(sclist));
    // c.subcategories = List.from(l);
    if (notify!) notifyListeners();
  }

  void addsubcat(Category c, Subcategory s) {
    // List<Category> l = catpro.getreallofCat;
    _lofCategory
        .firstWhere((element) => element.name == c.name)
        .subcategories!
        .add(s);

    notifyListeners();
  }

  void delsubcat(Category c, Subcategory s) {
    // List<Category> l = catpro.getreallofCat;
    _lofCategory
        .firstWhere((element) => element.name == c.name)
        .subcategories!
        .remove(s);
    notifyListeners();
  }

  List<Subcategory> getsubcat(Category c) {
    print(c.name);
    // List<Category> l = catpro.getlofCat;
    // l.forEach((element) {
    //   print(element.name);
    // });
    // print(l.firstWhere((element) => element.name == c.name).subcategories!);
    return _lofCategory
        .firstWhere((element) => element.name == c.name)
        .subcategories!;
  }
}

class ItemPro with ChangeNotifier {
  CategoryPro catpro = new CategoryPro();
  void setItemList(Category c, Subcategory s, List<Item> ilist) {
    // List<Category> l = catpro.getreallofCat;
    _lofCategory
        .firstWhere((element) => element.name == c.name)
        .subcategories!
        .firstWhere((element) => (element.name == s.name))
        .items!
        .clear();
    _lofCategory
        .firstWhere((element) => element.name == c.name)
        .subcategories!
        .firstWhere((element) => (element.name == s.name))
        .items!
        .addAll(ilist);
  }

  void addItem(Category c, Subcategory s, Item i) {
    // List<Category> l = catpro.getreallofCat;
    _lofCategory
        .firstWhere((element) => element.name == c.name)
        .subcategories!
        .firstWhere((element) => (element.name == s.name))
        .items!
        .add(i);
    notifyListeners();
  }

  void delItem(Category c, Subcategory s, Item i) {
    // List<Category> l = catpro.getreallofCat;
    _lofCategory
        .firstWhere((element) => element.name == c.name)
        .subcategories!
        .firstWhere((element) => (element.name == s.name))
        .items!
        .remove(i);
    notifyListeners();
  }

  List<Item> getItemList(Category c, Subcategory s) {
    // List<Category> l = catpro.getlofCat;
    return _lofCategory
        .firstWhere((element) => element.name == c.name)
        .subcategories!
        .firstWhere((element) => (element.name == s.name))
        .items!;
  }
}
