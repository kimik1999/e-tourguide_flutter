import 'package:flutter_etourguide/etourguide_model/topic_model.dart';

class TopicViewModel {
  Topic _topic;
  List<Topic> listTopic;

  TopicViewModel({this.listTopic, Topic topic}) : _topic = topic;

  int get id {
    return _topic.id;
  }

  String get name_en {
    return _topic.name_en;
  }

  String get description_en {
    return _topic.description_en;
  }

  String get name {
    return _topic.name;
  }

  String get description {
    return _topic.description;
  }

  String get imageUrl {
    return _topic.imageUrl;
  }

  String get startedDate {
    return _topic.startDate;
  }

  double get rating {
    return _topic.avgRating;
  }

  int get totalFeedback {
    return _topic.totalFeedback;
  }

  List<Topic> get ListTopic {
    listTopic = [
      Topic(
          id: 1,
          name: 'Topic 1',
          description: 'This is about Topic 1',
          imageUrl:
              'https://p.favim.com/orig/2018/08/15/art-statue-aesthetic-Favim.com-6126426.jpg',
          avgRating: 4.50),
      Topic(
          id: 2,
          name: 'Topic 2',
          description: 'This is about Topic 2',
          imageUrl:
              'https://p.favim.com/orig/2018/08/15/art-statue-aesthetic-Favim.com-6126426.jpg',
          avgRating: 4.65),
      Topic(
          id: 3,
          name: 'Topic 3',
          description: 'This is about Topic 3',
          imageUrl:
              'https://p.favim.com/orig/2018/08/15/art-statue-aesthetic-Favim.com-6126426.jpg',
          avgRating: 4.7),
      Topic(
          id: 4,
          name: 'Topic 4',
          description: 'This is about Topic 4',
          imageUrl:
              'https://p.favim.com/orig/2018/08/15/art-statue-aesthetic-Favim.com-6126426.jpg',
          avgRating: 4.4)
    ];
    return listTopic;
  }
}
