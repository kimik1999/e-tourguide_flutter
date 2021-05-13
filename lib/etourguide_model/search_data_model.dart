class SearchData{
  int id;
  String name;
  String description;
  String name_en;
  String description_en;
  String imageUrl;
  String startDate;
  String endDate;
  double avgRating;
  int totalFeedback;
  String type;

  SearchData({this.id, this.name, this.name_en, this.description, this.description_en, this.imageUrl,
    this.startDate, this.endDate, this.avgRating, this.totalFeedback, this.type});

  factory SearchData.fromJson(Map<String, dynamic> json){
    return new SearchData(
        id: json['id'],
        name: json['name'],
        name_en: json['nameEng'],
        description: json['description'],
        description_en: json['descriptionEng'],
        imageUrl: json['image'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        avgRating: json['rating'],
        totalFeedback: json['totalFeedback'],
        type: json['type']
    );
  }
}