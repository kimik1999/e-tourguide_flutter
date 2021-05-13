import 'package:flutter_etourguide/etourguide_model/search_data_model.dart';

class SearchDataViewModel {
  SearchData _searchData;
  List<SearchData> listData;
  SearchDataViewModel({this.listData, SearchData data}) : _searchData = data;

  int get id {
    return _searchData.id;
  }

  String get name {
    return _searchData.name;
  }

  String get description {
    return _searchData.description;
  }

  String get name_en {
    return _searchData.name_en;
  }

  String get description_en {
    return _searchData.description_en;
  }

  String get imageUrl {
    return _searchData.imageUrl;
  }

  String get startedDate {
    return _searchData.startDate;
  }

  String get endDate {
    return _searchData.endDate;
  }

  double get rating {
    return _searchData.avgRating;
  }

  int get totalFeedback {
    return _searchData.totalFeedback;
  }

  String get type {
    return _searchData.type;
  }
}
