import 'package:flutter/material.dart';
import 'package:flutter_etourguide/etourguide_model/event_model.dart';
import 'package:flutter_etourguide/etourguide_model/feedback_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/event_viewmodel.dart';
import 'package:flutter_etourguide/services/web_services.dart';

enum LoadingStatus { completed, searching, empty }

class ListEventViewModel with ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<EventViewModel> events = List<EventViewModel>();

  void getSuggestionEvent() async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<Event> listSuggestionEvent = await WebService().fetchSuggestionEvent();
    this.events = listSuggestionEvent
        .map((event) => EventViewModel(event: event))
        .toList();
    if (this.events.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }

  void getAllEvent() async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<Event> listEvent = await WebService().fetchAllEvent();
    this.events =
        listEvent.map((event) => EventViewModel(event: event)).toList();
    if (this.events.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }

  void getCurrentEvent() async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<Event> listEvent = await WebService().fetchCurrentEvent();
    this.events =
        listEvent.map((event) => EventViewModel(event: event)).toList();
    if (this.events.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }

  Future<String> getEventInDuration(
      String eventId, List<String> exhibitId) async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    String durationEstimate =
        await WebService().fetchEventInDuration(eventId, exhibitId);
    if (durationEstimate.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
    return durationEstimate;
  }

  Future<int> addFeedbackForAnEvent(FeedBack feedback) async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    int status = await WebService().fetchFeedbackAnEvent(feedback);
    if (status != 1) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
    return status;
  }
}
