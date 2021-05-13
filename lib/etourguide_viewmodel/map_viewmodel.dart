import 'package:flutter_etourguide/etourguide_model/map_model.dart';

class MapsViewModel {
  Maps _map;
  List<Maps> listMap;
  MapsViewModel({this.listMap, Maps map}) : _map = map;

  int get floorId {
    return _map.floorId;
  }

  int get roomId {
    return _map.roomId;
  }

  double get dx {
    return _map.dx;
  }

  double get dy {
    return _map.dy;
  }
}
