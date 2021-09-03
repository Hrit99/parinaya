import 'package:flutter/material.dart';

class Item {
  String? name;
  String? detail;
  List<dynamic>? imageFolderLink;
  String? id;
  Item(
      {@required this.id,
      @required this.name,
      @required this.detail,
      @required this.imageFolderLink});
}
