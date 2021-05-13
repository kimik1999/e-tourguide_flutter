import 'package:flutter/material.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_event_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_exhibit_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_searchdata_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_topic_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_etourguide/etourguide_widget/gallerypage/item_widget.dart';

import 'package:flutter_etourguide/etourguide_widget/search_widget.dart';
import 'package:provider/provider.dart';

class ListItemStf extends StatefulWidget {
  String type;
  String item_name;
  String query;
  ListItemStf({this.item_name, this.query, this.type});
  @override
  _ListItemStfState createState() => _ListItemStfState();
}

class _ListItemStfState extends State<ListItemStf> {
  String en_code = "en";
  String vi_code = "vi";
  @override
  void didUpdateWidget(covariant ListItemStf oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.item_name.toLowerCase().contains("topic")) {
        Provider.of<ListTopicViewModel>(context, listen: false).getAllTopic();
        // print("topic loading");
      } else if (widget.item_name.toLowerCase().contains("event")) {
        Provider.of<ListEventViewModel>(context, listen: false).getAllEvent();
      } else if (widget.item_name.toLowerCase().contains("exhibit")) {
        Provider.of<ListExhibitViewModel>(context, listen: false)
            .getAllExhibit();
      } else if (widget.item_name.toLowerCase().contains("search")) {
        Provider.of<ListSearchDataViewModel>(context, listen: false)
            .getDataByName(
                widget.query, widget.type != null ? en_code : vi_code);
      } else {}
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.item_name.toLowerCase().contains("topic")) {
        Provider.of<ListTopicViewModel>(context, listen: false).getAllTopic();
        // print("topic loading");
      } else if (widget.item_name.toLowerCase().contains("event")) {
        Provider.of<ListEventViewModel>(context, listen: false).getAllEvent();
      } else if (widget.item_name.toLowerCase().contains("exhibit")) {
        Provider.of<ListExhibitViewModel>(context, listen: false)
            .getAllExhibit();
      } else if (widget.item_name.toLowerCase().contains("search")) {
        Provider.of<ListSearchDataViewModel>(context, listen: false)
            .getDataByName(
                widget.query, widget.type != null ? en_code : vi_code);
      } else {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(alignment: AlignmentDirectional.center, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    !widget.item_name.contains("search")
                        ? Container(
                            padding: EdgeInsets.only(top: 25),
                            height: 50,
                            width: 50,
                            //alignment: AlignmentDirectional.topStart,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black45.withOpacity(0.8),
                                size: 22,
                              ),
                            ),
                          )
                        : Container(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 25),
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Text(
                            widget.item_name.contains("search")
                                ? 'search_result_label'.tr()
                                :  widget.item_name
                                .contains("Event")
                                ? 'all_event_label'.tr()
                                :  widget.item_name
                                .contains("Topic")
                                ? 'all_topic_label'.tr()
                                :  widget.item_name
                                .contains("Exhibit")
                                ? 'all_exhibit_label'.tr()
                                : "",
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Helve',
                                fontSize: 20),
                          ),
                        ),
                        widget.item_name.contains("search") &&
                                getListLength("search", context) <= 0
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.35),
                                child: Text(
                                  'no_matching'.tr(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Helve",
                                      color: Colors.black45,
                                      fontSize: 16),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ],
                ),
//                widget.item_name.contains("search")
//                    ? Container()
//                    : SearchWidget(
//                        type: widget.type,
//                      ),
                //Container(),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 15),
                    child: Container(
                      // height: MediaQuery.of(context).size.height * 0.72,
                      child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: getListLength(widget.item_name, context),
                          itemBuilder: (BuildContext context, int index) {
                            return getListGalleryItem(
                                widget.item_name, index, context);
                          }),
                    )),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  int getListLength(String item_name, BuildContext context) {
    if (item_name.toLowerCase().contains("event")) {
      var listEventViewModel = Provider.of<ListEventViewModel>(context);
      if (listEventViewModel.loadingStatus.toString().contains("completed"))
        return listEventViewModel.events.length;
    } else if (item_name.toLowerCase().contains("topic")) {
      var listTopicViewModel = Provider.of<ListTopicViewModel>(context);
      if (listTopicViewModel.loadingStatus.toString().contains("completed"))
        return listTopicViewModel.topics.length;
    } else if (item_name.toLowerCase().contains("exhibit")) {
      var listExhibitViewModel = Provider.of<ListExhibitViewModel>(context);
      if (listExhibitViewModel.loadingStatus.toString().contains("completed"))
        //print(listExhibitViewModel.exhibits.length);
      return listExhibitViewModel.exhibits.length;
    } else if (item_name.toLowerCase().contains("search")) {
      var listSearchViewModel = Provider.of<ListSearchDataViewModel>(context);
      return listSearchViewModel.data.length;
    } else {}
  }

  Widget getListGalleryItem(String item_name, int index, BuildContext context) {
    if (item_name.toLowerCase().contains("event")) {
      var listEventViewModel = Provider.of<ListEventViewModel>(context);
      if (listEventViewModel.events.length > 0)
        return ItemWidget(
          id: listEventViewModel.events[index].id,
          tab_name: "event",
          totalFeedback: listEventViewModel.events[index].totalFeedback,
          item_name: widget.type != null
              ? listEventViewModel.events[index].name_en
              : listEventViewModel.events[index].name,
          imageUrl: listEventViewModel.events[index].imageUrl,
          description: widget.type != null
              ? listEventViewModel.events[index].description_en
              : listEventViewModel.events[index].description,
          endDate: listEventViewModel.events[index].endDate,
          startDate: listEventViewModel.events[index].startedDate,
          rating: listEventViewModel.events[index].rating,
          type: widget.type,
        );
    } else if (item_name.toLowerCase().contains("topic")) {
      var listTopicViewModel = Provider.of<ListTopicViewModel>(context);
      if (listTopicViewModel.topics.length > 0)
        return ItemWidget(
          tab_name: "topic",
          id: listTopicViewModel.topics[index].id,
          description: widget.type != null
              ? listTopicViewModel.topics[index].description_en
              : listTopicViewModel.topics[index].description,
          rating: listTopicViewModel.topics[index].rating,
          totalFeedback: listTopicViewModel.topics[index].totalFeedback,
          item_name: widget.type != null
              ? listTopicViewModel.topics[index].name_en
              : listTopicViewModel.topics[index].name,
          imageUrl: listTopicViewModel.topics[index].imageUrl,
          type: widget.type,
        );
    } else if (item_name.toLowerCase().contains("exhibit")) {
      var listExhibitViewModel = Provider.of<ListExhibitViewModel>(context);
      if (listExhibitViewModel.exhibits.length > 0)
        return ItemWidget(
          tab_name: "exhibit",
          id: listExhibitViewModel.exhibits[index].id,
          description: widget.type != null
              ? listExhibitViewModel.exhibits[index].description_en
              : listExhibitViewModel.exhibits[index].description,
          totalFeedback: listExhibitViewModel.exhibits[index].totalFeedback,
          rating: listExhibitViewModel.exhibits[index].rating,
          item_name: widget.type != null
              ? listExhibitViewModel.exhibits[index].name_en
              : listExhibitViewModel.exhibits[index].name,
          imageUrl: listExhibitViewModel.exhibits[index].imageUrl,
          type: widget.type,
        );
    } else if (item_name.toLowerCase().contains("search")) {
      var listSearchViewModel = Provider.of<ListSearchDataViewModel>(context);
      return ItemWidget(
        tab_name: listSearchViewModel.data[index].type.toLowerCase(),
        id: listSearchViewModel.data[index].id,
        item_name: widget.type != null
            ? listSearchViewModel.data[index].name_en
            : listSearchViewModel.data[index].name,
        imageUrl: listSearchViewModel.data[index].imageUrl,
        totalFeedback: listSearchViewModel.data[index].totalFeedback,
        rating: listSearchViewModel.data[index].rating,
        description: widget.type != null
            ? listSearchViewModel.data[index].description_en
            : listSearchViewModel.data[index].description,
        startDate: listSearchViewModel.data[index].startedDate,
        endDate: listSearchViewModel.data[index].endDate,
        type: widget.type,
      );
    } else {}
  }
}
