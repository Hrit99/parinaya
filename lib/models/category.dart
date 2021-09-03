import 'package:flutter/material.dart';
import 'package:parinaya/models/subcategory.dart';

class Category {
  String? name;
  List<Subcategory>? subcategories;
  Category({@required this.name, @required this.subcategories});
}
