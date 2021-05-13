import 'package:flutter/material.dart';
class AnimatedItem {
  String title;
  IconData icon;
  Color iconColor;
  int index;
  AnimatedItem({this.title, this.icon, this.iconColor, this.index});

  String get Title{
    return title;
  }
  IconData get Icon{
    return icon;
  }
  Color get IconColor{
    return iconColor;
  }
  int get Index{
    return this.index;
  }
  set Index(int index){
    this.index = index;
  }
}