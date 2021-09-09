import 'dart:io';

import 'package:flutter/material.dart';
import 'package:parinaya/models/subcategory.dart';

class Category {
  String? name;
  List<Subcategory>? subcategories;
  String? cimglink;
  Category({
    @required this.name,
    @required this.subcategories,
    @required this.cimglink,
  });
}
