class Room {
  int id;
  int floor;
  int no;
  int status;
  Room({this.id, this.floor, this.no, this.status});

  factory Room.fromJson(Map<String, dynamic> json) {
    return new Room(
      id: json['id'],
      floor: json['floor'],
      no: json['no'],
      status: json['status'],
    );
  }
}
