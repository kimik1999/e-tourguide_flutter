import 'package:flutter/cupertino.dart';
import 'package:flutter_etourguide/etourguide_model/room_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/room_viewmodel.dart';
import 'package:flutter_etourguide/services/web_services.dart';

enum LoadingStatus { completed, searching, empty }

class ListRoomViewModel with ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<RoomViewModel> room = List<RoomViewModel>();

  void getAllRoom() async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<Room> listRoom = await WebService().fetchAllRoom();
    this.room = listRoom.map((room) => RoomViewModel(room: room)).toList();
    if (this.room.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }
}
