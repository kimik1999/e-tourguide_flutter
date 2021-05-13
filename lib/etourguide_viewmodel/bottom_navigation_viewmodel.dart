import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_etourguide/constraint.dart';
import 'package:flutter_etourguide/etourguide_model/bottom_navigation_model.dart';
import 'package:easy_localization/easy_localization.dart';

class AnimatedItemViewModel extends StatefulWidget {
  List<AnimatedItem> items;
  Duration animationDuration;
  final Function onBarTap;
  int index_setting;
  String title;
  String type;

  AnimatedItemViewModel(
      {List<AnimatedItem> item,
      Duration duration,
      this.onBarTap,
      this.index_setting,
      this.title,
      this.type});

  List<AnimatedItem> get ListItem {
    items = [
      AnimatedItem(title: "Home", icon: Icons.home, iconColor: kPrimaryColor),
      AnimatedItem(
          title: "Favorite", icon: Icons.favorite, iconColor: kPrimaryColor),
      AnimatedItem(title: "Tour", icon: Icons.tour, iconColor: kPrimaryColor),
      AnimatedItem(title: "Map", icon: Icons.map, iconColor: kPrimaryColor),
      AnimatedItem(
          title: "QR", icon: Icons.qr_code_scanner, iconColor: kPrimaryColor),
    ];
    return items;
  }

  Duration get AnimationDuration {
    animationDuration = const Duration(milliseconds: 500);
    return animationDuration;
  }

  @override
  _AnimatedItemViewModelState createState() => _AnimatedItemViewModelState();
}

class _AnimatedItemViewModelState extends State<AnimatedItemViewModel>
    with TickerProviderStateMixin {
  String default_title = "Map";
  int selectedIndex = 0;
  List<AnimatedItem> items = [];
  @override
  Widget build(BuildContext context) {
    if (widget.type != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    items = [
      AnimatedItem(
          title: 'home_menu'.tr(), icon: Icons.home, iconColor: kPrimaryColor),
      AnimatedItem(
          title: 'favorite_menu'.tr(),
          icon: Icons.favorite,
          iconColor: kPrimaryColor),
      AnimatedItem(
          title: 'duration_menu'.tr(),
          icon: Icons.tour,
          iconColor: kPrimaryColor),
      AnimatedItem(
          title: 'map_menu'.tr(), icon: Icons.map, iconColor: kPrimaryColor),
      AnimatedItem(
          title: 'scan_menu'.tr(),
          icon: Icons.qr_code_scanner,
          iconColor: kPrimaryColor),
    ];
    // widget.index_setting > 0 ? selectedIndex = widget.index_setting : selectedIndex;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 12, top: 12, right: 10, left: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildAnimatedItem(),
        ),
      ),
    );
  }

  List<Widget> _buildAnimatedItem() {
    List<Widget> _items = List();
    for (int i = 0; i < items.length; i++) {
      AnimatedItem item = items[i];
      bool isSelected;

      if (default_title.contains("Map")) {
        // selectedIndex = widget.index_setting;
        if (widget.index_setting > 0) {
          selectedIndex = widget.index_setting;
          isSelected = selectedIndex == i;
        } else {
          isSelected = selectedIndex == i;
        }
        //isSelected = widget.index_setting == i;
      } else {
        isSelected = selectedIndex == i;
      }

      _items.add(InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            default_title = items[i].title;
            // print(default_title);
            selectedIndex = i;
            widget.onBarTap(selectedIndex);
          });
        },
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          duration: widget.AnimationDuration,
          decoration: BoxDecoration(
            color: isSelected ? item.iconColor.withOpacity(0.1) : null,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Row(
            children: <Widget>[
              Icon(item.Icon, color: isSelected ? item.IconColor : Colors.grey),
              AnimatedSize(
                duration: widget.AnimationDuration,
                curve: Curves.easeInOut,
                vsync: this,
                child: Text(
                  isSelected ? item.Title : "",
                  style: TextStyle(fontSize: 16, color: item.IconColor),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return _items;
  }
}
