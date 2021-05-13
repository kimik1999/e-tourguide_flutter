import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/exhibit_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_exhibit_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_widget/homepage/exhibit_item.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ExhibitWidget extends StatefulWidget {
  double height;
  double width;
  List<ExhibitViewModel> exhibitEvent;
  int eventId;
  int topicId;
  int roomId;
  String type;
  ExhibitWidget(this.height, this.width,
      {this.eventId, this.exhibitEvent, this.topicId, this.roomId, this.type});
  ExhibitViewModel exhibitViewModel = new ExhibitViewModel();
  @override
  _ExhibitWidgetState createState() => _ExhibitWidgetState();
}

class _ExhibitWidgetState extends State<ExhibitWidget> {

  @override
  void initState() {
    //print("exhibit ${widget.roomId}");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.eventId != null) {
        Provider.of<ListExhibitViewModel>(context, listen: false)
            .getExhibitInEvent(widget.eventId);
        //print(widget.eventId);
      } else if (widget.topicId != null) {
        Provider.of<ListExhibitViewModel>(context, listen: false)
            .getExhibitInTopic(widget.topicId);
      } else if (widget.roomId != null) {
        Provider.of<ListExhibitViewModel>(context, listen: false)
            .getExhibitInRoom(widget.roomId);
        //print(widget.roomId);
      } else {
        Provider.of<ListExhibitViewModel>(context, listen: false)
            .getCurrentExhibit();
      }
    });
    super.initState();
  }
  @override
  void didUpdateWidget(covariant ExhibitWidget oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.eventId != null) {
        Provider.of<ListExhibitViewModel>(context, listen: false)
            .getExhibitInEvent(widget.eventId);
        //print(widget.eventId);
      } else if (widget.topicId != null) {
        Provider.of<ListExhibitViewModel>(context, listen: false)
            .getExhibitInTopic(widget.topicId);
      } else if (widget.roomId != null && context != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<ListExhibitViewModel>(context, listen: false)
            .getExhibitInRoom(widget.roomId);
        });
        //print(widget.roomId);
      } else {
        if(context != null)
        WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<ListExhibitViewModel>(context, listen: false)
            .getCurrentExhibit();
        });
      }
    });
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    if(widget.type != null){
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    var listExhibit = Provider.of<ListExhibitViewModel>(context);
    //print(listExhibit.exhibits.length);
    return Container(
      padding: EdgeInsets.only(right: 14),
      height: widget.height,
      color: Colors.white,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listExhibit.exhibits.length,
          itemBuilder: (BuildContext context, int index) {
            return  ExhibitItem(
              width: widget.width,
              id: listExhibit.exhibits[index].id,
              totalFeedback: listExhibit.exhibits[index].totalFeedback,
              item_name: widget.type != null ? listExhibit.exhibits[index].name_en != null ? listExhibit.exhibits[index].name_en : "Updating" : listExhibit.exhibits[index].name,
              imageUrl: listExhibit.exhibits[index].imageUrl,
              description: widget.type!= null ? listExhibit.exhibits[index].description_en != null ? listExhibit.exhibits[index].description_en : "Updating" : listExhibit.exhibits[index].description,
              type: widget.type,
            );
          }),
    );
  }

  int getListLength(BuildContext context) {
    if (widget.eventId != null) {
      var listExhibitInEvent = Provider.of<ListExhibitViewModel>(context);
      //print(listExhibitInEvent.exhibits.length);
      return listExhibitInEvent.exhibits.length;
    } else if (widget.topicId != null) {
      var listExhibitInTopic = Provider.of<ListExhibitViewModel>(context);
      return listExhibitInTopic.exhibits.length;
    } else if (widget.roomId != null) {
      var listExhibitInRoom = Provider.of<ListExhibitViewModel>(context);
      return listExhibitInRoom.exhibits.length;
    } else {
      var listCurrentExhibit = Provider.of<ListExhibitViewModel>(context);
      return listCurrentExhibit.exhibits.length;
    }
  }

//  Widget getListGalleryItem(int index, BuildContext context) {
//    if (widget.eventId != null) {
//      var listExhibitInEvent = Provider.of<ListExhibitViewModel>(context);
//      if (listExhibitInEvent.exhibits.length > 0)
//        return ExhibitItem(
//          width: widget.width,
//          id: listExhibitInEvent.exhibits[index].id,
//          totalFeedback: listExhibitInEvent.exhibits[index].totalFeedback,
//          item_name: listExhibitInEvent.exhibits[index].name,
//          imageUrl: listExhibitInEvent.exhibits[index].imageUrl,
//          description: listExhibitInEvent.exhibits[index].description,
//          rating: listExhibitInEvent.exhibits[index].rating,
//        );
//    } else if (widget.topicId != null) {
//      var listExhibitInTopic = Provider.of<ListExhibitViewModel>(context);
//      //print(listExhibitInTopic.exhibits[index].id);
//      if (listExhibitInTopic.exhibits.length > 0)
//        return ExhibitItem(
//          width: widget.width,
//          id: listExhibitInTopic.exhibits[index].id,
//          totalFeedback: listExhibitInTopic.exhibits[index].totalFeedback,
//          item_name: listExhibitInTopic.exhibits[index].name,
//          imageUrl: listExhibitInTopic.exhibits[index].imageUrl,
//          description: listExhibitInTopic.exhibits[index].description,
//          rating: listExhibitInTopic.exhibits[index].rating,
//        );
//    } else if (widget.roomId != null) {
//      var listExhibitInRoom = Provider.of<ListExhibitViewModel>(context);
//      if (listExhibitInRoom.exhibits.length > 0)
//        return ExhibitItem(
//          width: widget.width,
//          id: listExhibitInRoom.exhibits[index].id,
//          totalFeedback: listExhibitInRoom.exhibits[index].totalFeedback,
//          item_name: listExhibitInRoom.exhibits[index].name,
//          imageUrl: listExhibitInRoom.exhibits[index].imageUrl,
//          description: listExhibitInRoom.exhibits[index].description,
//          rating: listExhibitInRoom.exhibits[index].rating,
//        );
//    } else {
//      var listCurrentExhibit = Provider.of<ListExhibitViewModel>(context);
//      if (listCurrentExhibit.exhibits.length > 0)
//        return ExhibitItem(
//          width: widget.width,
//          id: listCurrentExhibit.exhibits[index].id,
//          totalFeedback: listCurrentExhibit.exhibits[index].totalFeedback,
//          item_name: listCurrentExhibit.exhibits[index].name,
//          imageUrl: listCurrentExhibit.exhibits[index].imageUrl,
//          description: listCurrentExhibit.exhibits[index].description,
//        );
//    }
//  }
}
