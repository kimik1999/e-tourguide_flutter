import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_etourguide/constraint.dart';
import 'package:flutter_etourguide/etourguide_model/event_model.dart';
import 'package:flutter_etourguide/etourguide_model/topic_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_event_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_exhibit_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_feedback_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_topic_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/route_vm_api.dart';
import 'package:flutter_etourguide/etourguide_widget/homepage/details_widget.dart';
import 'package:flutter_etourguide/etourguide_widget/homepage/gridview_widget.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class DetailsPageView extends StatefulWidget {
  Event event;
  Topic topic;
  String type;
  DetailsPageView({this.event, this.topic, this.type});
  @override
  _DetailsPageViewState createState() => _DetailsPageViewState();
}

class _DetailsPageViewState extends State<DetailsPageView> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListExhibitViewModel()),
        ChangeNotifierProvider(create: (_) => ListFeedbackViewModel()),
        ChangeNotifierProvider(create: (_) => ListEventViewModel()),
        ChangeNotifierProvider(create: (_) => ListTopicViewModel()),
      ],
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 80,
          color: Colors.white,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                        color: kPrimaryColor,
                        blurRadius: 3,
                        offset: Offset(2, 2))
                  ]),
              height: 40,
              width: MediaQuery.of(context).size.width * 0.5,
              child: RaisedButton.icon(
                label: Text('discover',
                        style: TextStyle(
                            fontFamily: 'Helve',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))
                    .tr(),
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white.withOpacity(0.8),
                  size: 14,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return widget.event != null
                        ? MultiProvider(
                            providers: [
                                ChangeNotifierProvider(
                                    create: (_) => ListExhibitViewModel()),
                                ChangeNotifierProvider(
                                    create: (_) => ListEventViewModel()),
                                ChangeNotifierProvider(
                                    create: (_) => ListTopicViewModel()),
                                ChangeNotifierProvider(
                                    create: (_) => RouteVMApi()),
                              ],
                            child: GridViewWidget(
                              eventId: widget.event.id,
                              type: widget.type,
                              event: widget.event,
                            ))
                        : MultiProvider(
                            providers: [
                                ChangeNotifierProvider(
                                    create: (_) => ListExhibitViewModel()),
                                ChangeNotifierProvider(
                                    create: (_) => ListEventViewModel()),
                                ChangeNotifierProvider(
                                    create: (_) => ListTopicViewModel()),
                                ChangeNotifierProvider(
                                    create: (_) => RouteVMApi()),
                              ],
                            child: GridViewWidget(
                              topicId: widget.topic.id,
                              type: widget.type,
                              topic: widget.topic,
                            ));
                  }));
                },
                //color: Color(0xFF76c6bd),
                color: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                //child: Text("View Direction",
                // style: TextStyle(fontFamily: 'CourNew', color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
        body: DetailsWidget(
          event: widget.event,
          topic: widget.topic,
          type: widget.type,
        ),
      ),
    );
  }
}
