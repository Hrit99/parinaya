import 'package:flutter/material.dart';
import 'package:parinaya/models/item.dart';

class Subcategory {
  String? name;
  List<Item>? items;
  String? scimglink;
  Subcategory(
      {@required this.name, @required this.items, @required this.scimglink});
}
