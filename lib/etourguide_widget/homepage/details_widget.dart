import 'package:flutter/material.dart';
import 'package:flutter_etourguide/constraint.dart';
import 'package:flutter_etourguide/etouguide_view/rating_feedback_page_view.dart';
import 'package:flutter_etourguide/etourguide_model/event_model.dart';
import 'package:flutter_etourguide/etourguide_model/topic_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_exhibit_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_feedback_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_widget/homepage/exhibit_widget.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:easy_localization/easy_localization.dart';

class DetailsWidget extends StatefulWidget {
  Event event;
  Topic topic;
  String type;
  DetailsWidget({this.event, this.topic, this.type});
  @override
  _DetailsWidgetState createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  bool showDescription = false;
  @override
  void didUpdateWidget(covariant DetailsWidget oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.event != null) {
        Provider.of<ListFeedbackViewModel>(context, listen: false)
            .getFeedbackInEvent(widget.event.id);
      }
      if (widget.topic != null) {
        Provider.of<ListFeedbackViewModel>(context, listen: false)
            .getFeedbackInTopic(widget.topic.id);
      }
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.event != null) {
        Provider.of<ListFeedbackViewModel>(context, listen: false)
            .getFeedbackInEvent(widget.event.id);
      }
      if (widget.topic != null) {
        Provider.of<ListFeedbackViewModel>(context, listen: false)
            .getFeedbackInTopic(widget.topic.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    var listFeedback = Provider.of<ListFeedbackViewModel>(context);
    // print(widget.topic.id);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListExhibitViewModel()),
      ],
      child: SizedBox.expand(
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
            ),
            Container(
              //alignment: AlignmentDirectional.topStart,
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: widget.event != null
                          ? NetworkImage(widget.event.imageUrl)
                          : NetworkImage(widget.topic.imageUrl),
                      fit: BoxFit.fill)),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 2, top: 10, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      //alignment: AlignmentDirectional.topStart,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white.withOpacity(0.8),
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.5,
                maxChildSize: 0.7,
                builder: (BuildContext context, scrollController) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black38,
                              blurRadius: 5,
                              spreadRadius: 3,
                              offset: Offset(0, 2))
                        ]),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.006,
                            width: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Text(
                            widget.event != null
                                ? widget.event.name
                                : widget.topic.name,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 18,
                                fontFamily: 'Helve',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 12),
                          child: widget.event != null
                              ? Text(
                                  "${widget.event.startDate} - ${widget.event.endDate}",
                                  style: TextStyle(
                                      fontFamily: 'Helve',
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))
                              : null,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: widget.event != null
                                  ? EdgeInsets.only(top: 12)
                                  : null,
                              child: SmoothStarRating(
                                starCount: 5,
                                size: 14,
                                color: kPrimaryColor,
                                borderColor: kPrimaryColor,
                                rating: widget.event != null
                                    ? double.parse(widget.event.avgRating
                                        .toStringAsFixed(2))
                                    : double.parse(widget.topic.avgRating
                                        .toStringAsFixed(2)),
                                isReadOnly: true,
                                allowHalfRating: true,
                                spacing: 1,
                              ),
                            ),
                            Container(
                                padding: widget.event != null
                                    ? EdgeInsets.only(top: 12, left: 10)
                                    : EdgeInsets.only(left: 10),
                                child: Text(
                                  widget.event != null
                                      ? widget.event.avgRating
                                          .toStringAsFixed(2)
                                      : widget.topic.avgRating.toString(),
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontFamily: 'Helve'),
                                )),
                            Container(
                                padding: widget.event != null
                                    ? EdgeInsets.only(top: 12, left: 10)
                                    : EdgeInsets.only(left: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return MultiProvider(
                                          providers: [
                                            ChangeNotifierProvider(
                                                create: (_) =>
                                                    ListFeedbackViewModel())
                                          ],
                                          child: widget.event != null
                                              ? RatingFeedbackPageView(
                                                  eventId: widget.event.id,
                                                  totalRating:
                                                      widget.event.avgRating,
                                                  totalFeedback: widget
                                                      .event.totalFeedback,
                                                  listFeedback:
                                                      listFeedback.feedback,
                                                  type: widget.type,
                                                )
                                              : RatingFeedbackPageView(
                                                  topicId: widget.topic.id,
                                                  totalRating:
                                                      widget.topic.avgRating,
                                                  totalFeedback: widget
                                                      .topic.totalFeedback,
                                                  listFeedback:
                                                      listFeedback.feedback,
                                                  type: widget.type,
                                                ));
                                    }));
                                  },
                                  child: Text(
                                    'review',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Helve',
                                    ),
                                  ).tr(),
                                )),
                          ],
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 15),
                            child: Text('description',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.7),
                                        fontFamily: 'Helve',
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold))
                                .tr()),
                        Container(
//                                constraints: BoxConstraints(
//                                  maxWidth: MediaQuery.of(context).size.height - 300
//                                ),
                            padding: EdgeInsets.only(top: 10, right: 5),
                            child: Text(
                                widget.event != null
                                    ? widget.event.description
                                    : widget.topic.description,
                                maxLines: showDescription == true ? null : 1,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Helve',
                                  fontSize: 14,
                                ))),
                        Container(
                            padding: EdgeInsets.only(top: 5),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  showDescription = !showDescription;
                                });
                              },
                              child: Text(
                                      showDescription == true
                                          ? "show_shorten".tr()
                                          : "read_more".tr(),
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontFamily: 'Helve',
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.bold))
                                  .tr(),
                              //WidgetSpan(child: Icon(showDescription == false ? Icons.textsms_outlined : Icons.short_text, size: 15, color: Colors.black26,))
                            )),
                        Container(
                          padding: widget.event != null
                              ? const EdgeInsets.only(top: 15)
                              : EdgeInsets.only(top: 30),
                          child: Text('exhibit_in_event_label',
                                  style: TextStyle(
                                      fontFamily: 'Helve',
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold))
                              .tr(),
                        ),
                        widget.event != null
                            ? ExhibitWidget(
                                MediaQuery.of(context).size.width * 0.45,
                                MediaQuery.of(context).size.height * 0.15,
                                eventId: widget.event.id,
                                type: widget.type,
                              )
                            : ExhibitWidget(
                                MediaQuery.of(context).size.width * 0.41,
                                MediaQuery.of(context).size.height * 0.15,
                                topicId: widget.topic.id,
                                type: widget.type)
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
