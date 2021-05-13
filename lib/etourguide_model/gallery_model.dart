import 'package:flutter/cupertino.dart';

class Gallery {
  String name;
  IconData icon;
  String imageUrl;

  Gallery({this.name, this.icon, this.imageUrl});

  String get Name {
    return name;
  }

  String get ImageUrl {
    return imageUrl;
  }

  IconData get Icon {
    return icon;
  }
}
