import 'package:flutter/material.dart';
import 'package:flutter_etourguide/etourguide_model/map_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/icon_room_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/map_viewmodel.dart';
import 'package:flutter_etourguide/services/web_services.dart';

enum LoadingStatus { completed, searching, empty }

class MapUploadViewModel with ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<MapsViewModel> maps = List<MapsViewModel>();
  List<IconRoomViewModel> icons = List<IconRoomViewModel>();

  Future<String> getMap(int floor) async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    String url = await WebService().fetchGetMap(floor);
    if (url.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
    return url;
  }

  void getAllPosition() async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<Maps> listMap = await WebService().fetchAllPosition();
    this.maps = listMap.map((map) => MapsViewModel(map: map)).toList();
    if (this.maps.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }

}
