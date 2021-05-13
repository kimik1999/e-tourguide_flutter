import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_etourguide/constraint.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_event_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_exhibit_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_topic_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_widget/categorypage/carousel_slider_widget.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class FavoritePageView extends StatefulWidget {
  String type;
  FavoritePageView({this.type});
  @override
  _FavoritePageViewState createState() => _FavoritePageViewState();
}

class _FavoritePageViewState extends State<FavoritePageView>
    with AutomaticKeepAliveClientMixin<FavoritePageView> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.type != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListEventViewModel()),
        ChangeNotifierProvider(create: (_) => ListTopicViewModel()),
        ChangeNotifierProvider(create: (_) => ListExhibitViewModel())
      ],
      child: DefaultTabController(
          length: 3,
          child: Scaffold(backgroundColor: Colors.white, body: menu())),
    );
  }

  Widget menu() {
    return SafeArea(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Text(
              "favorite",
              style: TextStyle(
                  fontFamily: "Helve",
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                  color: Colors.black45),
              textAlign: TextAlign.start,
            ).tr(),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TabBar(
              labelColor: kPrimaryColor,
              unselectedLabelColor: Colors.black26,
              indicatorColor: Colors.blueAccent,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: UnderlineTabIndicator(
                  insets: EdgeInsets.only(left: 52, right: 52),
                  borderSide: BorderSide(width: 2, color: Colors.black)),
//                indicator: BoxDecoration(
//                    color: Colors.black,
//                    borderRadius: BorderRadius.all(Radius.circular(30))
//                ),
              labelStyle: TextStyle(
                fontFamily: "Helve",
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(
                  child: Align(
                      alignment: Alignment.center,
                      child: Text('all_event_label').tr()),
                ),
                Tab(
                  child: Align(
                      alignment: Alignment.center,
                      child: Text('all_topic_label').tr()),
                ),
                Tab(
                  child: Align(
                      alignment: Alignment.center,
                      child: Text('all_exhibit_label').tr()),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                Container(
                  color: Colors.white,
                  child: CarouselSliderWidget(
                    tab_name: "event",
                    type: widget.type,
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: CarouselSliderWidget(
                    tab_name: "topic",
                    type: widget.type,
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: CarouselSliderWidget(
                    tab_name: "exhibit",
                    type: widget.type,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
