class Exhibit {
  int id;
  String name;
  String name_en;
  String description;
  String description_en;
  String imageUrl;
  String createdDate;
  double avgRating;
  int totalFeedback;
  String duration;
  bool isDelete;
  bool isChecked = false;

  Exhibit(
      {this.id,
      this.name,
      this.name_en,
      this.description,
      this.description_en,
      this.imageUrl,
      this.createdDate,
      this.avgRating,
      this.duration,
      this.isDelete,
      this.totalFeedback});

  factory Exhibit.fromJson(Map<String, dynamic> json) {
    return new Exhibit(
        id: json['id'],
        name: json['name'],
        name_en: json['nameEng'],
        description: json['description'],
        description_en: json['descriptionEng'],
        imageUrl: json['image'],
        avgRating: json['rating'],
        totalFeedback: json['totalFeedback']);
  }
}
