import 'package:flutter/material.dart';

class Topic{
  int id;
  String name;
  String name_en;
  String description;
  String description_en;
  String imageUrl;
  String startDate;
  double avgRating;
  int totalFeedback;

  Topic({this.id, this.name, this.name_en, this.description, this.description_en, this.imageUrl, this.startDate,
    this.avgRating, this.totalFeedback});

  factory Topic.fromJson(Map<String, dynamic> json){
    return new Topic(
        id: json['id'],
        name: json['name'],
        name_en: json['nameEng'],
        description: json['description'],
        description_en: json['descriptionEng'],
        imageUrl: json['image'],
        startDate: json['startDate'],
        avgRating: json['rating'],
        totalFeedback: json['totalFeedback']
    );
  }
}