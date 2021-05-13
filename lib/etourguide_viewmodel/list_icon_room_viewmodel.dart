import 'package:flutter/cupertino.dart';
import 'package:flutter_etourguide/etourguide_model/icon_room_model.dart';
import 'package:flutter_etourguide/services/web_services.dart';

enum LoadingStatus { completed, searching, empty }

class ListIconRoomViewModel with ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  Future<List<IconRoom>> getIconRoomButton(int floorId) async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<IconRoom> list = await WebService().fetchAllIconRoomButton(floorId);
    //this.icons = list.map((icon) => IconRoomViewModel(iconRoom: icon)).toList();
    if (list.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
    print(list.length);
    return list;
  }
}
