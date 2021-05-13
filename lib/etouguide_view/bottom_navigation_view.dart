import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_etourguide/etouguide_view/connection_widget.dart';
import 'package:flutter_etourguide/etouguide_view/favoritepage_view.dart';
import 'package:flutter_etourguide/etouguide_view/homepage_view.dart';
import 'package:flutter_etourguide/etouguide_view/mappage_view.dart';
import 'package:flutter_etourguide/etouguide_view/scanpage_view.dart';
import 'package:flutter_etourguide/etouguide_view/tour_duration_page_view.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/bottom_navigation_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/floorplan_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_exhibit_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_icon_room_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/map_upload_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/position_text_vm_api.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/route_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/route_vm_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class BottomNavigationView extends StatefulWidget {
  String type;
  int index_setting;
  RouteViewModel args;
//List ViewPage = [new HomePageView(), new FavoritePageView(), new MapPageView(), new GalleryPageView()];

  BottomNavigationView({this.index_setting, this.type, this.args});
  @override
  _BottomNavigationViewState createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  AnimatedItemViewModel animatedItemViewModel = new AnimatedItemViewModel();
  int selectedIndex;
  List<Widget> viewPage;
  PageController _pageController;
  DateTime backButtonPressTime;
  @override
  void initState() {
    if (widget.index_setting != null && widget.index_setting > 0) {
      // print(widget.index_setting);
      selectedIndex = widget.index_setting;
    } else {
      selectedIndex = 0;
    }

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.args != null) {
      if (widget.args.type != null) {
        context.locale = Locale('en', 'US');
      } else {
        context.locale = Locale('vi', 'VN');
        widget.type = null;
      }
    } else {
      //not call Map route, be like: widget.type = args.type
      if (widget.type != null) {
        context.locale = Locale('en', 'US');
      } else {
        context.locale = Locale('vi', 'VN');
      }
    }
    //print("bottom ${widget.type}");
    viewPage = [
      HomePageView(
        type: widget.args != null ? widget.args.type : widget.type,
      ),
      FavoritePageView(
        type: widget.args != null ? widget.args.type : widget.type,
      ),
      TourDurationPageView(
        type: widget.args != null ? widget.args.type : widget.type,
      ),
      MapPageView(
        type: widget.args != null ? widget.args.type : widget.type,
      ),
      ScanPageView(
        type: widget.args != null ? widget.args.type : widget.type,
      )
    ];
    _pageController = PageController(initialPage: selectedIndex);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FloorPlanViewModel()),
        ChangeNotifierProvider(create: (_) => ListExhibitViewModel()),
        ChangeNotifierProvider(create: (_) => MapUploadViewModel()),
        ChangeNotifierProvider(create: (_) => ListIconRoomViewModel()),
        ChangeNotifierProvider(create: (_) => RouteVMApi()),
        ChangeNotifierProvider(create: (_) => PositionTextVMApi()),
      ],
      child: Scaffold(
        body: WillPopScope(
          onWillPop: onWillPop,
          child: Stack(alignment: AlignmentDirectional.topCenter, children: [
            PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: viewPage,
            ),
            ConnectionWidget(
              type: widget.args != null ? widget.args.type : widget.type,
            )
          ]),
        ),
        bottomNavigationBar: AnimatedItemViewModel(
          type: widget.type,
          item: animatedItemViewModel.ListItem,
          duration: animatedItemViewModel.AnimationDuration,
          index_setting:
              widget.index_setting != null ? widget.index_setting : 0,
          title: widget.index_setting != null
              ? widget.index_setting == 2
                  ? "Tour"
                  : "Map"
              : null,
          onBarTap: (index) {
            setState(() {
              selectedIndex = index;
              _pageController.jumpToPage(index);
            });
          },
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButton = backButtonPressTime == null ||
        currentTime.difference(backButtonPressTime) > Duration(seconds: 3);
    if (backButton) {
      backButtonPressTime = currentTime;
      Fluttertoast.showToast(msg: 'exit_app'.tr());
      return false;
    }
    SystemNavigator.pop();
  }
}
