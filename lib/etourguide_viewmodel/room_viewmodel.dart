import 'package:flutter_etourguide/etourguide_model/room_model.dart';

class RoomViewModel {
  List<Room> listRoom;
  Room _room;
  RoomViewModel({this.listRoom, Room room}) : _room = room;

  int get id {
    return _room.id;
  }

  int get floor {
    return _room.no;
  }

  int get no {
    return _room.no;
  }

  int get status {
    return _room.status;
  }

//  List<Room> get ListRoom{
//    listRoom = [
//      Room(id: '1', name: 'Room 1', description: 'This is about Topic 1', imageUrl: 'https://i.pinimg.com/originals/fb/1e/56/fb1e56fec95fe10488c35fd63c3053bb.jpg'),
//      Room(id: '2', name: 'Room 2', description: 'This is about Topic 2', imageUrl: 'https://i.pinimg.com/originals/fb/1e/56/fb1e56fec95fe10488c35fd63c3053bb.jpg'),
//      Room(id: '3', name: 'Room 3', description: 'This is about Topic 3', imageUrl: 'https://i.pinimg.com/originals/fb/1e/56/fb1e56fec95fe10488c35fd63c3053bb.jpg'),
//      Room(id: '4', name: 'Room 4', description: 'This is about Topic 4', imageUrl: 'https://i.pinimg.com/originals/fb/1e/56/fb1e56fec95fe10488c35fd63c3053bb.jpg')
//    ];
//    return listRoom;
//  }
}
