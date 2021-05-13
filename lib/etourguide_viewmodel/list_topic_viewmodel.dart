import 'package:flutter/material.dart';
import 'package:flutter_etourguide/etourguide_model/feedback_model.dart';
import 'package:flutter_etourguide/etourguide_model/topic_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/topic_viewmodel.dart';
import 'package:flutter_etourguide/services/web_services.dart';

enum LoadingStatus { completed, searching, empty }

class ListTopicViewModel with ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<TopicViewModel> topics = List<TopicViewModel>();

  void getAllTopic() async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<Topic> listTopic = await WebService().fetchAllTopic();
    this.topics =
        listTopic.map((topic) => TopicViewModel(topic: topic)).toList();
    if (this.topics.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }

  void getSuggestionTopic() async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<Topic> listSuggestionTopic = await WebService().fetchSuggestionTopic();
    this.topics = listSuggestionTopic
        .map((topic) => TopicViewModel(topic: topic))
        .toList();
    if (this.topics.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }

  Future<String> getTopicInDuration(
      String topicId, List<String> exhibitId) async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    String durationEstimate =
        await WebService().fetchTopicInDuration(topicId, exhibitId);
    if (durationEstimate.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
    return durationEstimate;
  }

  Future<int> addFeedbackForAnTopic(FeedBack feedback) async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    int status = await WebService().fetchFeedbackAnTopic(feedback);
    if (status != 1) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
    return status;
  }
}
