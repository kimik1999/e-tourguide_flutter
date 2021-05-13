import 'package:flutter_etourguide/etourguide_model/event_model.dart';
import 'package:flutter_etourguide/etourguide_model/route_model.dart';
import 'package:flutter_etourguide/etourguide_model/topic_model.dart';

class RouteViewModel {
  RouteModel _route;
  RouteViewModel({RouteModel route}) : _route = route;

  List<dynamic> get listRoute {
    return _route.listRoute;
  }

  String get text {
    return _route.text;
  }

  String get type {
    return _route.type;
  }

  String get textRouteVi {
    return _route.textRouteVi;
  }

  String get textRouteEng {
    return _route.textRouteEng;
  }
  int get floor{
    return _route.floor;
  }
  set floor(int floor){
    _route.floor = floor;
  }

  String get scan {
    return _route.scan;
  }

  set scan(String scan) {
    _route.scan = scan;
  }

  Event get event{
    return _route.event;
  }

  Topic get topic{
    return _route.topic;
  }
}
