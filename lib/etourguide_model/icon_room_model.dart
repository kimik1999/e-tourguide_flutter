class IconRoom {
  int id;
  int type;
  double dx;
  double dy;
  String name;
  bool status;
  List<double> position;
  int floor;
  int floorId;
  int roomId;

  IconRoom(
      {this.id,
      this.type,
      this.dx,
      this.dy,
      this.floorId,
      this.roomId,
      this.name,
      this.status,
      this.position,
      this.floor});
  factory IconRoom.fromJson(Map<String, dynamic> json) {
    return new IconRoom(
        id: json['id'],
        type: json['type'],
        dx: json['dx'],
        dy: json['dy'],
        floorId: json['floorId'],
        roomId: json['roomId']);
  }
}
