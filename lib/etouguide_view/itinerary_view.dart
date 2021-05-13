import 'package:flutter/material.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_exhibit_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_widget/durationpage/duration_widget.dart';
import 'package:flutter_etourguide/etourguide_widget/homepage/gridview_widget.dart';
import 'package:provider/provider.dart';

class ItineraryView extends StatefulWidget {
  int eventId;
  int topicId;
  ItineraryView({this.eventId, this.topicId});

  @override
  _ItineraryViewState createState() => _ItineraryViewState();
}

class _ItineraryViewState extends State<ItineraryView> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListExhibitViewModel()),
      ],
      child: DefaultTabController(
          length: 2,
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                shadowColor: Colors.transparent,
                backgroundColor: Colors.black,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Choose Itinerary",
                      style: TextStyle(
                          fontFamily: "CourNew",
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                          color: Colors.white),
                    ),
                    Text(""),
                  ],
                ),
                bottom: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(width: 2, color: Colors.white)),
                  labelStyle: TextStyle(
                    fontFamily: "CourNew",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  tabs: [
                    Tab(
                      child: Align(
                          alignment: Alignment.center, child: Text("Exhibit")),
                    ),
                    Tab(
                      child: Align(
                          alignment: Alignment.center, child: Text("Duration")),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  Container(
                    color: Colors.white,
                    child: widget.eventId != null
                        ? GridViewWidget(eventId: widget.eventId)
                        : GridViewWidget(
                            topicId: widget.topicId,
                          ),
                  ),
                  Container(
                    color: Colors.white,
                    child: DurationWidget(),
                  ),
                ],
              ),
            ),
          )),
    );
    ;
  }
}
