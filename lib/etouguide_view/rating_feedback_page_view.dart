import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_etourguide/constraint.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/feedback_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_event_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_feedback_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_topic_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_widget/feedback_dialog.dart';
import 'package:flutter_etourguide/etourguide_widget/feedback_item.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingFeedbackPageView extends StatefulWidget {
  int eventId;
  int topicId;
  double totalRating;
  int totalFeedback;
  List<FeedbackViewModel> listFeedback;
  String type;
  RatingFeedbackPageView(
      {this.eventId,
      this.topicId,
      this.totalRating,
      this.totalFeedback,
      this.listFeedback,
      this.type});
  @override
  _RatingFeedbackPageViewState createState() => _RatingFeedbackPageViewState();
}

class _RatingFeedbackPageViewState extends State<RatingFeedbackPageView> {
  int progress_review_length = 5;
  var username = TextEditingController();
  TextEditingController description = new TextEditingController();
  var userNameErr = "Độ dài tên tối thiểu > 3 ký tự";
  bool userInvalid = false;
  int lengthOfList = 0;
  @override
  void didUpdateWidget(covariant RatingFeedbackPageView oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.eventId != null) {
        Provider.of<ListFeedbackViewModel>(context, listen: false)
            .getFeedbackInEvent(widget.eventId);
      }
      if (widget.topicId != null) {
        Provider.of<ListFeedbackViewModel>(context, listen: false)
            .getFeedbackInTopic(widget.topicId);
      }
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.eventId != null) {
        Provider.of<ListFeedbackViewModel>(context, listen: false)
            .getFeedbackInEvent(widget.eventId);
      }
      if (widget.topicId != null) {
        Provider.of<ListFeedbackViewModel>(context, listen: false)
            .getFeedbackInTopic(widget.topicId);
      }
    });
    super.initState();
  }

  Future<List<FeedbackViewModel>> refreshList(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3));
    var listFb = Provider.of<ListFeedbackViewModel>(context);
    return listFb.feedback;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    var listFb = Provider.of<ListFeedbackViewModel>(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  pageBuilder: (a, b, c) => MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                                create: (_) => ListFeedbackViewModel())
                          ],
                          child: RatingFeedbackPageView(
                            topicId: widget.topicId,
                            eventId: widget.eventId,
                            totalRating: widget.totalRating,
                            type: widget.type,
                          ))));
          return Future.value(true);
        },
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 25),
                      height: 50,
                      width: 50,
                      //alignment: AlignmentDirectional.topStart,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).popUntil((route) {
                            return route.settings.name == "DetailsPageView";
                          });
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black45.withOpacity(0.8),
                          size: 22,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 25),
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        'rating_and_review',
                        style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Helve',
                            fontSize: 20),
                      ).tr(),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 0.25,
                      )
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          kPrimaryColor,
                          Colors.green[600],
                          Colors.green[500],
                        ]),
                  ),
                  height: MediaQuery.of(context).size.height * 0.265,
                  width: MediaQuery.of(context).size.width * 0.92,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 18, 25, 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Text(
                                avgRating(context).toStringAsFixed(2),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    fontFamily: "Helve"),
                              ),
                            ),
                            Container(
                              child: SmoothStarRating(
                                starCount: 5,
                                size: 14,
                                color: Colors.white,
                                borderColor: Colors.white,
                                //rating: widget.event != null ? double.parse(widget.event.avgRating.toStringAsFixed(2)) : double.parse(widget.topic.avgRating.toStringAsFixed(2)),
                                isReadOnly: true,
                                allowHalfRating: true,
                                spacing: 1,
                              ),
                            ),
                            Container(
                              child: Text(
                                "${listFb.feedback.length.toString()} " +
                                    'review'.tr(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: "Helve"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              List.generate(progress_review_length, (index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${progress_review_length - index}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Helve",
                                      fontWeight: FontWeight.bold),
                                ),
                                LinearPercentIndicator(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  lineHeight: 5.0,
                                  percent: listFb.feedback.length > 0
                                      ? ratingPercent(
                                          progress_review_length - index)
                                      : 0,
                                  progressColor: Colors.white,
                                  backgroundColor: Colors.black.withOpacity(0.3),
                                ),
                              ],
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.12,
                width: MediaQuery.of(context).size.width * 0.92,
                margin: EdgeInsets.only(top: 15),
                child: RaisedButton(
                  onPressed: () {
                    showRatingDialog();
                  },
                  color: Colors.white,
                  child: Text(
                    'write_feedback',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontFamily: "Helve",
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ).tr(),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                    child: Stack(children: <Widget>[
                      listFb.feedback.length > 0
                          ? ListView(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              children:
                                  List.generate(listFb.feedback.length, (index) {
                                return FeedbackItem(
                                  listFeedback: listFb.feedback,
                                  index: index,
                                );
                              }),
                            )
                          : ListView(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              children: List.generate(1, (index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      top: 30, right: 10, left: 10),
                                  alignment: Alignment.center,
                                  child: Text(
                                    widget.topicId != null
                                        ? 'label_feedback_topic'
                                        : 'label_feedback_event',
                                    style: TextStyle(
                                        fontSize: 18, fontFamily: "Helve"),
                                  ).tr(),
                                );
                              }),
                            ),
//                    Center(
//                      child: Text(
//                        widget.topicId != null
//                            ? 'label_feedback_topic'
//                            : 'label_feedback_event',
//                        style: TextStyle(fontSize: 18, fontFamily: "Helve"),
//                      ).tr(),
//                    ),
                    ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showRatingDialog() async {
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
                        eventId: widget.eventId,
                        topicId: widget.topicId,
                        type: widget.type,
                      ))),
            ),
          );
        });
  }

  void onSignTextField() {
    setState(() {
      if (username.text.length < 3) {
        userInvalid = true;
      } else {
        userInvalid = false;
      }
    });
  }

  double avgRating(BuildContext context) {
    double totalRating = 0;
    double avgRating = 0;
    var listFb = Provider.of<ListFeedbackViewModel>(context);
    if (listFb.feedback.length > 0) {
      for (int i = 0; i < listFb.feedback.length; i++) {
        totalRating = totalRating + listFb.feedback[i].rating;
      }
      avgRating = totalRating / listFb.feedback.length;
    } else {
      avgRating = 0;
    }
    return avgRating;
  }

  double ratingPercent(int index) {
    int count = 0;
    var listFb = Provider.of<ListFeedbackViewModel>(context);
    for (int i = 0; i < listFb.feedback.length; i++) {
      if (listFb.feedback[i].rating
          .toString()
          .contains("${index.toString()}.")) {
        count = count + 1;
      }
    }

    //print(count);
    double ratingPercent = double.parse(count.toString()) /
        double.parse(listFb.feedback.length.toString());
    //print(ratingPercent);
    return ratingPercent;
  }

  Future<bool> _onWillPop() async {
    Navigator.of(context).popUntil((route) {
      return route.settings.name == "DetailsPageView";
    });
  }
}
