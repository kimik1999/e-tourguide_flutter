class FeedBack {
  int id;
  int eventId;
  int topicId;
  String visitorName;
  double rating;
  String description;
  String date;
  bool status;

  FeedBack(
      {this.id,
      this.topicId,
      this.eventId,
      this.visitorName,
      this.rating,
      this.description,
      this.date,
      this.status});

  factory FeedBack.fromJson(Map<String, dynamic> json) {
    return new FeedBack(
        id: json['id'],
        eventId: json['eventId'],
        topicId: json['topicId'],
        visitorName: json['visitorName'],
        rating: json['rating'],
        description: json['description'],
        date: json["createDate"],
        status: json["status"]);
  }
}
