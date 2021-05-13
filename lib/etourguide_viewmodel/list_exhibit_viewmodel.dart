import 'package:flutter/material.dart';
import 'package:flutter_etourguide/etourguide_model/exhibit_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/exhibit_viewmodel.dart';
import 'package:flutter_etourguide/services/web_services.dart';

enum LoadingStatus { completed, searching, empty }

class ListExhibitViewModel with ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<ExhibitViewModel> exhibits = List<ExhibitViewModel>();

  void getAllExhibit() async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<Exhibit> listExhibit = await WebService().fetchAllExhibit();
    this.exhibits = listExhibit
        .map((exhibit) => ExhibitViewModel(exhibit: exhibit))
        .toList();
    if (this.exhibits.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }

  Future<List<ExhibitViewModel>> getSuggestionExhibitForSearch() async {
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
    return this.exhibits;
  }

  void getSuggestionExhibit() async {
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

  void getExhibitInEvent(int eventId) async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<Exhibit> listExhibit = await WebService().fetchExhibitInEvent(eventId);
    this.exhibits = listExhibit
        .map((exhibit) => ExhibitViewModel(exhibit: exhibit))
        .toList();
    if (this.exhibits.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }

  void getExhibitInTopic(int topicId) async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<Exhibit> listExhibit = await WebService().fetchExhibitInTopic(topicId);
    this.exhibits = listExhibit
        .map((exhibit) => ExhibitViewModel(exhibit: exhibit))
        .toList();
    if (this.exhibits.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }

  void getExhibitInRoom(int roomId) async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<Exhibit> listExhibit =
        await WebService().fetchAllExhibitInRoom(roomId);
    this.exhibits = listExhibit
        .map((exhibit) => ExhibitViewModel(exhibit: exhibit))
        .toList();
    if (this.exhibits.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }

  void getCurrentExhibit() async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<Exhibit> listExhibit = await WebService().fetchCurrentExhibit();
    this.exhibits = listExhibit
        .map((exhibit) => ExhibitViewModel(exhibit: exhibit))
        .toList();
    if (this.exhibits.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }

  void getExhibitInduration(String time) async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<Exhibit> listExhibit = await WebService().fetchExhibitInDuration(time);
    this.exhibits = listExhibit
        .map((exhibit) => ExhibitViewModel(exhibit: exhibit))
        .toList();
    if (this.exhibits.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }

  void getListExhibit() async {
    List<Exhibit> listExhibit = [
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
    this.exhibits = listExhibit
        .map((exhibit) => ExhibitViewModel(exhibit: exhibit))
        .toList();
    notifyListeners();
  }
}
