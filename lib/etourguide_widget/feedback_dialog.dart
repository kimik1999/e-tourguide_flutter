import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_etourguide/constraint.dart';
import 'package:flutter_etourguide/etouguide_view/rating_feedback_page_view.dart';
import 'package:flutter_etourguide/etourguide_model/feedback_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_event_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_feedback_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_topic_viewmodel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:easy_localization/easy_localization.dart';

class FeedbackDialog extends StatefulWidget {
  int eventId;
  int topicId;
  String type;
  bool isFeedbackOnMap;
  FeedbackDialog({this.eventId, this.topicId, this.isFeedbackOnMap, this.type});
  @override
  _FeedbackDialogState createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  var username = TextEditingController();
  TextEditingController description = new TextEditingController();
  var userNameErr;
  bool userInvalid = false;
  double rate = 0;
  String text = "";
  @override
  Widget build(BuildContext context) {
    if (widget.type != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    userNameErr = 'username_err'.tr();
    return Container(
      height: MediaQuery.of(context).size.height * 0.74,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/mtgsystem_logo.png",
                  height: MediaQuery.of(context).size.height * 0.15,
                )),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'dialog_feedback_label',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Helve",
                    color: kPrimaryColor,
                    fontSize: 16),
              ).tr(),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              alignment: Alignment.center,
              child: SmoothStarRating(
                starCount: 5,
                size: 35,
                color: kPrimaryColor,
                borderColor: kPrimaryColor,
                //rating: widget.event != null ? double.parse(widget.event.avgRating.toStringAsFixed(2)) : double.parse(widget.topic.avgRating.toStringAsFixed(2)),
                isReadOnly: false,
                allowHalfRating: false,
                spacing: 1,
                onRated: (rating) {
                  rate = rating;
                },
              ),
            ),
            Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.red[800],
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
                  FilteringTextInputFormatter.deny(RegExp('^[0-9]+'))
                ],
                maxLength: 20,
                controller: username,
                decoration: InputDecoration(
                    errorText: userInvalid == true ? userNameErr : null,
                    hintText: 'your_name_hint'.tr()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))
                  ],
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  maxLength: 100,
                  controller: description,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'write_feedback_hint'.tr()),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: RaisedButton(
                    color: kPrimaryColor,
                    child: Text(
                      'cancel_button',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: "Helve"),
                    ).tr(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(8),
                  child: RaisedButton(
                    onPressed: () {
                      onSignTextField();
                      if (rate >= 1) {
                        setState(() {
                          text = "";
                        });

                        if (widget.eventId != null) {
                          if (userInvalid == false) {
                            Provider.of<ListEventViewModel>(context,
                                    listen: false)
                                .addFeedbackForAnEvent(new FeedBack(
                                    eventId: widget.eventId,
                                    visitorName: username.text,
                                    description: description != null
                                        ? description.text
                                        : "",
                                    rating: rate))
                                .then((int result) {
                              if (result == 1) {
                                if(widget.isFeedbackOnMap == true){
                                  Fluttertoast.showToast(
                                      msg:
                                      'feedback_msg'.tr(),
                                      toastLength: Toast.LENGTH_LONG);
                                  Navigator.pop(context);
                                } else {
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
//                                              totalRating: widget.totalR
//                                              ating,
                                                type: widget.type,
                                              ))));
                                  //Navigator.pop(context);

                                  Fluttertoast.showToast(
                                      msg:
                                      'feedback_msg'.tr(),
                                      toastLength: Toast.LENGTH_LONG);

                                }



                              } else {
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                    msg: 'feedback_err'.tr(),);
                              }
                            });
                          }
                        } else if (widget.topicId != null) {
                          if (userInvalid == false) {
                            Provider.of<ListTopicViewModel>(context,
                                    listen: false)
                                .addFeedbackForAnTopic(new FeedBack(
                                    topicId: widget.topicId,
                                    visitorName: username.text,
                                    description: description != null
                                        ? description.text
                                        : "",
                                    rating: rate))
                                .then((int result) {
                              if (result == 1) {
                                if(widget.isFeedbackOnMap == true){
                                  Fluttertoast.showToast(
                                      msg:
                                      'feedback_msg'.tr(),
                                      toastLength: Toast.LENGTH_LONG);
                                  Navigator.pop(context);
                                } else {
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
//                                              totalRating: widget.totalR
//                                              ating,
                                                type: widget.type,
                                              ))));
                                  Fluttertoast.showToast(
                                      msg:
                                      'feedback_msg'.tr(),
                                      toastLength: Toast.LENGTH_LONG);
                                }
                                //print('ahiihi');


                              } else {
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                  msg: 'feedback_err'.tr(),);
                              }
                            });
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: 'null_id'.tr());
                        }
                      } else {
                        setState(() {
                          text = "star_err".tr();
                        });
                      }
                    },
                    child: Text(
                      'send_button',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: "Helve"),
                    ).tr(),
                    color: kPrimaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
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
}
