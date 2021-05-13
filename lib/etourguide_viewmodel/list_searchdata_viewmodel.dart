import 'package:flutter/material.dart';
import 'package:flutter_etourguide/etourguide_model/exhibit_model.dart';
import 'package:flutter_etourguide/etourguide_model/search_data_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/exhibit_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/search_data_viewmodel.dart';
import 'package:flutter_etourguide/services/web_services.dart';

enum LoadingStatus { completed, searching, empty }

class ListSearchDataViewModel with ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<SearchDataViewModel> data = List<SearchDataViewModel>();
  List<ExhibitViewModel> exhibits = List<ExhibitViewModel>();

  void getDataByName(String name, String language_code) async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<SearchData> listData =
        await WebService().fetchDataByName(name, language_code);
    this.data =
        listData.map((data) => SearchDataViewModel(data: data)).toList();
    if (this.data.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }

  void getSuggestionSearch() async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<Exhibit> listSuggestionExhibit =
        await WebService().fetchSuggestionExhibit();
    this.exhibits = listSuggestionExhibit
        .map((exhibit) => ExhibitViewModel(exhibit: exhibit))
        .toList();
    if (this.exhibits.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }
}
