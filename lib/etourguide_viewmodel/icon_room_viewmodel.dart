import 'package:flutter_etourguide/etourguide_model/icon_room_model.dart';

class IconRoomViewModel {
  IconRoom _iconRoom;
  IconRoomViewModel({IconRoom iconRoom}) : _iconRoom = iconRoom;

  int get id {
    return _iconRoom.id;
  }

  int get floorId {
    return _iconRoom.floorId;
  }

  int get roomId {
    return _iconRoom.roomId;
  }

  int get type {
    return _iconRoom.type;
  }

  double get dx {
    return _iconRoom.dx;
  }

  double get dy {
    return _iconRoom.dy;
  }

  List<IconRoom> roomIcons_floor1 = [
    IconRoom(id: 101, name: "S1", position: [-0.356, -0.08]),
    IconRoom(id: 102, name: "S2", position: [-0.0005, -0.048]),
    IconRoom(id: 1, name: "1", position: [0.095, 0.0086]),
    IconRoom(id: 2, name: "2", position: [0.095, 0.065]),
    IconRoom(id: 3, name: "3", position: [0.188, 0.02]),
    IconRoom(id: 4, name: "4", position: [0.188, 0.05]),
    IconRoom(id: 5, name: "5", position: [0.284, 0.02]),
    IconRoom(id: 6, name: "6", position: [0.284, 0.05]),
    IconRoom(id: 7, name: "7", position: [0.354, 0.134]),
    IconRoom(id: 8, name: "8", position: [0.354, 0.0725]),
    IconRoom(id: 9, name: "9", position: [0.354, 0.025]),
    IconRoom(id: 10, name: "10", position: [0.335, -0.12]),
    IconRoom(id: 11, name: "11", position: [0.43, -0.12]),
    IconRoom(id: 12, name: "12", position: [0.335, -0.19]),
    IconRoom(id: 13, name: "13", position: [0.43, -0.19]),
    IconRoom(id: 14, name: "14", position: [-0.09, 0.06]),
    IconRoom(id: 15, name: "15", position: [-0.142, 0.06]),
    IconRoom(id: 16, name: "16", position: [-0.1922, 0.06]),
    IconRoom(id: 17, name: "17", position: [-0.239, 0.06]),
    IconRoom(id: 18, name: "18", position: [-0.2875, 0.06]),
    IconRoom(id: 19, name: "19", position: [-0.386, 0.0052]),
    IconRoom(id: 20, name: "20", position: [-0.386, 0.064]),
    IconRoom(id: 21, name: "21", position: [-0.386, 0.1194]),
    IconRoom(id: 22, name: "22", position: [-0.412, -0.145]),
    IconRoom(id: 23, name: "23", position: [-0.346, -0.145]),
    IconRoom(id: 24, name: "24", position: [-0.422, -0.2015]),
    IconRoom(id: 25, name: "25", position: [-0.334, -0.2015]),
    IconRoom(id: 26, name: "26", position: [-0.412, -0.248]),
    IconRoom(id: 27, name: "27", position: [-0.346, -0.248]),
  ];
  List<IconRoom> roomIcons_floor2 = [
    IconRoom(id: 28, name: "28", position: [-0.378, 0.042]),
    IconRoom(id: 201, name: "S2.1", position: [-0.356, -0.0158]),
    IconRoom(id: 202, name: "S2.2", position: [-0.001, -0.0158]),
    IconRoom(id: 29, name: "29", position: [-0.378, 0.0934]),
    IconRoom(id: 30, name: "30", position: [-0.378, 0.15]),
    IconRoom(id: 31, name: "31", position: [-0.263, 0.048]),
    IconRoom(id: 32, name: "32", position: [-0.169, 0.048]),
    IconRoom(id: 33, name: "33", position: [-0.093, 0.048]),
    IconRoom(id: 34, name: "34", position: [-0.263, 0.097]),
    IconRoom(id: 35, name: "35", position: [-0.169, 0.097]),
    IconRoom(id: 36, name: "36", position: [-0.093, 0.097]),
    IconRoom(id: 37, name: "37", position: [-0.407, -0.159]),
    IconRoom(id: 38, name: "38", position: [-0.343, -0.159]),
    IconRoom(id: 39, name: "39", position: [-0.407, -0.207]),
    IconRoom(id: 40, name: "40", position: [-0.343, -0.207]),
    IconRoom(id: 41, name: "41", position: [0.103, 0.046]),
    IconRoom(id: 42, name: "42", position: [0.103, 0.101]),
    IconRoom(id: 43, name: "43", position: [0.178, 0.046]),
    IconRoom(id: 44, name: "44", position: [0.178, 0.101]),
    IconRoom(id: 45, name: "45", position: [0.262, 0.046]),
    IconRoom(id: 46, name: "46", position: [0.262, 0.101]),
    IconRoom(id: 9, name: "47", position: [0.344, 0.046]),
    IconRoom(id: 8, name: "48", position: [0.404, 0.046]),
    IconRoom(id: 7, name: "49", position: [0.344, 0.134]),
    IconRoom(id: 10, name: "50", position: [0.404, 0.134]),
    IconRoom(id: 11, name: "51", position: [0.3428, -0.028]),
    IconRoom(id: 12, name: "52", position: [0.4038, -0.028]),
    IconRoom(id: 13, name: "53", position: [0.3428, -0.088]),
    IconRoom(id: 14, name: "54", position: [0.4038, -0.088]),
    IconRoom(id: 15, name: "55", position: [0.3428, -0.152]),
    IconRoom(id: 16, name: "56", position: [0.4038, -0.152]),
  ];
  List<IconRoom> get listIconFloor1 {
    return this.roomIcons_floor1;
  }

  List<IconRoom> get listIconFloor2 {
    return this.roomIcons_floor2;
  }
}
