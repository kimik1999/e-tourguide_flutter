import 'package:flutter/material.dart';
import 'package:flutter_etourguide/constraint.dart';
import 'package:flutter_etourguide/etourguide_model/event_model.dart';
import 'package:flutter_etourguide/etourguide_model/topic_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_event_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_topic_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_widget/mappage/map_feedback_item.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class TabFeedbackMap extends StatefulWidget {
  String type;
  Event event;
  Topic topic;
  TabFeedbackMap({this.type, this.event, this.topic});
  @override
  _TabFeedbackMapState createState() => _TabFeedbackMapState();
}

class _TabFeedbackMapState extends State<TabFeedbackMap> {

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    if(widget.type != null){
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListEventViewModel()),
        ChangeNotifierProvider(create: (_) => ListTopicViewModel())
      ],
      child: DefaultTabController(
          length: 2,
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Scaffold(
                backgroundColor: Colors.white,
                bottomNavigationBar: FlatButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text('close_button',
                    style: TextStyle(
                        fontFamily: "Helve",
                        color: kPrimaryColor,
                      fontWeight: FontWeight.bold
                    ),).tr(),),
                body: menu(),
              ),
            ),
          )),
    );
  }

  Widget menu() {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 15),
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: kPrimaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: kPrimaryColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.white,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                  color: kPrimaryColor,
                ),
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                    print(selectedIndex);
                  });
                },
                tabs: [
                  Tab(
                    child: Align(
                        alignment: Alignment.center, child: Text('all_event_label').tr()),
                  ),
                  Tab(
                    child: Align(
                        alignment: Alignment.center, child: Text('all_topic_label').tr()),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    color: Colors.white,
                    child: MapFeedbackItem(
                      type: widget.type,
                      item_name: "event",
                      event: widget.event,
                    ),
                  ),
                  Container(
                      color: Colors.white,
                      child: MapFeedbackItem(
                        type: widget.type,
                        item_name: "topic",
                        topic: widget.topic,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
