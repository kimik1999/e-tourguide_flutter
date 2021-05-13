class Maps {
  double dx;
  double dy;
  int floorId;
  int roomId;

  Maps({this.dx, this.dy, this.roomId, this.floorId});

  factory Maps.fromJson(Map<String, dynamic> json) {
    return new Maps(
      dx: json['dx'],
      dy: json['dy'],
      floorId: json['floorId'],
      roomId: json['roomId'],
    );
  }
}
