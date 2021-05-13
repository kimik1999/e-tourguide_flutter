import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_event_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_exhibit_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_searchdata_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_widget/gallerypage/category_item.dart';
import 'package:flutter_etourguide/etourguide_widget/homepage/event_widget.dart';
import 'package:flutter_etourguide/etourguide_widget/homepage/exhibit_widget.dart';
import 'package:flutter_etourguide/etourguide_widget/search_widget.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePageView extends StatefulWidget {
  String type;
  HomePageView({this.type});
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with AutomaticKeepAliveClientMixin<HomePageView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    //print("${widget.type} home");
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    } else {}
    if (widget.type != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListEventViewModel()),
        ChangeNotifierProvider(create: (_) => ListExhibitViewModel()),
        ChangeNotifierProvider(create: (_) => ListSearchDataViewModel()),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchWidget(
                    type: widget.type,
                  ),
                  EventWidget(
                    type: widget.type,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 5, 0, 0),
                    child: Text(
                      'new_exhibit_label',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.65),
                          fontSize: 20,
                          fontFamily: "Helve"),
                    ).tr(),
                  ),
                  ExhibitWidget(
                    MediaQuery.of(context).size.width * 0.4,
                    MediaQuery.of(context).size.height * 0.25,
                    type: widget.type,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 5, 15, 15),
                    child: Text(
                      'type',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.65),
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Helve',
                          fontSize: 20),
                    ).tr(),
                  ),
                  Category(
                    type: widget.type,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
