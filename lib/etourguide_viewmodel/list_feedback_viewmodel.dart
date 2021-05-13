import 'package:flutter/cupertino.dart';
import 'package:flutter_etourguide/etourguide_model/feedback_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/feedback_viewmodel.dart';
import 'package:flutter_etourguide/services/web_services.dart';

enum LoadingStatus { completed, searching, empty }

class ListFeedbackViewModel with ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<FeedbackViewModel> feedback = List<FeedbackViewModel>();

  void getFeedbackInEvent(int eventId) async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<FeedBack> listFeedback =
        await WebService().fetchFeedbackInEvent(eventId);
    this.feedback =
        listFeedback.map((fb) => FeedbackViewModel(feedBack: fb)).toList();
    if (this.feedback.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }

  void getFeedbackInTopic(int topicId) async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<FeedBack> listFeedback =
        await WebService().fetchFeedbackInTopic(topicId);
    this.feedback =
        listFeedback.map((fb) => FeedbackViewModel(feedBack: fb)).toList();
    if (this.feedback.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }
}
