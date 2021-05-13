import 'package:flutter/material.dart';
import 'package:flutter_etourguide/services/web_services.dart';

enum LoadingStatus { completed, searching, empty }

class PositionTextVMApi with ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;

  Future<String> getTextByPosition(String language, List<dynamic> position) async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    String text =
    await WebService().fetchTextByPosition(language, position);
    if (text.isEmpty) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
    return text;
  }

  
}
