import 'package:flutter_etourguide/etourguide_model/exhibit_model.dart';

class ExhibitViewModel {
  List<Exhibit> listExhibit;
  Exhibit _exhibit;
  ExhibitViewModel({this.listExhibit, Exhibit exhibit}) : _exhibit = exhibit;

  int get id {
    return _exhibit.id;
  }

  String get name {
    return _exhibit.name;
  }

  String get description {
    return _exhibit.description;
  }

  String get name_en {
    return _exhibit.name_en;
  }

  String get description_en {
    return _exhibit.description_en;
  }

  String get imageUrl {
    return _exhibit.imageUrl;
  }

  double get rating {
    return _exhibit.avgRating;
  }

  int get totalFeedback {
    return _exhibit.totalFeedback;
  }

  bool get isChecked {
    return _exhibit.isChecked;
  }

  set isChecked(bool value) {
    _exhibit.isChecked = value;
  }

  List<Exhibit> get ListExhibit {
    listExhibit = [
      Exhibit(
          id: 1,
          name: 'Exhibit 1',
          description: 'This is about Exhibit 1',
          imageUrl:
              'https://i.pinimg.com/736x/9f/f1/22/9ff122d0cc46f519dd740cba6ca0341d.jpg',
          avgRating: 4.50),
      Exhibit(
          id: 2,
          name: 'Exhibit 2',
          description: 'This is about Exhibit 2',
          imageUrl:
              'https://i.pinimg.com/736x/9f/f1/22/9ff122d0cc46f519dd740cba6ca0341d.jpg',
          avgRating: 4.65),
      Exhibit(
          id: 3,
          name: 'Exhibit 3',
          description: 'This is about Exhibit 3',
          imageUrl:
              'https://i.pinimg.com/736x/9f/f1/22/9ff122d0cc46f519dd740cba6ca0341d.jpg',
          avgRating: 4.7),
      Exhibit(
          id: 4,
          name: 'Exhibit 4',
          description: 'This is about Exhibit 4',
          imageUrl:
              'https://i.pinimg.com/736x/9f/f1/22/9ff122d0cc46f519dd740cba6ca0341d.jpg',
          avgRating: 4.4),
      Exhibit(
          id: 5,
          name: 'Exhibit 1',
          description: 'This is about Exhibit 1',
          imageUrl:
              'https://i.pinimg.com/736x/9f/f1/22/9ff122d0cc46f519dd740cba6ca0341d.jpg',
          avgRating: 4.50),
      Exhibit(
          id: 6,
          name: 'Exhibit 2',
          description: 'This is about Exhibit 2',
          imageUrl:
              'https://i.pinimg.com/736x/9f/f1/22/9ff122d0cc46f519dd740cba6ca0341d.jpg',
          avgRating: 4.65),
      Exhibit(
          id: 7,
          name: 'Exhibit 3',
          description: 'This is about Exhibit 3',
          imageUrl:
              'https://i.pinimg.com/736x/9f/f1/22/9ff122d0cc46f519dd740cba6ca0341d.jpg',
          avgRating: 4.7),
      Exhibit(
          id: 8,
          name: 'Exhibit 4',
          description: 'This is about Exhibit 4',
          imageUrl:
              'https://i.pinimg.com/736x/9f/f1/22/9ff122d0cc46f519dd740cba6ca0341d.jpg',
          avgRating: 4.4)
    ];
    return listExhibit;
  }
}
