import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_etourguide/etouguide_view/details_page_view.dart';
import 'package:flutter_etourguide/etourguide_model/topic_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/topic_viewmodel.dart';

class TopicWidget extends StatelessWidget {
  double height;
  double width;
  TopicWidget(this.height, this.width);
  TopicViewModel topicViewModel = new TopicViewModel();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 14),
      height: height,
      color: Colors.white,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: topicViewModel.ListTopic.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailsPageView(
                      topic: new Topic(
                          name: topicViewModel.ListTopic[index].name,
                          avgRating: topicViewModel.ListTopic[index].avgRating,
                          imageUrl: topicViewModel.ListTopic[index].imageUrl,
                          description:
                              topicViewModel.ListTopic[index].description));
                }));
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(14, 14, 2, 14),
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.blueAccent),
              ),
            );
          }),
    );
  }
}
