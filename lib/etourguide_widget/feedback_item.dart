import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_etourguide/constraint.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/feedback_viewmodel.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FeedbackItem extends StatefulWidget {
  List<FeedbackViewModel> listFeedback;
  int index;
  FeedbackItem({this.listFeedback, this.index});
  @override
  _FeedbackItemState createState() => _FeedbackItemState();
}

class _FeedbackItemState extends State<FeedbackItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.92,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black26,
          spreadRadius: 0.2,
          blurRadius: 0.4,
          offset: Offset(0, 1),
        ),
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
//            margin: EdgeInsets.only(top: 10),
//            height: MediaQuery.of(context).size.height * 0.08,
//            width: MediaQuery.of(context).size.width * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            kPrimaryColor,
                            Colors.green[600],
                            Colors.green[500],
                          ])),
                  child: Icon(
                    Icons.account_circle,
                    size: 45,
                    color: Colors.white,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: 10, top: 15),
                            child: Text(
                              widget.listFeedback[widget.index].visitorName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Helve",
                                  fontSize: 16),
                            )),
                        Container(
                            margin: EdgeInsets.only(
                              top: 15,
                            ),
                            child: Text(
                              "- ${widget.listFeedback[widget.index].createdDate}",
                              style: TextStyle(
                                  fontFamily: "Helve",
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: SmoothStarRating(
                            starCount: 5,
                            size: 14,
                            color: kPrimaryColor,
                            borderColor: kPrimaryColor,
                            rating: widget.listFeedback != null
                                ? double.parse(widget
                                    .listFeedback[widget.index].rating
                                    .toStringAsFixed(2))
                                : 0,
                            isReadOnly: true,
                            allowHalfRating: true,
                            spacing: 1,
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              widget.listFeedback[widget.index].rating
                                  .toString(),
                              style: TextStyle(
                                  fontFamily: "Helve",
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.only(left: 10),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9),
              child: Text(widget.listFeedback[widget.index].description),
            ),
          )
        ],
      ),
    );
  }
}
