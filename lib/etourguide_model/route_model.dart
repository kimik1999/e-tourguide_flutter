import 'package:flutter_etourguide/etourguide_model/event_model.dart';
import 'package:flutter_etourguide/etourguide_model/topic_model.dart';

class RouteModel {
  List<dynamic> listRoute;
  String text;
  String textRouteVi;
  String textRouteEng;
  String scan;
  String type;
  int floor;
  Event event;
  Topic topic;

  RouteModel(
      {this.listRoute,
      this.type,
      this.text,
      this.textRouteVi,
      this.textRouteEng,
      this.scan,
      this.floor,
      this.event,
      this.topic});

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return new RouteModel(
        listRoute: json['_listRoute'],
        textRouteVi: json['_textRouteVi'],
        textRouteEng: json['_textRouteEng']);
  }
}
