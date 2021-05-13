import 'package:flutter_etourguide/etourguide_model/feedback_model.dart';

class FeedbackViewModel {
  FeedBack _feedBack;
  // EventViewModel({Event event}) : _event = event;
  FeedbackViewModel({FeedBack feedBack}) : _feedBack = feedBack;

  int get id {
    return _feedBack.id;
  }

  int get eventId {
    return _feedBack.eventId;
  }

  int get topicId {
    return _feedBack.topicId;
  }

  String get visitorName {
    return _feedBack.visitorName;
  }

  String get description {
    return _feedBack.description;
  }

  String get createdDate {
    return _feedBack.date;
  }

  bool get status {
    return _feedBack.status;
  }

  double get rating {
    return _feedBack.rating;
  }
}
