import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_event_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_exhibit_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_topic_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_widget/categorypage/carousel_constructor.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class CarouselSliderWidget extends StatefulWidget {
  String tab_name;
  String type;
  CarouselSliderWidget({this.tab_name, this.type});
  @override
  _CarouselSliderWidgetState createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> with AutomaticKeepAliveClientMixin {

  int _currentIndex = 0;
  List img_tmp = [
    "https://img.freepik.com/free-photo/abstract-surface-textures-white-concrete-stone-wall_74190-8184.jpg?size=626&ext=jpg",
    "https://img.freepik.com/free-photo/abstract-surface-textures-white-concrete-stone-wall_74190-8184.jpg?size=626&ext=jpg",
    "https://img.freepik.com/free-photo/abstract-surface-textures-white-concrete-stone-wall_74190-8184.jpg?size=626&ext=jpg",
    "https://img.freepik.com/free-photo/abstract-surface-textures-white-concrete-stone-wall_74190-8184.jpg?size=626&ext=jpg"
  ];
  @override
  void didUpdateWidget(covariant CarouselSliderWidget oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_){
     // if(widget.tab_name.contains("event")){
        Provider.of<ListEventViewModel>(context, listen: false)
            .getSuggestionEvent();
     // } else if(widget.tab_name.contains("topic")){
        Provider.of<ListTopicViewModel>(context, listen: false)
            .getSuggestionTopic();
     // } else {
        Provider.of<ListExhibitViewModel>(context, listen: false)
            .getSuggestionExhibit();
    //  }
    });
    super.didUpdateWidget(oldWidget);
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      if(widget.tab_name.contains("event")){
        Provider.of<ListEventViewModel>(context, listen: false)
            .getSuggestionEvent();
      } else if(widget.tab_name.contains("topic")){
        Provider.of<ListTopicViewModel>(context, listen: false)
            .getSuggestionTopic();
      } else {
        Provider.of<ListExhibitViewModel>(context, listen: false)
            .getSuggestionExhibit();
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var listEventViewModel = Provider.of<ListEventViewModel>(context);
    var listTopicViewModel = Provider.of<ListTopicViewModel>(context);
    var listExhibitViewModel = Provider.of<ListExhibitViewModel>(context);
    if(widget.type != null){
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        CarouselSlider(
            height: MediaQuery.of(context).size.height * 0.62,
            initialPage: 0,
            enlargeCenterPage: true,
            onPageChanged: (index){
              _currentIndex = index;
                  },
            items: widget.tab_name.contains("event") && listEventViewModel.loadingStatus.toString().contains("completed") ? listEventViewModel.events.map((event){
              if(listEventViewModel.events.length > 0)
              return CarouselConstructor(type: widget.type, tab_name: "event",id: event.id, imgUrl: event.imageUrl, name: widget.type != null ? event.name_en : event.name, rating: event.rating, startDate: event.startedDate, endDate: event.endDate,description: widget.type != null ? event.description_en : event.description, totalFeedback: event.totalFeedback,);
          }).toList() :
            widget.tab_name.contains("topic")  && listTopicViewModel.loadingStatus.toString().contains("completed") ? listTopicViewModel.topics.map((topic){
              //print("topic: ${topic.}");
              if(listTopicViewModel.topics.length > 0)
              return CarouselConstructor(type: widget.type, tab_name: "topic", id: topic.id, imgUrl: topic.imageUrl, name: widget.type != null ? topic.name_en : topic.name, rating: topic.rating, description: widget.type != null ? topic.description_en : topic.description, startDate: topic.startedDate, totalFeedback: topic.totalFeedback,);
            }).toList() :
            widget.tab_name.contains("exhibit") && listExhibitViewModel.loadingStatus.toString().contains("completed") ? listExhibitViewModel.exhibits.map((exhibit){
              if(listExhibitViewModel.exhibits.length > 0)
              return CarouselConstructor(type: widget.type, tab_name: "exhibit", id: exhibit.id, imgUrl: exhibit.imageUrl, name: widget.type != null ? exhibit.name_en : exhibit.name, rating: exhibit.rating, description: widget.type != null ? exhibit.description_en : exhibit.description, totalFeedback: exhibit.totalFeedback,);
            }).toList() :
             img_tmp.map((tmp){
               return CarouselConstructor(type: widget.type,imgUrl: tmp, name: "", rating: 0,);
             }).toList(),
        )
//            : Container(
//          child: Image.network("https://soangiang.edu.vn/wp-content/themes/fastvideo-pro/assets/img/ajax-loader.gif"),
//        ),
    ]);
  //return Text(listEventViewModel.events.length.toString());
  }
}

