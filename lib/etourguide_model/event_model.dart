class Event {
  int id;
  String name;
  String name_en;
  String description;
  String description_en;
  String imageUrl;
  String createdDate;
  String startDate;
  String endDate;
  double avgRating;
  int totalFeedback;
  List<String> feedback;
  bool isDelete;

  Event(
      {this.id,
      this.name,
      this.name_en,
      this.description,
      this.description_en,
      this.imageUrl,
      this.createdDate,
      this.startDate,
      this.endDate,
      this.avgRating,
      this.totalFeedback,
      this.feedback,
      this.isDelete});

  factory Event.fromJson(Map<String, dynamic> json) {
    return new Event(
        id: json['id'],
        name: json['name'],
        name_en: json['nameEng'],
        description: json['description'],
        description_en: json['descriptionEng'],
        imageUrl: json['image'],
        avgRating: json['rating'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        isDelete: json['isDelete'],
        totalFeedback: json['totalFeedback']);
  }
}
