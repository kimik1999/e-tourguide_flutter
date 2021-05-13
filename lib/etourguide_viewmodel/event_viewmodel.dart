import 'package:flutter_etourguide/etourguide_model/event_model.dart';

class EventViewModel {
  Event _event;
  List<Event> listEvent;
  EventViewModel({this.listEvent, Event event}) : _event = event;

  int get id {
    return _event.id;
  }

  String get name {
    return _event.name;
  }

  String get description {
    return _event.description;
  }

  String get name_en {
    return _event.name_en;
  }

  String get description_en {
    return _event.description_en;
  }

  String get imageUrl {
    return _event.imageUrl;
  }

  String get createdDate {
    return _event.createdDate;
  }

  String get startedDate {
    return _event.startDate;
  }

  String get endDate {
    return _event.endDate;
  }

  double get rating {
    return _event.avgRating;
  }

  int get totalFeedback {
    return _event.totalFeedback;
  }

  List<String> get feedback {
    return _event.feedback;
  }

  List<Event> get ListEvent {
    listEvent = [
      Event(
          id: 1,
          name: 'Event 1',
          description: 'This is about Event 1',
          imageUrl:
              'https://i.pinimg.com/736x/0c/4f/f1/0c4ff1fce8b45312fe6749aea7862de5.jpg',
          startDate: "25/01/2021",
          endDate: "26/01/2021",
          avgRating: 4.50),
      Event(
          id: 2,
          name: 'Event 2',
          description: 'This is about Event 2',
          imageUrl:
              'https://i.pinimg.com/736x/0c/4f/f1/0c4ff1fce8b45312fe6749aea7862de5.jpg',
          startDate: "25/01/2021",
          endDate: "26/01/2021",
          avgRating: 4.65),
      Event(
          id: 3,
          name: 'Event 3',
          description: 'This is about Event 3',
          imageUrl:
              'https://i.pinimg.com/736x/0c/4f/f1/0c4ff1fce8b45312fe6749aea7862de5.jpg',
          startDate: "25/01/2021",
          endDate: "26/01/2021",
          avgRating: 4.7),
      Event(
          id: 4,
          name: 'Event 4',
          description: 'This is about Event 4',
          imageUrl:
              'https://i.pinimg.com/736x/0c/4f/f1/0c4ff1fce8b45312fe6749aea7862de5.jpg',
          startDate: "25/01/2021",
          endDate: "26/01/2021",
          avgRating: 4.4)
    ];
    return listEvent;
  }
}
