import 'package:flutter/material.dart';
import 'package:flutter_etourguide/constraint.dart';
import 'package:flutter_etourguide/etouguide_view/details_page_view.dart';
import 'package:flutter_etourguide/etourguide_model/event_model.dart';
import 'package:flutter_etourguide/etourguide_model/topic_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_event_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_topic_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_widget/feedback_dialog.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:easy_localization/easy_localization.dart';

class MapFeedbackItem extends StatefulWidget {
  String item_name;
  Event event;
  Topic topic;
  String type;
  MapFeedbackItem({this.type, this.item_name, this.event, this.topic});
  @override
  _MapFeedbackItemState createState() => _MapFeedbackItemState();
}

class _MapFeedbackItemState extends State<MapFeedbackItem> {
  @override
  void initState() {
    if(widget.item_name.contains("event"))  
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ListEventViewModel>(context, listen: false).getAllEvent();

    });
    else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ListTopicViewModel>(context, listen: false).getAllTopic();
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var listEventItem = Provider.of<ListEventViewModel>(context);
    var listTopicItem = Provider.of<ListTopicViewModel>(context);
    if (widget.type != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          widget.event != null ?
          Container(
            margin: EdgeInsets.all(10),
            child: Text('viewed').tr(),
          ) : widget.topic != null ?
          Container(
            margin: EdgeInsets.all(10),
            child: Text('viewed').tr(),
          ) : Container(),
          widget.event == null ?
          Container() :
          getViewed(widget.event, null),
          widget.topic == null ?
          Container() :
          getViewed(null, widget.topic),
          Column(
              children: List.generate(
                  widget.item_name.contains("event")
                      ? listEventItem.events.length
                      : listTopicItem.topics.length, (index) {
            return Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        offset: Offset(1, 2),
                        spreadRadius: 1,
                        blurRadius: 2)
                  ]),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        if (widget.item_name.contains("event")) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) {
                                    return DetailsPageView(
                                      event: new Event(
                                          id: listEventItem.events[index].id,
                                          name: widget.type != null
                                              ? listEventItem.events[index].name_en
                                              : listEventItem.events[index].name,
                                          avgRating:
                                              listEventItem.events[index].rating,
                                          imageUrl:
                                              listEventItem.events[index].imageUrl,
                                          startDate: listEventItem
                                                      .events[index].startedDate !=
                                                  null
                                              ? listEventItem
                                                  .events[index].startedDate
                                              : "",
                                          endDate: listEventItem
                                                      .events[index].startedDate !=
                                                  null
                                              ? listEventItem.events[index].endDate
                                              : "",
                                          description: widget.type != null
                                              ? listEventItem
                                                  .events[index].description_en
                                              : listEventItem
                                                  .events[index].description,
                                          totalFeedback: listEventItem
                                              .events[index].totalFeedback),
                                      type: widget.type,
                                    );
                                  },
                                  settings:
                                      RouteSettings(name: "DetailsPageView")));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) {
                                    return DetailsPageView(
                                      topic: new Topic(
                                          id: listTopicItem.topics[index].id,
                                          name: widget.type != null
                                              ? listTopicItem.topics[index].name_en
                                              : listTopicItem.topics[index].name,
                                          avgRating:
                                              listTopicItem.topics[index].rating,
                                          imageUrl:
                                              listTopicItem.topics[index].imageUrl,
                                          startDate: listTopicItem
                                                      .topics[index].startedDate !=
                                                  null
                                              ? listTopicItem
                                                  .topics[index].startedDate
                                              : "",
                                          description: widget.type != null
                                              ? listTopicItem
                                                  .topics[index].description_en
                                              : listTopicItem
                                                  .topics[index].description,
                                          totalFeedback: listTopicItem
                                              .topics[index].totalFeedback),
                                      type: widget.type,
                                    );
                                  },
                                  settings:
                                      RouteSettings(name: "DetailsPageView")));
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2,
                                spreadRadius: 1)
                          ],
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: widget.item_name.contains("event")
                                  ? NetworkImage(
                                      "${listEventItem.events[index].imageUrl}")
                                  : NetworkImage(
                                      "${listTopicItem.topics[index].imageUrl}")),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(8, 5, 5, 5),
                          child: Text(
                            widget.type != null &&
                                    widget.item_name.contains("event")
                                ? "${listEventItem.events[index].name_en}"
                                : widget.type != null &&
                                        widget.item_name.contains("topic")
                                    ? "${listTopicItem.topics[index].name_en}"
                                    : widget.type == null &&
                                            widget.item_name.contains("event")
                                        ? "${listEventItem.events[index].name}"
                                        : "${listTopicItem.topics[index].name}",
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 5, 5, 5),
                          child: SmoothStarRating(
                            color: kPrimaryColor,
                            borderColor: kPrimaryColor,
                            size: 12,
                            rating: widget.item_name.contains("event")
                                ? listEventItem.events[index].rating
                                : listTopicItem.topics[index].rating,
                            starCount: 5,
                            isReadOnly: true,
                            allowHalfRating: true,
                            spacing: 0.5,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          height: 40,
                          margin: EdgeInsets.only(left: 15),
                          padding: EdgeInsets.fromLTRB(8, 5, 5, 5),
                          child: RaisedButton(
                            color: kPrimaryColor,
                            child: Text(
                              'review',
                              style: TextStyle(
                                  fontFamily: "Helve",
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ).tr(),
                            onPressed: () {
                              widget.item_name.contains("event")
                                  ? showRatingDialog(
                                      listEventItem.events[index].id, null)
                                  : showRatingDialog(
                                      null, listTopicItem.topics[index].id);
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          })),
        ],
      ),
    );
  }

  void showRatingDialog(int eventId, int topicId) async {
    await showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 50),
              child: Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15.0)), //this right here
                  child: MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                            create: (_) => ListEventViewModel()),
                        ChangeNotifierProvider(
                            create: (_) => ListTopicViewModel())
                      ],
                      child: FeedbackDialog(
                        eventId: eventId,
                        topicId: topicId,
                        isFeedbackOnMap: true,
                        type: widget.type,
                      ))),
            ),
          );
        });
  }

  Widget getViewed(Event event, Topic topic){
    Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black38,
                offset: Offset(1, 2),
                spreadRadius: 1,
                blurRadius: 2)
          ]),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) {
                          return DetailsPageView(
                            event: widget.event != null && widget.item_name.contains("event")? new Event(
                                id: widget.event.id,
                                name: widget.type != null
                                    ? widget.event.name_en
                                    : widget.event.name,
                                avgRating:
                                widget.event.avgRating,
                                imageUrl:
                                widget.event.imageUrl,
                                startDate: widget.event.startDate !=
                                    null
                                    ? widget.event.startDate
                                    : "",
                                endDate: widget.event.endDate !=
                                    null
                                    ? widget.event.endDate
                                    : "",
                                description: widget.type != null
                                    ? widget.event.description_en
                                    : widget.event.description,
                                totalFeedback: widget.event.totalFeedback) : null,
                            type: widget.type,
                            topic: widget.topic != null && widget.item_name.contains("topic") ? new Topic(
                                id: widget.topic.id,
                                name: widget.type != null
                                    ? widget.topic.name_en
                                    : widget.topic.name,
                                avgRating:
                                widget.topic.avgRating,
                                imageUrl:
                                widget.topic.imageUrl,
                                startDate: widget.topic.startDate !=
                                    null
                                    ? widget.topic.startDate
                                    : "",
                                description: widget.type != null
                                    ? widget.topic.description_en
                                    : widget.topic.description,
                                totalFeedback: widget.topic.totalFeedback) : null,
                          );
                        },
                        settings:
                        RouteSettings(name: "DetailsPageView")));

              },
              child: Container(
                width: 100,
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        spreadRadius: 1)
                  ],
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: widget.event != null
                          ? NetworkImage(
                          "${widget.event.imageUrl}")
                          : NetworkImage(
                          "${widget.topic.imageUrl}")),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(8, 5, 5, 5),
                  child: Text(
                    widget.type != null &&
                        widget.item_name.contains("event") && widget.event != null
                        ? "${widget.event.name_en}"
                        : widget.type != null &&
                        widget.item_name.contains("topic") && widget.topic != null
                        ? "${widget.topic.name_en}"
                        : widget.type == null &&
                        widget.item_name.contains("event") && widget.event != null
                        ? "${widget.event.name}"
                        : "${widget.topic.name}",
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8, 5, 5, 5),
                  child: SmoothStarRating(
                    color: kPrimaryColor,
                    borderColor: kPrimaryColor,
                    size: 12,
                    rating: widget.item_name.contains("event") && widget.event != null
                        ? widget.event.avgRating
                        : widget.topic.avgRating,
                    starCount: 5,
                    isReadOnly: true,
                    allowHalfRating: true,
                    spacing: 0.5,
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  height: 40,
                  margin: EdgeInsets.only(left: 15),
                  padding: EdgeInsets.fromLTRB(8, 5, 5, 5),
                  child: RaisedButton(
                    color: kPrimaryColor,
                    child: Text(
                      'review',
                      style: TextStyle(
                          fontFamily: "Helve",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ).tr(),
                    onPressed: () {
                      widget.item_name.contains("event") && widget.event !=null
                          ? showRatingDialog(
                          widget.event.id, null)
                          : showRatingDialog(
                          null, widget.topic.id);
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
